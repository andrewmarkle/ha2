class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :url
      t.string :phone_number
      t.integer :owner_id, index: true
      t.string :time_zone
      t.string :stripe_user_id
      t.string :stripe_access_token
      t.string :stripe_publishable_key
      t.string :stripe_refresh_token

      t.timestamps
    end
  end
end
