module EasyApiDoc
  module ResourceHelper
    def label_color_for_http_method(method)
      case method.upcase
      when 'GET'
        "success"
      when 'POST'
        "primary"
      when 'DELETE'
        "danger"
      when 'PUT'
        "info"
      when 'PATCH'
        "warning"
      else
        "default"
      end
    end
  end
end
