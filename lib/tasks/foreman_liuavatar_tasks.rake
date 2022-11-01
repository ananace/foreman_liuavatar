# frozen_string_literal: true

namespace :test do
  desc 'Test ForemanLiuavatar'
  Rake::TestTask.new(:foreman_liuavatar) do |t|
    test_dir = File.join(__dir__, '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :liuavatar do
  desc 'Refresh LiU avatars'
  task refresh: :environment do
    User.current = User.anonymous_admin

    username = ENV.fetch('user', nil)
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

Rake::Task[:test].enhance %w[test:foreman_liuavatar]
