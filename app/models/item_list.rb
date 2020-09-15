class ItemList < ApplicationRecord
  belongs_to :plan
  belongs_to :item
end
