module EasyApiDoc
  class ApplicationController < ::ApplicationController

    before_filter :load_versions
    before_filter :authenticate!
    before_filter :authorize!

    protected

    def authenticate!
      instance_eval &EasyApiDoc::Options.authenticate_with
    end

    def authorize!
      instance_eval &EasyApiDoc::Options.authorize_with
    end

    def load_versions
      @api_versions = EasyApiDoc::ApiVersion.all
    end
  end
end
