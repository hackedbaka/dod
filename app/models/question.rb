class Question < ActiveRecord::Base

	has_many :games

	validates :category, numericality: { only_integer: true }
	validates :text, presence: true, uniqueness: { case_sensitive: false}
	validates :answer_1, :answer_2, :answer_3, :answer_4, presence: true
	validates :correct_answer, presence: true, numericality: { only_integer: true }

end
