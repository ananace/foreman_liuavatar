# frozen_string_literal: true

module ForemanLiuavatar
  class Engine < ::Rails::Engine
    engine_name 'foreman_liuavatar'

    initializer 'foreman_liuavatar.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_liuavatar do
          requires_foreman '>= 3.12'
        end
      end
    end

    config.to_prepare do
      ::User.prepend ForemanLiuavatar::UserExtensions
    rescue StandardError => e
      Rails.logger.warn "ForemanLiuAvatar: skipping engine hook(#{e})"
    end
  end
end
