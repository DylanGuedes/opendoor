class CreateFreeWifiStations < ActiveRecord::Migration[5.1]
  def change
    create_table :free_wifi_stations do |t|
      t.string :worker_uuid
      t.integer :worker
      t.string :uuid
      t.belongs_to :platform
      t.float :lat
      t.float :lon
      t.string :status
    end
  end
end
