class CreateBuffers < ActiveRecord::Migration[8.1]
  def change
    create_table :buffers do |t|
      t.string :name
      t.float :due
      t.float :paid

      t.timestamps
    end
  end
end
