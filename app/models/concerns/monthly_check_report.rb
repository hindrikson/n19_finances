module MonthlyCheckReport
  TRACKED_BUFFERS = %w[
    water_buffer
    electricity_buffer
    oil_buffer
    groceries_buffer
    reserve_buffer
    deposit_buffer
  ].freeze

  def to_markdown
    income_transactions = Transaction.where(
      date: month.beginning_of_month..month.end_of_month,
      transaction_type: "income"
    )

    expense_transactions = Transaction.where(
      date: month.beginning_of_month..month.end_of_month,
      transaction_type: "expense"
    )

    buffer_entries_for_month = BufferEntry.where(
      date: month.beginning_of_month..month.end_of_month
    )

    md = []
    md << "# Monthly Report — #{month.strftime("%B %Y")}"
    md << ""

    # ================================
    md << "## Monthly Check"
    md << ""
    md << "| | |"
    md << "|---|---|"
    md << "| Account State | #{account_state} |"
    md << "| Transactions Sum | #{transactions_sum} |"
    md << "| Difference | #{difference} |"
    md << "| Balanced | #{balanced? ? "✅ Yes" : "❌ No"} |"
    md << "| Buffers Sum | #{buffers_sum} |"
    md << "| Buffer Remaining | #{buffer_remaining} |"
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
    md << "**Total Income: #{income_transactions.sum(:amount)}**"
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
    (TRACKED_BUFFERS + ["remaining_buffer"]).each do |cat|
      total = buffer_entries_for_month.where(category: cat).sum(:amount)
      md << "| #{cat} | #{total} |"
    end
    md << ""
    md << "**Total Buffers: #{buffer_entries_for_month.sum(:amount)}**"
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
