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
    let(:submit)    { "Submit entry" }
    before do
      sign_in user
      @event = event
      visit new_submission_path(id: @event.id)
    end

    it { should have_content("New Submission") }
    it { should have_content(event.name) }

    describe "with invalid information" do

      it "should not create a submission" do
        expect { click_button submit }.not_to change(Submission, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it { should have_content("error") }
      end
    end

    # describe "with valid information" do
    #   let(:title) { "Boom shakalaka" }
    #   before do
    #     fill_in "Title",              with: title
    #     fill_in "Video url",          with: "https://www.youtube.com/watch?v=XyjvCRowFrM"
    #     fill_in "Role",               with: "awesomesauce"
    #     fill_in "Production company", with: "Backflip Films"
    #     fill_in "Budget",             with: "10k"   
    #     select first('#submission_category_id option')
    #   end

    #   it "should create a submission" do
    #     expect { click_button submit }.to change(Submission, :count)
    #   end

    #   describe "after saving the submission with video url" do
    #     before do
    #       click_button submit
    #     end

    #     it { should have_content(event.name) }
    #     it { should have_selector("div.alert.alert-success") }
    #     it { should have_content('Finish and pay') }
    #     it { should_not have_content('Upload video') }
    #   end

    #   describe "on user page" do
    #     before do
    #       click_button submit
    #       visit user_page(user)
    #     end
    #     it { should have_content(title)}
    #   end
    # end



  end

end
