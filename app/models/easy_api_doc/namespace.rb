module EasyApiDoc
  class Namespace
    include EasyApiDoc::Configurable

    def resources
      @resources ||= load_children(EasyApiDoc::Resource, 'resources')
    end

    def authentication
      @authentication ||= inherited_overridable('authentication', :from => ['resource', 'namespace', 'apiversion'])
    end

  end
end
