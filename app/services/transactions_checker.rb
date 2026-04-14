class TransactionsChecker

  BUFFER_CATEGORIES = BufferCategories::CATEGORIES

  def initialize(date, account_state)
    @date = date
    @date_range = date.beginning_of_month..date.end_of_month
    @account_state = account_state
  end

  def difference
    transactions_sum - @account_state
  end

  def remaining
    transactions_sum - buffers_sum
  end

  def transactions_sum
    (income - expense).round(2)
  end

  def month_income_transactions
    Transaction.where(date: @date_range, transaction_type: "income")
  end

  def month_expense_transactions
    Transaction.where(date: @date_range, transaction_type: "expense")
  end

  def buffers_sum
    income = BufferEntry.where(date: ..@date_range.last, category: BUFFER_CATEGORIES, transaction_type: "income").sum(:amount)
    expense = BufferEntry.where(date: ..@date_range.last, category: BUFFER_CATEGORIES, transaction_type: "expense").sum(:amount)
    (income - expense).round(2)
  end

  def buffer_category_sum(cat)
    income = BufferEntry.where(date: ..@date_range.last, category: cat, transaction_type: "income").sum(:amount)
    expense = BufferEntry.where(date: ..@date_range.last, category: cat, transaction_type: "expense").sum(:amount)
    (income - expense).round(2)
  end

  def buffer_categories_sums
    BUFFER_CATEGORIES.map do |cat|
      { cat: cat, total: buffer_category_sum(cat) }
    end
  end

  def month_buffer_transactions
    BufferEntry.where(date: @date_range)
  end

  def balanced?
    difference.abs < 0.01
  end

  def checker
    if difference.abs > 0.01
      puts "The transactions sum from the database do not match the account state. You entered a wrong transaction."
      clear_all_month_entries(@date)
    else
      puts "Very good! The transactions were correctly entered :)"
    end
  end

  private

  def clear_all_month_entries(date)
    Transaction.where(date: @date_range).destroy_all
    BufferEntry.where(date: @date_range).destroy_all
    MonthlyCheck.where(month: @date_range).destroy_all
    puts "Cleared all entries for #{@date.strftime("%B %Y")}"
  end

  def income
    Transaction.where(date: ..@date_range.last, transaction_type: "income").sum(:amount).round(2)
  end

  def expense
    Transaction.where(date: ..@date_range.last, transaction_type: "expense").sum(:amount).round(2)
  end


end
