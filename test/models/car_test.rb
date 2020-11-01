require 'test_helper'

class CarTest < ActiveSupport::TestCase
    test "returns a full_model string" do
        car = Car.create(make: 'Toyota', model: 'Yaris', year: 2019, 
            kilometers: 1000, max_wheel_usage_before_change: 12000, 
            max_trunk_space: 100)
        assert car.full_model = 'Toyota Yaris 2019'
    end
end