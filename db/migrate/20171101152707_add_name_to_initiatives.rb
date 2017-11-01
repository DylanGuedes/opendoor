class AddNameToInitiatives < ActiveRecord::Migration[5.1]
  def change
    add_column :initiatives, :name, :string
  end
end
