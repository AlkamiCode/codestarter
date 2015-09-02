class CartItemsController < ApplicationController
  def index
    if cart.data.empty?
      flash[:success] = "Your Cart Is Empty! Go Fill It Up!"
      redirect_to root_path
    else
      @cart_items = cart.items
    end
  end

  def create
    project = Project.find(params[:item_id])
    cart.add_project(project)
    session[:cart] = cart.data
    redirect_to :back
  end

  def update
    cart.update_funding_amount(params[:id], params[:funding_amount])
    redirect_to :back
  end

  def destroy
    @project = Project.find(params[:id])
    cart.remove_project(@project)
    session[:cart] = cart.data
    flash[:success] = render_to_string partial: "flash"
    redirect_to cart_path
  end
end
