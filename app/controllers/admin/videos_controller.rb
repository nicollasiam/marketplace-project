class Admin::VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all.where(user: user)
  end

  def show
  end

  def edit
  end

  def new
    @video = Video.new
  end

  def update
    if @video.update(video_params)
      redirect_to admin_video_path(@video)
    else
      render :edit
    end
  end

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    if @video.save
      redirect_to admin_video_path(@video)
    else
      render :new
    end
  end

  def destroy
    @video.destroy
    redirect_to admin_videos_path
  end

  private

  def find_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:file, :file_cache, :user)
  end
end
