class BookTransactionsController < ApplicationController
  before_action :set_book_transaction, only: [:show, :edit, :update, :destroy]
# GET /book_transactions
# GET /book_transactions.json
  before_action :checkauth?, only: [:new, :edit, :update, :destroy, :index]
  def checkauth?
    unless is_admin?
      flash[:privileges]="Not enough privileges"
      redirect_to root_path
    end
  end
  def index
    @book_transactions = BookTransaction.all
  end
# GET /book_transactions/1
# GET /book_transactions/1.json
  def show
  end
# GET /book_transactions/new
  def new
    @book_transaction = BookTransaction.new
  end
  def create
    @book_transaction = BookTransaction.new(book_transaction_params)
    respond_to do |format|
      if @book_transaction.save
        @book_transaction.book.update(status: "Checked out")
        format.html { redirect_to root_path, notice: 'Book transaction was successfully created.' }
        format.json { render :show, status: :created, location: @book_transaction }
      else
        format.html { render :new }
        format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
      end
    end
  end
# GET /book_transactions/1/edit
  def edit
  end
# POST /book_transactions
# POST /book_transactions.json
  def checkin
    @book = Book.find(params[:id])
    if( @book.nil?)
      redirect_to root_path , notice:"Book not found"
      return
    end
    @book_transaction = BookTransaction.new
  end
  def create2
    book = Book.find(return_params[:book_id])
    if(book.nil?)
      redirect_to root_path,notice: "Book not found"
      return
    end
    owner = book.current_owner
    unless (owner.nil?)
      if(owner == current_user or is_admin?)
        @book_transaction = BookTransaction.new(book_id:book.id,member_id:book.current_owner.id)
        respond_to do |format|
          if @book_transaction.save
            @book_transaction.book.update(status: "Available")





            format.html { redirect_to root_path, notice: 'Book Returned.' }
            format.json { render :show, status: :created, location: @book_transaction }
          else
            format.html { redirect_to checkin_path(book), "Could not return book. Try again." }
            format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to root_path,notice:"Not enough privileges"
      end
    else
      redirect_to root_path, notice: 'Book already returned'
    end
  end
  def checkout
    @book = Book.find(params[:id])
    if( @book.nil?)
      redirect_to root_path,notice:"Book not found"
    end
    @book_transaction = BookTransaction.new
  end
  def create1
    @book_transaction = BookTransaction.new(book_transaction_params)
    member = @book_transaction.member
    book = @book_transaction.book
    if member.nil?
      redirect_to checkout_path(book), notice: 'Member does not exist'
      return
    end
    if book.current_owner.nil?
      respond_to do |format|
        if @book_transaction.save
          @book_transaction.book.update(status: "Checked out")
          format.html { redirect_to root_path, notice: 'Book checked out.' }
          format.json { render :show, status: :created, location: @book_transaction }
        else
          format.html { redirect_to checkout_path(book), notice: "member id not entered in correct format" }
          format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: 'Book already checkout'
    end
  end
# PATCH/PUT /book_transactions/1
# PATCH/PUT /book_transactions/1.json
  def update
    respond_to do |format|
      if @book_transaction.update(book_transaction_params)
        format.html { redirect_to root_path, notice: 'Book transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_transaction }
      else
        format.html { render :edit }
        format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
      end
    end
  end
# DELETE /book_transactions/1
# DELETE /book_transactions/1.json
  def destroy
    @book_transaction.destroy
    respond_to do |format|
      format.html { redirect_to book_transactions_url, notice: 'Book transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
# Use callbacks to share common setup or constraints between actions.
  def set_book_transaction
    @book_transaction = BookTransaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice:"Book Transaction not found"
  end
# Never trust parameters from the scary internet, only allow the white list through.
  def return_params
    params.require(:book_transaction).permit(:book_id)
  end
  def book_transaction_params
    params.require(:book_transaction).permit(:book_id,:member_id)
  end
end