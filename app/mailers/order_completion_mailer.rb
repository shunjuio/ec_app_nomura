class OrderCompletionMailer < ApplicationMailer
  def order_completion_mail(member, order)
    @member = member
    @order_products = OrderProduct.where(order_id: order.id).includes(:product)
    # mail to: order.member.email, subject: "ご注文ありがとうございます"
    mail to: order.member.email, subject: "Thank you for your order."
  end
end
