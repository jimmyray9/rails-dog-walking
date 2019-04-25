class Api::V1::DogsController < Api::V1::BaseController
  before_action :set_dog, only: [:show, :update, :destroy]
  def index
    @user = User.find(params[:user_id])
    @dogs = Dog.all
    @dogs.each do |dog|
      render json: dog if dog.user == @user
    end
  end

  def show
    @user = User.find(params[:user_id])
    render json: @dog if @dog.user == @user
  end

  def update
    @user = User.find(params[:user_id])
    @dog.user = @user
    if @dog.update(dog_params)
      render json: @dog
    else
      render_error
    end
  end

  def create
    @user = User.find(params[:user_id])
    @dog = Dog.new(dog_params)
    @dog.user = @user
    if @dog.save
      render json: @dog, status: :created
    else
      render_error
    end
  end

  def destroy
    @dog.destroy
    head :no_content
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

   def dog_params
    params.require(:dog).permit(:breed, :name, :description, :user_id)
  end

  def render_error
    render json: { errors: @dog.errors.full_messages }, status: :unprocessable_entity
  end
end
