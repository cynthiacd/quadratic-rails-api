class TrinomialsController < ApplicationController

  #this will respond to get request and provide a problem
  # (at this time a plus plus problem)
  def index
    # initialize a new problem
    problem = Trinomial.new
    # next figure out the pattern to call
    pattern = generate_plus_plus
    # find that pattern
    render json: problem.pattern,
           each_serializer: TrinomialSerializer,
           status: :ok
  end


end
