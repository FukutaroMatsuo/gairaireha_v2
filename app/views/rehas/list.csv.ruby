require 'csv'

CSV.generate do |csv|
  csv_column_labels = ["", "合計", "運動器", "脳血管", "呼吸器"]
  csv << csv_column_labels
  csv_column_values = [
    "人数",
    @reha.locomotor_count + @reha.cerebrovascular_count + @reha.respiratory_count,
    @reha.locomotor_count,
    @reha.cerebrovascular_count,
    @reha.respiratory_count,
  ]
  csv << csv_column_values

  csv_column_values = [
    "単位数",
    @reha.locomotor_unit + @reha.cerebrovascular_unit + @reha.respiratory_unit,
    @reha.locomotor_unit,
    @reha.cerebrovascular_unit,
    @reha.respiratory_unit,
  ]
  csv << csv_column_values
  
  csv_column_labels = ["", "実施者名", "患者名", "疾患別", "単位数"]
  csv << csv_column_labels
  @reha.each do |reha|
    csv_column_values = [
      "",
      reha.user.name,
      reha.patient.patient_name,
      reha.patient.deasease,
      reha.unit,
    ]
    csv << csv_column_values
  end

end