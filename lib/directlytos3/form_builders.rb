require 'action_view/helpers'

class ActionView::Helpers::FormBuilder
  def s3_file_field(method, options = {})
    parent_form_options = @parent_builder.instance_variable_get("@options")
    if parent_form_options.has_key?(:html) && parent_form_options[:html].has_key?(:id) && parent_form_options[:html][:id] == 's3-upload-form'
      @template.file_field(@object_name, method, objectify_options(options.merge(:name=>"file")))      
    else
      @template.file_field(@object_name, method, objectify_options(options))
    end
  end
  alias_method :file_field, :s3_file_field

  # def extra_tags_for_form_with_snowman_excluded_from_gets(html_options)
  #   old = extra_tags_for_form_without_snowman_excluded_from_gets(html_options)
  #   if html_options.has_key?("id") && html_options["id"] == 's3-upload-form' && !old.include?("_method")
  #     content_tag(:div, '', :style => 'margin:0;padding:0;display:inline')
  #   else
  #     old
  #   end
  # end
  # alias_method_chain :extra_tags_for_form, :snowman_excluded_from_gets

end
