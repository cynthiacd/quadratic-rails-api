class TrinomialsController < ApplicationController

  #this will respond to get request and provide a problem
  # (at this time a plus plus problem)
  def index
    # initialize a new problem
    problem = SpecialTrinomial.new
    # in future will need to set user for problem
    # user = ""
    # problem.user_id = user.id


    # next figure out the pattern to call
    # pattern = generate_plus_plus
    # find that pattern
    render json: problem.generate_random_special,
           status: :ok
  end

  # should this be in a users controller cause its main job is to update the users
  # mastery level?
  def check_solution
    # the params might look like: { "trinomial" => { "general_form": "blah",
                                              # "solution": "()()",
                                              # "username": "testname1",
                                              # "pattern": "plus_plus",
                                                # "step1": "blah",
                                                # "step2": "blah",
                                                # "step3/final answer": "blah"
                                              # "points": true or false }}
    # user_answer = params["final"]
    # solution1 = params["solution1"]
    # solution2 = params["solution2"]
    user = User.find_by(username: params["username"])
    # call User class function to update mastery level
    user.update_mastery_levels(params)

    # provide API response
    render status: :ok, json: { message: "Ready for next problem"}
  end
end
