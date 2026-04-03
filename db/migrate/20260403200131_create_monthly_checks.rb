class CreateMonthlyChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_checks do |t|
      t.date :month
      t.float :account_state
      t.float :transactions_sum

      t.timestamps
    end
  end
end
