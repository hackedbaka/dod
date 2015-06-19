require 'pusher'

Pusher.url = "http://be43fa2ad18873862a59:27dc62d992295d688ac5@api.pusherapp.com/apps/124178"
Pusher.logger = Rails.logger

Pusher.app_id = ENV["pusher_app_id"]
Pusher.key    = ENV["pusher_key"]
Pusher.secret = ENV["pusher_secret"]