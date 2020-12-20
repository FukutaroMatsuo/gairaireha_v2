require 'rails_helper'

RSpec.describe Reha, type: :model do
  before do 
    @reha = FactoryBot.build(:reha)
  end

  describe "バリデーションのテスト" do
    it "入力必須項目は機能しているか" do
      expect(@reha).to be_valid
    end
  end
end