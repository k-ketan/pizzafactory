# frozen_string_literal: true

class Topping < ApplicationRecord
  belongs_to :pizza, optional: true
  enum :category, { veg: 0, non_veg: 1 }

  validates :name, :price, :category, presence: true
end
