module EasyApiDoc
  class DocumentationController < EasyApiDoc::ApplicationController
    before_filter :defaults

    def namespace
      @resources = @namespace.resources
    end

    def resource
      @resource = @namespace.resources.find {|r| r.name == params[:resource] }
      if @resource.nil?
        raise "no resource #{params[:resource]}"
      end
      @actions = @resource.actions
    end

    def api_action
      @resource = @namespace.resources.find {|r| r.name == params[:resource] }
      @action = @resource.actions.find {|a| a.name == params[:api_action] }
    end

    private

    def defaults
      @api_version = EasyApiDoc::ApiVersion.find(params[:api])
      @namespace = @api_version.namespaces.find {|ns| ns.name == params[:namespace] }
      @meta = EasyApiDoc::ApiVersion.config['meta']
      @app_title = @meta['app_title'] if @meta
    end
    # def execute_action
    #   @api_version = EasyApiDoc::ApiVersion.find(params[:api])
    #   @namespace = @api_version.namespaces.find {|ns| ns.name == params[:namespace] }
    #   @resource = @namespace.resources.find {|r| r.name == params[:resource] }
    #   @action = @resource.actions.find {|a| a.name == params[:api_action] }
    #   params[:payload].delete(:authenticity_token)

    #   res = @action.run(params[:payload], params[:remote_method], params[:format])
    #   render params[:format].to_sym => res, :status => 200 #res[:status]
    # end

  end
end
