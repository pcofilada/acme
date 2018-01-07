class Order < ApplicationRecord
  has_many :histories, as: :historyable
end
