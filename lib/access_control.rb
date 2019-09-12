module AccessControl
  class << self
    attr_reader :permissions

    def map
      mapper = Mapper.new
      yield mapper
      @permissions ||= []
      @permissions += mapper.mapped_permissions
    end

    # Returns the permission of given name or nil if it wasn't found
    # Argument should be a symbol
    def permission(name)
      permissions.detect { |p| p.name == name }
    end

    def allowed_actions(action, role, project_module)
      name = AccessControl.fetch_name(action)
      return false if name.nil? && role.nil?

      p_module = fetch_project_module(project_module, action)

      return false if role.permission[p_module].nil?
      role.permission[p_module].include?(name.to_s)
    end

    def fetch_name(action)
      if action.is_a?(Symbol)
        action
      elsif action.is_a?(String)
        action.to_sym
      elsif action.is_a?(Hash)
        s = "#{action[:controller]}/#{action[:action]}"
        permissions.detect { |p| p.actions.include?(s) }.name
      else
        raise ArgumentError, "Symbol or a Hash expected, #{action.class.name} given: #{action}"
      end
    end

    def fetch_project_module(project_module, action)
      project_module.present? ? project_module : action[:controller]
    end
  end

  class Mapper
    def initialize
      @project_module = nil
    end

    def permission(name, hash, options = {})
      @permissions ||= []
      options.merge!(project_module: @project_module)
      @permissions << Permission.new(name, hash, options)
    end

    def mapped_permissions
      @permissions
    end

    def project_module(name)
      @project_module = name
      yield self
      @project_module = nil
    end
  end

  class Permission
    attr_reader :name, :actions, :project_module

    def initialize(name, hash, options)
      @name = name
      @actions = []
      @project_module = options[:project_module]
      hash.each do |controller, actions|
        @actions << if actions.is_a?(Array)
                      actions.collect { |action| "#{controller}/#{action}" }
                    else
                      "#{controller}/#{actions}"
                    end
      end
      @actions.flatten!
    end
  end
end
