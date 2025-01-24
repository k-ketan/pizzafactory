# frozen_string_literal: true

require 'test_helper'

class MenuControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular_user)
    sign_in @user
  end

  test 'should get index and return all menu items' do
    get menu_index_url, as: :json
    assert_response :success

    json_response = response.parsed_body
    assert_not_nil json_response['pizzas']
    assert_not_nil json_response['crusts']
    assert_not_nil json_response['toppings']
    assert_not_nil json_response['sides']

    assert_operator json_response['pizzas'].size, :>, 0
    assert_operator json_response['crusts'].size, :>, 0
    assert_operator json_response['toppings'].size, :>, 0
    assert_operator json_response['sides'].size, :>, 0
  end

  test 'should return unauthorized if not authenticated' do
    sign_out @user
    get menu_index_url, as: :json
    assert_response :unauthorized
  end
end
