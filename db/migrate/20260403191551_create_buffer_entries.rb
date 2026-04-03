class CreateBufferEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :buffer_entries do |t|
      t.string :transaction_type
      t.string :name
      t.date :month
      t.float :amount
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
