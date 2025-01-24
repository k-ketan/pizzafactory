# frozen_string_literal: true

require 'test_helper'

class PizzaTest < ActiveSupport::TestCase
  def setup
    @order = orders(:order_one)
    @pizza = Pizza.new(
      name: 'Margherita',
      category: 'vegetarian',
      size: 'regular',
      price: 8.99,
      order: @order
    )
  end

  test 'should be valid with valid attributes' do
    assert @pizza.valid?, 'Pizza should be valid with all attributes present'
  end

  test 'should not be valid without a name' do
    @pizza.name = nil
    assert_not @pizza.valid?, 'Pizza is valid without a name'
    assert_includes @pizza.errors[:name], "can't be blank"
  end

  test 'should not be valid without a category' do
    @pizza.category = nil
    assert_not @pizza.valid?, 'Pizza is valid without a category'
    assert_includes @pizza.errors[:category], "can't be blank"
  end

  test 'should not be valid without a size' do
    @pizza.size = nil
    assert_not @pizza.valid?, 'Pizza is valid without a size'
    assert_includes @pizza.errors[:size], "can't be blank"
  end

  test 'should not be valid without a price' do
    @pizza.price = nil
    assert_not @pizza.valid?, 'Pizza is valid without a price'
    assert_includes @pizza.errors[:price], "can't be blank"
  end

  test 'should allow valid categories' do
    valid_categories = %w[vegetarian non_vegetarian]
    valid_categories.each do |category|
      @pizza.category = category
      assert @pizza.valid?, "Pizza is invalid with category: #{category}"
    end
  end

  test 'should allow valid sizes' do
    valid_sizes = %w[regular medium large]
    valid_sizes.each do |size|
      @pizza.size = size
      assert @pizza.valid?, "Pizza is invalid with size: #{size}"
    end
  end
end
