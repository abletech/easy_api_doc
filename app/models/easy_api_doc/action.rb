require 'net/http'

module EasyApiDoc
  class Action
    include EasyApiDoc::Configurable

    def path
      uri = attributes['uri']
      if host
        "#{protocol}://#{host}#{uri}"
      else
        uri
      end
    end

    # def run(params, method, format)
    #   uri = URI(path + "." + format)
    #   res = Net::HTTP.send(method.downcase, uri) # TODO works with get only
    #   # {:body => res.body, :status => res.status}
    #   res
    # end

    def parameters
      @parameters ||= load_children(EasyApiDoc::Parameter, 'parameters')
    end

    def post_data
      attributes['post_data']
    end

    def protocol
      v = @parents['apiversion']
      v.attributes['defaults']['protocol'] || 'http'
    end

    def host
      v = @parents['apiversion']
      if v && v.attributes['defaults']
        v.attributes['defaults']['domain']
      else
        nil
      end
    end

    def formats
      v = inherited_overridable('formats', :from => ['resource', 'namespace'])
      v.split(/\,\s/) if v
    end

    def authentication
      @authentication ||= inherited_overridable('authentication', :from => ['resource', 'namespace', 'apiversion'])
    end

    def options
      @attributes['options']
    end

  end
end
