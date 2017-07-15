class TrinomialsController < ApplicationController

  #this will respond to get request and provide a problem
  # (at this time a plus plus problem)
  def new
    type = ["trinomial", "special", "a>1"].sample

    case type
      when "trinomial"
        trinomial = Trinomial.new
      when "special"
        trinomial = SpecialTrinomial.new
      when "a>1"
        trinomial = ATrinomial.new
    end

    render json: trinomial.generate_random_pattern,
           status: :ok
  end
end
