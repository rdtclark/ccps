class OrganisationsController < ApplicationController
before_action :set_org, only: [:show]

  # organisation/
  def index
    org = Organisation.all
    render json: org
  end

  # organisation/:id
  def show
    render json: @org
  end

  # def about
  #   orgs = Organisation.with_about
  #   render json: orgs
  # end

  private

  def set_org
    @org = Organisation.find(params[:id])
  end
end
