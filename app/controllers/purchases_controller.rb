class PurchasesController < ApplicationController

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      flash[:success] = 'Item purchased'
      redirect_to :library
    else
      flash[:alert] = 'Something went wrong with this purchase'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:purchasable_id, :purchasable_type, :user_id, :quality)
  end

end
