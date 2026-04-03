class RenameMonthToDateInBufferEntries < ActiveRecord::Migration[7.0]
  def change
    rename_column :buffer_entries, :month, :date
  end
end
