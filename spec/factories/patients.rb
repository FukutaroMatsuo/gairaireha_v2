FactoryBot.define do
  factory :patient do
    patient_name { Faker::Name.name }
    kana { "かんじゃ" }
    birthday { "1993-09-01" }
    area { "佐世保1" }
    start_day { "2020-10-01" }
    deasease { "運動器" }
    goal { "下半身強化" }
    achievement { "未達成" }
    drop_out { "入院" }
    created_at { Time.current }
    association :user

    # validates :patient_name,  presence: true, length: { maximum: 7 }    
    # validates :kana,          presence: true, length: { maximum: 15 }  
    # validates :birthday,      presence: true, length: { maximum: 10 }
    # validates :area,          presence: true, length: { maximum: 20 }
    # validates :start_day,     presence: true, length: { maximum: 10 }
    # validates :deasease,      presence: true, length: { maximum: 10 }
    # validates :goal,                          length: { maximum: 30 }
    # validates :achievement,                   length: { maximum: 10 }
    # validates :drop_out,                      length: { maximum: 20 }
  
  end
end