# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:order_one)
    @pizza = pizzas(:one)

    @topping_cheese = toppings(:topping_cheese)
    @topping_pepperoni = toppings(:topping_pepperoni)
    @topping_mushrooms = toppings(:topping_mushrooms)
    @topping_truffle = toppings(:topping_truffle)

    @inventory_cheese = inventories(:inventory_cheese)
  end

  test 'should create a valid order' do
    assert @order.valid?, 'Order should be valid with valid attributes'
  end

  test 'should not be valid without a customer name' do
    @order.customer_name = nil
    assert_not @order.valid?, 'Order is valid without a customer name'
    assert_includes @order.errors[:customer_name], "can't be blank"
  end

  test 'should not allow toppings if inventory is insufficient' do
    Inventory.create!(item_name: 'cheese', quantity: 0)

    pizza = pizzas(:pizza_with_cheese)
    pizza.toppings << toppings(:topping_cheese)

    @order.pizzas << pizza
    @order.valid?
  end

  test 'should not allow status reversal after confirmed or completed' do
    order = orders(:order_confirmed)
    order.status = 'pending'
    assert_not order.save, 'Order status was reverted from confirmed to pending'
    assert_includes order.errors[:base], 'Cannot modify an order that is already confirmed'
  end

  test 'should not allow cancellation of confirmed or completed orders' do
    order = orders(:order_confirmed)
    assert_no_difference 'Order.count' do
      order.destroy
    end
    assert_includes order.errors[:base], 'Order cannot be canceled as it is already confirmed'
  end
end
