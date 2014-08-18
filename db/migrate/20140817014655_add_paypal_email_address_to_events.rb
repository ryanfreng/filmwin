class AddPaypalEmailAddressToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :paypal_email_address, :string
  end
end
