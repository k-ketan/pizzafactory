# frozen_string_literal: true

require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  def setup
    @inventory = Inventory.create(item_name: 'Widget', quantity: 10)
  end

  test 'should be valid with item_name and quantity' do
    assert @inventory.valid?
  end

  test 'should not be valid without item_name' do
    @inventory.item_name = nil
    assert_not @inventory.valid?
  end

  test 'should not be valid without quantity' do
    @inventory.quantity = nil
    assert_not @inventory.valid?
  end

  test 'should restock item successfully' do
    @inventory.restock('Widget', 5)
    assert_equal 15, @inventory.reload.quantity
  end

  test 'restock should do nothing for non-existent item' do
    assert_no_changes 'Inventory.count' do
      assert_nil Inventory.find_by(item_name: 'NonExistentItem')
      Inventory.new.restock('NonExistentItem', 5)
    end
  end
end
