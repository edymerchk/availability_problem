class Ride < ApplicationRecord
  has_many :stops
  belongs_to :provider

  def available?(requested_pax, departure_stop, arrival_stop)
    requested_pax <= AvailabilityChecker.new(self, departure_stop, arrival_stop).available_seats
  end
end
