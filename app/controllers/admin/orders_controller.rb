class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout 'admin'

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    OrderMailer.notify_ship(@order).deliver! #出貨發信
    redirect_back fallback_location: root_path
  end

  def shipped 
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_back fallback_location: root_path
  end

  def cancel 
    @order = Order.find(params[:id])
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver! #取消訂單發信
    redirect_back fallback_location: root_path
  end

  def return 
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_back fallback_location: root_path
  end
end
