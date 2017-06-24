class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path
      flash[:alert] = "你没有这个操作权限！！！"
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path
      flash[:alert] = "你没有这个操作权限！！！"
    end

    if @movie.update(movie_params)
      redirect_to movies_path
      flash[:notice] = "编辑电影成功！"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path
      flash[:alert] = "你没有这个操作权限！！！"
    end
    
    @movie.destroy
    redirect_to movies_path
    flash[:alert] = "删除电影成功！"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
