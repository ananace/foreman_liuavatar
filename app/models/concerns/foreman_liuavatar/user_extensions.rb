# frozen_string_literal: true

module ForemanLiuavatar
  module UserExtensions
    def refresh_avatar!
      avatar = retrieve_liu_avatar
      return unless avatar

      hash = Digest::SHA1.hexdigest(avatar)
      return if hash == avatar_hash

      path = "#{Rails.public_path}/images/avatars/#{hash}.jpg"
      File.write(path, avatar, mode: 'wb')

      self.avatar_hash = hash
      save
    end

    private

    def retrieve_liu_avatar
      match = /^(\w{1,5})(\d{2})$/.match login
      return unless match

      num = match.captures.last
      resp = Net::HTTP.get_response(URI("https://liu.se/-/media/employeeimages/#{num}/employee_image_#{login}.jpeg"))
      resp.value

      resp.body
    end
  end
end
