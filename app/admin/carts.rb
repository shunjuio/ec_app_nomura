ActiveAdmin.register Cart do
  permit_params :product_id, :member_id, :quantity

  form do |f|
    f.inputs do
      f.input :product_id, as: :select, collection: Product.all.map{|p| ["#{p.name}", p.id]}
      f.input :member_id, as: :select, collection: Member.all.map{|m| ["#{m.email}", m.id]}
      f.input :quantity
    end
    f.actions
  end
end
