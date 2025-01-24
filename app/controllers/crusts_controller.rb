# frozen_string_literal: true

class CrustsController < ApplicationController
  before_action :set_crust, only: %i[show update destroy]

  def index
    @crusts = Crust.all
    render json: @crusts
  end

  def show
    render json: @crust
  end

  def create
    @crust = Crust.new(crust_params)
    if @crust.save
      render json: @crust, status: :created
    else
      render json: { errors: @crust.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @crust.update(crust_params)
      render json: @crust, status: :ok
    else
      render json: { errors: @crust.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @crust.destroy
      render json: { message: 'Crust was successfully destroyed.' }, status: :ok
    else
      render json: { errors: @crust.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_crust
    @crust = Crust.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Crust not found' }, status: :not_found
  end

  def crust_params
    params.require(:crust).permit(:name)
  end
end
