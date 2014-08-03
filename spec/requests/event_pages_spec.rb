require 'spec_helper'

describe 'Event pages' do
  
  subject { page }

  describe "show" do

    let(:user)  { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event, created_by: user.id) }

    before(:each) do
      sign_in user
      visit event_path(event)
    end

    it { should have_title(event.name) }
    it { should have_content(event.description) }
    it { should have_content(pretty_date(event.entry_start_date)) }
    it { should have_content(pretty_date(event.entry_end_date)) }
    it { should have_content(pretty_date(event.judging_date)) }
    it { should have_content(pretty_date(event.show_date)) }

  end
end
