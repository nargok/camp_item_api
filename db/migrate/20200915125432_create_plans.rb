class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :place
      t.text :memo

      t.timestamps
    end
  end
end
