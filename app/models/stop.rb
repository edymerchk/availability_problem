class Stop < ApplicationRecord
  has_many :connections
  belongs_to :ride

  scope :between, -> (departure, arrival) {
    where("stops.order >= :departure_order AND stops.order <= :arrival_order",
         departure_order: departure.order, arrival_order: arrival.order )}

  def connections
     Connection.where(departure_stop: self).or(Connection.where(arrival_stop: self))
  end
end
