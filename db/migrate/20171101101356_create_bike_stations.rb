class CreateBikeStations < ActiveRecord::Migration[5.1]
  def change
    create_table :bike_stations do |t|
      t.string :worker_uuid
      t.integer :worker
      t.string :uuid
      t.belongs_to :platform
      t.string :bike_station_uuid
      t.float :lat
      t.float :lon
      t.string :status

      t.timestamps
    end
  end
end
