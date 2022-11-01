# frozen_string_literal: true

require 'test_plugin_helper'

class UserTest < ActiveSupport::TestCase
  let(:img) { '/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsKCwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wgARCAABAAEDAREAAhEBAxEB/8QAFAABAAAAAAAAAAAAAAAAAAAACP/EABQBAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhADEAAAAVSf/8QAFBABAAAAAAAAAAAAAAAAAAAAAP/aAAgBAQABBQJ//8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAwEBPwF//8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAgEBPwF//8QAFBABAAAAAAAAAAAAAAAAAAAAAP/aAAgBAQAGPwJ//8QAFBABAAAAAAAAAAAAAAAAAAAAAP/aAAgBAQABPyF//9oADAMBAAIAAwAAABCf/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAwEBPxB//8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAgBAgEBPxB//8QAFBABAAAAAAAAAAAAAAAAAAAAAP/aAAgBAQABPxB//9k=' } # rubocop:disable Layout/LineLength

  context 'with valid LiU-user' do
    let(:user) { User.new login: 'liuid12' }

    test 'it should retrieve and store the avatar' do
      resp = mock
      resp.expects(:value).once
      resp.expects(:body).once.returns(Base64.decode64(img))

      Net::HTTP.expects(:get_response)
               .with(URI('https://liu.se/-/media/employeeimages/12/employee_image_liuid12.jpeg'))
               .once
               .returns resp
      File.expects(:write).once

      user.expects(:avatar_hash=).with('2a1cd7509bf3efad8f8df0511115afef62b9e9a1')
      user.expects :save

      user.refresh_avatar!
    end

    test 'it should not update the avatar when unchanged' do
      resp = mock
      resp.expects(:value).once
      resp.expects(:body).once.returns(Base64.decode64(img))

      Net::HTTP.expects(:get_response)
               .with(URI('https://liu.se/-/media/employeeimages/12/employee_image_liuid12.jpeg'))
               .once
               .returns resp

      user.expects(:avatar_hash).once.returns '2a1cd7509bf3efad8f8df0511115afef62b9e9a1'

      File.expects(:write).never
      user.expects(:avatar_hash=).never
      user.expects(:save).never

      user.refresh_avatar!
    end
  end

  context 'with valid - if odd - LiU-user' do
    let(:user) { User.new login: 'a99' }

    test 'it should retrieve and store the avatar' do
      resp = mock
      resp.expects(:value).once
      resp.expects(:body).once.returns(Base64.decode64(img))

      Net::HTTP.expects(:get_response)
               .with(URI('https://liu.se/-/media/employeeimages/99/employee_image_a99.jpeg'))
               .once
               .returns resp
      File.expects(:write).once

      user.expects(:avatar_hash=).with('2a1cd7509bf3efad8f8df0511115afef62b9e9a1')
      user.expects :save

      user.refresh_avatar!
    end
  end

  context 'with invalid LiU-user' do
    let(:user) { User.new login: 'some.user' }

    test 'it should not try to retrieve an avatar' do
      Net::HTTP.expects(:get_response).never

      user.refresh_avatar!
    end
  end
end
