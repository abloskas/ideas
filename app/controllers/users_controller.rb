class UsersController < ApplicationController
  before_action :require_login, only: [ :show, :edit, :update]
  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/ideas"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users"
    end
  end

  def login
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to "/ideas"
    else
      flash[:errors] = ["Invalid Username or Password. Have you registered?"]
      redirect_to "/users"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def logout
    session[:user_id] = nil
    redirect_to "/users"
  end

  private
  def user_params
    params.require(:user).permit(:name, :alias, :email, :password)
  end
end
