class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :status
      t.references :plane, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
