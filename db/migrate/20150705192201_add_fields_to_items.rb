class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :title, :string
    add_column :items, :features, :text
  end
end
