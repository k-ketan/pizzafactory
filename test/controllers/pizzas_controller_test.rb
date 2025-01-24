# frozen_string_literal: true

require 'test_helper'

class PizzasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pizza = pizzas(:pizza_with_cheese)
  end

  test 'should get index' do
    get pizzas_url, as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_not_nil json_response
    assert_equal Pizza.count, json_response.size
  end

  test 'should show pizza' do
    get pizza_url(@pizza), as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_equal @pizza.name, json_response['name']
    assert_equal @pizza.category, json_response['category']
    assert_equal @pizza.size, json_response['size']
    assert_equal @pizza.price.to_f, json_response['price'].to_f
  end

  test 'should initialize new pizza' do
    get new_pizza_url, as: :json
    assert_response :success
    json_response = response.parsed_body
    assert json_response.keys.include?('id')
  end

  test 'should create pizza with valid data' do
    assert_difference('Pizza.count', 1) do
      post pizzas_url, params: { pizza: @pizza }, as: :json
    end
    assert_response :created
    json_response = response.parsed_body
    assert_equal 'Pizza with Cheese', json_response['name']
    assert_equal 'vegetarian', json_response['category']
    assert_equal 'medium', json_response['size']
    assert_equal 9.99, json_response['price'].to_f
  end

  test 'should return not found when showing non-existent pizza' do
    get pizza_url(-1), as: :json
    assert_response :not_found
  end
end
