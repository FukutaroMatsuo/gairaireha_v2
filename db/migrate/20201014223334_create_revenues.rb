class CreateRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :revenues do |t|
      t.date :working_month
      t.integer :score

      t.timestamps
    end
  end
end
