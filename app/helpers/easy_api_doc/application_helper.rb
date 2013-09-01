require 'github/markup'

module EasyApiDoc
  module ApplicationHelper

    def api_link(api)
      api_path(:id => api.name)
    end

    def namespace_link(namespace)
      namespace_path(:api => namespace.parents['apiversion'].name, :namespace => namespace.name)
    end

    def resource_link(resource)
      resource_path(:api => resource.parents['apiversion'].name, :namespace => resource.parents['namespace'].name, :resource => resource.name)
    end

    def action_link(action)
      api_action_path(:api => action.parents['apiversion'].name, :namespace => action.parents['namespace'].name, :resource => action.parents['resource'].name, :api_action => action.name)
    end

    def breadcrumbs(stack)
      crumbs = []
      stack.each do |name, uri|
        if uri
          crumbs << link_to(name, uri)
        else
          crumbs << name
        end
      end

      content_tag(:ol, :class => "breadcrumb") do
        output = ""
        crumbs.each do |c|
          output += content_tag(:li, c, :class => crumbs.last ? 'active' : nil)
        end
        output.html_safe
      end
    end

    def contents_for_resource(resource, attribute_name)
      tree = ['doc', 'api', resource.parents['apiversion'].name, resource.parents['namespace'].name, resource.name]
      file = File.join(*tree, "#{attribute_name}.md")
      if File.exists?(file)
        GitHub::Markup.render(file, File.read(file)).html_safe
      else
        resource.attributes[attribute_name]
      end
    end

    def contents_for_action(resource, action, attribute_name)
      tree = ['doc', 'api', resource.parents['apiversion'].name, resource.parents['namespace'].name, resource.name, action.name]
      file = File.join(*tree, "#{attribute_name}.md")
      if File.exists?(file)
        GitHub::Markup.render(file, File.read(file)).html_safe
      else
        action.attributes[attribute_name]
      end
    end

    def example_json(key_json_file)
      tree = ['doc', 'api', 'examples', 'json']
      file = File.join(*tree, "#{key_json_file}")
      if File.exists?(file)
        File.read(file)
      else
        nil
      end
    end
  end
end
