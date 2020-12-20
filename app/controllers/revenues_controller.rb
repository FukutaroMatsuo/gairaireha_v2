class RevenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_revenue, only: [:edit, :update]

  def index
    # 2018年度の収益のChart
    @revenues_data_two_years_ago = Revenue.two_years_ago.revenue_array
    # 2019年度の収益のChart
    @revenues_data_last_year = Revenue.last_year.revenue_array
    # 2020年度の収益のChart
    @revenues_data_this_year = Revenue.this_year.revenue_array
    
    # 各データのまとめ
    @d1 = [4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3]
    @d2 = Reha.this_year.eager_load(:patient).where('patients.start_day': Date.new(2020, 4, 1)..Date.new(2021, 3, 31)).group("extract(year from patients.start_day)", "extract(month from patients.start_day)").order("extract_year_from_patents_start_day", "extract_month_from_patients_start_day").count(:'patients.id').values
    @d5 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").eager_load(:patient).where("patients.deasease='運動器'").distinct.patient_count.values
    @d6 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").eager_load(:patient).where("patients.deasease='脳血管'").distinct.patient_count.values
    @d7 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").eager_load(:patient).where("patients.deasease='呼吸器'").distinct.patient_count.values
    @d8 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").distinct.patient_count.values
    @d9 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").one_unit.values
    @d10 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").multiple_unit.values
    @d11 = Reha.this_year.group("extract(year from day)", "extract(month from day)").order("extract_year_from_day", "extract_month_from_day").sum_unit.values
    @d12 = Revenue.this_year_array
    @d13 = Revenue.this_year_on_year

    # csv出力用
    respond_to do |format|
      format.html
      format.csv {
        send_data render_to_string,
                  filename: "今年度の詳細データ一覧.csv"
      }
    end 
  end

  def show

  end

  def new
    @revenue = Revenue.new
  end

  def create
    @revenue = Revenue.new(revenue_params)
    if @revenue.save
      flash[:notice] = "収益を新規登録しました"
      redirect_to action: :index and return
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @revenue.update(revenue_params)
      flash[:notice] = "収益を編集しました"
      redirect_to action: :index and return
    else
      render 'edit'
    end
  end

  private

  def set_revenue
    @revenue = Revenue.find(params[:id])
  end

  def revenue_params
    params.require(:revenue).permit(:working_month, :score)
  end

end
