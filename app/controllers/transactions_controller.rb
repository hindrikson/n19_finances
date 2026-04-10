class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.order(date: :desc)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    if params[:payments].present?
      params[:payments].each do |flatmate_id, data|
        flatmate = Flatmate.find(flatmate_id)
        Transaction.create!(
          flatmate: flatmate.name,
          transaction_type: "income",
          date: data[:date],
          amount: data[:amount],
          room: flatmate.room,
          description: "#{flatmate.name} rent"
        )
      end
      redirect_to transactions_path, notice: "All rent payments saved successfully."
    else
      @transaction = Transaction.new(transaction_params)
      if @transaction.save
        redirect_to transactions_path, notice: "Transaction saved successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :date, :amount, :transaction_type, :category, :description, :room_id)
  end
end
