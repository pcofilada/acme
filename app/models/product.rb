class Product < ApplicationRecord
  has_many :histories, as: :historyable
end
