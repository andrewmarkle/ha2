class AddFieldsToPlan < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :price, :integer
    add_column :plans, :total_price, :integer, null: false, default: 0
    add_column :plans, :price_per_walk, :integer, null: false, default: 0
  end
end
