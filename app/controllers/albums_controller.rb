class AlbumsController < ApplicationController

  def new
    @bands = Band.all
    @band = Band.find_by_id(params[:band_id])
    render :new
  end

  def create
    @bands = Band.all
    @band = Band.find_by_id(params[:band_id])
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = "Album saved!"
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def index
    redirect_to band_url(params[:band_id])
  end

  def show
    @band = Band.find_by_id(params[:band_id])
    @album = Album.find_by_id(params[:id])
  end

  private

  def album_params
    params.require(:album).permit(:id, :name, :band_id, :year, :album_type)
  end
end
