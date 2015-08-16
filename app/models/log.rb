class Log < ActiveRecord::Base
  serialize :items
  serialize :modified
  
  # Validate :items and :modified
  # TODO: This section was deemed too complicated by CodeClimate,
  #       simplify it!
  validate do |log|
    if log.items.length == 0
      log.errors[:items] << "Log has to target atleast one item" # Translate!
    end
    # Check validity of all items (uids)
    log.items.each do |uid|
      unless /\h{8}-\h{4}-\h{4}-\h{4}-\h{12}/.match(uid)
        log.errors[:items] << "Log contains invalid item uid" # Translate!
      end
    end
    
    unless log.modified.is_a?(Hash) and (
        log.modified[:added].is_a?(Array) and
        log.modified[:removed].is_a?(Array)
      )
      #log.errors[:modified] << "Log's modified attribute is of invalid format" #T!
    end
  end
  
  # Custom reader for items_human
  def items_human
    if self.items
      self.items.join(', ')
    else
      ""
    end
  end
  
  # Custom writer for items_human
  def items_human=(input)
    self.items = input.split(',').grep(String).collect(&:strip)
  end
  
  # Applies the changes described in this log on the items it affects
  def apply
    # TODO
  end
end
