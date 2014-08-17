require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }

  it { should respond_to(:email) }
  it { should respond_to(:verify_sign) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:address_city) }
  it { should respond_to(:address_name) }
  it { should respond_to(:address_state) }
  it { should respond_to(:address_street) }
  it { should respond_to(:address_zip) }
  it { should_not respond_to(:phone) }
  it { should respond_to(:payment_gross) }
  it { should_not respond_to(:auth_id) } 
  it { should respond_to(:payment_status) }
  it { should respond_to(:txn_id) }

end
