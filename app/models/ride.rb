class Ride < ApplicationRecord
  has_many :stops
  belongs_to :provider

  def available?(requested_pax, departure_stop, arrival_stop)
    requested_pax <= available_seats(departure_stop, arrival_stop)
  end

  private

  def available_seats(departure_stop, arrival_stop)
    capacity - number_bookings(departure_stop, arrival_stop)
  end

  def number_bookings(departure_stop, arrival_stop)
    Booking.where(connection: connections(departure_stop, arrival_stop)).sum(:pax)
  end

  def connections(departure_stop, arrival_stop)
    between_coonections(departure_stop, arrival_stop) + arround_coonections(departure_stop, arrival_stop)
  end

  def between_coonections(departure_stop, arrival_stop)
    Stop.between(departure_stop, arrival_stop).map do |stop|
      stop.connections
    end.flatten.uniq
  end

  def arround_coonections(departure_stop, arrival_stop)
    Connection.joins("INNER JOIN stops AS departures ON connections.departure_stop_id = departures.id ")
      .joins("INNER JOIN stops AS arrivals ON connections.arrival_stop_id = arrivals.id")
        .where("departures.order < :departure_order AND arrivals.order > :arrival_order", departure_order: departure_stop.order, arrival_order: arrival_stop.order )
  end
end
