class CartItemsController < ApplicationController

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    if cart_items_params[:quantity].to_i > @cart_item.product.quantity
      flash[:warning] = "数量不足以加入购物车，請刪除刪除商品"
    else
      @cart_item.update(cart_items_params)
      flash[:notice] = "成功变更数量"
    end
    redirect_to carts_path
  end


  def destroy
    @cart = current_cart #從 application controller 取得購物車
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @cart_item.destroy
    @product = @cart_item.product
    flash[:warning] = "成功將 #{@product.title} 從購物車中刪除"
    redirect_to carts_path
  end

  private
  def cart_items_params
    params.require(:cart_item).permit(:quantity)
  end
end
