module PagesHelper

  def active?(input)
    action_name == input ? "nav-link active" : "nav-link"
  end
end
