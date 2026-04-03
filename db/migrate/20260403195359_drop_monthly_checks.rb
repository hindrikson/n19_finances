class DropMonthlyChecks < ActiveRecord::Migration[7.0]
  def change
    drop_table :monthly_checks
  end
end
