describe AvailabilityChecker do
  let(:ride) { create(:ride, capacity: 50) }

  let(:stop_a) { create(:stop, name: "Medellin", order: 1, ride: ride ) }
  let(:stop_b) { create(:stop, name: "La Paz", order: 2, ride: ride ) }
  let(:stop_c) { create(:stop, name: "Cochabamba", order: 3, ride: ride ) }
  let(:stop_d) { create(:stop, name: "Santiago de Chile", order: 4, ride: ride ) }

  let!(:booking) { create(:booking, connection: conection, pax: 30) }

  describe "#available_seats" do
    context "with 1 booking with te arrival on the middle of the requested stops" do
      let(:conection) { create(:connection, departure_stop: stop_a, arrival_stop: stop_c) }
      let(:subject) { AvailabilityChecker.new(ride, stop_b, stop_d) }

      it 'includes the booking and returns 2 seats' do
        expect(subject.available_seats).to eq(20)
      end
    end

    context "with 1 booking with te departure on the middle of the requested stops" do
      let(:conection) { create(:connection, departure_stop: stop_b, arrival_stop: stop_d) }
      let(:subject) { AvailabilityChecker.new(ride, stop_a, stop_c) }

      it 'includes the booking and returns 2 seats' do
        expect(subject.available_seats).to eq(20)
      end
    end

    context "with 1 booking in the middle of the requested stops" do
      let(:conection) { create(:connection, departure_stop: stop_b, arrival_stop: stop_c) }

      let(:subject) { AvailabilityChecker.new(ride, stop_a, stop_d) }

      it 'includes the booking and returns 2 seats' do
        expect(subject.available_seats).to eq(20)
      end
    end

    context "with the requested stops in the middle of 1 booking" do
      let(:conection) { create(:connection, departure_stop: stop_a, arrival_stop: stop_d) }
      let(:subject) { AvailabilityChecker.new(ride, stop_b, stop_c) }

      it 'includes the booking and returns 2 seats' do
        expect(subject.available_seats).to eq(20)
      end
    end
  end
end
