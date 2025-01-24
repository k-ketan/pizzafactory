# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :pizzas, dependent: :destroy
  has_many :sides, dependent: :destroy

  validates :customer_name, presence: true
  validate :validate_toppings, :validate_inventory

  enum :status, { pending: 'pending', confirmed: 'confirmed', completed: 'completed' }

  before_update :prevent_status_reversal, if: -> { status_was.in?(%w[confirmed completed]) }
  before_destroy :ensure_not_cancellable

  def validate_toppings
    validate_topping_count
    validate_topping_availability
    validate_premium_toppings
  end

  def validate_inventory
    pizzas.each do |pizza|
      pizza.toppings.each do |topping|
        inventory_item = Inventory.find_by(item_name: topping.name)
        errors.add(:base, "Not enough inventory for #{topping.name}") if inventory_item.nil? || inventory_item.quantity < 1
      end
    end
  end

  private

  def ensure_not_cancellable
    return unless confirmed? || completed?

    errors.add(:base, "Order cannot be canceled as it is already #{status}")
    throw(:abort)
  end

  def prevent_status_reversal
    return unless status != 'confirmed' && status != 'completed'

    errors.add(:base, "Cannot modify an order that is already #{status_was}")
    throw(:abort)
  end

  def validate_topping_count
    pizzas.each do |pizza|
      return if pizza.toppings.size <= 3

      errors.add(:base, 'Too many toppings!')
    end
  end

  def validate_topping_availability
    pizzas.each do |pizza|
      return if pizza.toppings.none?(&:unavailable?)

      errors.add(:base, 'One or more toppings are unavailable!')
    end
  end

  def validate_premium_toppings
    pizzas.each do |pizza|
      return if pizza.toppings.count(&:premium?) <= 2

      errors.add(:base, 'Only two premium toppings are allowed!')
    end
  end
end
