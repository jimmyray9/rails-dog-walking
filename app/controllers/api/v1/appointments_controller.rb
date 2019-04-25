class Api::V1::AppointmentsController < Api::V1::BaseController
  before_action :set_appointment, only: [:show, :update, :destroy]
  def index
    @user = User.find(params[:user_id])
    @dog = Dog.find(params[:dog_id])
    @appointments = Appointment.all
    @array = []
    @appointments.each do |appointment|
      @array << appointment if appointment.user == @user && appointment.dog == @dog
    end
    render json: @array
  end

  def show
    @user = User.find(params[:user_id])
    @dog = Dog.find(params[:dog_id])
    render json: @appointment if @appointment.user == @user && @appointment.dog == @dog
  end

  def update
    @user = User.find(params[:user_id])
    @appointment.user = @user
    @dog = Dog.find(params[:dog_id])
    @appointment.dog = @dog

    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render_error
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @user = User.find(params[:user_id])
    @appointment.user = @user
    @dog = Dog.find(params[:dog_id])
    @appointment.dog = @dog

    if @appointment.save
      render json: @appointment, status: :created
    else
      render_error
    end
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

   def appointment_params
    params.require(:appointment).permit(:date_time, :address, :duration, :price, :user_id, :dog_id)
  end

  def render_error
    render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
  end
end
