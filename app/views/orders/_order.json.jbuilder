json.extract! order, :id, :member_id, :postage, :amount_billed, :payment_method, :shipping_address, :postal_code, :created_at, :updated_at
json.url order_url(order, format: :json)
