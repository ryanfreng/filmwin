module ApplicationHelper

  # Retunrs the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Filmwin"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def pretty_date(the_time)
    the_time.strftime("%b %e, %Y")
  end

  def pretty_date_time(the_time)
    the_time.strftime("%b %e, %Y, %l:%M%p")
  end

end
