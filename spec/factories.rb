FactoryGirl.define do
  factory :order do
    payment_date    { Date.today }
    verify_sign     { Faker::Number.number(10)}
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    address_city    { Faker::Address.city }
    address_name    { Faker::Address.street_name }
    address_state   { Faker::Address.state }
    address_street  { Faker::Address.building_number }
    address_zip     { Faker::Address.zip }
    payment_gross   { rand(50..300) }
    txn_id          { Faker::Number.number(8) }
    payment_status  { ["Paid", "Processing", "Failed"].sample }
  end

  factory :user_type do
    name            { Faker::Name.name }
    earlybird_cost  { rand(40..65) }
    standard_cost   { earlybird_cost + rand(1..20) }
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
    sequence(:name)       { |n| "Event #{n}" }
    sub_heading           "This is how we do it. Blablablablablablablablablabl"
    description           "For our description we'll have many many words"*3
    entry_start_date      Date.today
    earlybird_date        30.days.from_now
    entry_end_date        60.days.from_now
    judging_date          65.days.from_now
    show_date             70.days.from_now
    paypal_email_address  'testing-address@gmail.com'
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
    order
  end

  factory :submission_quantity do
    sequence(:beginning_value)  { |n| n*4-3 }
    sequence(:end_value)        { |n| n*4 }
    event
  end

  factory :submission_cost do
    standard      65
    earlybird     55
    submission_quantity
    user_type
  end


end