

class Item < ActiveRecord::Base
  # The SecureRandom library is used to generate uid:s
  require 'securerandom'
  
  # Generate uid on creation
  before_save :generate_uid, on: :new
  def generate_uid
    self.uid = SecureRandom.uuid
  end
  
  validates :uid,
    presence: true,
    format: { with: /\h{8}-\h{4}-\h{4}-\h{4}-\h{12}/ },
    length: { is: 36 },
    on: :update
  validates :type, presence: true
  
  ## List of subclasses and their aliases
    # When adding a new subclass, please maintain both TYPES and TYPES_HASH
    # [name, class],
    TYPES = [
      [I18n.t(:cable, scope: [:activerecord, :models]), 'Cable'],
      [I18n.t(:device, scope: [:activerecord, :models]), 'Device'],
      [I18n.t(:object, scope: [:activerecord, :models]), 'Object'],
    ]
    # class => name,
    TYPES_HASH = {
      'Cable' => I18n.t(:cable, scope: [:activerecord, :models]),
      'Device' => I18n.t(:device, scope: [:activerecord, :models]),
      'Object' => I18n.t(:object, scope: [:activerecord, :models]),
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
