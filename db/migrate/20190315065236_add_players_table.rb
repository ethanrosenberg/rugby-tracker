class AddPlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
    end
  end
end
