

class Item < ActiveRecord::Base
  # The SecureRandom library is used to generate uid:s
  require 'securerandom'
  
  # Generate uid on creation
  before_save :generate_uid, on: :new
  def generate_uid
    self.uid = SecureRandom.uuid
  end
  
  validates :type, presence: true
  
  ## List of subclasses and their aliases
    # When adding a new subclass, please maintain both TYPES and TYPES_HASH
    # [name, class],
    TYPES = [
      [Cable.model_name.human, 'Cable'],
      [Device.model_name.human, 'Device'],
      [Misc.model_name.human, 'Object'],
    ]
    # class => name,
    TYPES_HASH = {
      'Cable' => Cable.model_name.human,
      'Device' => Device.model_name.human,
      'Object' => Misc.model_name.human,
    }
    
    def get_type_name
      TYPES_HASH[self.type]
    end
  ##
  
  # Use uid as an URL parameter instead of id
  def to_param
    self.uid
  end
  
end
