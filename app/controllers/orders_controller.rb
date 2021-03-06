class OrdersController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    if params.has_key?(:txn_id)
      if ENV['ENVIRONMENT'] == 'Development'
        response = "VERIFIED"
      else
        response = validate_IPN_notification(request.raw_post)
      end
      logger.info("Here's the response: #{response}")
      case response
      when "VERIFIED"
        order = Order.new(txn_id: params[:txn_id],
                  email: params[:payer_email],
                  verify_sign: params[:verify_sign],
                  first_name: params[:first_name],
                  last_name: params[:last_name],
                  address_city: params[:address_city],
                  address_name: params[:address_name],
                  address_state: params[:address_state],
                  address_street: params[:address_street],
                  address_zip: params[:address_zip],
                  payment_gross: params[:payment_gross],
                  payment_status: params[:payment_status],
                  payment_date: params[:payment_date])
        has_ids = /ids=\[(.*)\]/.match(params[:item_name])
        if has_ids && order.save
          submissions = Submission.find(has_ids[1].split(',') )
          submissions.each do |s|
            s.update_attributes(order: order)
          end
        else
          logger.info("Order successful, paypal IPN buffer overflow")
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
      uri = URI.parse(ENV['PAYPAL_ADDRESS'] + "?cmd=_notify-validate")
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
end
