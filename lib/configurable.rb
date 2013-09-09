module EasyApiDoc
  module Configurable
    extend ActiveSupport::Concern

    included do
      attr_accessor :name, :attributes, :parents
    end

    module ClassMethods
      def all
        root_node.map do |name, opts|
          new(name, opts)
        end
      end

      def find(name)
        name, attrs = root_node.find {|key, attrs| key.to_s == name.to_s }
        new(name, attrs)
      end

      def config
        Configuration.load
      end

      # Override me
      def config_path
        [self.to_s.split("::").last.downcase]
      end

      # protected

      def root_node
        node = self.config
        config_path.each do |n|
          node = node[n]
        end
        node
      end
    end

    def defaults
      inherited_overridable('defaults')
    end

    def inherited_overridable(attr_name, options = {:from => []})
      if v = @attributes[attr_name]
        return v
      end

      if options[:from]
        search = options[:from].map {|s| @parents[s] }
      else
        search = @parents
      end
      search.each do |parent|
        if parent && v = parent.attributes[attr_name]
          return v
        end
      end
      nil
    end

    def load_children(klass, nodename = nil, options = {})
      ref = (nodename ? @attributes[nodename] : @attributes) || []
      parents = @parents.merge(self.class.to_s.split("::").last.downcase => self)
      ref.map do |name, opts|
        next if options[:exclude] && options[:exclude].include?(name)
        opts = opts.merge(options[:extra_attributes]) if options[:extra_attributes]
        klass.new(name, opts, parents)
      end.compact
    end

    # Instance methods
    def initialize(name, attributes, parents = {})
      @name = name
      @attributes = attributes
      @parents = parents
    end

    # Shortcuts
    def [](key)
      @attributes[key]
    end

    def []=(key, value)
      @attributes[key] = value
    end

  end
end
