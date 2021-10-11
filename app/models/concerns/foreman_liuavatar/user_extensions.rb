# frozen_string_literal: true

module ForemanLiuavatar
  module UserExtensions
    def refresh_avatar!
      match = /^(\w{5})(\d{2})$/.match login
      return unless match

      num = match.captures.last
      resp = Net::HTTP.get_response(URI("https://liu.se/-/media/employeeimages/#{num}/employee_image_#{login}.jpeg"))
      resp.value

      hash = Digest::SHA1.hexdigest(resp.body)
      return if hash == avatar_hash

      path = "#{Rails.public_path}/images/avatars/#{hash}.jpg"
      File.write(path, resp.body, mode: 'wb')

      self.avatar_hash = hash
      save
    end
  end
end
