# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :item_name
      t.integer :quantity

      t.timestamps
    end
  end
end
