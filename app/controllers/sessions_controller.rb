class SessionsController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create

    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to charities_path
  end

  def auth_failure
    redirect_to games_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to games_path
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end