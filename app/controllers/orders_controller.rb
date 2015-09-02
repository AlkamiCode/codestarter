class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    if current_user
      @order = current_user.orders.build
      @order.cart_data = session[:cart] if session[:cart]
      if @order.save
          @order.projects.each do |project|
            cart.items.each do |item|
              updated_current_funding = project.current_funding + item.funding_amount.to_f
              project.update_attributes!(current_funding: updated_current_funding)
            end
            project.update_attributes!(status: 1) if project.current_funding >= project.funding_goal
          end
        send_registration_email(current_user)
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

  def send_registration_email(user)
    NotificationMailer.contact(user.email).deliver_now
  end
end
