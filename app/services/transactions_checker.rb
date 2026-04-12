class TransactionsChecker

  def self.difference(account_state)
    self.transactions_sum - account_state
  end

  def self.remaining
    self.transactions_sum - BufferSummary.sum_all
  end

  def self.transactions_sum
    (self.income - expense).round(2)
  end

  def self.balanced?
    self.difference.abs < 0.01
  end

  def self.checker(date, account_state)
    difference = self.difference(account_state)
    if difference.abs > 0.01
      puts "The transactions sum from the database do not match the account state. You entered a wrong transaction."
      self.clear_all_month_entries(date)
    else
      puts "Very good! The transactions were correctly entered :)"
    end
  end

  private

  def self.clear_all_month_entries(date)
    Transaction.where(date: date.beginning_of_month..date.end_of_month).destroy_all
    BufferEntry.where(date: date.beginning_of_month..date.end_of_month).destroy_all
    MonthlyCheck.where(month: date.beginning_of_month..date.end_of_month).destroy_all
    puts "Cleared all entries for #{date.strftime("%B %Y")}"
  end

  def self.income
    income = Transaction.where(transaction_type: "income").sum(:amount).round(2)
  end

  def self.expense
    expense = Transaction.where(transaction_type: "expense").sum(:amount).round(2)
  end


end
