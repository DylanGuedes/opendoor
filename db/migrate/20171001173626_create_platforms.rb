class CreatePlatforms < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms do |t|
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
