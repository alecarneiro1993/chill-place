class PurchasesController < ApplicationController

  def create
    @purchase = Purchase.new(purchase_params)
    if !has_been_bought?
      if @purchase.save
        flash[:success] = 'Item purchased'
        redirect_to controller: :pages,
        action: :library,
        type: @purchase.purchasable_type == 'Movie' ? :movies : :seasons
      else
        flash[:alert] = 'Something went wrong with this purchase'
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = 'This item has been bought already. Check your library'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:purchasable_id, :purchasable_type, :user_id, :quality)
  end

  def has_been_bought?
    Purchase.where(
      purchasable_id: @purchase.purchasable_id,
      purchasable_type: @purchase.purchasable_type,
      user: current_user,
      quality: @purchase.quality,
      created_at: 3.days.ago..DateTime.now).any?
  end

end
