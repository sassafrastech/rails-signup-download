include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
    avatar { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'image1.png'), 'image/png') }


    trait :admin do
      role 'admin'
    end

  end
end
