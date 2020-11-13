FactoryBot.define do
    factory :comment, :class => 'BxBlockComments::Comment' do
      comment { "hwllo" }
      account {create :email_account }
      post { create :post }
    end
end