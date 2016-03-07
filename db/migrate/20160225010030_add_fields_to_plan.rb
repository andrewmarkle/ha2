class AddFieldsToPlan < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :price, :integer
    add_column :plans, :total_price, :integer
    add_column :plans, :price_per_walk, :integer
  end
end
