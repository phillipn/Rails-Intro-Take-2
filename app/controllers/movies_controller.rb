class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    redirect_to movies_path(ratings: session[:ratings]) if params[:ratings].nil? && session[:ratings]
    @all_ratings = Movie.all_ratings
    
    session[:sort] = params[:sort] if params[:sort].present?
    session[:direction] = params[:direction] if params[:direction].present?
    session["ratings"] = params["ratings"] if params["ratings"].present?
    
    if params[:ratings].nil? && session[:ratings].nil?
      @ratings_filter = @all_ratings 
    else
      @ratings_filter = session["ratings"].keys
    end
  
    @movies = Movie.all
    @movies = @movies.order(session[:sort] + " " + session[:direction]) if session[:sort] && session[:direction]
    @movies = @movies.select { |m| @ratings_filter.include?(m.rating) } if session[:ratings]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
