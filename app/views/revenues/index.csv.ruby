require 'csv'

CSV.generate do |csv|
  csv_column_labels = ["", "新規", "再利用", "中止", "運", "脳", "呼", "実人数", "1単位数", "2単位数", "総単位数", "総点数", "前年比"]
  csv << csv_column_labels

  @d1.zip(@d2, @d5, @d6, @d7, @d8, @d9, @d10, @d11, @d12, @d13) do |d|
    csv_column_values = [
      d[0],
      d[1],
      d[1],
      d[1],
      d[2],
      d[3],
      d[4],
      d[5],
      d[6],
      d[7],
      d[8],
      d[9],
      d[10],
    ]
    csv << csv_column_values
  end

end