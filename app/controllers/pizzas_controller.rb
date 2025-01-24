# frozen_string_literal: true

class PizzasController < ApplicationController
  before_action :set_pizza, only: :show

  def index
    @pizzas = Pizza.all
    render json: @pizzas
  end

  def show
    render json: @pizza
  end

  def new
    @pizza = Pizza.new
    render json: @pizza
  end

  def create
    pizza = Pizza.new(pizza_params)
    if pizza.save
      render json: pizza, status: :created
    else
      render json: { errors: pizza.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(:name, :category, :size, :price)
  end
end
