class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order(date: :desc)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: "Transaction saved successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :date, :amount, :transaction_type, :category, :description, :room_id)
  end
end
