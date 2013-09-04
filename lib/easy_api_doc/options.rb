module EasyApiDoc
  module Options
    class << self

      def authenticate_with(&block)
        @authenticate = block if block
        @authenticate || Proc.new {}
      end

      def authorize_with(*args, &block)
        authorization_type = args.shift
        current_user_method = args.shift
        if authorization_type
          @authorize = Proc.new {
            @current_user_method = current_user_method
            @authorization_type = ('EasyApiDoc::' + authorization_type.to_s.classify).constantize.new(self, @current_user_method)
          }
        else
          @authorize = block if block
        end
        @authorize || Proc.new {}
      end
    end
  end
end