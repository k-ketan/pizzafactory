# frozen_string_literal: true

require 'test_helper'

class ToppingTest < ActiveSupport::TestCase
  def setup
    @inventory = inventories(:inventory_cheese)
    @topping = Topping.new(name: 'Cheese', price: 9.99, category: :veg)
  end

  test 'should be valid with valid attributes' do
    assert @topping.valid?, 'Topping should be valid with name, price, category, and inventory'
  end

  test 'should not be valid without a name' do
    @topping.name = nil
    assert_not @topping.valid?, 'Topping is valid without a name'
    assert_includes @topping.errors[:name], "can't be blank"
  end

  test 'should not be valid without a price' do
    @topping.price = nil
    assert_not @topping.valid?, 'Topping is valid without a price'
    assert_includes @topping.errors[:price], "can't be blank"
  end

  test 'should not be valid without a category' do
    @topping.category = nil
    assert_not @topping.valid?, 'Topping is valid without a category'
    assert_includes @topping.errors[:category], "can't be blank"
  end

  test 'should allow category as veg or non_veg' do
    @topping.category = :veg
    assert @topping.valid?, "Topping should be valid with category 'veg'"

    @topping.category = :non_veg
    assert @topping.valid?, "Topping should be valid with category 'non_veg'"

    assert_raises(ArgumentError) do
      @topping.category = :invalid_category
    end
  end
end
