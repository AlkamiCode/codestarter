class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    if current_user
      @order = current_user.orders.build
      @order.cart_data = session[:cart] if session[:cart]
      if @order.save
          @order.projects.each do |project|
            updated_current_funding = project.current_funding + params[:funding_amount].to_f
            project.update_attributes!(current_funding: updated_current_funding)

            project.update_attributes!(status: 1) if project.current_funding >= project.funding_goal
          end
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
end
