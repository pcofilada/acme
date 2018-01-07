class Invoice < ApplicationRecord
  belongs_to :order, optional: true

  has_many :histories, as: :historyable
end
