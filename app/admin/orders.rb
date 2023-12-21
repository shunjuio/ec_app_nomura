ActiveAdmin.register Order do
  permit_params :member_id, :postage, :amount_billed, :payment_method, :shipping_address,
                :postal_code, :purchaser_last_name, :purchaser_first_name, :purchaser_email

  form do |f|
    f.inputs do
      f.input :member_id, as: :select, collection: Member.all.map { |m| [m.email.to_s, m.id] }
      f.input :postage
      f.input :amount_billed
      f.input :payment_method
      f.input :shipping_address
      f.input :postal_code
      f.input :purchaser_last_name
      f.input :purchaser_first_name
      f.input :purchaser_email
    end
    f.actions
  end
end
