class CreateAirQualities < ActiveRecord::Migration[5.1]
  def change
    create_table :air_qualities do |t|
      t.string :worker_uuid
      t.integer :worker
      t.string :uuid
      t.belongs_to :platform
      t.string :region
      t.float :lat
      t.float :lon
      t.string :status

      t.timestamps
    end
  end
end
