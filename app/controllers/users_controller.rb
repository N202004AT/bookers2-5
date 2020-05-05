class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, {only:[:edit,:update]}
	def index
		@book = Book.new
		@users = User.all
		@user = current_user
	end
	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
		current_user.book_comments
	end
	def edit
		@user = current_user
	end
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   flash[:success]='You have updated user successfully.'
		   redirect_to user_path(@user.id)
		else
		   render :edit
		end
	end

	def ensure_correct_user
		@user = User.find(params[:id])
		if @user != current_user
		   redirect_to user_path(current_user.id)
		end
	end

    private
	def user_params
		params.require(:user).permit(:name,:profile_image,:introduction)
	end


end
