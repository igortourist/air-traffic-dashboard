class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :model
      t.string :status

      t.timestamps null: false
    end
  end
end
