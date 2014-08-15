require 'spec_helper'

describe Submission do
  let(:submission) { FactoryGirl.create(:submission) }

  subject { submission }

  it { should respond_to(:user) }
  it { should respond_to(:event) }
  it { should respond_to(:category) }
  it { should respond_to(:title) }
  it { should respond_to(:user_role) }
  it { should respond_to(:client) }
  it { should respond_to(:budget) }
  it { should respond_to(:production_company) }
  it { should respond_to(:comments_other) }
  it { should respond_to(:video_url) } 
  it { should respond_to(:editor) }
  it { should respond_to(:cinematographer) }
  it { should respond_to(:director) }
  it { should respond_to(:producer) }
  it { should respond_to(:order) }
  it { should respond_to(:order_id) }

  it { should be_valid }

  describe "when required elements are not present" do
    %w(user_id event_id category_id title).each do |s|
      describe "#{s}" do
        before { submission[s] = nil }
        it { should_not be_valid }
      end
    end
  end

end

