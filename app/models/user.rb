class User < ActiveRecord::Base
  
  protected
    def after_create
      # Expire main trivia (includes User.count)
      expire_cache 'main_trivia'
    end
end
