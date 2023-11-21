ActiveAdmin.register OrderProduct do
  permit_params :product_id, :order_id, :quantity

  form do |f|
    f.inputs do
      f.input :product_id, as: :select, collection: Product.all.map{|p| ["#{p.name}", p.id]}
      f.input :order_id, as: :select, collection: Order.all.map{|o| ["#{o.id}", o.id]}
      f.input :quantity
    end
    f.actions
  end
end
