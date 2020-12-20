class Revenue < ApplicationRecord
  validates :working_month, presence: true
  validates :score,         presence: true, length: { in: 5..6 }

  # ある月の点数の取得
  scope :month_of_score, -> (month){ find_by(month).score }

  # 2018年度
  scope :two_years_ago, -> { where(working_month: Date.new(2018, 4, 1)..Date.new(2019, 3, 31)) }

  # 2019年度
  scope :last_year, -> { where(working_month: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)) }

  # 2020年度
  scope :this_year, -> { where(working_month: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)) }

  # 日付の昇順
  scope :working_month_ask, -> { order(working_month: "ASC") }

  # working_monthとscoreを配列で取得
  scope :revenue_array, -> { map { |revenue| [revenue.working_month.month, revenue.score] }.to_h }
  
  # 2018年度の収益の配列
  scope :this_year_array, -> { where(working_month: Date.new(2018, 4, 1)..Date.new(2019, 3, 31)).order(:working_month).pluck(:score) }

  # 2019年度の収益の配列
  scope :this_year_array, -> { where(working_month: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)).order(:working_month).pluck(:score) }

  # 今年度の収益の配列
  scope :this_year_array, -> { where(working_month: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).order(:working_month).pluck(:score) }

  # 収益の前年比
  def self.this_year_on_year
    d1 = self.where(working_month: Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).order(:working_month).pluck(:score)
    d2 = self.where(working_month: Date.new(2019, 4, 1)..Date.new(2020, 3, 31)).order(:working_month).pluck(:score)

    [d1, d2].each_with_object([]) { |e, a| e.each_index { |i| a[i] = -e[i] - a[i].to_i } }
  end



end