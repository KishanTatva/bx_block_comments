FactoryBot.define do
    factory :post, :class => 'BxBlockPost::Post' do
      description { "hwllo" }
      account {create :account }
    end
end