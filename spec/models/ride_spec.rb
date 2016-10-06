require 'rails_helper'

RSpec.describe Ride, type: :model do
  let(:ride) { create(:ride, capacity: 50) }

  describe "#available?" do
    context 'when the AvailabilitChecker#available_seats returns more than the requested_pax' do
      before { allow_any_instance_of(AvailabilityChecker).to receive(:available_seats).and_return(20) }
      it 'returns a truthy value' do
        expect(ride.available?(10, double, double)).to be_truthy
      end
    end

    context 'when the AvailabilitChecker#available_seats returns equal quantity than the requested_pax' do
      before { allow_any_instance_of(AvailabilityChecker).to receive(:available_seats).and_return(10) }
      it 'returns a truthy value' do
        expect(ride.available?(10, double, double)).to be_truthy
      end
    end

    context 'when the AvailabilitChecker#available_seats returns less than the requested_pax' do
      before { allow_any_instance_of(AvailabilityChecker).to receive(:available_seats).and_return(9) }
      it 'returns a falsey value' do
        expect(ride.available?(10, double, double)).to be_falsey
      end
    end
  end
end
