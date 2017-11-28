class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :worker_uuid
      t.integer :worker
      t.string :uuid
      t.integer :post_id
      t.integer :step
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
