require 'securerandom'

class Item < ActiveRecord::Base
  before_save :generate_uid, on: :new
  
  def generate_uid
    self.uid = SecureRandom.uuid
  end
end
