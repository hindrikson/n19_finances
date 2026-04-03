# Run with: rails runner lib/scripts/seed_transactions.rb

# Room transactions
room1 = Room.find_by(name: "room_1") # Jonathan, Maren
room2 = Room.find_by(name: "room_2") # Ruda
room3 = Room.find_by(name: "room_3") # Arce
room4 = Room.find_by(name: "room_4") # Nona
room5 = Room.find_by(name: "room_5") # Tanja
room6 = Room.find_by(name: "room_6") # Viola
room7 = Room.find_by(name: "room_7") # Lisa
room8 = Room.find_by(name: "room_8") # Ronny

income_date = Date.new(2026, 2, 10)
expense_date = Date.new(2026, 2, 15)

# ================================
# Account Initial state
# ================================
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 14759.52,
  description: "Account state of January"
)

# ================================
# INCOME TRANSACTIONS
# ================================

# ---- Room income transactions ----
# Room 1
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 66.03,
  room: room1,
  description: "Korrektur Miete Dezember 25"
)

Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 82.58,
  room: room1,
  description: "Korrektur Miete Januar 26"
)

Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 82.58,
  room: room1,
  description: "Korrektur Miete Februar 26"
)

# Room 2
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 626.62,
  room: room2
)

# Room 3
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 430.73,
  room: room3
)

# Room 4
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 522.67,
  room: room4
)

# Room 5
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 0.0, # Done
  room: room5
)

# Room 6
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 473.41,
  room: room6
)

# Room 7
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 354.14,
  room: room7
)

# Room 8 (Ronny)
Transaction.create(
  transaction_type: "income",
  date: income_date,
  amount: 491.32,
  room: room8
)

Transaction.create(
  transaction_type: "income",
  name: "transfer from arce",
  date: income_date,
  amount: 14.16,
  description: "correction Rent January and February Arce (7,08e)"
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

Transaction.create(
  transaction_type: "expense",
  name: "account_fees",
  category: "account_fees",
  date: expense_date,
  amount: 3.80,
  description: "account fees"
)

# IGNORE THE ENTRIES BELOW
# ================================
# FIXES BUFFERS ENTRIES
# ================================

BufferEntry.create(
  transaction_type: "income",
  name: "oil_buffer",
  date: income_date,
  amount: 400.0,
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
  name: "deposit_buffer",
  date: income_date,
  amount: 0.0,
  category: "deposit_buffer",
  description: "default payment"
)

BufferEntry.create(
  transaction_type: "income",
  name: "electricity_buffer",
  date: income_date,
  amount: 0.0,
  category: "electricity_buffer",
  description: "default payment"
)

BufferEntry.create(
  transaction_type: "income",
  name: "water_buffer",
  date: income_date,
  amount: 0.0,
  category: "water_buffer",
  description: "default payment"
)

# ================================
# Montly check
# ================================
check = MonthlyCheck.create(
  month: income_date,
  account_state: 14217.97
)
check.allocate_remaining!
check.save_markdown!


