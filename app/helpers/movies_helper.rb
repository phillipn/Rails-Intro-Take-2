module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def sortable(column, title = '')
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, movies_path(sort: column, direction: direction)
  end
  
  def highlighted?(sort)
    'hilite' if session[:sort] == sort
  end
  
  def check_if_true(params, rating)
    params.include?(rating) ? true : false
  end
end
