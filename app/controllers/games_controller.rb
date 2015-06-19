class GamesController < ApplicationController
	def index
	end

	def room
		@roomid = SecureRandom.hex(12)
		Pusher['test_channel'].trigger('my_event', {
      	
    })
	end

end
