class AddFlatmateToTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :transactions, :flatmate, :string
  end
end
