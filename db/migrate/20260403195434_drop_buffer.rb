class DropBuffer < ActiveRecord::Migration[8.1]
  def change
    drop_table :buffers
  end
end
