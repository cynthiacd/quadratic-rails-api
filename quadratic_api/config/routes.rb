Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # following convention trinomials should be pluar but you are really only sending one problem...

  post "trinomials/check", to: "users#check_solution", as: "check_solution"
  get "trinomials", to: "trinomials#index", as: "trinomials"
  get "users/report", to: "users#get_report", as: "user_report"
end
