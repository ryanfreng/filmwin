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
    it { should_not have_content('New Category')}

    describe "when logged in" do
      before do
        sign_in category.event.user
        visit event_path(category.event)
      end

      describe "and owner of event" do
        it { should have_link('Edit event', href: edit_event_path(category.event)) }
        it { should have_link('Edit', href: edit_category_path(category)) }
        it { should_not have_content('New Category')}

        describe "clicking on edit category" do
          before { click_link("Edit") }

          it { should have_content("Update category") }

          describe "with invalid information" do
            let(:new_name)  { '' }
            before do
              fill_in "Name", with: new_name
              click_button "Save changes"
            end

            it { should have_content('error') }

          end

          describe "with valid information" do
            let(:new_name)  {'VIDEOPRODUCTION'}
            let(:new_description) { 'This is how we doin a brand new dance now' }
            before do
              fill_in "Name",         with: new_name
              fill_in "Description",  with: new_description
              click_button "Save changes"
            end

            it { should have_selector('div.alert.alert-success') }

          end

        end

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


        # end

      end

    end

  end

  describe "new" do
    let(:new_event) { FactoryGirl.create(:event) }
    before do
      visit new_category_path
    end

    it { should have_content("Sign in") }

    describe "logged in" do
      before do
        sign_in new_event.user
      end

      describe "without an event" do
        before do
          visit new_category_path
        end

        # Doesn't work, can't pass url param in capybara...
        # specify { expect(current_path).to eq "/" }
      end

      describe "with an event" do
        let(:new_category) { FactoryGirl.build(:category, event_id: new_event.id)}
        before do
          #store_current_event_for_new_category=new_event
          #new_category_path(event_id: new_event.id)
        end

        #specify { expect(current_path).to eq "/categories/new/#{new_event.id}"}
        # Doesn't work, can't pass url param in capybara...
        #it { should have_content("Create a category") }
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
            specify { expect(category.reload.name).to eq new_name }
            specify { expect(category.reload.description).to eq new_description }
          end
       end

       describe "without access" do
        let(:user2) { FactoryGirl.create(:user) }
        let(:category) { FactoryGirl.create(:category) }
        before do
          sign_in user2
          visit edit_category_path(category)
        end
        specify { expect(current_path).to eq "/events/#{category.event.id}" }
        it { should_not have_content("Update category") }
        
      end
    end
  end
end