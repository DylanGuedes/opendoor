class AddCityToInitiatives < ActiveRecord::Migration[5.1]
  def change
    add_column :initiatives, :city, :string
  end
end
