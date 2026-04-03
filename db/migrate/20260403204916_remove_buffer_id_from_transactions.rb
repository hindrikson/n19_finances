class RemoveBufferIdFromTransactions < ActiveRecord::Migration[8.1]
  def change
    remove_column :transactions, :buffer_id, :integer
  end
end
