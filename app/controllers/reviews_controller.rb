class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to account_reviews_path
      flash[:notice] = "编辑成功！！！"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to account_reviews_path
    flash[:alert] = "你已经删除成功！！！"
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
