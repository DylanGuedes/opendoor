class AddAddressToInitiatives < ActiveRecord::Migration[5.1]
  def change
    add_column :initiatives, :address, :string
  end
end
