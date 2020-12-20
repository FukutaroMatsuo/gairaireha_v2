User.create!(
  [
    {
      name:  "管理者",
      email: "admin@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "リハ一郎",
      email: "reha1@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "リハ二郎",
      email: "reha2@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "リハ三郎",
      email: "reha3@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "リハ四郎",
      email: "reha4@example.com",
      password:              "password",
      password_confirmation: "password",
    },
  ]
)

100.times do |n|
  gimei = Gimei.new
  birthday = Faker::Date.birthday(min_age: 18, max_age: 90)
  area = ["佐世保1地区", "佐世保2地区", "佐世保3地区", "佐世保4地区", "佐世保5地区", "その他"]
  start_day = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  deasease = ["運動器", "呼吸器", "脳血管"]
  user_id = [2, 3, 4, 5]
  goal = ["下半身強化", "上半身強化"]
  achievement = ["達成", "未達成"]
  drop_out = ["手術", "介護保険", "入院"]
  
  Patient.create!(
    patient_name: gimei.name.kanji,
    kana: gimei.name.hiragana,
    birthday: birthday,
    area: area[rand(6)],
    start_day: start_day,
    deasease: deasease[rand(3)],
    user_id: user_id[rand(4)],
    goal: goal[rand(2)],
    achievement: achievement[rand(2)],
    drop_out: drop_out[rand(3)]
  )
end

1000.times do |n|
  user_id = [2, 3, 4, 5]
  patient_id = [*1..100]
  day = Faker::Date.between(from: 12.month.ago, to: 12.month.from_now)
  unit = [1, 2]

  Reha.create!(
    user_id: user_id[rand(4)],
    patient_id: patient_id[rand(100)],
    day: day,
    unit: unit[rand(2)]
  )
end

[
  [Date.new(2018, 4, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 5, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 6, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 7, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 8, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 9, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 10, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 11, 1), "#{rand(150000..190000)}"],
  [Date.new(2018, 12, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 1, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 2, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 3, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 4, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 5, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 6, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 7, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 8, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 9, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 10, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 11, 1), "#{rand(150000..190000)}"],
  [Date.new(2019, 12, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 1, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 2, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 3, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 4, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 5, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 6, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 7, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 8, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 9, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 10, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 11, 1), "#{rand(150000..190000)}"],
  [Date.new(2020, 12, 1), "#{rand(150000..190000)}"],
  [Date.new(2021, 1, 1), "#{rand(150000..190000)}"],
  [Date.new(2021, 2, 1), "#{rand(150000..190000)}"],
  [Date.new(2021, 3, 1), "#{rand(150000..190000)}"]
].each do |working_month, score|
  Revenue.create!(
    { working_month: working_month, score: score}
  )
end