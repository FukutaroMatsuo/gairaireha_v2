require 'rails_helper'

RSpec.describe Patient, type: :model do

  before do
    @patient = FactoryBot.build(:patient)
  end

  describe "バリデーションのテスト" do
    it "有効な状態か" do
      expect(@patient).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      @patient = build(:patient, patient_name: nil)
      @patient.valid?
      expect(@patient.errors[:patient_name]).to include("を入力してください")
    end

    it "ふりがながなければ無効な状態であること" do
      @patient = build(:patient, kana: nil)
      @patient.valid?
      expect(@patient.errors[:kana]).to include("を入力してください")
    end

    it "生年月日がなければ無効な状態であること" do
      @patient = build(:patient, birthday: nil)
      @patient.valid?
      expect(@patient.errors[:birthday]).to include("を入力してください")
    end

    it "地域がなければ無効な状態であること" do
      @patient = build(:patient, area: nil)
      @patient.valid?
      expect(@patient.errors[:area]).to include("を入力してください")
    end

    it "開始日がなければ無効な状態であること" do
      @patient = build(:patient, start_day: nil)
      @patient.valid?
      expect(@patient.errors[:start_day]).to include("を入力してください")
    end

    it "疾患がなければ無効な状態であること" do
      @patient = build(:patient, deasease: nil)
      @patient.valid?
      expect(@patient.errors[:deasease]).to include("を入力してください")
    end

    it "名前が7文字以内であること" do
      @patient = build(:patient, patient_name: "あ" * 8)
      @patient.valid?
      expect(@patient.errors[:patient_name]).to include("は7文字以内で入力してください")
    end

    it "かなが15文字以内であること" do
      @patient = build(:patient, kana: "あ" * 16)
      @patient.valid?
      expect(@patient.errors[:kana]).to include("は15文字以内で入力してください")
    end

    it "地域が10文字以内であること" do
      @patient = build(:patient, area: "あ" * 11 )
      @patient.valid?
      expect(@patient.errors[:area]).to include("は10文字以内で入力してください")
    end

    it "疾患が3文字以内であること" do
      @patient = build(:patient, deasease: "あ" * 4 )
      @patient.valid?
      expect(@patient.errors[:deasease]).to include("は3文字以内で入力してください")
    end

    it "目標が30文字以内であること" do
      @patient = build(:patient, goal: "あ" * 31 )
      @patient.valid?
      expect(@patient.errors[:goal]).to include("は30文字以内で入力してください")
    end

    it "達成判定が3文字以内であること" do
      @patient = build(:patient, achievement: "あ" * 4 )
      @patient.valid?
      expect(@patient.errors[:achievement]).to include("は3文字以内で入力してください")
    end

    it "中止理由が20文字以内であること" do
      @patient = build(:patient, drop_out: "あ" * 21 )
      @patient.valid?
      expect(@patient.errors[:drop_out]).to include("は20文字以内で入力してください")
    end

  end

end
