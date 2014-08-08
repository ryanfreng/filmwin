require 'spec_helper'

describe 'Event pages' do
  
  let(:event) { FactoryGirl.create(:event) }

  subject { page }

  describe "new" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit new_event_path
    end

    it { should have_content("Create an Event")}
    it { should have_title("New Event")}

    
  end

  describe "show" do

    before(:each) do
      sign_in event.user
      visit event_path(event)
    end

    it { should have_title(event.name) }
    it { should have_content(event.description) }
    it { should have_content(event.sub_heading) }
    it { should have_content(pretty_date(event.entry_start_date)) }
    it { should have_content(pretty_date(event.entry_end_date)) }
    it { should have_content(pretty_date(event.judging_date)) }
    it { should have_content(pretty_date(event.show_date)) } 

  end

  describe "edit" do
    before(:each) do
      sign_in event.user
      visit edit_event_path(event)
    end

    it { should have_title("Update event") }

    describe "page" do
      it { should have_content("Update your event") }
      ['Name', 'Sub heading', 'Description', 'Entry start date',
                'Entry end date', 'Judging date', 'Show date'].each do |n|
        it { should have_content(n) }
      end
    end

    describe "with invalid information" do
      before do
        fill_in "Entry start date",    with: 'abcd'
        click_button 'Save changes'
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)              { 'New Wave Awards' }
      let(:new_entry_start_date)  { Date.today }
      let(:new_sub_heading)       { Faker::Lorem.sentence(2) }

      before do
        fill_in "Name",               with: new_name
        fill_in "Entry start date",   with: new_entry_start_date
        fill_in "Sub heading",        with: new_sub_heading
        click_button "Save changes"
      end

      it { should_not have_content('error') }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Edit') }
      specify { expect(event.reload.name).to eq new_name }
      specify { expect(event.reload.entry_start_date).to eq new_entry_start_date }
      specify { expect(event.reload.sub_heading).to eq new_sub_heading }

    end

    describe "forbidden attributes" do
      let(:params) do
        { event: { user_id: 3, name: event.name, sub_heading: event.sub_heading,
                    description: event.description, entry_start_date: event.entry_start_date,
                    entry_end_date: event.entry_end_date, judging_date: event.judging_date,
                    show_date: event.show_date } }
      end

      before do
        sign_in event.user, no_capybara: true
        patch event_path(event), params
      end

      specify { expect(event.reload).not_to eq 3 }

    end

  end
end
