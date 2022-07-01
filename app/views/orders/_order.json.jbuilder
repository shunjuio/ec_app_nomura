json.extract! order, :id, :member_id, :postage, :amount_billed, :payment_method, :shipping_address, :postal_code, :purchaser_last_name, :purchaser_first_name, :purchaser_email, :created_at, :updated_at
json.url order_url(order, format: :json)
