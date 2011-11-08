# Directly To S3

- Version: 0.1.0

## Requirements

- Rails 3.1

## Purpose

Inserts an S3 upload field anywhere in a document

## Installing

    gem install directlytos3
	export S3_KEY="<your key>"
	export S3_SECRET_KEY="<your secret key>"

## Usage

    = s3_form_for Article.new, :id => "tester3", :bucket => 'thisismybucket', :builder => TwitterBootstrapFormFor::FormBuilder do |f|
      = f.file_field :hello
    = s3_field_tag 'name', :bucket => 'thisismybucket', :key => "test", :randomize => true, :redirect => "http://localhost", :remote => true

You can use either helper, though if you do use `s3_form_for` and you add any other input fields it will fail. This was mainly implemented so you could use builders and adjust the style easily. In addition, if you use `s3_form_for` you have to add the `s3_file_field`. This was done for the reasons above as well.

## Options

A full list of options that can be passed to the helpers are listed below

- bucket: The name of the bucket
- secret_key: The secret key, though you could probably put this in the environment variables
- public_key: The public access key, likewise with this as well
- key: The path (not excluding the final '/')
- redirect: Where to redirect 
- acl: public-read|public|private
- max_filesize: The maximum file size
- randomize: Add a leading random string to avoid collisions 

## TODO

- Specs
