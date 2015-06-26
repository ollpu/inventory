require 'securerandom'

class Item < ActiveRecord::Base
  before_save :generate_uid, on: :new
  
  TYPES = [
    ['Cable', 'Cable'],
    ['Device', 'Device'],
    ['Person', 'Person'],
  ]
  
  
  
  def generate_uid
    self.uid = SecureRandom.uuid
  end
end
