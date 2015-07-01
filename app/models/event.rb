class Event < ActiveRecord::Base
  protected
    def after_create
      # Expire main trivia (includes Event.count)
      expire_cache 'main_trivia'
    end
end
