class CreateRehas < ActiveRecord::Migration[5.2]
  def change
    create_table :rehas do |t|
      t.integer :user_id
      t.integer :patient_id
      t.date :day
      t.integer :unit

      t.timestamps
    end
  end
end
