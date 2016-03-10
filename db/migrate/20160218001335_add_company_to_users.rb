class AddCompanyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :company, index: true, type: :uuid
  end
end
