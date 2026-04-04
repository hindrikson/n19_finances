month = Date.new(2026, 3, 1)

Transaction.where(date: month.beginning_of_month..month.end_of_month).destroy_all
BufferEntry.where(date: month.beginning_of_month..month.end_of_month).destroy_all
MonthlyCheck.where(month: month.beginning_of_month..month.end_of_month).destroy_all

puts "Cleared all entries for #{month.strftime("%B %Y")}"
