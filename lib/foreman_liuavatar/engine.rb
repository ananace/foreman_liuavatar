# frozen_string_literal: true

module ForemanLiuavatar
  class Engine < ::Rails::Engine
    engine_name 'foreman_liuavatar'

    initializer 'foreman_liuavatar.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_liuavatar do
        requires_foreman '>= 1.14'
      end
    end

    config.to_prepare do
      ::User.send :prepend, ForemanLiuavatar::UserExtensions
    rescue => e
      Rails.logger.warn "ForemanVmwareAdvanced: skipping engine hook(#{e})"
    end
  end
end
