require 'test_helper'

class CarTest < ActiveSupport::TestCase
    def setup
        @car = Car.create(make: 'Toyota', model: 'Yaris', year: 2019, 
        kilometers: 1000, max_wheel_usage_before_change: 12000, 
        max_trunk_space: 100)
    end


    test "returns a full_model string" do
        assert_equal @car.full_model, 'Toyota Yaris 2019'
    end

    test "returns available trunk space" do
        assert_equal @car.available_trunk_space, 100
        @car.update(current_trunk_usage: 50)
        assert_equal @car.available_trunk_space, 50
    end

    test "returns kilometers_before_wheel_change" do
        assert_equal @car.kilometers_before_wheel_change, 12000
        @car.update(current_wheel_usage: 6000)
        assert_equal @car.kilometers_before_wheel_change, 6000
    end

    test "update current_trunk_usage, when store_in_trunk < limit " do
        @car.store_in_trunk(50)       
        assert_equal @car.current_trunk_usage, 50
    end

    test "fails current_trunk_usage update, when store_in_trunk > limit " do
        assert_raise RuntimeError do
            @car.store_in_trunk(1000)
        end      
    end

    test "returns wheel_usage_status when current_wheel_usage > threshold" do
        @car.update(current_wheel_usage: 11000)
        assert_equal @car.wheel_usage_status, 'Please change your wheels'
    end

    test "returns wheel_usage_status when current_wheel_usage < threshold" do
        @car.update(current_wheel_usage: 6000)
        assert_equal @car.wheel_usage_status, 'Wheels are OK, you can keep using them'
    end

    
end