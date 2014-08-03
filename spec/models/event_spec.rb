require 'spec_helper'

describe Event do

  let(:user)   { FactoryGirl.create(:user)}
  let(:event)  { FactoryGirl.create(:event, created_by: user.id) }

  subject { event }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:entry_start_date) }
  it { should respond_to(:entry_end_date) }
  it { should respond_to(:show_date) }
  it { should respond_to(:judging_date) }
  it { should respond_to(:created_by) }

  it { should be_valid }

  %w(name description entry_start_date entry_end_date show_date judging_date created_by).each do |n|
    describe "when #{n} is not present" do
      before { event[n] = '' }
      it { should_not be_valid }
    end
  end

  describe "when name is too long" do
    before { event.name = 'a'*51 }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { event.description = 'a'*201 }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      @same_event = event.dup
      @same_event.description = 'new thing'
      @same_event.save
    end
    specify { expect(@same_event).not_to be_valid }
  end


end
