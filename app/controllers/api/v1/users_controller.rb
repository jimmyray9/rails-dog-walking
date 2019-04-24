class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [:show, :update, :destroy]
  protect_from_forgery with: :null_session

  def login
    code = params[:code]
    if params[:code].nil?
      a = token_params
      authen = a['token']
      openid = decode(authen)
      render json: {
        status: 200
      }
    else
      token = RestClient.get("https://api.weixin.qq.com/sns/jscode2session?appid=wx9907b4461ceeeee9&secret=f1df82dee8dfa9232df22129c4747846&js_code=#{params[:code]}&grant_type=authorization_code")
      openid = JSON.parse(token)['openid']
      payload = { token: openid }

      @user = User.new
      @user.username = openid
      @user.save

      authen = JWT.encode payload, nil, 'none'
      render json: {
        authen: authen
      }
    end
  end

  def decode(token)
    t = JWT.decode token, nil, false
    t[0]['token']
  end

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
    # payload = { data:@user.id }
    # token = JWT.encode payload, nil, "none"
    # @user.token = token
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

  def token_params
    params.require(:tokens).permit(:token)
  end
end
