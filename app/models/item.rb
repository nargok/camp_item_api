class Item < ApplicationRecord
  has_many :item_lists
  has_many :plans, through: :item_lists
end
