class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country]
    video = VideoService.get_video(country)
    images = ImageService.get_images(country)
    
    if video[:items].blank? && images[:results].blank?
      render json: LearningResourcesSerializer.no_result(country)
    else
      render json: LearningResourcesSerializer.results(country, video, images)
    end
  end
end