require 'httparty'

class Siskel
	attr_reader :title, :rating, :year, :plot, :concensus, :actor
	def initialize(title, options = nil)
    
    if options.nil?	
    	movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&tomatoes=true")
    elsif !options[:year].nil?
    	new_year = options[:year]
    	movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{new_year}")
    else
    	plot = options[:plot].to_s
    	movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&plot=#{plot}")
    end

    if movie["Response"] == "False"
    	@title = "Movie not found!"
    else
	    @title = movie["Title"]
	    @actor = movie["Actors"].split(", ")
	    # @actor = @actor
	    @rating = movie["Rated"]
	    @year = movie["Year"]
	    @plot = movie["Plot"]
	    tomatoes = movie["tomatoUserMeter"].to_i
	    if tomatoes > 75 && tomatoes < 101
	    	@concensus = "Two Thumbs Up"
	    end

	    if tomatoes < 51 && tomatoes > 25
	    	@concensus = "Thumbs Down"
	    end
	end
  end
end 







