class User < ActiveRecord::Base
  
  protected
    def after_create
      # Expire main trivia (includes User.count)
      expire_fragment 'main_trivia'
    end
end
