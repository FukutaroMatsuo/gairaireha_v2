class AddKanaToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :kana, :string
  end
end
