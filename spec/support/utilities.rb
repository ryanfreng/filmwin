include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def random_sample(the_class, option={})
  #only handles one option
  if the_class.class == Class
    if option.size > 0 
      the_class.where(option.first[0] => option.first[1]).offset(rand(the_class.count)).first
    else
      the_class.offset(rand(the_class.count)).first
    end
  end
end