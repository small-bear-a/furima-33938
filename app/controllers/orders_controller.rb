class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_action, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    if current_user == @item.user || @item.purchase.present?
      redirect_to root_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(order_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_action
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:purchase_address).permit(:code, :prefecture_id, :city, :address, :building_name, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
