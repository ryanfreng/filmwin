FactoryGirl.define do
  factory :user_type do
    name            { Faker::Name.name }
    earlybird_cost  { random(40..65) }
    standard_cost   { earlybird_cost + random(1..20) }
  end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    company "Apple"
    title "Neo"
    password "foobar"
    password_confirmation "foobar"
    user_type

    factory :admin do
      admin true
    end

  end

  factory :event do
    sequence(:name)   { |n| "Event #{n}" }
    sub_heading       "This is how we do it. Blablablablablablablablablabl"
    description       "For our description we'll have many many words"*3
    entry_start_date  Date.today
    entry_end_date    60.days.from_now
    judging_date      65.days.from_now
    show_date         70.days.from_now
    user
  end

  factory :category do
    name          { Faker::Name.name + ' ' + Faker::Lorem.word }
    description   { Faker::Lorem.sentence(2) }
    event
  end

  factory :submission do
    category
    event               { self.category.event }
    user                { self.event.user }
    user_role           { Faker::Name.name }
    client              { Faker::Company.name }
    title               { Faker::Company.catch_phrase }
    budget              { Faker::Number.number(4) }
    production_company  { Faker::Company.name }
    video_url           { "https://www.youtube.com/watch?v=XyjvCRowFrM"}
    comments_other      { Faker::Lorem::sentence(4) }
    #after(:create) do |s|
    #  s.event = s.category.event
    #  s.user = s.event.user
    #end
  end


end