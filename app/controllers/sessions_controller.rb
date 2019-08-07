class SessionsController < ApplicationController
  def new
    #just renders a form
  end

  def create
    #submits the form, keeps user logged in
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id #saving user_id in session, saved by cookies so browser can handle it
      flash[:notice] = "Login successful"
      redirect_to user
    else
      flash.now[:danger] = "Incorrect email/password"
      render 'new'
    end
  end

  def destroy
    #log out
    session[:user_id]=nil
    flash[:notice]="You have successfully logged out"
    redirect_to root_path
  end
end
