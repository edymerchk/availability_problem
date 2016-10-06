class AvailabilityChecker
  def initialize(ride, departure_stop, arrival_stop)
    @ride = ride
    @departure_stop = departure_stop
    @arrival_stop = arrival_stop
  end

  def available_seats
    @ride.capacity - number_of_bookings
  end


  def number_of_bookings
    Booking.where(connection: connections).sum(:pax)
  end

  def connections
    between_touching_coonections + arround_coonections
  end

  def between_touching_coonections
    Stop.between(@departure_stop, @arrival_stop).map do |stop|
      stop.connections
    end.flatten.uniq
  end

  def arround_coonections
    Connection.joins("INNER JOIN stops AS departures ON connections.departure_stop_id = departures.id ")
      .joins("INNER JOIN stops AS arrivals ON connections.arrival_stop_id = arrivals.id")
        .where("departures.order < :departure_order AND arrivals.order > :arrival_order", departure_order: @departure_stop.order, arrival_order: @arrival_stop.order )
  end
end
