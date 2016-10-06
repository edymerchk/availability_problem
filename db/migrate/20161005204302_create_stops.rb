class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.belongs_to :ride, foreign_key: true
      t.integer :order
      t.string :name

      t.timestamps
    end
  end
end
