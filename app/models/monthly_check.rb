class MonthlyCheck < ApplicationRecord
  include MonthlyCheckReport

  before_save :calculate_transactions_sum

  TRACKED_BUFFERS = TrackedBuffers::TRACKED_BUFFERS

  def difference
    (account_state - transactions_sum).round(2)
  end

  def balanced?
    difference.abs < 0.01
  end

  def buffers_sum
    BufferEntry.where(category: MonthlyCheckReport::TRACKED_BUFFERS).sum(:amount).round(2)
  end

  def buffer_remaining
    (transactions_sum - buffers_sum).round(2)
  end

  private

  def calculate_transactions_sum
    income = Transaction.where(transaction_type: "income").sum(:amount).round(2)
    expense = Transaction.where(transaction_type: "expense").sum(:amount).round(2)
    self.transactions_sum = (income - expense).round(2)
  end

  def buffer_category_total(cat)
    income = BufferEntry.where(category: cat, transaction_type: "income").sum(:amount)
    expense = BufferEntry.where(category: cat, transaction_type: "expense").sum(:amount)
    (income - expense).round(2)
  end

end
