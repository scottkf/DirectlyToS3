require 'mime/types'
require 'base64'
require 'directlytos3'

module Directlytos3::S3
  
  def self.signature(options)
    policy = self.policy(options)
    secret_key      = options[:secret_key] || ENV['S3_SECRET_KEY']
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret_key, policy)).gsub("\n","")
  end

  def self.policy(options)


    policy = {"expiration" => options[:expiration_date],
      "conditions" =>  [ 
        {"bucket" =>  options[:bucket]}, 
        ["starts-with", "$key", options[:key]],
        {"acl" => options[:acl]},
        ["starts-with", "$Content-Type", ''],
        ["content-length-range", 0, options[:max_filesize]]
      ]
    }
    policy["conditions"] << {"success_action_redirect" => options[:redirect]} if options[:redirect]
    policy["conditions"] << {"success_action_status" => options[:status].to_s} if options[:status]
    Base64.encode64(policy.to_json).gsub(/\n/,'')
  end

end