# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/send_order_confirmation
  def send_order_confirmation
    OrderMailer.send_order_confirmation
  end

end
