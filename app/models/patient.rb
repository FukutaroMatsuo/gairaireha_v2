class Patient < ApplicationRecord
  
  belongs_to :user, dependent: :destroy
  has_many :rehas, dependent: :destroy
  has_many :reha_users, through: :rehas, source: :user
  
  validates :patient_name, presence: true  
  validates :kana, presence: true  
  validates :birthday, length: { in: 0..10 }
  validates :area, length: { in: 0..20 }
  validates :start_day, length: { in: 0..10 }
  validates :deasease, presence: true, length: { in: 1..10 }
  validates :goal, length: { in: 0..30 }
  validates :achievement, length: { in: 0..10 }
  validates :drop_out, length: { in: 0..20 }

  
  # 今年度の目標達成率
  def self.goal_achievement
    # 今年度の新規患者
    @d1 = self.where(start_day: Date.new(2020, 4, 1)..Date.new(2021, 3, 31))
    # 今年度の新規患者数
    @d2 = @d1.count
    # 今年度の新規患者のうち目標達成者数
    @d3 = @d1.where("patients.achievement='達成'").count
    
    @d3 * 100 / @d2
  end
  
  # 一ヶ月継続率
  def self.one_month
    # 先月の新規患者
    @d1 = self.where(start_day: Date.today.last_month.all_month)
    # 先月の新規患者の数
    @d2 = @d1.count
    # 先月の新規患者のうち今月も来ている数
    @d3 = @d1.eager_load(:rehas).where('rehas.day':Date.today.all_month).count(:patient_id)
    
    @d3 * 100 / @d2
  end
  
  # 三ヶ月継続率
  def self.three_month
    # 3ヶ月前の新規患者
    @d1 = self.where(start_day: Date.today.ago(3.month).all_month)
    # 3ヶ月前の新規患者の数
    @d2 = @d1.count
    # 3ヶ月前の新規患者のうち今月も来ている数
    @d3 = @d1.eager_load(:rehas).where('rehas.day':Date.today.all_month).count(:patient_id)
    
    @d3 * 100 / @d2
  end
  
  # 今月の中止者
  def self.drop_out
    @d1 = self.eager_load(:rehas).where('rehas.day': Date.today.last_month.all_month)
    @d2 = self.eager_load(:rehas).where('rehas.day': Date.today.all_month)
    
    @d1 - @d2
  end
  
  # 前月の中止者
  def self.drop_out_prev_month
    @d1 = self.eager_load(:rehas).where('rehas.day': Date.today.ago(2.month).all_month)
    @d2 = self.eager_load(:rehas).where('rehas.day': Date.today.last_month.all_month)
    
    @d3 = @d1 - @d2
    
    @d3
  end
  
  # 今月の患者
  def self.now_patients
    self.eager_load(:rehas).where('rehas.day': Date.today.all_month)
  end
  
  # 起算日の降順
  scope :start_day_desc, -> { order(start_day: 'DESC') }

  # 前年度が起算日
  scope :prev_year, -> { where(start_day: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)) }

  # 今年度が起算日
  scope :this_year, -> { where(start_day: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)) }

  # 今月が起算日
  scope :this_month, -> { where(start_day: Date.today.all_month) }

  # 患者ののあいうえお順
  scope :order_kana, -> { order('kana COLLATE "C" ASC') }

end
