require 'rails_helper'

RSpec.describe AdminController, :type => :controller do

  it "should return index view if user is admin" do

    allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
    get :index

    expect(response).to render_template(:index)

  end

  it "admin can render new questions form" do

    allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
    get :new

    expect(response).to render_template(:new)
    
  end

  it "admin can add questions to the question bank" do

    allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
    get :new

    expect(assigns(:question)).to be_a_new(Question)
    
  end

  it "should redirect after new question" do

  		allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
  		post :create, question: FactoryGirl.attributes_for(:valid_question)

    	expect(response).to redirect_to(admin_index_path)
  end

  it "should render new form again if invalid question params" do
    	allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
  		post :create, question: FactoryGirl.attributes_for(:invalid_question)

    	expect(response).to render_template(:new)
  end

  it "admin can access edit question template" do
  		allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
  		@question = FactoryGirl.create(:valid_question)
  		
    	get :edit,id: @question.id

    	expect(response).to render_template(:edit)
  end

  it "should delete the question when click delete" do
        allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
  		@question = FactoryGirl.create(:valid_question)

        get :destroy, id: @question.id
        @question = Question.find_by(id: @question.id)
        
        expect(@question).to be nil 
    end

    it "should redirect to index page after deleting a question" do
        allow(controller).to receive(:authorizeAdmin).and_return(FactoryGirl.build(:valid_user))
  		@question = FactoryGirl.create(:valid_question)

        get :destroy, id: @question.id

        expect(response).to redirect_to(admin_index_path)
    end



end


