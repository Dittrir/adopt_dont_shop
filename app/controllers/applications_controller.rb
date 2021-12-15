class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    search = Pet.find_by(name: params[:search])
    if search
      @application.pet_applications.create(pet_id: search.id)
    else
      flash[:notice] = "No results found. Please try again."
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Fields can't be left blank."
      render :new
    end
  end

private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end
