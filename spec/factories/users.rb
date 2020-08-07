FactoryBot.define do

  factory :user do
    nickname              {"やまもと"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"田中"}
    first_name            {"花子"}
    family_name_kana      {"タナカ"}
    first_name_kana       {"ハナコ"}
    birthdate             {"2020-08-04"}
  end

end