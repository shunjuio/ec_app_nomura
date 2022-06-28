json.extract! product, :id, :name, :price, :alcohol, :image_path, :material, :product_area, :created_at, :updated_at
json.url product_url(product, format: :json)
