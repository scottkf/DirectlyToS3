module Directlytos3::Exceptions
  class S3Exception < StandardError
  end

  class MissingAccessKey < S3Exception
    def initialize(key)
      super("You did not provide both required access keys. Please provide the #{key} key.")
    end
  end

  class NoBucketSpecified < S3Exception
    def initialize
      super("You did not specify a bucket.")
    end
  end


end