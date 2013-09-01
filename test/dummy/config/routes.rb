Rails.application.routes.draw do
  mount EasyApiDoc::Engine => "/api_doc"
end
