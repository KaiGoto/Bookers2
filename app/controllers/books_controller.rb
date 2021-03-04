class BooksController < ApplicationController
  def new
    @book = Book.new
    @book = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] ='Book was successfully created.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end
  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ='Book was successfully created.'
      redirect_to book_path
    else
      render :edit
    end
  end
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] ='Book was successfully created.'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
