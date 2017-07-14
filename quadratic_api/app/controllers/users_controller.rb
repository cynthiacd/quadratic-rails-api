class UsersController < ApplicationController
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

  def get_report
    user = User.find(1)
    report = user.generate_mastery_report_for_diagram

    render json: report, status: :ok 
  end
end
