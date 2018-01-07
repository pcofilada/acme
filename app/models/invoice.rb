class Invoice < ApplicationRecord
  belongs_to :order

  has_many :histories, as: :historyable
end
