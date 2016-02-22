class RemoveFieldsFromCompany < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :owner_id, :integer
    remove_column :companies, :time_zone, :string
  end
end
