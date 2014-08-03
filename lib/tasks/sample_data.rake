namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 mcai_member: true,
                 title: 'Owner',
                 company: 'THE ONE',
                 admin: true )
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    Event.create!( name: "Wave Awards 2014", 
                        description: "Welcome to the Web Audio Video Excellence
                        award show! Please see the details and categories
                        below and enter!",
                        entry_start_date: Date.today,
                        entry_end_date:   60.days.from_now,
                        show_date:        70.days.from_now,
                        judging_date:     65.days.from_now,
                        created_by:       admin.id)
  end
end