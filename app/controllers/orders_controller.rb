class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
  	@orders = Order.all
  	respond_with(@orders)
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new order_params
  	respond_to do |format|
	  if @order.save
	  	format.html { redirect_to @order, notice: 'Order was successfully created.' }
	  	format.json { render json: @order, status: :created, location: @order }
	  else
	  	format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
  	  end
  	end
  end

  def update
  	respond_to do |format|
  	  if @order.update_attributes order_params
  	  	format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
  	end
  end

  def destroy
  	@order.destroy
  	respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def show
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit( :name, :comment, :user_id, :drink_id)
    end
end