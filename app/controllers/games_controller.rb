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
				Pusher[@game.room_id].trigger('start_game', {
		      	});
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
		Pusher[@game.room_id].trigger('answered', {
			player: params[:player],
      		correct: correct
      	});
      	render nothing: true, status: 200
	end	

	

	

end
