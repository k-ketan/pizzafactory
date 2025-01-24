# frozen_string_literal: true

class Pizza < ApplicationRecord
  belongs_to :order, optional: true
  has_one :crust, dependent: :destroy
  has_many :toppings, dependent: :destroy
  enum :category, { vegetarian: 0, non_vegetarian: 1 }
  enum :size, { regular: 0, medium: 1, large: 2 }

  validates :name, :category, :size, :price, presence: true
end
