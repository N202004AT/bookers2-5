class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, {only: [:edit,:update,]}

	def index
		@user = current_user
		@book = Book.new
		@books = Book.all
	end

	def edit
		@book = Book.find(params[:id])
	end

	def show
		@book = Book.new
		@booked = Book.find(params[:id])
		@user = User.find(@booked.user_id)
		@book_comment = BookComment.new
		@book_comments = @booked.book_comments
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   flash[:success]='You have updated book successfully.'
		   redirect_to book_path(@book.id)
		else
		   render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def create
		@book = Book.new(book_params)
		@book.user_id=current_user.id
		if @book.save
		   flash[:success]='You have creatad book successfully.'
		   redirect_to book_path(@book.id)
		else
		   @user = current_user
		   @books = Book.all
		   render :index
		end
	end

	def ensure_correct_user
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		end
	end
	private
	def book_params
		params.require(:book).permit(:title,:body,:user_id)
	end
end
