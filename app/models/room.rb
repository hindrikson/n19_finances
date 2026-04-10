class Room < ApplicationRecord
  has_many :flatmates
  has_many :transactions
end
