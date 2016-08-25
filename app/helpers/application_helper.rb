module ApplicationHelper
  def render_page_title
    site_name = Settings.site_name
    title = @page_title ? "#{@page_title} - #{site_name}" : site_name
    content_tag('title', title, nil, false)
  end

  def iframe_src(path)
    url = URI.join(Devise.cas_base_url,path)
    url.query = URI.encode_www_form([["service", request.base_url]])
    url
  end
end
