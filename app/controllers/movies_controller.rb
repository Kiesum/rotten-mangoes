    class MoviesController < ApplicationController

      def index
        @movies = Movie.all

        if params[:duration]
          min_value = params[:duration].split('-')[0]
          max_value = params[:duration].split('-')[1]
        end

        if max_value == nil 
          max_value = Movie.maximum("runtime_in_minutes")+1
        end

        if params[:title_or_director] || params[:duration]
          @movies = Movie.title_or_director(params[:title_or_director]).duration(min_value, max_value)
        end

      end

      def show
        @movie = Movie.find(params[:id])
      end

      def new
        @movie = Movie.new
      end

      def edit
        @movie = Movie.find(params[:id])
      end

      def create
        @movie = Movie.new(movie_params)

        if @movie.save
          redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"  
        else
          render :new
        end
      end

      def update
        @movie = Movie.find(params[:id])

        if @movie.update_attributes(movie_params)
          redirect_to movie_path(@movie)
        else
          render :edit
        end
      end

      def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movies_path
      end

      protected

      def movie_params
        params.require(:movie).permit(
          :title, :release_date, :director, :runtime_in_minutes, :description, :image
        )
      end

    end