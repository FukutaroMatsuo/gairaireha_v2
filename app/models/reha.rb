class Reha < ApplicationRecord
  
  validates :day, presence: true

  belongs_to :user, dependent: :destroy
  belongs_to :patient, dependent: :destroy
  
  # 実人数（distinct）と延べ人数
  scope :patient_count, -> { count(:patient_id) }
  
  # 1単位数
  scope :one_unit, -> { where(unit: 1).sum(:unit) }
  
  # 2単位数
  scope :multiple_unit, -> { where.not(unit: 1).sum(:unit) }
  
  # 総単位数
  scope :sum_unit, -> { sum(:unit) }

  # 今月の稼働日
  scope :this_month, -> { where(day: Date.today.all_month) }

  # 先月の稼働日
  scope :prev_month, -> { where(day: Date.today.last_month.all_month) }

  # 今年度の稼働日
  scope :this_year, -> { where(day: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)) }

  # 前年度の稼働日
  scope :prev_year, -> { where(day: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)) }

  # 今月の日報
  scope :this_month_report, -> { this_month.eager_load(:patient).group(:'patients.deasease').order('patients.deasease DESC').group("extract(day from day)").sum_unit }
  
  # 今年度の月報
  scope :this_year_report, -> { this_year.eager_load(:patient).group(:'patients.deasease').group("extract(year from day), extract(month from day)").order('patients.deasease DESC').sum_unit }

  # 今年度の実人数
  scope :num_of_people_this_year, -> { this_year.group("extract(month from day)").distinct.patient_count }
  
  # 今年度の単位数
  scope :unit_this_year, -> { this_year.group("extract(month from day)").sum_unit }

  # 今年度の疾患別リハ人数
  scope :deasease_this_year, -> { this_year.eager_load(:patient).group(:'patients.deasease').order('patients.deasease DESC').sum_unit }

  # 今年度のPT別リハ人数
  scope :pt_this_year, -> { this_year.eager_load(:user).group(:'users.name').group("extract(month from day)").sum_unit }

  # 年度別かつPT別の総単位数
  scope :pt_all_year, -> { this_year.eager_load(:user).group(:'users.name').sum_unit }

  # 稼働日のデータ
  scope :get_day, -> { order(day: "DESC").select(:day).distinct }

  # 運動器総単位数
  scope :locomotor_unit, -> { eager_load(:patient).where("patients.deasease='運動器'").sum_unit }

  # 脳血管総単位数
  scope :cerebrovascular_unit, -> { eager_load(:patient).where("patients.deasease='脳血管'").sum_unit }

  # 呼吸器総単位数
  scope :respiratory_unit, -> { eager_load(:patient).where("patients.deasease='呼吸器'").sum_unit }
  
  # 運動器人数
  scope :locomotor_count, -> { eager_load(:patient).where("patients.deasease='運動器'").distinct.patient_count }

  # 脳血管人数
  scope :cerebrovascular_count, -> { eager_load(:patient).where("patients.deasease='脳血管'").distinct.patient_count }

  # 呼吸器人数
  scope :respiratory_count, -> { eager_load(:patient).where("patients.deasease='呼吸器'").distinct.patient_count }
  
  # 新規患者数
  scope :new_patient, -> { where(day: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).eager_load(:patient).where('patients.start_day': Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).group("extract(year from patients.start_day)", "extract(month from patients.start_day)").order("extract_year_from_patents_start_day", "extract_month_from_patients_start_day").count(:'patients.id') }
  
  # 今年度の月別のグルーピング
  scope :month_of_grouup, -> { group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day") }



  # 月間稼働率
  def self.operation_month
    # リハ一郎、リハ二郎の総単位数
    @d1 = self.where(day: Date.today.all_month).where(user_id: [2,3]).sum_unit

    @d1 * 100 / 864
  end
  
  # 前月稼働率
  def self.operation_prev_month
    @d1 = self.where(day: Date.today.last_month.all_month).where(user_id: [2,3]).sum_unit
    
    @d1 * 100 / 864
  end
  
  # 今年度稼働率
  def self.operation_this_year
    @d1 = self.where(day: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)).where(user_id: [2,3]).sum_unit
    
    @d1 * 100 / 10368
  end
  
  # 月間稼働率グラフ
  def self.operation
    @d1 = self.where(day: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).group("extract(month from day)").where(user_id: [2,3]).sum_unit
    
    @d1.transform_values { |x| x * 100 / 864 }
  end
  
  # 収益
  def self.revenue
    # 計画書
    @d1 = self.eager_load(:patient).where.not("patients.deasease='脳血管'").patient_count
    # 運動器点数
    @d2 = self.eager_load(:patient).where("patients.deasease='運動器'").sum_unit
    # 呼吸器点数
    @d3 = self.eager_load(:patient).where("patients.deasease='呼吸器'").sum_unit
    # 脳血管点数
    @d4 = self.eager_load(:patient).where("patients.deasease='脳血管'").sum_unit
    
    (@d1*300) + (@d2*170) + (@d3*175) + (@d4*100)
  end

end