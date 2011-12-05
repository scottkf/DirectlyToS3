require 'mime/types'
require 'action_view/helpers'
require 'base64'
require 'directlytos3'
require 'digest'


module Directlytos3
  
  def self.configure(options)
    options[:bucket] ||= ENV['S3_BUCKET']
    options[:secret_key] ||= ENV['S3_SECRET_KEY']
    options[:access_key] ||= ENV['S3_KEY']
    options[:key] ||= ''
    options[:key].gsub!(/(\/)$/, '')
    options[:content_type] ||= MIME::Types.type_for("${filename}").to_s
    options[:redirect] ||= '/'
    options[:acl] ||= 'public-read'
    options[:expiration_date] ||= 10.hours.from_now.utc.xmlschema
    options[:max_filesize] ||= 1.megabyte
    options[:randomize] ||= false
    raise Directlytos3::Exceptions::NoBucketSpecified if !options[:bucket]
    raise Directlytos3::Exceptions::MissingAccessKey, "secret" if !options[:secret_key]
    raise Directlytos3::Exceptions::MissingAccessKey, "public" if !options[:access_key]
  end

  
  def self.random_string
    Digest::SHA1.hexdigest Time.now.utc.to_s
  end
  
  module FormHelpers
    

  
    def s3_field_tag(name, options = {})
      Directlytos3::configure(options)
      
      form_tag("https://#{options[:bucket]}.s3.amazonaws.com/", :remote => options[:remote], :enctype=>"multipart/form-data",:method=>"post", :id => 's3-upload-form', :authenticity_token => false) do
        s3_hidden_fields(options)
        concat file_field_tag 'file'
      end

    end
    
    

  
    def s3_form_for(record, *args, &block)
      raise ArgumentError, "s3_form_for: Missing block" unless block_given?

      options = args.extract_options!
      url = options[:path] || "https://#{options[:bucket]}.s3.amazonaws.com/"
      args << {:url => url, :builder => options[:builder], :enctype => "multipart/form-data", :method => "post", :html => {:id => 's3-upload-form'}, :authenticity_token => false, :remote => options[:remote]}
      Directlytos3::configure(options)
      form_for(record, *(args)) do |f|
        s3_hidden_fields(options)
        block.call(f)
        # f.file_field "file", :name => "file"
      end
    end
    
    def s3_hidden_fields(options)
 
      policy = Directlytos3::S3.policy(options)
      signature = Directlytos3::S3.signature(options)
      
      concat hidden_field_tag('key', "#{options[:key]}#{'/' if !options[:key].blank?}#{Directlytos3.random_string if options[:randomize]}${filename}")
      concat hidden_field_tag('AWSAccessKeyId', "#{options[:access_key]}")
      concat hidden_field_tag('acl', "#{options[:acl]}")
      concat hidden_field_tag('success_action_redirect', "#{options[:redirect]}")
      concat hidden_field_tag('policy', "#{policy}")
      concat hidden_field_tag('signature', "#{signature}")
      concat hidden_field_tag('Content-Type', "#{options[:content_type]}")
      options.except!(:key, :access_key, :acl, :redirect, :content_type, :secret_key, :randomize, :expiration_date, :max_filesize)
    end
    
  end
end