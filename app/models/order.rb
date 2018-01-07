class Order < ApplicationRecord
  has_many :invoices
  has_many :histories, as: :historyable
end
