namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

  ut1 = UserType.create!(name: 'MCAI-Member', earlybird_cost: 50, standard_cost: 65)
  ut2 = UserType.create!(name: 'Non-Member', earlybird_cost: 65, standard_cost: 75)
  ut3 = UserType.create!(name: 'Student', earlybird_cost: 25, standard_cost: 35)    

    admin = User.create!(name: "Ryan Freng",
                 email: "ryan@backflipfilms.com",
                 password: "foobar",
                 password_confirmation: "foobar",  
                 user_type: ut1,               
                 title: 'Owner',
                 company: 'Backflip Films',
                 admin: true )
    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.org"
    #   password  = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end

    e = Event.create!( name: "Wave Awards 2014", 
                        sub_heading: "Welcome to the Web Audio Video Excellence
                        award show! Please see the details and categories
                        below and enter!",
                        description: "The WAVE awards are a celebration of
                        local talent in the video production industry as well
                        as web, multimedia, and graphic design fields. Check
                        out the categories below and enter. This year we've
                        updated our categories to better reflect the changing
                        industry as well as added a 'Best in Show' award. This
                        year our judging will be done by a panel of judges from
                        around the midwest and coming from a wide range of
                        professions. We are also joining forces with the newly
                        created MCAI 30 second film festival and will be 
                        announcing the winners at the WAVEs.",
                        entry_start_date: Date.today,
                        entry_end_date:   60.days.from_now,
                        show_date:        70.days.from_now,
                        judging_date:     65.days.from_now,
                        user_id:       admin.id)
    
    p = Category.create!( name: 'Video Production',
                      description: "All the things we do", 
                      event: e)
    Category.create!( name: 'Producing',
                      description: 'all the scheduling',
                      event: e,
                      parent: p)
    Category.create!( name: 'Directing',
                      description: 'making the magic happen',
                      event: e,
                      parent: p)

  end
end