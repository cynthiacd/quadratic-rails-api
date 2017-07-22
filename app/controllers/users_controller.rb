class UsersController < ApplicationController
  before_action :authenticate_user only: [:check_solution, :report]
  # need this cause rails auto hids password and password_confirmation - without
  # password appears to be missing and fails validations
  wrap_parameters :user, include: [:username, :password, :password_confirmation]

  # will this be moved to user_token_controller?
  def create
    # username = params[:username]
    # password = params[:password]
    # p params
    user = User.new(user_params)
    # user.username = params[:username]
    # user.password = params[:password]
    # user.save

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
    # the params might look like: { "trinomial" => { "general_form": "blah",
                                              # "solution": "()()",
                                              # "username": "testname1",
                                              # "token": "userToken"
                                              # "pattern": "plus_plus",
                                              # "step1": "blah",
                                              # "step2": "blah",
                                              # "step3/final answer": "blah"
                                              # "points": true or false }}
    # can change to current_user once singin/singout is working
    user = User.find_by(username: params["username"])
    # call User class function to update mastery level
    user.update_mastery_levels(params)
    # provide API response
    render status: :ok, json: { message: "Ready for next problem"}
  end

  def new_report
    user = User.find(1)
    report = user.generate_mastery_report
    render json: report, status: :ok
  end

  private

  def user_params
    return params.required(:user).permit(:username, :password, :password_confirmation)
  end
end
