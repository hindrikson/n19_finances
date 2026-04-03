class BufferEntry < ApplicationRecord
  CATEGORIES = %w[
    water_buffer
    electricity_buffer
    oil_buffer
    groceries_buffer
    reserve_buffer
    deposit_buffer
    remaining_buffer
  ].freeze

  TRANSACTION_TYPES = %w[income expense].freeze

  validates :category, inclusion: { in: CATEGORIES }
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
end
