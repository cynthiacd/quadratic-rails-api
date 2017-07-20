class UsersController < ApplicationController
  before_action :authenticate_user

  # will this be moved to user_token_controller?
  def create
    # username = params[:username]
    # password = params[:password]

    user = User.new
    user.username = params[:username]
    user.password = params[:password]
    user.save

    if user.valid?
      # need to send back token to show user is loggin!
      # the JSON Web Token (JWT) will be UserID + our Secret String
      # (must keep very secret - hide in env file?)
      # so if user posts again (a solution) they can send that Token
      # and you can id the user by that Token :)
      render status: :ok, json: { message: "success - user was added" }
    else
      render status: :bad_request, json: user.errors
    end
  end

  # will this be moved to user_token_controller?
  def login
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
end
