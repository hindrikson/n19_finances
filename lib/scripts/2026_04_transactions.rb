# Run with: rails runner lib/scripts/seed_transactions.rb

# MONTH
month = 4
year = 2026
income_date = Date.new(year, month, 10)
expense_date = Date.new(year, month, 15)

rooms = Room.all
buffers = BufferCategories::CATEGORIES
expenses = ExpenseCategories::CATEGORIES

def create_rent_transacion(name, income_date, amount)
  flatmate = Flatmate.all.find_by(name: name)
  if flatmate
    Transaction.create(
      flatmate: flatmate.name,
      transaction_type: "income",
      date: income_date,
      amount: amount,
      room: flatmate.room,
      description: "#{flatmate.name} rent"
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


# ================================
# INCOME RENT TRANSACTIONS
# ================================
create_rent_transacion("Jonathan", income_date, 699.12)
create_rent_transacion("Maren",    income_date, 160.0)
create_rent_transacion("Ruda",     income_date, 626.62)
create_rent_transacion("Arce",     income_date, 437.81)
create_rent_transacion("Nona",     income_date, 522.67)
create_rent_transacion("Tanja",    income_date, 554.01)
create_rent_transacion("Viola",    income_date, 473.41)
create_rent_transacion("Lisa",     income_date, 354.14)
create_rent_transacion("Ronny",    income_date, 491.32)

# ================================
# OTHER INCOME TRANSACTIONS
# ================================
Transaction.create(
  name: "deposit",
  transaction_type: "income",
  date: income_date,
  amount: 726,
  description: "Nona: deposit"
)


# ================================
# EXPENSES TRANSACTIONS
# ================================
# water (RheinEnergie)
create_expense_transaction(name: "water_bill", expense_date: expense_date,
                           amount: 49.0,
                           description: "RheinEnergie: monthly water bill")
# internet (Telekom)
create_expense_transaction(name: "internet_bill", expense_date: expense_date,
                           amount: 54.0,
                           description: "Maren: internet Telekom")
# GEZ Rundfunk
create_expense_transaction(name: "gez", expense_date: expense_date,
                           amount: 55.08,
                           description: "Rundfunk (GEZ) fee")
# wash machine (Jonathan: Leasing of the wash machine)
create_expense_transaction(name: "wash_machine_bill", expense_date: expense_date,
                           amount: 14.99,
                           description: "Jonathan: Leasing of the wash machine")
# flat electricity (Jonathan: flat electricity (Naturstrom))
create_expense_transaction(name: "flat_electricity_bill", expense_date: expense_date,
                           amount: 29.0,
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
create_expense_transaction(name: "account_fees", expense_date: expense_date,
                           amount: 3.80,
                           description: "account fees")

# ================================
# BUFFER TRANSACTIONS
# ================================

# Splitwise
Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 96.99,
  description: "Hannes groceries"
)

# ================================
# FIX BUFFERS ENTRIES
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



# ================================
# Montly check
# ================================
check = MonthlyCheck.create(
  month: income_date,
  account_state: 13726.89
)
check.save_markdown!


