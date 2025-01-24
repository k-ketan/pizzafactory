# frozen_string_literal: true

class CreateSides < ActiveRecord::Migration[7.1]
  def change
    create_table :sides do |t|
      t.string :name
      t.decimal :price
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
