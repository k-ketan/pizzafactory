# frozen_string_literal: true

require 'test_helper'

class ToppingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topping = toppings(:topping_cheese)
  end

  test 'should get index' do
    get toppings_url, as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_not_nil json_response
    assert_equal Topping.count, json_response.size
  end

  test 'should show topping' do
    get topping_url(@topping), as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_equal @topping.name, json_response['name']
    assert_equal @topping.price.to_f, json_response['price'].to_f
  end

  test 'should initialize new topping' do
    get new_topping_url, as: :json
    assert_response :success
    json_response = response.parsed_body
    assert json_response.keys.include?('id')
  end

  test 'should create topping with valid data' do
    assert_difference('Topping.count', 1) do
      post toppings_url, params: { topping: { name: 'Mushrooms', price: 1.5, category: 'veg' } }, as: :json
    end
    assert_response :created
    json_response = response.parsed_body
    assert_equal 'Mushrooms', json_response['name']
    assert_equal 1.5, json_response['price'].to_f
    assert_equal 'veg', json_response['category']
  end

  test 'should return not found when showing non-existent topping' do
    get topping_url(-1), as: :json
    assert_response :not_found
  end
end
