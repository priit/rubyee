module LinkHelpers

  def text_or_link_to(text, url = nil)
    if url
      link_to text, url
    else
      text
    end
  end

end
