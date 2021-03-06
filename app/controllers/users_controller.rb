class UsersController < ApplicationController
  before_action  :set_user, only: [:edit, :update, :show]
      #this replaces having the below code in each of these actions:
      # @user = User.find(params[:id])
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="#{@user.username}, your signup was successful"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice]="User credentials updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account has been deleted"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if !logged_in? && current_user != @user && !current_user.admin?
      flash[:notice] = "You cannot make changes to others' accounts"
      redirect_to root_path
    end
  end

end
