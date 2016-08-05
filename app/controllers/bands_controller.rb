class BandsController < ApplicationController
  before_action :logged_in?, only: [:new]

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find_by_id(params[:id])
    render :show
  end

  def destroy
    @band = Band.find_by_id(params[:id])
    @band.delete
    flash[:notice] = "Band deleted!"
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
