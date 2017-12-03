class AddCordsToMechanics < ActiveRecord::Migration[5.1]
  def change
    add_column :mechanics, :lat, :float
    add_column :mechanics, :lng, :float
  end
end
