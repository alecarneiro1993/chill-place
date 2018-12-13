FactoryBot.define do
  factory :purchase do
    purchasable_id { FactoryBot.create(:movie).id }
    purchasable_type { 'Movie' }
    quality { :standard }
  end
end
