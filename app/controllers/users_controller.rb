class UsersController < ApplicationController
  before_action  :set_user, only: [:edit, :update, :show] #this replaces having the below code in each of these actions:
      # @user = User.find(params[:id])

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice]="#{@user.username}, your signup was successful"
      redirect_to articles_path
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

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
