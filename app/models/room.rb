class Room < ApplicationRecord
  has_many :flatmates
  has_many :transactions

  def payment_description(amount)
    flatmate_names = flatmates.map(&:name).join(", ")
    
    if amount > due
      overpaid = amount - due
      "#{flatmate_names}: Overpaid by #{overpaid}"
    elsif amount < due
      underpaid = due - amount
      "#{flatmate_names}: Underpaid by #{underpaid}"
    else
      "#{flatmate_names}: Paid exactly"
    end
  end
end
