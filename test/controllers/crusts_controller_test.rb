# frozen_string_literal: true

require 'test_helper'

class CrustsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crust = Crust.create(name: 'Thin Crust') # Create a sample crust for testing
  end

  test 'should get index' do
    get crusts_url, as: :json
    assert_response :success
    assert_not_empty response.body
  end

  test 'should show crust' do
    get crust_url(@crust), as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_equal @crust.name, json_response['name']
  end

  test 'should create crust' do
    assert_difference('Crust.count', 1) do
      post crusts_url, params: { crust: { name: 'Pan Crust' } }, as: :json
    end
    assert_response :created
    json_response = response.parsed_body
    assert_equal 'Pan Crust', json_response['name']
  end

  test 'should not create crust with invalid data' do
    assert_no_difference('Crust.count') do
      post crusts_url, params: { crust: { name: '' } }, as: :json
    end
    assert_response :unprocessable_entity
    json_response = response.parsed_body
    assert_includes json_response['errors'], "Name can't be blank"
  end

  test 'should update crust' do
    patch crust_url(@crust), params: { crust: { name: 'Stuffed Crust' } }, as: :json
    assert_response :ok
    @crust.reload
    assert_equal 'Stuffed Crust', @crust.name
  end

  test 'should not update crust with invalid data' do
    patch crust_url(@crust), params: { crust: { name: '' } }, as: :json
    assert_response :unprocessable_entity
    json_response = response.parsed_body
    assert_includes json_response['errors'], "Name can't be blank"
  end

  test 'should destroy crust' do
    assert_difference('Crust.count', -1) do
      delete crust_url(@crust), as: :json
    end
    assert_response :ok
    json_response = response.parsed_body
    assert_equal 'Crust was successfully destroyed.', json_response['message']
  end

  test 'should return not found when destroying a non-existent crust' do
    assert_no_difference('Crust.count') do
      delete crust_url(-1), as: :json
    end
    assert_response :not_found
    json_response = response.parsed_body
    assert_equal 'Crust not found', json_response['error']
  end
end
