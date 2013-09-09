module EasyApiDoc
  class ApiController < EasyApiDoc::ApplicationController

    def index
      @api_versions = EasyApiDoc::ApiVersion.all
    end
  end
end
