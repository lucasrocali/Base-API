class V1::WorksController < ApplicationController

    # GET /works
  def index
    @works = Work.order(:id).all
    render :json => @works
  end
end
