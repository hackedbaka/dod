class GamesController < ApplicationController
	def index
	end

	def room
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game


		if !@game then
			@game = Game.last
			# @questions = Question.all
			# @question = @questions[rand(0..@questions.length-1)]

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
	end

	def game_end
		@game = Game.find_by(p1: current_user.id)
		@game = Game.find_by(p2: current_user.id) if !@game
		# @user1 = User.find_by(p1: current_user.id)
		# @user2 = User.find_by(p2: current_user.id)
		#transfer bet amount from game to players
		# if params[:player] == '1'
		# 	@user1.donated.to_f += @game.p1_bet
		# 	@user2.earned.to_f += @game.p1_bet
		# else
		# 	@user2.donated.to_f += @game.p2_bet
		# 	@user1.earned.to_f += @game.p2_bet

		# end
		# @user.save

		Pusher[@game.room_id].trigger('kick_time', {});

		@game.delete

	end

end
