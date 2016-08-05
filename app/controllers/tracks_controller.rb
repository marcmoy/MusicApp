class TracksController < ApplicationController

  def new
    @track = Track.new
    @album = Album.find_by_id(params[:album_id])
    @band = Band.find_by_id(params[:band_id])
    flash[:track_nums] = 1
    render :new
  end

  def create
    @album = Album.find_by_id(params[:album_id])
    @band = Band.find_by_id(params[:band_id])
    @track = Track.new(track_params)

    if @track.save
      flash[:notice] = "Tracks added!"
      redirect_to band_album_url(params[:band_id], params[:album_id])
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def index
    redirect_to band_album_url(params[:band_id], params[:album_id])
  end

  def show
    @track = Track.find_by_id(params[:id])
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :lyrics, :track_type)
  end
end
