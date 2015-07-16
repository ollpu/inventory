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
    item.title = "Some title"
    
    assert_nothing_raised do
      item.save!
    end
    assert_not_nil item.uid, "Item was saved without uid"
  end
  
  test 'type should be present' do
    item = Item.new
    item.title = "Some title"
    assert_raises ActiveRecord::RecordInvalid do
      item.save!
    end
    
    assert_nil item.uid, "uid was generated for invalid item"
    
    assert_raises ActionController::UrlGenerationError do
      item_path item
      item_url item
    end
  end
  
  test 'features_human function' do
    item = Item.new
    item.features = ["This", "is", "a", "list"]
    assert_equal "This, is, a, list", item.features_human,
      "features_human did not return expected ', ' delimitered list"
    
    item.features = nil
    assert_equal "", item.features_human,
      "features_human did not return a string on invalid input"
  end
  
  test 'features_human=' do
    item = Item.new
    
      # The function should strip surrounding whitespace
    item.features_human = "This,     is   , a,list "
    
    assert_equal ["This", "is", "a", "list"], item.features,
      "features_human= did not generate appropriate Array"
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
  
  test 'short_uid function' do
    item = Item.new
    item.generate_uid
    
    assert_equal item.uid.split(/\-/).first, item.short_uid,
      "short_uid returned an unexpected value"
  end
  
end
