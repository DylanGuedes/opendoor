class AddStateToInitiatives < ActiveRecord::Migration[5.1]
  def change
    add_column :initiatives, :state, :string
  end
end
