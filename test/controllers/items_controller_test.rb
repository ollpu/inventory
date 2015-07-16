require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test 'get index' do
    get :index
    assert_template :index, layout: "items/index"
    assert_response :success
    assert_not_nil assigns(:items)
  end
  
  test 'get show' do
    get :show
    assert_template :show, layout: "items/show"
    assert_response :success
    assert_not_nil assigns(:item)
  end
  
  test 'get edit' do
    get :edit
    assert_not_nil assigns(:item)
    assert_redirected_to item_path(assings(:item)) << "#edit"
  end
  
  test 'post update' do
    post :update, item: {title: "Hello", features_human: "This, is, a, list"}
    assert_not_nil assigns(:item)
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
