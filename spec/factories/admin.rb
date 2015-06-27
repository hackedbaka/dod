FactoryGirl.define do

	## General
  factory :valid_user, class: User do

  	email "test@test.com"
  	oauth_token "password"
  end

  factory :valid_question, class: Question do

  	category "0"
  	text "a question"
  	answer_1 "first"
  	answer_2 "second"
  	answer_3 "third"
  	answer_4 "fourth"
  	correct_answer "2"
  end

  factory :invalid_question, class: Question do

  	category nil
  	text nil
  	answer_1 "first"
  	answer_2 "second"
  	answer_3 "third"
  	answer_4 "fourth"
  	correct_answer "2"
  end

end

