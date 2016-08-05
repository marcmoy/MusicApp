class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["Username and/or password is incorrect"]
      render :new
    else
      login(@user)
      redirect_to bands_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

end
