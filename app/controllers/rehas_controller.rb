class RehasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rehas, only: [:show, :edit, :update, :destroy]
  
  def index
    # 稼働日一覧の取得
    @get_day = Reha.get_day
    # 実人数
    @patient_count_month = Reha.this_month.distinct.patient_count
    @patient_count_prev_month = Reha.prev_month.distinct.patient_count
    @patient_count_year = Reha.this_year.distinct.patient_count
    # 延べ人数
    @total_patient_count_month = Reha.this_month.patient_count
    @total_patient_count_prev_month = Reha.prev_month.patient_count
    @total_patient_count_year = Reha.this_year.patient_count
    # 1単位数
    @one_unit_sum_month = Reha.this_month.one_unit
    @one_unit_sum_prev_month = Reha.prev_month.one_unit
    @one_unit_sum_year = Reha.this_year.one_unit
    # 2単位数
    @multiple_unit_sum_month = Reha.this_month.multiple_unit
    @multiple_unit_sum_prev_month = Reha.prev_month.multiple_unit
    @multiple_unit_sum_year = Reha.this_year.multiple_unit
    # 総単位数
    @unit_sum_month = Reha.this_month.sum_unit
    @unit_sum_prev_month = Reha.prev_month.sum_unit
    @unit_sum_year = Reha.this_year.sum_unit

    # 日報chart
    @reha_report = Reha.this_month_report
    # 月報chart
    @reha_report_month = Reha.this_year_report
    # 実人数chart
    @reha_unit_this_year = Reha.num_of_people_this_year
    # 単位数chart
    @reha_this_year = Reha.unit_this_year
    # 総収益chart
    @revenues_data_this_year = Revenue.this_year.revenue_array
    # 稼働率chart
    @operation = Reha.operation
    # 疾患別chart
    @reha_deasease_this_year = Reha.deasease_this_year
    # 専従PT別chart
    @out_patient_reha_pt_this_year = Reha.pt_this_year
    # PT別chart
    @reha_pt_this_year = Reha.pt_all_year
  end
  
  def show
    @user = @reha.user
    @patient = @reha.patient
  end

  def new
    @rehas = RehasCollection.new
  end

  def create
    @rehas = RehasCollection.new(rehas_params)
    if @rehas.save
      flash[:notice] = "今日の日報を登録しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reha.update(edit_params)
      flash[:notice] = "日報を編集しました"
      redirect_to "/list/#{@reha.day}"
    else
      render 'edit'
    end
  end

  def destroy
    @reha.destroy
    flash[:notice] = "削除が完了しました"
    redirect_to "/list/#{@reha.day}"
  end
  
  # 日報入力日の一覧
  def day
    @get_day = Reha.get_day
  end

  # ある日付の日報一覧
  def list
    @day = Reha.find_by(day: params[:day])
    @reha = Reha.where(day: params[:day])
    respond_to do |format|
      format.html
      format.csv {
        send_data render_to_string,
                  filename: "外来日報_#{@day.day}.csv"
      }
    end
  end
  
  private

  def set_rehas
    @reha = Reha.find(params[:id])
  end
  
  def rehas_params
    params.require(:rehas)
  end

  def edit_params
    params.require(:reha).permit(:day, :user_id, :patient_id, :unit)
  end
  
end