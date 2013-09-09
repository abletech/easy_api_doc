module EasyApiDoc
  class ApiVersion
    include EasyApiDoc::Configurable

    def namespaces
      @namespaces ||= load_children(EasyApiDoc::Namespace, nil, {:exclude => ['defaults', 'meta', 'description']})
    end

    def self.config_path
      ['api']
    end

    def authentication
      @authentication ||= inherited_overridable('authentication', :from => ['resource', 'namespace', 'apiversion'])
    end

  end
end
