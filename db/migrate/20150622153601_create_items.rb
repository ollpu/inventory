class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :uid
      t.string :type
      
      t.timestamps null: false
    end
  end
end
