class Api::V1::TherapistsController < ApplicationController
  before_action :authorize

  def index
    therapists = Therapist.all
    render json: therapists, status: :ok
  end

  def show
    begin 
      therapist = Therapist.find(params[:id])
      patients = therapist.patients

      serialized_info = TherapistSerializer.therapist_view(therapist, patients)
      render json: serialized_info, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    end
  end

  def create
    therapist = Therapist.new(therapist_params)
    if therapist.save
      render json: therapist, status: :created
    else
      render json: {errors: therapist.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    begin
      therapist = Therapist.find(params[:id])
      therapist.update(therapist_params)

      render json: therapist, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    end
  end

  def destroy
    therapist = Therapist.find(params[:id])
    therapist.patients.destroy_all
    
    if therapist.destroy
      render json: {message: "Therapist deleted successfully"}, status: :ok
    end
  end

  private

  def therapist_params
    params.require(:therapist).permit(:name, :email, :office_number, :specialization, :years_in_practice, :credentials, :bio)
  end
end