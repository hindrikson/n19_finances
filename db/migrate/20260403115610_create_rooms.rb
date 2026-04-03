class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.float :due
      t.float :paid
      t.text :description

      t.timestamps
    end
  end
end
