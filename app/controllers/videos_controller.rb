class VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @videos = Video.all.reverse_order
  end

  def show
    @video = Video.find(params[:id])
    @video_coordinates = { lat: @video.latitude, lng: @video.longitude }

    @hash = Gmaps4rails.build_markers(@video) do |video, marker|
      marker.lat video.latitude
      marker.lng video.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end
end
