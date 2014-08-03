require 'spec_helper'

describe Category do
  let(:category) { FactoryGirl.create(:category) }

  subject { category }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:event) }
  it { should respond_to(:parent) }
  it { should respond_to(:parent_id) }

  it { should be_valid }

  %w(name description event_id).each do |n|
    describe "when #{n} is not present" do
      before { category[n] = '' }
      it { should_not be_valid }
    end
  end

  describe "when name is too long" do
    before { category.name = 'a'*51 }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { category.description = 'a'*251 }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      @same_category = category.dup
      @same_category.description = 'new thing'
      @same_category.save
    end
    specify { expect(@same_category).not_to be_valid }
  end

end
