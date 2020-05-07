class SearchesController < ApplicationController
  def search
    @method = params[:search_method]
    @word = params[:search_word]
    @model = params[:book_or_user]
    @records = search_for(@model, @method, @word)
    #部分テンプレート先に新規投稿のフォームが存在する為book.newと定義しなければいけない
    @book = Book.new
  end

  private
  def search_for(model,method,word)
    if model == "book"
                if method == "forward_match"
                         Book.where("title LIKE?","#{word}%")
                elsif method == "backward_match"
                         Book.where("title LIKE?","%#{word}")
                elsif method == "perfect_match"
                         Book.where(title: "#{word}")
                elsif method == "partial_match"
                         Book.where("title LIKE?","%#{word}%")
                else
                         Book.all
                end
    elsif model == "user"
                if method == "forward_match"
                         User.where("name LIKE?","#{word}%")
                elsif method == "backward_match"
                         User.where("name LIKE?","%#{word}")
                elsif method == "perfect_match"
                         User.where(name: "#{word}")
                elsif method == "partial_match"
                         User.where("name LIKE?","%#{word}%")
                else
                         User.all
                end
    end
  end
end
