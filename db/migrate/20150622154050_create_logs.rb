class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :description
      t.string :item
      t.string :new_state

      t.timestamps null: false
    end
  end
end
