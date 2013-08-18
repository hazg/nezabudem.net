module NotSavedToS
  def self.included(base)
    base.class_eval {

      def save!(*)
        begin
          create_or_update
        rescue e
          #Rails.logger.debug e.awesome_inspect
          false
        end
      end
    }
  end
end
#ActiveRecord::RecordNotSaved
#ActiveRecord::Base.send :include, NotSavedToS

