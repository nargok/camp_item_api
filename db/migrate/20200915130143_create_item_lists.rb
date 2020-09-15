class CreateItemLists < ActiveRecord::Migration[6.0]
  def change
    create_table :item_lists do |t|
      t.references :plan
      t.references :item

      t.timestamps
    end
  end
end
