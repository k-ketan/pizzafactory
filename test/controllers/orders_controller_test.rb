# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular_user)
    @order = orders(:order_one)
    @pizza = pizzas(:pizza_with_cheese)
    sign_in @user
  end

  test 'should create order with valid data' do
    assert_difference('Order.count', 1) do
      post orders_url, params: { order: { customer_name: 'John', status: 'pending', pizza_ids: [@pizza.id], side_ids: [], crust_id: 1 } }, as: :json
    end
    assert_response :created
    json_response = response.parsed_body
    assert_equal 'John', json_response['customer_name']
    assert_equal 'pending', json_response['status']
  end

  test 'should show order details' do
    get order_url(@order), as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_equal @order.id, json_response['id']
    assert_equal @order.customer_name, json_response['customer_name']
  end

  test 'should cancel order successfully' do
    assert_difference('Order.count', -1) do
      delete order_url(@order), as: :json
    end
    assert_response :ok
    json_response = response.parsed_body
    assert_equal 'Order canceled successfully.', json_response['message']
  end

  test 'should update order status' do
    patch order_url(@order), params: { order: { status: 'completed' } }, as: :json
    assert_response :ok
    json_response = response.parsed_body
    assert_equal 'completed', json_response['status']
  end

  test 'should return forbidden if user is not a customer' do
    sign_out @user
    @user = users(:vendor_user)
    sign_in @user
    post orders_url, params: { order: { customer_name: 'John Doe', status: 'pending', pizza_ids: [1], side_ids: [1], crust_id: 1 } }, as: :json
    assert_response :forbidden
    json_response = response.parsed_body
    assert_equal 'Only customers can place orders', json_response['error']
  end
end
