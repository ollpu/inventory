class Event < ActiveRecord::Base
  protected
    def after_create
      # Expire main trivia (includes Event.count)
      expire_fragment 'main_trivia'
    end
    def after_destroy; after_create; end
end
