class AddStepToAirQualities < ActiveRecord::Migration[5.1]
  def change
    add_column :air_qualities, :step, :integer
  end
end
