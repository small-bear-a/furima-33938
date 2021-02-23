FactoryBot.define do
  factory :purchase_address do
    code           { '123-4567' }
    prefecture_id  { 2 }
    city           { '練馬区' }
    address        { 1111 }
    building_name  { 'マンション' }
    phone          { 12_345_123_451 }
    # purchase_id    {2}
    token          { 'tok_abcdefghijk000000000000' }
  end
end
