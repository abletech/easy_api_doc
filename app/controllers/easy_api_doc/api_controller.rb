module EasyApiDoc
  class ApiController < EasyApiDoc::ApplicationController

    def index
      @api_versions = EasyApiDoc::ApiVersion.all
    end

    def show
      @api_version = EasyApiDoc::ApiVersion.find(params[:id])
    end

  end
end
