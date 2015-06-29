require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  
  test 'generate_uid should return uuid' do
    item = Item.new
    item.generate_uid
    
    assert_match /\h{8}-\h{4}-\h{4}-\h{4}-\h{12}/, item.uid, "generate_uid did not generate a valid UUID"
  end
  
  test 'uid should be generated before save' do
    item = Item.new
    item.type = "Cable"
    
    assert_nothing_raised do
      item.save!
    end
    assert_not_nil item.uid, "Item was saved without uid"
  end
  
  test 'type should be present' do
    item = Item.new
    assert_raises ActiveRecord::RecordInvalid do
      item.save!
    end
    
    assert_nil item.uid, "uid was generated for invalid item"
    
    assert_raises ActionController::UrlGenerationError do
      item_path item
      item_url item
    end
  end
  
  test 'get_type_name function' do
    item = Item.new
    item.type = "Device"
    
    assert_equal I18n.t(:device, scope: [:activerecord, :models]),
      item.get_type_name,
      "get_type_name did not return right translation"
    
  end
  
  test 'to_param function' do
    item = Item.new
    item.generate_uid
    
    assert_equal item.uid, item.to_param, "to_param did not return actual uid"
  end
    
end
