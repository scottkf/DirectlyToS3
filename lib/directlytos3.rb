require 'action_view'

module Directlytos3
  autoload :VERSION,      'directlytos3/version'
  autoload :Railtie,      'directlytos3/railtie'
  autoload :FormHelpers,  'directlytos3/form_helpers'
  autoload :S3,           'directlytos3/s3'
  autoload :Exceptions,   'directlytos3/exceptions'
end

Directlytos3::Railtie