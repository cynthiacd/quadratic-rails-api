Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # following convention trinomials should be pluar but you are really only sending one problem...

  post "trinomial/check", to: "users#check_solution", as: "check_solution"
  # get "trinomials", to: "trinomials#index", as: "trinomials"
  get "trinomial", to: "users#get_new_trinomial", as: "trinomial"
  get "user/report", to: "users#get_report", as: "user_report"
end
