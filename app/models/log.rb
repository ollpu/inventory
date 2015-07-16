class Log < ActiveRecord::Base
  serialize :items, :changed
  
  # Validate :items and :changed
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
    
    if not (
        log.changed[:added].is_a?(Array) and
        log.changed[:removed].is_a?(Array)
      )
      log.errors[:changed] << "Log's changed attribute is of invalid format" #T!
    end
  end
  
  # Applies the changes described in this log on the items it affects
  def apply
    # TODO
  end
end
