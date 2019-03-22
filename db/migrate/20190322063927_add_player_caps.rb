class AddPlayerCaps < ActiveRecord::Migration
  def change
    add_column :players, :caps, :integer
  end
end
