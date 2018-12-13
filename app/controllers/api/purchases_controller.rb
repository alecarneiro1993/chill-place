class Api::PurchasesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_user, only: [:index]

  def index
    render json: {
      purchased_items: format_purchases
    }
  end

  def create
    @user = User.find(params[:purchase][:user_id])
    @purchase = Purchase.new(purchase_params)
    if !has_been_bought?
      @purchase.save ? (head 200) : (head 404)
    else
      head 401
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:purchasable_id, :purchasable_type, :quality, :user_id)
  end

  def has_been_bought?
    Purchase.where(
      purchasable_id: @purchase.purchasable_id,
      purchasable_type: @purchase.purchasable_type,
      user: @user,
      quality: @purchase.quality,
      created_at: 3.days.ago..DateTime.now).any?
  end

  def format_purchases
    purchases = Purchase.where(user: @user, created_at: 3.days.ago..DateTime.now).order(created_at: :desc)
      purchases.map { |purchase|
        item = purchase.purchasable
        time_left = ((item[:created_at] + 3.days - Time.now)/3600).round
        item = item.attributes
        item[:time_left] = "#{time_left} hours"
        item
      }
  end
end
