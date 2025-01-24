# frozen_string_literal: true

class ToppingsController < ApplicationController
  before_action :set_topping, only: :show

  def index
    @toppings = Topping.all
    render json: @toppings
  end

  def show
    render json: @topping
  end

  def new
    @topping = Topping.new
    render json: @topping
  end

  def create
    topping = Topping.new(topping_params)
    if topping.save
      render json: topping, status: :created
    else
      render json: { errors: topping.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name, :price, :category)
  end
end
