class IntentsController < ApplicationController
  def create
    render json: Ralyxa::Skill.handle(request)
  end
end