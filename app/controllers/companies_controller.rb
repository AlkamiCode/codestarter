class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def dashboard
    company = Company.find_by(url: params[:company])
  end
end
