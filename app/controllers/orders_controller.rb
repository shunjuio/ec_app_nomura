class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
    @member = Member.find_by(id: session[:member_id])
  end

  # GET /orders/1 or /orders/1.json
  def show
    @member = Member.find_by(id: session[:member_id])
    @order_products = OrderProduct.where(order_id: @order.id).includes(:product)
    @index = 0
  end

  # GET /orders/new
  def new
    @member = Member.find_by(id: session[:member_id])
    @carts = Cart.where(member_id: @member[:id]).includes(:product)
    @index = 0
    total_prices = @carts.map do |cart|
      cart.product.price * cart.quantity
    end
    @total_price = total_prices.sum
    @total_quantity = @carts.sum(:quantity)
    @postage = 500
    @amount_billed = @total_price + @postage
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @member = Member.find_by(id: session[:member_id])
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @member = Member.find_by(id: session[:member_id])
    @carts = Cart.where(member_id: @member[:id]).includes(:product)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "ご購入ありがとうございました" }
        format.json { render :show, status: :created, location: @order }
        # order_productへ商品と個数を登録して、cartから商品を削除する処理を書く
        @carts.each do |cart|
          @order_product = OrderProduct.new(product_id: cart.product_id, order_id: @order.id, quantity: cart.quantity)
          @order_product.save
          cart.destroy
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "ご購入ありがとうございました" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params[:order].permit(:member_id, :postage, :amount_billed, :payment_method, :shipping_address, :postal_code, :purchaser_last_name, :purchaser_first_name, :purchaser_email)
  end
end
