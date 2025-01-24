# frozen_string_literal: true

require 'test_helper'

class InventoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vendor = users(:vendor_user) # Assuming you have a vendor user fixture
    @non_vendor = users(:regular_user) # Assuming a regular user fixture
    @item = inventories(:inventory_cheese) # Assuming you have an item in the inventory fixture
  end

  test 'should restock item successfully' do
    sign_in @vendor # Sign in as a vendor user
    post inventory_restock_url, params: { item_name: @item.item_name, quantity: 10 }, as: :json
    assert_response :success
    json_response = response.parsed_body
    assert_equal I18n.t('inventory.restock.success'), json_response['message']
  end

  test 'should return item not found error' do
    sign_in @vendor
    post inventory_restock_url, params: { item_name: 'NonExistentItem', quantity: 10 }, as: :json
    assert_response :not_found
    json_response = response.parsed_body
    assert_equal I18n.t('inventory.restock.item_not_found'), json_response['error']
  end

  test 'should require user authentication' do
    post inventory_restock_url, params: { item_name: @item.item_name, quantity: 10 }, as: :json
    assert_response :unauthorized
  end

  test 'should return forbidden for non-vendor user' do
    sign_in @non_vendor
    post inventory_restock_url, params: { item_name: @item.item_name, quantity: 10 }, as: :json
    assert_response :forbidden
    json_response = response.parsed_body
    assert_equal I18n.t('inventory.restock.vendor_access'), json_response['error']
  end
end
