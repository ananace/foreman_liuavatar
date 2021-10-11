# frozen_string_literal: true

namespace :liuavatar do
  desc 'Refresh LiU avatars'
  task refresh: :environment do
    User.current = User.anonymous_admin

    username = ENV['user']
    if username
      user = User.find_by_login(username)
      puts "Refreshing avatar for #{user}"
      user.refresh_avatar!
    else
      puts 'Refreshing all avatars...'
      User.all.each do |u|
        u.refresh_avatar!
      rescue StandardError => e
        puts "Failed to refresh avatar for #{u}, #{e.class}: #{e}"
      end
    end

    puts 'Avatars refreshed.'
  end
end
