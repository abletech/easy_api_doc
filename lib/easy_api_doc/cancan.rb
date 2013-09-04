module EasyApiDoc
  class Cancan
    def initialize(controller, current_user_method, ability = ::Ability)
      @controller = controller
      @current_user_method = current_user_method
      @controller.instance_variable_set '@ability', ability
      @controller.extend ControllerExtension
      @controller.current_ability.authorize! :access, :api_docs
    end

    # def authorize(action, abstract_model = nil, model_object = nil)
    #   @controller.current_ability.authorize!(action, model_object || abstract_model && abstract_model.model) if action
    # end

    # def authorized?(action, abstract_model = nil, model_object = nil)
    #   @controller.current_ability.can?(action, model_object || abstract_model && abstract_model.model) if action
    # end

    # def query(action, abstract_model)
    #   abstract_model.model.accessible_by(@controller.current_ability, action)
    # end

    # def attributes_for(action, abstract_model)
    #   @controller.current_ability.attributes_for(action, abstract_model && abstract_model.model)
    # end

    private

    module ControllerExtension
      def current_ability
        @current_ability ||= @ability.new(send(@current_user_method))
      end
    end
  end
end
