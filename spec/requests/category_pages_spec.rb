require 'spec_helper'

describe 'Categegory pages' do

  let(:category)  { FactoryGirl.create(:category) }
  let(:category2) { FactoryGirl.create(:category, parent_id: category.id, event_id: category.event_id) }
  let(:category3) { FactoryGirl.create(:category, parent_id: category.id, event_id: category.event_id) }

  subject { page }

  describe "event page" do
    before do
      visit event_path(category.event)
    end

    it { should have_content(category.name) }
    it { should have_content("Categories") }
    it { should_not have_link('New category', href: new_category_path)}

    describe "when logged in" do
      before do
        sign_in category.event.user
        visit event_path(category.event)
      end

      describe "and owner of event" do
        it { should have_link('Edit event', href: edit_event_path(category.event)) }
        it { should have_link('Edit category', href: edit_category_path(category)) }
        it { should have_link('New category', href: new_category_path)}

        describe "clicking on edit category" do
          before { click_link("Edit category") }

          it { should have_content("Update category") }
        end
      end

    end

  end

  describe "edit" do
    before do
      visit edit_category_path(category)
    end

    describe "page" do
      describe "when not logged in"
        it { should_not have_content("Update category") }
      end

      describe "when logged in" do
        describe "with access" do
          before do
            sign_in category.event.user
            visit edit_category_path(category)
          end
          it { should have_content("Update category") }
          it { should have_content("Name") }
          it { should have_content("Description") }

          describe "with valid information" do
            let(:new_name) { 'Peter Parker' }
            let(:new_description) { 'The myth, the man, the legend, the spider!' }
            
            before do
              fill_in "Name",         with: new_name
              fill_in "Description",  with: new_description
              click_button "Save changes"
            end

            it { should_not have_content('error') }
            it { should have_selector('div.alert.alert-success') }
            it { should have_link('Edit category', href: edit_category_path(category)) }
            specify { expect(category.reload.name).to eq new_name }
            specify { expect(category.reload.description).to eq new_description }
          end
       end

       describe "without access" do
        let(:user2) { FactoryGirl.create(:user) }
        let(:category) { FactoryGirl.create(:category) }
        before do
          sign_in user2, no_capybara: true
          visit edit_category_path(category)
        end
        Capybara.exact = true
        it { should have_title("Filmwin") }
        it { should_not have_content("Update category") }
        
      end
    end
  end
end