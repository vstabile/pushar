require 'test_helper'

module Pushar
  class DevicesControllerTest < ActionController::TestCase
    setup do
      @device = devices(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:devices)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create device" do
      assert_difference('Device.count') do
        post :create, device: { app_id: @device.app_id, app_name: @device.app_name, app_version: @device.app_version, badge: @device.badge, banner: @device.banner, device_name: @device.device_name, device_version: @device.device_version, inactivated_at: @device.inactivated_at, locale: @device.locale, os_name: @device.os_name, os_version: @device.os_version, sound: @device.sound, token: @device.token, user_id: @device.user_id }
      end

      assert_redirected_to device_path(assigns(:device))
    end

    test "should show device" do
      get :show, id: @device
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @device
      assert_response :success
    end

    test "should update device" do
      patch :update, id: @device, device: { app_id: @device.app_id, app_name: @device.app_name, app_version: @device.app_version, badge: @device.badge, banner: @device.banner, device_name: @device.device_name, device_version: @device.device_version, inactivated_at: @device.inactivated_at, locale: @device.locale, os_name: @device.os_name, os_version: @device.os_version, sound: @device.sound, token: @device.token, user_id: @device.user_id }
      assert_redirected_to device_path(assigns(:device))
    end

    test "should destroy device" do
      assert_difference('Device.count', -1) do
        delete :destroy, id: @device
      end

      assert_redirected_to devices_path
    end
  end
end
