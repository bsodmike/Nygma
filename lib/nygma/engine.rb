module Nygma
  class Engine < ::Rails::Engine
    isolate_namespace Nygma

    config.before_initialize do
      ::ActiveRecord::Base.send(:include, Encryptable)
    end
  end
end
