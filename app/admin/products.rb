ActiveAdmin.register Product do
  permit_params :name, :price, :alcohol, :image_path, :material, :product_area
end
