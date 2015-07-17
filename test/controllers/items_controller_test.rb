require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test 'get index' do
    get :index
    assert_template :index, layout: "items/index"
    assert_response :success
    assert_not_nil assigns(:items)
  end
  
  test 'get show' do
    item = items(:one)
    get :show, uid: item.uid
    
    assert_template :show, layout: "items/show"
    assert_response :success
    assert_equal item, assigns(:item),
      "items#show did not select correct entry from database"
  end
  
  test 'get edit' do
    item = items(:one)
    get :edit, uid: item.uid
    
    assert_equal item, assigns(:item),
      "items#edit did not select correct entry from database"
    assert_redirected_to item_path(item) << "#edit"
  end
  
  test 'post update' do
    new_item = {
      title: "DMX 5m 5pin cable modified",
      features_human: "DMX, 5m, 5pin, Modified",
      features: ['DMX', '5m', '5pin', 'Modified']
    }
    item = items(:one)
    post :update,
      item: new_item,
      uid: item.uid
    
    assert_equal new_item[:title], assigns(:item).title,
      "items#update did not modify title correctly"
    assert_equal new_item[:features], assigns(:item).features,
      "items#update did not modify features correctly"
    assert_redirected_to item_path(assigns(:item))
  end
  
  
  test 'get new' do
    get :new
    assert_template :new, layout: "items/new"
    assert_response :success
    assert_not_nil assigns(:item)
  end
  
  test 'create new item' do
    get :new
    assert_template :new, layout: "items/new"
    assert_response :success
    assert_not_nil assigns(:item)
    
    assert_difference 'Item.count' do
      post :create, item: {type: 'Cable', title: 'Test title'}
    end
    assert_redirected_to item_path(assigns(:item))
  end
end
