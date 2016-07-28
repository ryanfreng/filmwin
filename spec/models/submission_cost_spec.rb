require 'spec_helper'

describe SubmissionCost do

  let(:submission_cost) { FactoryGirl.create(:submission_cost) }

  subject { submission_cost }

  it { should respond_to(:standard) }
  it { should respond_to(:earlybird) }
  it { should respond_to(:submission_quantity_id) }
  it { should respond_to(:user_type_id) }

  it { should be_valid }

  %w(standard earlybird submission_quantity_id user_type_id).each do |n|
    describe "when #{n} is not present" do
      before { submission_cost[n] = '' }
      it { should_not be_valid }
    end
  end

end
