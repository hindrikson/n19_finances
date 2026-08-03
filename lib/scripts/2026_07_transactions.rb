# Run with: rails runner lib/scripts/seed_transactions.rb

# MONTH
month = 7
year = 2026
income_date = Date.new(year, month, 10)
expense_date = Date.new(year, month, 15)

def create_rent_transacion(name, income_date, amount, description = nil)
  flatmate = Flatmate.find_by(name: name) # Optimized from Flatmate.all.find_by

  if flatmate
    Transaction.create(
      name: flatmate.room.name,
      flatmate: flatmate.name,
      transaction_type: "income",
      date: income_date,
      amount: amount,
      room: flatmate.room,
      description: description || "#{flatmate.name} rent"
    )
  else
    puts "Flatmate with name #{name} not found."
  end
end

def create_expense_transaction(name:, expense_date:, amount:, description:)
  if ExpenseCategories::CATEGORIES.include?(name)
    Transaction.create(
      transaction_type: "expense",
      name: name,
      category: name,
      date: expense_date,
      amount: amount,
      description: description
    )
  else
    puts "Expense category #{name} not found."
    puts "Available categories: #{ExpenseCategories::CATEGORIES.join(', ')}"
  end
end

# maren = Flatmate.find_by(name: "Maren")
# maren.destroy()


# ActiveRecord::Base.transaction do
#   Flatmate.find_by(room_id: 1).destroy # Remove Kimberly
#   Flatmate.create!(name: "Chimdi", room_id: 1)
# end

# ActiveRecord::Base.transaction do
#   Flatmate.find_by(room_id: 8).destroy # Remove Kimberly
#   Flatmate.create!(name: "Jonathan", room_id: 8)
# end

new_due_values = {
  "room_1" => 885.08,
  "room_2" => 597.72,
  "room_3" => 477.49,
  "room_4" => 524.09,
  "room_5" => 556.71,
  "room_6" => 472.83,
  "room_7" => 359.44,
  "room_8" => 491.47
}

new_due_values.each do |room_name, new_due|
  Room.where(name: room_name).update_all(due: new_due)
end

# ================================
# INCOME RENT TRANSACTIONS
# ================================
create_rent_transacion("Chimdi",    income_date, 885.08)
create_rent_transacion("Maren",    income_date, 160.0)
create_rent_transacion("Ruda",     income_date, 597.72)
create_rent_transacion("Arce",     income_date, 477.49)
create_rent_transacion("Nona",     income_date, 524.09)
create_rent_transacion("Tanja",    income_date, 556.71)
create_rent_transacion("Viola",    income_date, 472.83)
create_rent_transacion("Lisa",     income_date, 354.14)
create_rent_transacion("Jonathan",    income_date, 491.47)

# ================================
# OTHER INCOME TRANSACTIONS
# ================================
Transaction.create(
  name: "Nebenkonsten ruckzahlung",
  transaction_type: "income",
  date: income_date,
  amount: 295.84,
  description: "Nebenkonsten ruckzahlung from Hahnheiser"
)

Transaction.create(
  transaction_type: "income",
  name: "deposit",
  category: "deposit_buffer",
  date: income_date,
  amount: 800.0,
  description: "Chimdi deposit"
)



# ================================
# EXPENSES TRANSACTIONS
# ================================
# water (RheinEnergie)
create_expense_transaction(name: "water_bill", expense_date: expense_date,
                           amount: 58.0,
                           description: "RheinEnergie: monthly water bill (they are charging us now 58 instead of 49)")
# # internet (Telekom)
create_expense_transaction(name: "internet_bill", expense_date: expense_date,
                           amount: 49.0,
                           description: "Internet: NetCologne (for some reason they charged us 49 instead of 52.67)")
# GEZ Rundfunk
# create_expense_transaction(name: "gez", expense_date: expense_date,
#                            amount: 55.08,
#                            description: "Rundfunk (GEZ) fee")
# wash machine (Jonathan: Leasing of the wash machine)
create_expense_transaction(name: "wash_machine_bill", expense_date: expense_date,
                           amount: 14.99,
                           description: "Jonathan: Leasing of the wash machine")
# flat electricity (Jonathan: flat electricity (Naturstrom))
create_expense_transaction(name: "flat_electricity_bill", expense_date: expense_date,
                           amount: 31.0,
                           description: "Jonathan: flat electricity (Naturstrom)")
# haus electricity (Jonathan: house electricity (Qcells))
create_expense_transaction(name: "house_electricity_bill", expense_date: expense_date,
                           amount: 200.0,
                           description: "Jonathan: house electricity Qcells")
# rent (rent: Kai und Dirk Hannheiser
create_expense_transaction(name: "rent", expense_date: expense_date,
                           amount: 3335.0,
                           description: "rent: Kai und Dirk Hahnheiser")
# accout fees
# create_expense_transaction(name: "account_fees", expense_date: expense_date,
#                            amount: 3.80,
#                            description: "account fees")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 726.0,
                           description: "Deposit (Kaution) back to Ronny")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 160.0,
                           description: "Maren payed 160 to the account in July from when she is not a flatmate anymore.")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 40.0,
                           description: "40 Eruros of deposit (Kaution) back to Maren")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 49.0,
                           description: "Water reserve money to Tobi in case they still charge it from his account")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 55.08,
                           description: "Runfunk (GEZ) reserve money to Tobi in case they still charge it from his account")

create_expense_transaction(name: "other", expense_date: expense_date,
                           amount: 156.50,
                           description: "Deposit minus missing rent from November back to Ariane")

create_expense_transaction(name: "water", expense_date: expense_date,
                           amount: 101.78,
                           description: "RheinEnergie charged us for water. Is it a payment more for last year?")

# Splitwise
Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 208.87,
  description: "Tanja groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 60.00,
  description: "Arce groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 191.22,
  description: "Lisa groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 44.47,
  description: "Ruda groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 15.32,
  description: "Nona groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 8.40,
  description: "Nona groceries"
)

Transaction.create(
  transaction_type: "expense",
  name: "oil_buffer",
  category: "oil_buffer",
  date: expense_date,
  amount: 1150.0,
  description: "Jonathan money for oil"
)



# ================================
# BUFFER TRANSACTIONS
# ================================


# ================================
# REGULAR BUFFERS ENTRIES
# ================================

BufferEntry.create(
  transaction_type: "income",
  name: "oil_buffer",
  date: income_date,
  amount: 400.00,
  category: "oil_buffer",
  description: "default payment"
)

BufferEntry.create(
  transaction_type: "income",
  name: "groceries_buffer",
  date: income_date,
  amount: 80.0,
  category: "groceries_buffer",
  description: "default payment"
)

BufferEntry.create(
  transaction_type: "income",
  name: "reserve_buffer",
  date: income_date,
  amount: 80.0,
  category: "reserve_buffer",
  description: "default payment"
)

BufferEntry.create(
  transaction_type: "income",
  name: "maintenance_buffer",
  date: income_date,
  amount: 80.00,
  category: "maintenance_buffer",
  description: "default payment"
)

# Run Checks and summaries
puts RoomTransactionChecker.all_rooms(year, month)

final_state  = 16035.39

transactions_checker = TransactionsChecker.new(income_date, final_state)

# Remaining
puts "Remaining: #{transactions_checker.remaining}"

puts "Account sum: #{transactions_checker.transactions_sum}"

# Create markdown report
MonthlySummary.new(income_date, final_state).save_markdown!

# Account state
transactions_checker.checker

check = MonthlyCheck.create(month: income_date, account_state: 13726.89)

