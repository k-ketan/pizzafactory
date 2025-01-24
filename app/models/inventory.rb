# frozen_string_literal: true

class Inventory < ApplicationRecord
  validates :item_name, :quantity, presence: true

  def restock(item_name, quantity)
    item = Inventory.find_by(item_name: item_name)
    item&.update(quantity: item.quantity + quantity)
  end
end
