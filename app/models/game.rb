class Game < ActiveRecord::Base

	has_many :questions
	has_one :question

end
