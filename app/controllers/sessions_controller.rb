class SessionsController < ApplicationController
  def index
    render "login"
  end

  def create
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])

    if user.nil?
      render plain: "User does not exist"
    else
      login!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    logout!
    redirect_to "/sessions"
  end
end
