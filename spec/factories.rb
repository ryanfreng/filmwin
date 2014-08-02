FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    company "Apple"
    title "Neo"
    mcai_member true
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end