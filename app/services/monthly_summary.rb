class MonthlySummary
  def initialize(date, account_state)
    @date = date
    @date_range = date.beginning_of_month..date.end_of_month
    @account_state = account_state
  end
  
  BUFFER_CATEGORIES = BufferCategories::CATEGORIES

  def to_markdown
    transaction_checker = TransactionsChecker.new(@date, @account_state)

    # Monthy transactions
    month_income_transactions = transaction_checker.month_income_transactions
    month_expense_transactions = transaction_checker.month_expense_transactions

    # Buffer monthly transactions
    month_buffer_transactions = transaction_checker.month_buffer_transactions
    buffers_sum = transaction_checker.buffers_sum

    # total checks
    remaining = transaction_checker.remaining
    transactions_sum = transaction_checker.transactions_sum
    balanced = transaction_checker.balanced?
    difference = transaction_checker.difference

    md = []
    md << "# Monthly Report — #{@date.strftime("%B %Y")}"
    md << ""

    # ================================
    md << "## Monthly Check"
    md << ""
    md << "| | |"
    md << "|---|---|"
    md << "| Account State | #{@account_state} |"
    md << "| Transactions Sum | #{transactions_sum} |"
    md << "| Difference | #{difference} |"
    md << "| Balanced | #{balanced ? "✅ Yes" : "❌ No"} |"
    md << "| Buffers Sum | #{buffers_sum} |"
    md << "| Remaining | #{remaining} |"
    md << ""

    # ================================
    md << "## Rooms"
    md << ""
    md << "| Room | Status |"
    md << "|------|--------|"
    RoomTransactionChecker.all_rooms(@date.year, @date.month).each do |result|
      md << "| Room #{result.room_id} | #{result.description} |"
    end
    md << ""

    # ================================
    md << "## Income Transactions"
    md << ""
    md << "| Name | Date | Amount | Description |"
    md << "|------|------|--------|-------------|"
    month_income_transactions.each do |t|
      md << "| #{t.name} | #{t.date} | #{t.amount} | #{t.description} |"
    end
    md << ""
    md << "**Total Income: #{month_income_transactions.sum(:amount).round(2)}**"
    md << ""

    # ================================
    md << "## Expense Transactions"
    md << ""
    md << "| Name | Date | Amount | Category | Description |"
    md << "|------|------|--------|----------|-------------|"
    month_expense_transactions.each do |t|
      md << "| #{t.name} | #{t.date} | #{t.amount} | #{t.category} | #{t.description} |"
    end
    md << ""
    md << "**Total Expenses: #{month_expense_transactions.sum(:amount)}**"
    md << ""

    # ================================
    md << "## Buffer Entries"
    md << ""
    md << "| Name | Date | Amount | Type | Category | Description |"
    md << "|------|------|--------|------|----------|-------------|"
    month_buffer_transactions.each do |b|
      md << "| #{b.name} | #{b.date} | #{b.amount} | #{b.transaction_type} | #{b.category} | #{b.description} |"
    end
    md << ""

    # ================================
    md << "## Buffer Summary"
    md << ""
    md << "| Category | Total |"
    md << "|----------|-------|"
    BUFFER_CATEGORIES.each do |cat|
      md << "| #{cat} | #{transaction_checker.buffer_category_sum(cat)} |"
    end
    md << ""

    total_with_remainder = buffers_sum + remaining

    md << "**Remainder: #{remaining}**"
    md << ""
    md << "**Total Buffers: #{buffers_sum}**"
    md << ""
    md << "**Total Buffers + Remainder: #{total_with_remainder}**"
    md << ""
    md << "**Buffers Balanced: #{total_with_remainder == transactions_sum ? "✅ Yes" : "❌ No"}**"
    md << ""

    md.join("\n")
  end

  def save_markdown!
    filename = "report_#{@date.strftime("%Y_%m")}.md"
    path = Rails.root.join("lib", "reports", filename)
    FileUtils.mkdir_p(Rails.root.join("lib", "reports"))
    File.write(path, to_markdown)
    puts "Report saved to #{path}"
  end

end
