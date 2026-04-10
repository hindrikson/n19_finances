# Run with: rails runner lib/scripts/seed_transactions.rb

# MONTH
month = 3
year = 2026
income_date = Date.new(year, month, 10)
expense_date = Date.new(year, month, 15)

# NEW flatmates
ActiveRecord::Base.transaction do
  Flatmate.find_by(room_id: 4).destroy # Remove Kimberly
  Flatmate.create!(name: "Nona", room_id: 4)
end

# Room transactions
room1 = Room.find_by(name: "room_1") # Jonathan, Maren
room2 = Room.find_by(name: "room_2") # Ruda
room3 = Room.find_by(name: "room_3") # Arce
room4 = Room.find_by(name: "room_4") # Nona
room5 = Room.find_by(name: "room_5") # Tanja
room6 = Room.find_by(name: "room_6") # Viola
room7 = Room.find_by(name: "room_7") # Lisa
room8 = Room.find_by(name: "room_8") # Ronny

# ================================
# INCOME TRANSACTIONS
# ================================

# ---- Room income transactions ----
# Room 1 Jonathan
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 699.12,
  room: room1,
)

# Room 1 Maren
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 160.0,
  room: room1,
)

# Room 1 Maren
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 160.0,
  room: room1,
  description: "Maren: DOUBLE payment in March"
)

# Room 2 Ruda
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 626.62,
  room: room2
)

# Room 3 Arce
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 437.81,
  room: room3
)

# Room 4 Nona
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 522.67,
  room: room4
)

# Room 4 Nona
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 522.67,
  room: room4,
  description: "Nona: DOUBLE March payment"
)

# Room 5 Tanja
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 554.01, # Done
  room: room5
)

# Room 5 Tanja
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 554.01, # Done
  room: room5,
  description: "Tanja: DOUBLE March payment"
)

# Room 6 Viola
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 473.41,
  room: room6
)

# Room 7 Lisa
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 354.14,
  room: room7
)

# Room 8 Ronny
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 491.32,
  room: room8
)

# other income
# -----------------------------------------------------------------

Transaction.create(
  name: "deposit",
  transaction_type: "income",
  date: income_date,
  amount: 726,
  description: "Nona: deposit"
)

Transaction.create(
  name: "electrcity payback",
  transaction_type: "income",
  category: "electricity_buffer",
  date: income_date,
  amount: 400,
  description: "Qcells: payback"
)

# ================================
# EXPENSES TRANSACTIONS
# ================================

# water (RheinEnergie)
Transaction.create(
  transaction_type: "expense",
  name: "water_bill",
  category: "water_bill",
  date: expense_date,
  amount: 49.0,
  description: "RheinEnergie: monthly water bill"
)

# internet (Telekom)
Transaction.create(
  transaction_type: "expense",
  name: "internet_bill",
  category: "internet_bill",
  date: expense_date,
  amount: 54.0,
  description: "Maren: internet Telekom"
)

# GEZ Rundfunk
Transaction.create(
  transaction_type: "expense",
  name: "gez",
  category: "gez",
  date: expense_date,
  amount: 55.08,
  description: "Rundfunk (GEZ) fee"
)

# wash machine (Jonathan: Leasing of the wash machine)
Transaction.create(
  transaction_type: "expense",
  name: "wash_machine_bill",
  category: "wash_machine_bill",
  date: expense_date,
  amount: 14.99,
  description: "Jonathan: Leaning of the wash machine"
)

# flat electricity (Jonathan: flat electricity (Naturstrom))
Transaction.create(
  transaction_type: "expense",
  name: "flat_electricity_bill",
  category: "flat_electricity_bill",
  date: expense_date,
  amount: 29.0,
  description: "Jonathan: flat electricity"
)

# haus electricity (Jonathan: house electricity (Qcells))
Transaction.create(
  transaction_type: "expense",
  name: "house_electricity_bill",
  category: "house_electricity_bill",
  date: expense_date,
  amount: 200.0,
  description: "Jonathan: house electricity Qcells"
)

# rent (rent: Kai und Dirk Hannheiser
Transaction.create(
  transaction_type: "expense",
  name: "rent",
  category: "rent",
  date: expense_date,
  amount: 3335.0,
  description: "rent: Kai und Dirk Hahnheiser"
)

# rent (rent: Kai und Dirk Hannheiser
Transaction.create(
  transaction_type: "expense",
  name: "rent",
  category: "rent",
  date: expense_date,
  amount: 3335.0,
  description: "rent: DOUBLE Kai und Dirk Hahnheiser "
)

# accout fees
Transaction.create(
  transaction_type: "expense",
  name: "account_fees",
  category: "account_fees",
  date: expense_date,
  amount: 3.80,
  description: "account fees"
)

# Splitwise
Transaction.create(
  transaction_type: "expense",
  name: "groceries_buffer",
  category: "groceries_buffer",
  date: expense_date,
  amount: 96.99,
  description: "Hannes groceries"
)


# IGNORE THE ENTRIES BELOW
# ================================
# FIXES BUFFERS ENTRIES
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


