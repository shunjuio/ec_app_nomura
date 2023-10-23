class CartController < ApplicationController
  def index
    @member = Member.find_by(id: session[:member_id])
    @carts = Cart.where(member_id: @member[:id]).includes(:product)
    @index = 0
    total_prices = @carts.map do |cart|
      cart.product.price * cart.quantity
    end
    @total_price = total_prices.sum
    @total_quantity = @carts.sum(:quantity)
  end

  def new
    @cart = Cart.new
  end

  def show ; end

  def create
    carts = Cart.where(member_id: session[:member_id])
    if carts.find_by(product_id: params[:product_id])
      selected_product = carts.find_by(product_id: params[:product_id])
      selected_product[:quantity] += params[:quantity].to_i
      selected_product.save
    else
      cart = Cart.new(quantity: params[:quantity], product_id: params[:product_id], member_id: params[:member_id])
      cart.save
    end
    redirect_to("/cart/index")
  end

  def destroy
    cart = Cart.find_by(member_id: params[:member_id], product_id: params[:product_id])
    cart.destroy
    redirect_to("/cart/index")
  end
end
