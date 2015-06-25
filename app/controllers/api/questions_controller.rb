module Api
    class QuestionsController < ApplicationController
        protect_from_forgery with: :null_session

        def index
        	render json: Question.all, except: [:created_at, :updated_at]
        end

        def show
        	render json: Question.find(params[:id])
        end

        def create
        end

        def update
        end

        def destroy
        end

    end
end