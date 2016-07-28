require 'spec_helper'

describe SubmissionQuantity do

  let(:submission_quantity) { FactoryGirl.create(:submission_quantity) }
  let(:submission_quantity2) { FactoryGirl.create(:submission_quantity, event: submission_quantity.event) }

  subject { submission_quantity }

  it { should respond_to(:event_id) }
  it { should respond_to(:beginning_value) }
  it { should respond_to(:end_value) }

  it { should be_valid }

  %w(event_id beginning_value end_value).each do |n|
    describe "when #{n} is not present" do
      before do
        submission_quantity[n] = ''
        submission_quantity.save
      end
      specify { expect(submission_quantity).not_to be_valid }
    end
  end

  describe "when values don't overlap" do
    it { should be_valid }
  end

  describe "when values overlap" do
    before do
      submission_quantity.end_value = submission_quantity2.beginning_value + 1
    end
    it { should_not be_valid }
  end


end
