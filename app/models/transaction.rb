class Transaction < ApplicationRecord
  belongs_to :room, optional: true

  EXPENSE_CATEGORIES = ExpenseCategories::CATEGORIES
  BUFFER_CATEGORIES = BufferCategories::CATEGORIES
  ALL_CATEGORIES = (EXPENSE_CATEGORIES + BUFFER_CATEGORIES).freeze
  TRANSACTION_TYPES = %w[income expense].freeze

  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
  validates :category, inclusion: { in: ALL_CATEGORIES }, if: -> { category.present? }

  before_save :set_room_attributes
  after_save :create_buffer_entry

  private

  def set_room_attributes
    if room.present? && transaction_type == "income"
      self.name = room.name
      self.description = description.blank? ? room.payment_description(amount) : description
    end
  end

  def create_buffer_entry
    if BUFFER_CATEGORIES.include?(category)
      BufferEntry.create(
        transaction_type: transaction_type,
        name: name,
        date: date,
        amount: amount,
        category: category,
        description: description
      )
    end
  end

end
