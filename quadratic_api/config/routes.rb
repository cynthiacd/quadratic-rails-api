Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # following convention trinomials should be pluar but you are really only sending one problem...
  get "trinomials", to: "trinomials#index", as: "trinomials"
  post "trinomials/check", to: "users#check_solution", as: "check_solution"
end
