# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :ensure_customer!, only: :create
  before_action :set_order, only: %i[show update destroy]

  def show
    render json: @order
  end

  def create
    order = Order.new(order_params)
    if order.save
      update_inventory(order)
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy
      render json: { message: 'Order canceled successfully.' }, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_name, :status, pizza_ids: [], side_ids: [], crust_id: [])
  end

  def update_inventory(order)
    order.pizzas.each do |pizza|
      pizza.toppings.each do |topping|
        inventory_item = Inventory.find_by(item_name: topping.name)
        inventory_item.update(quantity: inventory_item.quantity - 1)
      end
    end
  end

  def ensure_customer!
    return if current_user.customer?

    render json: { error: 'Only customers can place orders' }, status: :forbidden
  end
end
