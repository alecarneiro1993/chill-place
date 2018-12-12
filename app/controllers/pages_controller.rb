class PagesController < ApplicationController

  layout 'splash', only: [:index]

  before_action :signed_in?, only: [:index]
  before_action :set_type, only: [:store]
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  def library
  end

  def store
    @items = @resource.order(:created_at).page(params[:page]).per(6)
  end

  private
  def signed_in?
    redirect_to library_path if user_signed_in?
  end

  def set_type
    @type = params[:type]
    @resource = @type == 'movies' ? Movie : Season
  end

end
