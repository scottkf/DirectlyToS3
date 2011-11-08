require 'rails/railtie'
require 'directlytos3'

class Directlytos3::Railtie < Rails::Railtie
  initializer 'directlytos3.initialize' do
    ActiveSupport.on_load(:action_view) do
      # require 'directlytos3/form_builders'
      include Directlytos3::FormHelpers
      require 'directlytos3/snowman_patch'
      require 'directlytos3/form_builders'
    end
  end
end
