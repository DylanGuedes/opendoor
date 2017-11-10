class AddAddressToBikeStations < ActiveRecord::Migration[5.1]
  def change
    add_column :bike_stations, :address, :string
  end
end
