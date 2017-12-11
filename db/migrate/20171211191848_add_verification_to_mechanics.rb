class AddVerificationToMechanics < ActiveRecord::Migration[5.1]
  def change
    add_column :mechanics, :verification, :boolean
  end
end
