require 'action_view'

module Directlytos3
  autoload :VERSION,      'directlytos3/version'
  autoload :Railtie,      'directlytos3/railtie'
  autoload :FormBuilders,  'directlytos3/form_builders'
  autoload :FormHelpers,  'directlytos3/form_helpers'
end

Directlytos3::Railtie