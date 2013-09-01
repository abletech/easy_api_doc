EasyApiDoc::Engine.routes.draw do

  resources :api, :only => [:index, :show]
  get '/api/:api/:namespace' => 'documentation#namespace',                        :as => 'namespace'
  get '/api/:api/:namespace/:resource' => 'documentation#resource',               :as => 'resource'
  get '/api/:api/:namespace/:resource/:api_action' => 'documentation#api_action', :as => 'api_action'

  root :to => 'api#index'
end
