FactoryBot.define do

  factory :item do
    name {"editテスト"}
    explanation {"食べ物の紹介"}
    category_id {"400"}
    condition_id {"1"}
    postage_id {"2"}
    prefecture_id {"1"}
    prepare_id {"2"}
    seller_id {"2"} 
    price {"23456"}
  end

end