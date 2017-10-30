FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "john#{n}"}
    sequence(:email) { |n| "john#{n}@example.org"}
    password 'test'
    is_private false

    trait :private do
      is_private true
    end

     factory :private_user, traits: [:private]
  end

  factory :comment do
    text 'comment'
  end

  factory :photo do
    image { File.new("#{Rails.root}/app/assets/images/missing_avatar_medium.jpg") }
    description 'x'
    association :user, factory: :user
  end

  factory :relationship do
    association :follower, factory: :user
    association :followed, factory: :user

    accepted true

    trait :pending do
      accepted false
    end

    factory :pending_relationship, traits: [:pending]
  end
end
