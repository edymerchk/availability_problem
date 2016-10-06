require 'rails_helper'

RSpec.describe Stop, type: :model do
  describe "scopes" do
    describe "between" do
      let!(:stop_a) { create(:stop, name: "Medellin", order: 1 ) }
      let!(:stop_b) { create(:stop, name: "La Paz", order: 2 ) }
      let!(:stop_c) { create(:stop, name: "Cochabamba", order: 3 ) }
      let!(:stop_d) { create(:stop, name: "Santiago de Chile", order: 4 ) }

      it 'returns only the stops between the departure and the arrival inclusive' do
        expect(Stop.between(stop_a, stop_d)).to eql(value)
      end
    end
  end
end
