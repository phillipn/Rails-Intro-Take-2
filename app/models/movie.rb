class Movie < ActiveRecord::Base
  def self.all_ratings
    Movie.pluck(:rating).uniq.sort
  end
end
