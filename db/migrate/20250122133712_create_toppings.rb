# frozen_string_literal: true

class CreateToppings < ActiveRecord::Migration[7.1]
  def change
    create_table :toppings do |t|
      t.string :name
      t.decimal :price
      t.integer :category
      t.references :pizza, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
