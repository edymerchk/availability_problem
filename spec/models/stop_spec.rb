require 'rails_helper'

RSpec.describe Stop, type: :model do
  let!(:stop_a) { create(:stop, name: "Medellin", order: 1 ) }
  let!(:stop_b) { create(:stop, name: "La Paz", order: 2 ) }
  let!(:stop_c) { create(:stop, name: "Cochabamba", order: 3 ) }
  let!(:stop_d) { create(:stop, name: "Santiago de Chile", order: 4 ) }

  describe "scopes" do
    describe "between" do
      it 'returns only the stops between the departure and the arrival inclusive' do
        expect(Stop.between(stop_a, stop_c)).to include(stop_a, stop_b, stop_c)
        expect(Stop.between(stop_a, stop_c)).to_not include(stop_d)
      end
    end
  end

  describe "#connections" do
    let(:conection_1) { create(:connection, departure_stop: stop_a, arrival_stop: stop_b) }
    let(:conection_2) { create(:connection, departure_stop: stop_b, arrival_stop: stop_c) }
    let(:conection_3) { create(:connection, departure_stop: stop_c, arrival_stop: stop_d) }

    it 'returns the connections that have the stop in the departure or the arrival' do
      expect(stop_b.connections).to include(conection_1, conection_2)
      expect(stop_b.connections).to_not include(conection_3)
    end
  end
end
