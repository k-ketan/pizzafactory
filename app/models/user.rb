# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[customer vendor].freeze

  validates :role, inclusion: { in: ROLES }

  def vendor?
    role == 'vendor'
  end

  def customer?
    role == 'customer'
  end
end
