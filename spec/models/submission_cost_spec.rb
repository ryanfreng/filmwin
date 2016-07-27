require 'spec_helper'

describe SubmissionCost do

  let(:submission_cost) { FactoryGirl.create(:submission_cost) }

  subject { submission_cost }

  it { should respond_to(:standard) }
  it { should respond_to(:earlybird) }
  it { should respond_to(:submission_quantity_id) }
  it { should respond_to(:user_type_id) }

  it { should be_valid }

end
