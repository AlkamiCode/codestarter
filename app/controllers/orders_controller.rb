class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    if current_user
      @order = current_user.orders.build
      @order.cart_data = session[:cart] if session[:cart]
      if @order.save
        @order.build_invoice(cart)
        send_checkout_email(current_user, "checkout")

        flash[:success] = "Successfully funded projects!"
        session[:cart] = nil
        redirect_to orders_path
      else
        flash[:danger] = "Your order could not be placed. Please contact support."
        redirect_to "/cart"
      end
    else
      flash[:danger] = "You need to log in to check out"
      redirect_to :back
    end
  end

  private

  def send_checkout_email(user, type)
    NotificationMailer.contact(user.email, type).deliver_now
  end
end
