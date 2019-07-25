# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string :username, null: false, limit: 60
    end
  end

  def down
    drop_table :users
  end
end
