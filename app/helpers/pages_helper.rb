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

  def page_path(param)
    action_name == 'library' ? library_path(type: param) : store_path(type: param)
  end

  def time_left(item)
    time = ((item.created_at + 3.days - Time.now)/3600).round.to_s
    "#{time} hours"
  end
end
