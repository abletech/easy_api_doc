module EasyApiDoc
  class ApplicationController < ActionController::Base

    before_filter :load_versions

    protected

    def load_versions
      @api_versions = EasyApiDoc::ApiVersion.all
    end

    def load_config
      Configuration.load
    end

  end
end
