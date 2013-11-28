require 'test_helper'

module Pushar
  class AppsControllerTest < ActionController::TestCase
    setup do
      @app = apps(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:apps)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create app" do
      assert_difference('App.count') do
        post :create, app: { adm_api_key: @app.adm_api_key, adm_client_id: @app.adm_client_id, adm_client_secret: @app.adm_client_secret, apn_app_key: @app.apn_app_key, apn_dev_cert: @app.apn_dev_cert, apn_prod_cert: @app.apn_prod_cert, gcm_api_key: @app.gcm_api_key, platform: @app.platform }
      end

      assert_redirected_to app_path(assigns(:app))
    end

    test "should show app" do
      get :show, id: @app
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @app
      assert_response :success
    end

    test "should update app" do
      patch :update, id: @app, app: { adm_api_key: @app.adm_api_key, adm_client_id: @app.adm_client_id, adm_client_secret: @app.adm_client_secret, apn_app_key: @app.apn_app_key, apn_dev_cert: @app.apn_dev_cert, apn_prod_cert: @app.apn_prod_cert, gcm_api_key: @app.gcm_api_key, platform: @app.platform }
      assert_redirected_to app_path(assigns(:app))
    end

    test "should destroy app" do
      assert_difference('App.count', -1) do
        delete :destroy, id: @app
      end

      assert_redirected_to apps_path
    end
  end
end
