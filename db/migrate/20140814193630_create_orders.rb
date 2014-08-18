class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :payment_date
      t.string :email
      t.string :verify_sign
      t.string :first_name
      t.string :last_name
      t.string :address_city
      t.string :address_name
      t.string :address_state
      t.string :address_street
      t.string :address_zip
      t.string :phone
      t.string :auth_amount
      t.string :auth_id
      t.string :auth_status
      t.string :payment_status

      t.timestamps
    end
  end
end
