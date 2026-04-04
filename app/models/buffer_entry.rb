class BufferEntry < ApplicationRecord
  BUFFER_CATEGORIES = BufferCategories::CATEGORIES
  TRANSACTION_TYPES = %w[income expense].freeze

  validates :category, inclusion: { in: BUFFER_CATEGORIES }
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
end
