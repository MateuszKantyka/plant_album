class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :car
      t.float :cost
      t.integer :rating_general
      t.integer :rating_cost
      t.integer :rating_time
      t.references :user, foreign_key: true
      t.references :mechanic, foreign_key: true
      t.timestamps
    end
  end
end
