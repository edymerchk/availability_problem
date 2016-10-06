class CreateRides < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.belongs_to :provider, foreign_key: true
      t.integer :capacity, default: 50

      t.timestamps
    end
  end
end
