class AdminController < ApplicationController

  before_filter :authorizeAdmin

	def index
        @questions = Question.all
    end

    def new
        @question = Question.new
    end

    def show
        render json: Question.find(params[:id])
    end

    def create
    	question = Question.new(question_params)
        if question.save
        	redirect_to "/admin"
        else
          render :new
    	end
    end

    def edit
  		@question = Question.find(params[:id])
	   end

    def update
  		@question = Question.find(params[:id])

  		if @question.update_attributes(question_params)
    		redirect_to "/admin"
  		else
    		render :edit
  		end
	 end

    def destroy
  		@question = Question.find(params[:id])
  		@question.destroy
  		redirect_to "/admin"
	 end

    private

    def question_params
        params.require(:question).permit(:category, :text, :answer_1, :answer_2, :answer_3, :answer_4, :correct_answer)
    end

end