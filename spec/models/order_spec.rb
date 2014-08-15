require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }

  it { should respond_to(:email) }
end
