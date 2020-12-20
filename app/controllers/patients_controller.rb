class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update]
  
  def index
    @patients = Patient.all.start_day_desc
    # 今年度の新規患者
    @new_patient = Patient.this_year.start_day_desc
    # 今月の新規患者数
    @this_month_patient = Patient.this_month.count
    # 今年度の新規患者数
    @this_year_patient = Patient.this_year.count
    # 前年度の新規患者数
    @prev_year_patient = Patient.prev_year.count
    # 今年度の目標達成率
    @goal_achievement = Patient.goal_achievement
    # 一ヶ月継続率
    @one_month = Patient.one_month
    # 三ヶ月継続率
    @three_month = Patient.three_month
    
    # 今月の中止者
    @drop_out = Patient.drop_out
    # 全中止者
    @drop_out_prev_month = Patient.drop_out_prev_month
    # 今月の患者一覧
    @now_patients = Patient.now_patients
    
    # 地域別
    @patient_area = Patient.now_patients.group(:area).count
    # 疾患別
    @patient_deasease = Patient.now_patients.group(:deasease).count
    # PT別
    @patient_pt = Patient.now_patients.eager_load(:user).group(:'users.name').count
  end
  
  def show
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:notice] = "患者を新規登録しました"
      redirect_to patients_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @patient.update(patient_params)
      flash[:notice] = "患者情報を編集しました"
      redirect_to patients_path
    else
      render 'edit'
    end
  end
  
  def destroy
    
  end
  
  private
  
  def set_patient
    @patient = Patient.find(params[:id])
  end
  
  def patient_params
    params.require(:patient).permit(:patient_name, :kana, :birthday, :area, :start_day, :deasease, :user_id, :goal, :achievement, :drop_out)
  end
  
end
