class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, only: [:show, :update]

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.create_success('Account'), auth_token: auth_token }
    json_response(response, :created)
  end

  def show
    return json_response({ error: Message.unauthorized }, 403) unless @user.id == current_user.id || is_admin?
    render json: @user
  end

  def update
    return json_response({ error: Message.unauthorized }, 403) unless @user.id == current_user.id
    @user.update!(user_params)
    json_response({ message: Message.update_success('User account'), user: @user })
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
