class GamesController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def index
	end

	def room
		#checks to see if the current user is inside a room
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game


		if !@game then
			@game = Game.last
			
	        if @game && !@game.p2
	        	##if p1 is empty, assign the player as player 1
	            @game.p2 = current_user.id
				Pusher[@game.room_id].trigger('start_game', {});
	        else
	            ##initialize game       	
	        	@game = Game.create
	        	@game.questions = Question.all
	            @game.p1 = current_user.id
				
				@game.room_id = SecureRandom.hex(12)
				@game.p1_bet = 0.01
				@game.p2_bet = 0.01
		    	@game.question = @game.questions[rand(0..@game.questions.length-1)]

	        end
	    	@game.save
	    	

	    end
		
	end

	def answered
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game
       	correct = (@game.question.correct_answer.to_s == params[:choice])

		# update bets
		if params[:player] == '1'
			if correct
				@game.p2_bet *= 2
			else
				@game.p1_bet *= 2 
			end
		else
			if correct
				@game.p1_bet *= 2
			else
				@game.p2_bet *= 2 
			end
		end
		@game.save

		Pusher[@game.room_id].trigger('answered', {
			player: params[:player],
      		correct: correct
      	});
      	render nothing: true, status: 200
	end	

	def start_another
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game
		@game.question = @game.questions[rand(0..@game.questions.length-1)]

		Pusher[@game.room_id].trigger('start_another', {});
		render nothing: true, status: 200
	end

	def game_end
		# binding.pry
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game
		
			user1 = User.find(@game.p1)
			if !user1.donated
				user1.donated = 0.0
			end
			if !user1.earned
				user1.earned = 0.0 
			end
			user1.donated += @game.p1_bet
			user1.earned += @game.p2_bet
			user1.save
		
		
			
				user2 = User.find(@game.p2)
				if !user2.donated
					user2.donated = 0.0 
				end
				if !user2.earned
					user2.earned = 0.0 
				end
				user2.earned += @game.p1_bet
				user2.donated += @game.p2_bet
				user2.save
			

		Pusher[@game.room_id].trigger('kick_time', {});

		flash[:alert] = "Someone wanted to quit"

		@game.delete
		render nothing: true, status: 200
	end

end
