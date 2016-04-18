require_relative '../lib/airport'
require_relative '../lib/plane'

describe Airport do
  subject(:airport) { described_class.new}
  let(:plane) {Plane.new}
  let(:capacity) {Airport::DEFAULT_CAPACITY}

  describe 'Airport characteristics' do
    before { allow(airport).to receive(:stormy?) {false} }

      it 'has a space for the planes to land' do
        expect(subject.arrival(plane)).to eq([plane])
      end

      it 'has a default capacity' do
        expect(subject.capacity).to eq(Airport::DEFAULT_CAPACITY)
      end

      it 'the default capacity of the airport can be overriden at will' do
        bigger_airport = Airport.new(20)
        expect(bigger_airport.capacity).to eq(20)
      end
  end

  describe '#plane_exit' do
    before { allow(airport).to receive(:stormy?) {true} }

      it 'will not allow a plane to take off if the weather is stormy' do
        message = "Can't let the plane out with this weather"
        expect{subject.plane_exit}.to raise_error(message)
      end

      it 'removes plane from the airport space ' do
        allow(airport).to receive(:stormy?) {false}
        subject.arrival(plane)
        expect{subject.plane_exit}.to change{subject.airport_space.count}.by(-1)
      end
  end

  describe '#arrival' do
    before { allow(airport).to receive(:stormy?) {true} }

    it 'will not allow a plane to land if the weather is stormy' do
      message = "Can't let you land in this weather"
      expect{subject.arrival(plane)}.to raise_error(message)
    end

    it 'will not allow to land a plane if its already on land' do
      allow(airport).to receive(:stormy?) {false}
      message = "This plane is already on land"
      subject.arrival(plane)
      expect{subject.arrival(plane)}.to raise_error(message)
    end
  end

  describe '#full?' do
    before { allow(airport).to receive(:stormy?) {false} }

      it 'can not accept more planes if the airport is full' do
        plane = double("plane", :landed => false)
        Airport::DEFAULT_CAPACITY.times{subject.airport_space << plane}
        message = "No more planes for today mate"
        expect{subject.arrival(plane)}.to raise_error(message)
      end
  end
  describe '#empty' do
    before { allow(airport).to receive(:stormy?) {false} }

      it 'will not allow a plane to leave when airport is empty' do
        message = "Can't take where there is none"
        expect{subject.plane_exit}.to raise_error(message)
      end
  end
end
