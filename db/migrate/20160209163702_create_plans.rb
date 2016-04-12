class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.references :company, index: true, type: :uuid
      t.string :name
      t.integer :interval, null: false, default: 0
      t.integer :price
      t.boolean :monday, null: false, default: false
      t.boolean :tuesday, null: false, default: false
      t.boolean :wednesday, null: false, default: false
      t.boolean :thursday, null: false, default: false
      t.boolean :friday, null: false, default: false
      t.boolean :saturday, null: false, default: false
      t.boolean :sunday, null: false, default: false
      t.boolean :taxable, null: false, default: false

      t.timestamps
    end
  end
end
