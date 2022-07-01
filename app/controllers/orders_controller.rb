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

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
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
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
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
