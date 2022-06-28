class CartController < ApplicationController
  def index
    @member = Member.find_by(id: session[:member_id])
    @carts = Cart.where(member_id: @member[:id]).includes(:product)
    @total_price = @carts.sum(:price)
  end

  def new
    @cart = Cart.new
  end

  def create
    cart = Cart.new(quantity: params[:quantity], product_id: params[:product_id], member_id: params[:member_id])
    cart.save
    redirect_to("/cart/index")
  end
end
