# app/services/buffer_summary.rb
class BufferSummary
  BUFFER_CATEGORIES = BufferCategories::CATEGORIES

  def self.sum_all
    income = BufferEntry.where(category: BUFFER_CATEGORIES, transaction_type: "income").sum(:amount)
    expense = BufferEntry.where(category: BUFFER_CATEGORIES, transaction_type: "expense").sum(:amount)
    (income - expense).round(2)
  end

  def self.category_total(cat)
    income = BufferEntry.where(category: cat, transaction_type: "income").sum(:amount)
    expense = BufferEntry.where(category: cat, transaction_type: "expense").sum(:amount)
    (income - expense).round(2)
  end

  def self.categories_totals
    BUFFER_CATEGORIES.map do |cat|
      {cat: cat, total: category_total(cat)}
    end
  end

end
