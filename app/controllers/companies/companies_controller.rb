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
    if current_company == current_user.company
      company = Company.find_by(url: params[:company])
      @projects = company.projects
    else
      flash[:danger] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end
end
