class ViewingPartiesController < ApplicationController
  def new
    @movie = MovieFacade.get_movie(params[:movie_id])
    @user = User.find(params[:user_id])
    @users = User.where("id != #{@user.id}")
  end
end