module EasyApiDoc
  class Resource
    include EasyApiDoc::Configurable

    def formats
      inherited_overridable('formats', :from => ['namespace'])
    end

    def actions
      @actions ||= load_children(EasyApiDoc::Action, 'actions')
    end

    def authentication
      @authentication ||= inherited_overridable('authentication', :from => ['resource', 'namespace', 'apiversion'])
    end

  end
end
