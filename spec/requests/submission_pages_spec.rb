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
    it { should have_content(submission.running_time) }
    it { should have_content(submission.recipient_name) }
    it { should have_content(submission.client) }    
    it { should have_content(submission.budget) }
    it { should have_content(submission.production_company) }
    it { should have_content(submission.comments_other)}
    it { should have_content(submission.director) }
    it { should have_content(submission.editor) }
    it { should have_content(submission.animator) }
    it { should have_content(submission.writer) }
    it { should have_content(submission.sound_designer) }
    it { should have_content(submission.producer) }
    it { should have_content(submission.extra_crew) }
    it { should have_link("", href: edit_submission_path(submission)) }
    it { should have_content("Objective, interesting challenges or unique aspects you’d like the judges to consider.")}

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
    let!(:user)      { FactoryGirl.create(:user) }
    let!(:event)     { FactoryGirl.create(:event) }
    let!(:main_categories)  { FactoryGirl.create_list(:category, 3, event_id: event.id) }
    let!(:categories) { FactoryGirl.create_list(:sub_category, 3, event_id: event.id, parent: main_categories.sample)}
    let(:submit)    { "Submit entry" }
    before do
      sign_in user
      @event = event
      visit new_submission_path(id: @event.id)
    end

    describe "event" do
      it "should have a category" do
        expect(event.categories).to include(categories.first)
      end
    end

    it { should have_content("New Submission") }
    it { should have_content(event.name) }
    it { should have_content('Category') }
    it { should_not have_select('Category', selected: 'Choose a category') }
    it { should have_select('Category', with_options: ['Choose a category'] + categories.map{|c| c.name} ) }
    it { should have_content('Client') }
    it { should have_content('Additional Crew')}
    it { should have_content('Objective, interesting challenges or unique aspects you’d like the judges to consider.')}

    describe "with invalid information" do
      let!(:title) { "Boom shakalaka" }    
      before do
        select('Choose a category', :from => 'Category')
        fill_in "Title",              with: title
        fill_in "Video url",          with: "NOT VALID"
        fill_in "Name",               with: "The Rock"
        fill_in "Production company", with: "Backflip Films"
        fill_in "Budget",             with: "10k"   
        fill_in "Additional Crew",    with: "Gaffer: Lighting Guy, Designer: Phil"  
        fill_in "Objective, interesting challenges or unique aspects you’d like the judges to consider.",     with: "This is my comment"
      end

      it "should not create a submission" do
        expect { click_button submit }.not_to change(Submission, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it { should have_content("error") }
        it { should have_content("* Category can't be blank") }
      end
    end

    describe "with valid information" do
      let!(:title) { "Boom shakalaka" }   
      let!(:the_category) { categories.first.name } 
      before do
        select(the_category, :from => 'Category')
        fill_in "Title",              with: title
        fill_in "Video url",          with: "https://www.youtube.com/watch?v=XyjvCRowFrM"
        fill_in "Name",               with: "The Rock"
        fill_in "Production company", with: "Backflip Films"
        fill_in "Additional Crew",    with: "Gaffer: Lighting Guy, Designer: Phil"  
        fill_in "Budget",             with: "10k"   
        fill_in "Objective, interesting challenges or unique aspects you’d like the judges to consider.",     with: "This is my comment"
      end

      it "should create a submission" do    
        expect { click_button submit }.to change(Submission, :count).by(1)
      end

      describe "after saving the submission with video url" do
        before do
          click_button submit
        end

        it { should have_content(the_category) }
        it { should have_content(event.name) }
        it { should have_content("Additional Crew") }
        it { should have_selector("div.alert.alert-success") }
        it { should have_content('Finish and Pay') }
        it { should_not have_content('Upload video') }
      end

      describe "on user page" do
        before do
          click_button submit
          visit user_path(user)
        end
        it { should have_content(title)}
      end
    end

  end

  describe "show" do
    let!(:admin)       { FactoryGirl.create(:admin) }
    let!(:users)       { FactoryGirl.create_list(:user, 5) }    
    let!(:event)       { FactoryGirl.create(:event, user: admin) }
    let!(:categories)  { FactoryGirl.create_list(:category, 15, event: event) }
    let!(:submissions) { FactoryGirl.create_list( :submission, 70, 
                          category: categories.sample,
                          user: users.sample,
                          event: event, 
                          comments_other: 'Regular comment' ) }

    before do
      sign_in admin
      visit submission_event_path(event.id)
    end

    it { should have_content("Submissions for #{event.name}") }      
    it { should have_content("Help") } 
    it { should have_content(event.categories.count) }   
    it { should have_content(submissions.sample.title) }
    it { should have_content(event.submissions.count) }
    it { should have_content(submissions.sample.title) } 

  end

end
