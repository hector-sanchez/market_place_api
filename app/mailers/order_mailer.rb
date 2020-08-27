class OrderMailer < ApplicationMailer
  default from: "no-reply@marketplace.com"

  def send_order_confirmation(order)
    @order = order
    @user = @order.user

    mail to:@order.user.email, subject: "Order Confirmation"
  end
end
