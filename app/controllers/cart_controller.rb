class CartController < ApplicationController
  before_action :authenticate_member!
  def index
    @carts = Cart.where(member_id: current_member.id).includes(:product)
    @index = 0
    total_prices = @carts.map do |cart|
      cart.product.price * cart.quantity
    end
    @total_price = total_prices.sum
    @total_quantity = @carts.sum(:quantity)
  end

  def new; end

  def create
    cart = find_or_initialize_cart

    if cart.save
      redirect_to('/cart/index')
    else
      redirect_to(root_path, alert: t('cart.create'))
    end
  end

  def destroy
    cart = Cart.find_by(member_id: params[:member_id], product_id: params[:product_id])
    cart.destroy
    redirect_to('/cart/index')
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :product_id, :member_id)
  end

  def find_or_initialize_cart
    carts = Cart.where(member_id: current_member.id)
    selected_product = carts.find_by(product_id: cart_params[:product_id])

    if selected_product
      selected_product.quantity += cart_params[:quantity].to_i
    else
      selected_product = carts.build(cart_params)
    end
    selected_product
  end
end
