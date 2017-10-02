class PlatformsController < ApplicationController
  def index
    @platforms = Platform.all
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(platform_params)
    if @platform.save
      redirect_to @platform
    else
      redirect_to new_platform_path
    end
  end

  def show
    @platform = Platform.find(params[:id])
  end

  def set_instance
    cookies[:instance_id] = params[:platform_id]
    redirect_to platforms_path
  end

  private

  def platform_params
    params.require(:platform).permit(:description, :url)
  end
end
