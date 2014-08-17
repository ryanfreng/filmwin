class OrdersController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    if parrams.has_key?(:txn_id)
      response = validate_IPN_notification(request.raw_post)
      case response
      when "VERIFIED"
        order = Order.new(txn_id: params(:txn_id),
                  email: params(:payer_email),
                  verify_sign: params(:verify_sign),
                  first_name: params(:first_name),
                  last_name: params(:last_name),
                  address_city: params(:address_city),
                  address_name: params(:address_name),
                  address_state: params(:address_state),
                  address_street: params(:address_street),
                  address_zip: params(:address_zip),
                  payment_gross: params(:payment_gross),
                  payment_status: params(:payment_status))
        if order.save
          submissions = Submission.find(/ids=\[(.*)\]/.match(params(:item_name))[1].split(',') )
          submissions.each do |s|
            s.update_attributes(order: order)
          end
        end

      when "INVALID"
        # log for investigation, send email to admin
      else
        # error, send email to admin
      end

      render nothing: true
    end
  end

  protected
    def validate_IPN_notification(raw)
      uri = URI.parse(PAYPAL_ADDRESS + "?cmd=notify-validate")
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 6-
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.use_ssl = true
      response = http.post(uri.request_uri, raw,
                            'Content-Length' => "#{raw.size}",
                            'User-Agent' => "My custom user agent"
                            ).body
end
