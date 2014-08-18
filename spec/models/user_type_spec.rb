require 'spec_helper'

describe 'User Type' do
  
  before do 
    @user_type = UserType.new(name: 'MCAI-Member', earlybird_cost: '50', standard_cost: '65' )
  end

  subject { @user_type }

  it { should respond_to(:name) }
  it { should respond_to(:earlybird_cost) }
  it { should respond_to(:standard_cost) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user_type.name = " " }
    it { should_not be_valid } 
  end

  describe "when earlybird_cost is not present" do
    before { @user_type.earlybird_cost = "" }
    it { should_not be_valid } 
  end

  describe "when earlybird_cost is not a number" do
    before { @user_type.earlybird_cost = "Spider-Man" }
    it { should_not be_valid } 
  end

  describe "when standard_cost is not present" do
    before { @user_type.standard_cost = "" }
    it { should_not be_valid } 
  end

  describe "when standard_cost is not an integer" do
    before { @user_type.standard_cost = "Wolverine" }
    it { should_not be_valid } 
  end


end
