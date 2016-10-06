class Connection < ApplicationRecord
  belongs_to :departure_stop, class_name: 'Stop'
  belongs_to :arrival_stop, class_name: 'Stop'
  has_many :bookings
end
