class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:format]
    video = VideoService.get_video(country)
    images = ImageService.get_images(country)

    render json: LearningResourcesSerializer.results(country, video, images)
  end
end