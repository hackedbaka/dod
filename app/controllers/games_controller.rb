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

	        # elsif !@game.p2
	        # 	##if p2 is empty, assing the player as player 2
	        # 	@game.p2 = current_user.id

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

	def bet
		@game =Game.first
       	@game.update_attributes(p1_bet: params[:p1_bet])
		Pusher['test_channel'].trigger('my_event', {
      		message: params[:p1_bet]
    	}) 
	end	

end
