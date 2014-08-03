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

  factory :event do
    sequence(:name)   { |n| "Event #{n}" }
    description       "This is how we do it. Blablablablablablablablablabl"
    entry_start_date  Date.today
    entry_end_date    60.days.from_now
    judging_date      65.days.from_now
    show_date         70.days.from_now
  end

end