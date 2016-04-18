require_relative '../lib/plane'

describe Plane do

subject(:plane) { described_class.new}

  describe 'Plane methods' do

    it 'allows a plane to land' do
      expect(subject).to respond_to(:land)
    end

    it 'allows a plane to take off' do
      expect(subject).to respond_to(:take_off)
    end
  end
  describe '#land' do

    it 'will assure that a plane has landed' do
      expect(subject.land).to eq(true)
    end
  end
  describe '#take_off' do

    it 'will assure that a plane has taken off' do
      expect(subject.take_off).to eq(false)
    end
  end
  describe '#landed?' do

    it 'tells you current location of the plane' do
      expect(subject.landed?).to eq(@landed)
    end
  end
end
