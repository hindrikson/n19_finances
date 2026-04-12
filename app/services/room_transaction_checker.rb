class RoomTransactionChecker
  Result = Data.define(:room_id, :year, :month, :sum, :due, :difference, :match, :description)

  def initialize(room, year, month)
    @room = room
    @year = year
    @month = month
  end

  def call
    Result.new(
      room_id:    @room.id,
      year:       @year,
      month:      @month,
      sum:        sum,
      due:        due,
      difference: difference,
      match:      match?,
      description: description
    )
  end

  def sum
    @sum ||= income_sum - expense_sum
  end

  def self.all_rooms(year, month)
    results = []
    Room.find_each do |room|
      results << new(room, year, month).call.description
    end
    return results
  end

  private

  def flatmate_names
    @room.flatmates.pluck(:name).join(", ")
  end

  def income_sum
    @room.transactions
      .where(transaction_type: "income")
      .where(date: date_range)
      .sum(:amount)
  end

  def expense_sum
    @room.transactions
      .where(transaction_type: "expense")
      .where(date: date_range)
      .sum(:amount)
  end

  def due
    @due ||= @room.due
  end

  def difference
    sum - due
  end

  def match?
    difference.zero?
  end

  def date_range
    Date.new(@year, @month).beginning_of_month..Date.new(@year, @month).end_of_month
  end

  def description
    if difference.zero?
      "✅ Paid — #{flatmate_names}"
    elsif difference.negative?
      "🔴 Underpaid by #{difference.abs} — #{flatmate_names}"
    else
      "🟡 Overpaid by #{difference} — #{flatmate_names}"
    end
  end

end
