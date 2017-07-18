Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # following convention trinomials should be pluar but you are really only sending one problem...
  pattern_constraints = { pattern: /(plus_plus)|
                                    (minus_plus)|
                                    (minus_minus)|
                                    (plus_minus)|
                                    (diff_sq)|
                                    (plus_dbl_sq)|
                                    (minus_dbl_sq)|
                                    (a_greater_one)|
                                    (custom)/ }

  get "trinomial/:pattern", to: "trinomials#new_custom", as: "new_trinomial", contraints: pattern_constraints
  # get "trinomial/:pattern", to: "tinomial#new_by_pattern" as: "new_trinomial_by_pattern",
  get "user/report", to: "users#new_report", as: "user_report"
  post "trinomial/check", to: "users#check_solution", as: "check_solution"
end
