class CreateMechanics < ActiveRecord::Migration[5.1]
  def change
    create_table :mechanics do |t|
      t.string :name
      t.string :city
      t.string :post_code
      t.string :address
      t.float :rating
      t.string :phone_number
      t.string :description

      t.timestamps
    end
  end
end
