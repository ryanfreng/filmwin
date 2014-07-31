FactoryGirl.define do
  factory :user do
    name      "Ryan Freng"
    email     "ryan@backflipfilms.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end