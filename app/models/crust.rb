# frozen_string_literal: true

class Crust < ApplicationRecord
  belongs_to :pizza, optional: true
  validates :name, presence: true
end
