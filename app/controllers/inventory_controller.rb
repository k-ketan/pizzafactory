# frozen_string_literal: true

class InventoryController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_vendor!

  def restock
    item = Inventory.find_by(item_name: params[:item_name])
    if item
      item.restock(params[:item_name], params[:quantity].to_i)
      render json: { message: I18n.t('inventory.restock.success') }
    else
      render json: { error: I18n.t('inventory.restock.item_not_found') }, status: :not_found
    end
  end

  private

  def ensure_vendor!
    return if current_user.vendor?

    render json: { error: I18n.t('inventory.restock.vendor_access') }, status: :forbidden
  end
end
