# frozen_string_literal: true

class CreateCrusts < ActiveRecord::Migration[7.1]
  def change
    create_table :crusts do |t|
      t.string :name
      t.references :pizza, foreign_key: true

      t.timestamps
    end
  end
end
