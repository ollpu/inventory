require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test 'get index' do
    get :index
    assert_template :index, layout: "items/index"
    assert_response :success
    assert_not_nil assigns(:items)
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
      post :create, item: {type: 'Cable'}
    end
    assert_redirected_to item_path(assigns(:item))
  end
end
