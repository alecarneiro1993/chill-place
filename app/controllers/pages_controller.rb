class PagesController < ApplicationController

  layout 'splash', only: [:index]

  before_action :signed_in?, only: [:index]
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  def library
  end

  def store
  end

  private
  def signed_in?
    redirect_to library_path if user_signed_in?
  end

end
