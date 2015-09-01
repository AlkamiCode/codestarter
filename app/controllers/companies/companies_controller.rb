class Companies::CompaniesController < ApplicationController
  before_action :company_not_found?

  helper_method :current_company

  def current_company
    @current_company ||= Company.find_by(url: params[:company])
  end

  def company_not_found?
    redirect_to projects_path unless current_company
  end

  def dashboard
    # @current_company ||= Company.find_by(url: params[:company])
    company = Company.find_by(url: params[:company])
    @projects = company.projects
  end
end
