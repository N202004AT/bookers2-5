class BookCommentsController < ApplicationController
	def create
		#対象のbookの情報を取得
		@book = Book.find(params[:book_id])
		#コメントはログインしているユーザがするよ。空のモデルを作る事でコメントの情報が入るよ。
		@book_comment = current_user.book_comments.new(book_comment_params)
		#コメントは何に対してするの？　＝　本に対してだよ。
		@book_comment.book_id = @book.id
		#コメントをセーブするよ
		@book_comment.save
		redirect_to book_path(@book.id)
	end
	def destroy
		@book_comment = BookComment.find(params[:book_id])
		@book = @book_comment.book
		if @book_comment.destroy
			#「.」リレーション、結びついた物を取り出す為に使う。
		   redirect_to book_path(@book.id)
		end
	end

	def book_comment_params
    params.require(:book_comment).permit(:user_id,:book_id,:comment)
end
end
