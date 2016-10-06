class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :connection, foreign_key: true
      t.integer :pax

      t.timestamps
    end
  end
end
