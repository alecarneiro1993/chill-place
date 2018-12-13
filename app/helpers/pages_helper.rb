module PagesHelper

  def active?(input)
    action_name == input ? "nav-link active" : "nav-link"
  end

  def active_type?(type)
    params[:type] == type ? "nav-link active" : "nav-link"
  end

  def item_type
    @type == 'movies' ? 'Movie' : 'Season'
  end
end
