class ChangeItemAndNewStateInLogs < ActiveRecord::Migration
  def change
    # Will be a serialised array of items affected
    rename_column :logs, :item, :items
    change_column :logs, :items, :text
    
    # Will be a serialized hash {added: [], removed: []} of features changed
    rename_column :logs, :new_state, :changed
    change_column :logs, :changed, :text
  end
end
