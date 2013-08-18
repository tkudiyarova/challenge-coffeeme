class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
  	@orders = Order.all
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new order_params
  	if @order.save
  	  redirect_to @order
  	else
  	  render action: 'new'
  	end
  end

  def update
  	@order.update_attributes! order_params
  	redirect_to @order
  end

  def destroy
  	@order.destroy
  	redirect_to orders_url
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :comment, :user_id, :drink_id)
    end
end