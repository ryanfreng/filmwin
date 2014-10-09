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
    it { should have_content(submission.comments_other)}
    it { should have_content(submission.director) }
    it { should have_content(submission.editor) }
    it { should have_content(submission.producer) }
    it { should have_link("", href: edit_submission_path(submission)) }
    it { should have_content("Goals of Piece & Other Comments")}

    describe "with no video url" do
      let(:submission2)  { FactoryGirl.create(:submission, video_url: nil) }
      let(:user2)        { submission2.user }
      before do
        sign_in user2
        visit user_path(user2)
      end
      
      it { should have_content('Upload video') }
    end

    describe "unpaid submission" do
      let(:submission3) { FactoryGirl.create(:submission, order: nil) }
      let(:user3)       { submission3.user }
      before do
        sign_in user3
        visit user_path(user3)
      end
      it { should have_content("Payment due") }
      it { should have_content(user3.current_cost(submission3.event)) }
      it { should have_content("Finish and Pay") }
    end

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
    it { should have_content('Client') }
    it { should have_content('Goals of Piece & Other Comments')}

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

  describe "show" do
    let(:admin)       { FactoryGirl.create(:admin) }
    let(:users)       { FactoryGirl.create_list(:user, 5) }
    let(:event)       { FactoryGirl.create(:event) }
    let(:categories)  { FactoryGirl.create_list(:category, 15, event_id: event.id) }
    let(:submissions) { FactoryGirl.create_list(  :submission_ru, 
                                                  70, event_id: event.id )} 

    before do
      sign_in admin
      visit submission_event_path(event.id)
    end

    describe "list of submissions" do
      it { should have_content("Submissions for #{event.name}")}
      it { should have_content(submissions[rand(submissions.size)-1].title )}

    end


  end

end
