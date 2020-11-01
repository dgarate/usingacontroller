require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'Car model spec' do
    let(:car) do
      Car.create(make: 'Toyota', model: 'Yaris', year: 2019,
                 kilometers: 1000, max_wheel_usage_before_change: 12000,
                 max_trunk_space: 100)
    end
    context 'basic methods' do
      it 'should return basic model info' do
        expect(car.make).to eq 'Toyota'
        expect(car.model).to eq 'Yaris'
      end
    end
  end

  describe 'Customs methods' do
    let(:car) do
      Car.create(make: 'Toyota', model: 'Yaris', year: 2019,
                 kilometers: 1000, max_wheel_usage_before_change: 12000,
                 max_trunk_space: 100)
    end
    context 'test full_model method' do
      it 'returns a full_model string' do
        expect(car.full_model).to eq 'Toyota Yaris 2019'
      end
    end
    
    context 'test available trunk space method' do
      it 'returns available trunk space' do
        expect(car.available_trunk_space).to eq 100
        car.update(current_trunk_usage: 50)
        expect(car.available_trunk_space).to eq 50
      end
    end

    context 'test kilometers_before_wheel_change method' do
      it 'returns kilometers_before_wheel_change' do
        expect(car.kilometers_before_wheel_change).to eq 12000
        car.update(current_wheel_usage: 6000)
        expect(car.kilometers_before_wheel_change).to eq 6000
      end
    end

    context 'test store_in_trunk method when store_in_trunk < limit' do
      it 'returns success message' do
        car.store_in_trunk(50)       
        expect(car.current_trunk_usage).to eq 50
      end
    end

    context 'test store_in_trunk method' do
      it 'test store_in_trunk method when store_in_trunk < limit' do
        car.store_in_trunk(50)       
        expect(car.current_trunk_usage).to eq 50
      end

      it 'test store_in_trunk method when store_in_trunk > limit' do
        expect{car.store_in_trunk(1500)}.to raise_error(RuntimeError)
      end
    end

    context 'test wheel_usage_status method' do
      it 'test wheel_usage_status when current_wheel_usage > threshold' do
        car.update(current_wheel_usage: 12000)
        expect(car.wheel_usage_status).to eq 'Please change your wheels'
      end
  
      it 'test wheel_usage_status when current_wheel_usage < threshold' do
        car.update(current_wheel_usage: 6000)
        expect(car.wheel_usage_status).to eq 'Wheels are OK, you can keep using them'
      end
    end

  end
end
