class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to root_url
  	else
  		render :new
  	end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
     @user = User.find(params[:id])
  end

  def update 
     @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private 
  def user_params
  	params.require(:user).permit(:name, :email)
  end
end
