class BooksController < ApplicationController
  before_action :set_book, only: [:return,  :show, :edit, :update, :destroy]
  before_action :is_logged_in?



  # GET /books
  # GET /books.json
  def is_logged_in?
    if current_user == nil
      flash[:privileges]="Please log in"
      redirect_to login_path
    end
  end 

  def index
    if params[:search_option].present?
      if (params[:search_option] == "isbn")
        @books = Book.where(isbn: params[:search])
      elsif (params[:search_option] == "author")
        @books = Book.where("authors LIKE '%#{params[:search]}%'")
      else
        # Search by title/name
        @books = Book.where("name LIKE '%#{params[:search]}%'")
      end
    else
      # Show all books
      @books = Book.all
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to @books , notice: 'Book was not successfully created.'}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_path, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to books_path, notice: 'Book can not be removed since it has active checkout'
    end
  end

  def return
    @book.update(status: "Available")
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice:"Book not found"
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:isbn, :name, :authors, :description)
  end
end
