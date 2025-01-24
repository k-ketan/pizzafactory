# frozen_string_literal: true

class CreatePizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.integer :category
      t.integer :size
      t.decimal :price
      t.references :order, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
