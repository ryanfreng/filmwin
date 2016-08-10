require 'spec_helper'

describe 'Admin pages' do
  
  let(:event) { FactoryGirl.create(:event) }

  subject { page }

        # describe "new category" do
        #   let(:name) { 'Wacky Wideos' }
        #   let(:dsc)  { "The wideos you won't show anyone else!" }

        #   before do
        #     fill_in "Name",         with: name
        #     fill_in "Description",  with: dsc
        #     click_button "Save new category"
        #   end

        #   it { should have_selector('div.alert.alert-success') }
        #   it { should have_content(name) }
        #   it { should have_content(dsc) }
        # need test for adding new category

end