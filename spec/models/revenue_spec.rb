require 'rails_helper'

RSpec.describe Revenue, type: :model do
  before do 
    @revenue = FactoryBot.build(:revenue)
  end

  describe "バリデーションのテスト" do
    it "入力必須項目は機能しているか" do
      expect(@revenue).to be_valid
    end
  end
end