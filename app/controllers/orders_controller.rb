class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :authenticate_member!

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order_products = OrderProduct.where(order_id: @order.id).includes(:product)
  end

  # GET /orders/new
  def new
    @carts = Cart.where(member_id: current_member.id).includes(:product)
    calculate_totals
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @carts = Cart.where(member_id: current_member.id).includes(:product)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: t('orders.create') }
        format.json { render :show, status: :created, location: @order }
        save_order_product
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
        format.html { redirect_to order_url(@order), notice: t('orders.update') }
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
      format.html { redirect_to orders_url, notice: t('orders.destroy') }
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
    params[:order].permit(:member_id, :postage, :amount_billed, :payment_method, :shipping_address, :postal_code,
                          :purchaser_last_name, :purchaser_first_name, :purchaser_email)
  end

  def calculate_totals
    total_prices = @carts.map { |cart| cart.product.price * cart.quantity }
    @total_price = total_prices.sum
    @total_quantity = @carts.sum(:quantity)
    @postage = 500
    @amount_billed = @total_price + @postage
  end

  def save_order_product
    @carts.each do |cart|
      @order_product = OrderProduct.new(product_id: cart.product_id, order_id: @order.id, quantity: cart.quantity)
      @order_product.save
      delete_cart(cart)
    end
  end

  def delete_cart(cart)
    cart.destroy
  end
end
