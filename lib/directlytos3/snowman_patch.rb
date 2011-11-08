module ActionView::Helpers::FormTagHelper
private

  def extra_tags_for_form_with_snowman_excluded_from_gets(html_options)
    old = extra_tags_for_form_without_snowman_excluded_from_gets(html_options)
    if html_options.has_key?("id") && html_options["id"] == 's3-upload-form' && !old.include?("_method")
      content_tag(:div, '', :style => 'margin:0;padding:0;display:inline')
    else
      old
    end
  end
  alias_method_chain :extra_tags_for_form, :snowman_excluded_from_gets

end