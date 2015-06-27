require 'securerandom'

class Item < ActiveRecord::Base
  before_save :generate_uid, on: :new
  def generate_uid
    self.uid = SecureRandom.uuid
  end
  
  # When adding a new subclass, please maintain both TYPES and TYPES_HASH
  # [name, class],
  TYPES = [
    ['Cable', 'Cable'],
    ['Device', 'Device'],
    ['Person', 'Person'],
  ]
  # class => name,
  TYPES_HASH = {
    'Cable' => 'Cable',
    'Device' => 'Device',
    'Person' => 'Person',
  }
  
  def get_type_name
    TYPES_HASH[self.type]
  end
  
  # Use uid as an URL parameter instead of id
  def to_param
    self.uid
  end
  
end
