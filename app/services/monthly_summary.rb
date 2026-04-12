class MonthlySummary
  def initialize(date, account_state)
    @date = date
    @date_range = date.beginning_of_month..date.end_of_month
    @account_state = account_state
  end
  
  BUFFER_CATEGORIES = BufferCategories::CATEGORIES

  def income_transactions
    Transaction.where(date: @date_range, transaction_type: "income")
  end

  def expense_transactions
    Transaction.where(date: @date_range, transaction_type: "expense")
  end

  def buffer_entries_for_month
    BufferEntry.where(date: @date_range)
  end

  def buffer_sum_all
    BufferSummary.sum_all
  end

  def remaining
    TransactionsChecker.remaining
  end

  def transactions_sum
    TransactionsChecker.transactions_sum
  end

  def balanced?
    TransactionsChecker.difference(@account_state) > 0.01
  end
  
  def to_markdown

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
    md << "| Difference | #{TransactionsChecker.difference(@account_state)} |"
    md << "| Balanced | #{balanced? ? "✅ Yes" : "❌ No"} |"
    md << "| Buffers Sum | #{buffer_sum_all} |"
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
    income_transactions.each do |t|
      md << "| #{t.name} | #{t.date} | #{t.amount} | #{t.description} |"
    end
    md << ""
    md << "**Total Income: #{income_transactions.sum(:amount).round(2)}**"
    md << ""

    # ================================
    md << "## Expense Transactions"
    md << ""
    md << "| Name | Date | Amount | Category | Description |"
    md << "|------|------|--------|----------|-------------|"
    expense_transactions.each do |t|
      md << "| #{t.name} | #{t.date} | #{t.amount} | #{t.category} | #{t.description} |"
    end
    md << ""
    md << "**Total Expenses: #{expense_transactions.sum(:amount)}**"
    md << ""

    # ================================
    md << "## Buffer Entries"
    md << ""
    md << "| Name | Date | Amount | Type | Category | Description |"
    md << "|------|------|--------|------|----------|-------------|"
    buffer_entries_for_month.each do |b|
      md << "| #{b.name} | #{b.date} | #{b.amount} | #{b.transaction_type} | #{b.category} | #{b.description} |"
    end
    md << ""

    # ================================
    md << "## Buffer Summary"
    md << ""
    md << "| Category | Total |"
    md << "|----------|-------|"
    BUFFER_CATEGORIES.each do |cat|
      md << "| #{cat} | #{BufferSummary.category_total(cat)} |"
    end
    md << ""

    total_with_remainder = buffer_sum_all + remaining

    md << "**Remainder: #{remaining}**"
    md << ""
    md << "**Total Buffers: #{buffer_sum_all}**"
    md << ""
    md << "**Total Buffers + Remainder: #{total_with_remainder}**"
    md << ""
    md << "**Buffers Balanced: #{total_with_remainder == transactions_sum ? "✅ Yes" : "❌ No"}**"
    md << ""

    md.join("\n")
  end

  def save_markdown!
    filename = "report_#{month.strftime("%Y_%m")}.md"
    path = Rails.root.join("lib", "reports", filename)
    FileUtils.mkdir_p(Rails.root.join("lib", "reports"))
    File.write(path, to_markdown)
    puts "Report saved to #{path}"
  end

end
