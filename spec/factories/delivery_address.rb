FactoryBot.define do

  factory :delivery_address do
    delivery_family_name              {"田中"}
    delivery_first_name               {"花子"}
    delivery_family_name_kana         {"タナカ"}
    delivery_first_name_kana          {"ハナコ"}
    post_code                         {"1234567"}
    prefecture_id                     {"id: 1, name: '北海道'"}
    city                              {"札幌"}
    home_number                       {"1-1-1"}
    building_name                     {"山田ビル101"}
    phone_number                      {"09012345678"}
    
    association :user
  end

end
