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
    BufferEntry.where(
      category: MonthlyCheckReport::TRACKED_BUFFERS,
      date: month.beginning_of_month..month.end_of_month
    ).sum(:amount)
  end

  def buffer_remaining
    (transactions_sum - buffers_sum).round(2)
  end

  def allocate_remaining!
    unless balanced?
      puts "Monthly check is not balanced. Difference: #{difference}"
      return
    end

    if buffer_remaining == 0
      puts "Buffers already match transactions sum. Nothing to allocate."
      return
    end

    BufferEntry.create(
      transaction_type: buffer_remaining > 0 ? "income" : "expense",
      name: "remaining_buffer",
      date: month,
      amount: buffer_remaining.abs,
      category: "remaining_buffer",
      description: "Auto allocated remaining for #{month.strftime("%B %Y")}"
    )

    puts "Allocated #{buffer_remaining} to remaining_buffer for #{month.strftime("%B %Y")}"
  end

  private

  def calculate_transactions_sum
    income = Transaction.where(date: month.beginning_of_month..month.end_of_month)
                        .where(transaction_type: "income")
                        .sum(:amount)

    expense = Transaction.where(date: month.beginning_of_month..month.end_of_month)
                         .where(transaction_type: "expense")
                         .sum(:amount)

    self.transactions_sum = income - expense
  end

end
