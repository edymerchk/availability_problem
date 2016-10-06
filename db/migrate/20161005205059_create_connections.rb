class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.integer :departure_stop_id
      t.integer :arrival_stop_id

      t.timestamps
    end
  end
end
