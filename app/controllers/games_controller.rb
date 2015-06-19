class GamesController < ApplicationController
	def index
	end

	def room
		@game =Game.first
		@questions = Question.all
		@question = @questions[rand(0..@questions.length-1)]
		@roomid = SecureRandom.hex(12)
		@game.update_attributes(p1_bet: params[:p1_bet])
		Pusher['test_channel'].trigger('my_event', {
      		message: params[:p1_bet]
    	})
	end

end
