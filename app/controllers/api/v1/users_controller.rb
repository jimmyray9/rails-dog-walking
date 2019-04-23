class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render_error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render_error
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

   def user_params
    params.require(:user).permit(:is_walker, :name, :zip_code, :phone_number, :walker_age, :walker_description, :walker_img, :token, :username)
  end

  def render_error
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
end
