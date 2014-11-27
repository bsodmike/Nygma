module Nygma
  module Configuration

    include ActiveSupport::Configurable

    config_accessor :secure_key, :secure_salt

  end
end
