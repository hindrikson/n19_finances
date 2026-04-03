class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.string :name
      t.date :date
      t.text :description
      t.float :amount
      t.references :room, null: true, foreign_key: true
      t.references :buffer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
