class CreateTaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :taxes, id: :uuid do |t|
      t.string :name
      t.integer :rate
      t.references :company, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
