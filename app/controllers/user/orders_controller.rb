class User::OrdersController < User::BaseController
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
