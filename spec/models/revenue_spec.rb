require 'rails_helper'

RSpec.describe Dish, type: :model do
  let!(:revenue) { create(:revenue) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(revenue).to be_valid
    end

    it "月の入力がなければ無効な状態であること" do
      revenue = build(:revenue, working_month: nil)
      revenue.valid?
      expect(revenue.errors[:working_month]).to include("を入力してください")
    end

    it "月が1文字以上2文字以下となっていること" do
      revenue = build(:revenue, working_month: 123)
      revenue.valid?
      expect(revenue.errors[:working_month]).to include("は2文字以下で入力してください")
    end

    it "点数の入力がなければ無効な状態であること" do
      revenue = build(:revenue, score: nil)
      revenue.valid?
      expect(revenue.errors[:score]).to include("を入力してください")
    end

    it "点数が7文字以上で無効となっていること" do
      revenue = build(:revenue, score: 1234567)
      revenue.valid?
      expect(revenue.errors[:score]).to include("は6文字以内で入力してください")
    end

  end
end