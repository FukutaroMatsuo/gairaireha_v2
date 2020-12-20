class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :patient_name
      t.integer :user_id
      t.date :birthday
      t.date :start_day
      t.string :deasease
      t.string :area
      t.text :goal
      t.string :achievement
      t.string :drop_out

      t.timestamps
    end
  end
end
