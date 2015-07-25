class ChangeNameOfChangedInLogs < ActiveRecord::Migration
  def change
    # changed confilcted with Active Record.
    rename_column :logs, :changed, :modified
  end
end
