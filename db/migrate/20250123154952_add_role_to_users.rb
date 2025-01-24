# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, default: 'customer', null: false
  end
end
