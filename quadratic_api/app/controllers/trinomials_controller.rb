class TrinomialsController < ApplicationController

  #this will respond to get request and provide a problem
  def new
    # trinomial generates 4 diff patterns so it should be in there four times...
    # or all four patterns should be there own class
    type = ["trinomial", "trinomial", "trinomial", "trinomial", "special", "a>1"].sample

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

  def new_custom
    user = User.find_by(username: "user1")
    # p user
    report = user.generate_mastery_report

    # lowest_pattern = report.min_by { |pattern, level| level }[0].to_s # returns [pattern: level]
    lowest_patterns = []
    report.each { |pattern, level| lowest_patterns << pattern if level < 60 }
    pattern = lowest_patterns.sample.to_s
    p pattern

    case pattern
    when "plus_plus", "minus_plus" , "minus_minus" , "plus_minus"
      trinomial = Trinomial.new.generate_trinomial(pattern)
    when "plus_dbl_sq" , "minus_dbl_sq" , "diff_sq"
      trinomial = SpecialTrinomial.new.generate_trinomial(pattern)
    when "a_greater_one"
      trinomial = ATrinomial.new.generate_random_pattern
    end

    p trinomial

    render json: trinomial,
           status: :ok
  end

end
