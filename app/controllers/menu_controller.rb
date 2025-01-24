# frozen_string_literal: true

class MenuController < ApplicationController
  before_action :authenticate_user!

  def index
    @pizzas = Pizza.all
    @crusts = Crust.all
    @toppings = Topping.all
    @sides = Side.all
    render json: {
      pizzas: @pizzas,
      crusts: @crusts,
      toppings: @toppings,
      sides: @sides
    }
  end
end
