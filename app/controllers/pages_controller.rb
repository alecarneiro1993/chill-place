class PagesController < ApplicationController

  layout 'splash', only: [:index]

  before_action :signed_in?, only: [:index]
  before_action :set_type, only: [:library, :store, :store_json, :checkout]
  skip_before_action :authenticate_user!, only: [:index, :store_json]

  def index
  end

  def library
    @items = get_purchased_items.order(created_at: :asc).page(params[:page]).per(6)
  end

  def store
    @items = @resource.order(created_at: :desc).page(params[:page]).per(6)
  end

  def store_json
    respond_to do |format|
      format.json {
        render json: {
          movies: Movie.all.order(id: :asc, created_at: :desc),
          seasons: format_seasons_json
        }
      }
    end
  end

  def checkout
    @item = @resource.find(params[:id])
    @purchase = Purchase.new
  end

  private
  def signed_in?
    redirect_to library_path if user_signed_in?
  end

  def set_type
    @type = params[:type]
    @resource = @type == 'movies' ? Movie : Season
  end

  def get_purchased_items
    Purchase.where(
      user: current_user,
      purchasable_type: @resource.to_s,
      created_at: 3.days.ago..DateTime.now
    )
  end

  def time_left(item)
    time = ((item.created_at + 3.days - Time.now)/3600).round(2).to_s.split('.')
    "#{time[0]} hours e #{time[1]} minutes"
  end

  def format_seasons_json
    Season.all.order(id: :asc, created_at: :desc).map { |season|
     s = season.attributes
     s[:episodes] = season.episodes.order(id: :asc)
     s
    }
  end
end
