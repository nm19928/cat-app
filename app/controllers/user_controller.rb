class UserController < ApplicationController
  def index
    render "index"
  end

  def show
    @user = User.find(params[:id])

    if @user == current_user
    render "show"
    else
    redirect_to user_url(current_user)
    end
  end

  def new
    render "new"
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      login!(@user)
      redirect_to "/cat"
    end
  end

  def user_params
    params.require(:user).permit(:username,:password)
  end
end
