module Admin::OrdersHelper
  def render_order_paid_state(order)
    case order.aasm_state
    when "order_placed"
      "未付款"
    when "paid"
      "已付款"
    when "order_apply_cancel"
      "申請取消訂單"
    when "order_apply_cancel_from_paid"
      "申請取消訂單（已付款）"
    when "order_cancelled"
      "訂單已取消"
    when "shipping"
      "出貨中"
    when "shipped"
      "已送達"
    when "good_returned"
      "以退貨"
    end
  end
end
