class GamesController < ApplicationController
	def index
	end

	def room
		@game = Game.first
		# @questions = Question.all
		# @question = @questions[rand(0..@questions.length-1)]

        if !@game.p1 
        	##if p1 is empty, assign the player as player 1
            @game.p1 = current_user.id

        elsif !@game.p2
        	##if p2 is empty, assing the player as player 2
        	@game.p2 = current_user.id

        else
            ##initialize game       	
        	@game = Game.create
        	@questions = Question.all
		    @question = @questions[rand(0..@questions.length-1)]
			
            @game.questions << @question 
			@game.room_id = SecureRandom.hex(12)
			@game.p1_bet = 0.01
			@game.p2_bet = 0.01

        end
            @question = @game.questions.first
        	@game.save
		
	end

	def bet
		@game =Game.first
       	@game.update_attributes(p1_bet: params[:p1_bet])
		Pusher['test_channel'].trigger('my_event', {
      		message: params[:p1_bet]
    	}) 
	end	

end
