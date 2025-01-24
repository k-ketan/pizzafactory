# frozen_string_literal: true

class Side < ApplicationRecord
  validates :name, :price, presence: true
end
