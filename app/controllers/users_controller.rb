class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:check_solution, :new_report]
  wrap_parameters :user, include: [:username, :password, :password_confirmation]

  def create
    user = User.new(user_params)

    if user.save
      # need to send back token to show user is loggin!
      # the JSON Web Token (JWT) will be UserID + our Secret String
      # (must keep very secret - hide in env file?)
      # so if user posts again (a solution) they can send that Token
      # and you can id the user by that Token :)
      render status: :created, json: { message: "success - user was added" }
    else
      render status: :bad_request, json: user.errors
    end
  end

  # will this be moved to user_token_controller?
  def signin
    user = User.find_by(username: params[:username].to_s.downcase)
    # p user
    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode( {user_id: user.id} )
      render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  def check_solution
    # can change to current_user once singin/singout is working
    # user = User.find_by(username: params["username"])
    user = current_user
    # call User class function to update mastery level
    user.update_mastery_levels(params)
    # provide API response
    render status: :ok, json: { message: "Ready for next problem"}
  end

  def new_report
    # will change to current_user once auth is finalized
    user = current_user
    report = user.generate_mastery_report
    render json: report, status: :ok
  end

  private

  def user_params
    return params.required(:user).permit(:username, :password, :password_confirmation)
  end
end
