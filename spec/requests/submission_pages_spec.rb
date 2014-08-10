require 'spec_helper'

describe 'Submission Pages' do
  
  let(:submission)  { FactoryGirl.create(:submission) }

  subject { page }

  describe "show" do
    let(:user)  { submission.user }
    before do      
      sign_in user
      visit user_path(user) #submission_path(submission)
    end

    it { should have_content(submission.event.name) }
    it { should have_content(submission.category.name) }    
    it { should have_content(submission.title) }
    it { should have_content(submission.user_role) }
    it { should have_content(submission.client) }
    it { should have_content(submission.budget) }
    it { should have_content(submission.production_company) }
    it { should have_link("Edit", href: edit_submission_path(submission)) }
  end

  describe "new" do
    let(:user)      { FactoryGirl.create(:user) }
    let(:event)     { submission.event }
    let(:category)  { submission.category }
    before do
      visit new_submission_path(id: event.id)
    end

    it { should have_content("#{event.name} submission") }
  end

end
