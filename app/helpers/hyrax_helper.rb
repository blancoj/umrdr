module HyraxHelper
  include ::BlacklightHelper
  include Hyrax::BlacklightOverride
  include Hyrax::HyraxHelperBehavior

  def link_to_profile(login)
    user = ::User.find_by_user_key(login)
    return login if user.nil?

    text = if user.respond_to? :name
             user.name
           else
             login
           end

    # TODO: Fix the link to the user profiles when the hyrax object isn't available.
    # TODO: Don't hard code relative paths.  Sort out the proper url helper to use here.
    #   hyrax_helper_behavior uses Hyrax::Engine.routes.url_helpers.profile_path(user) --- WHY?
    #   link_to text, hyrax.profile_path(user) # works when hyrax is available. 
    link_to text, "/data/users/#{login}"
  end
  # Hyrax upstream method has changed
  #def link_to_field(fieldname, fieldvalue, displayvalue = nil)
  #  p = { search_field: fieldname, q: '"' + fieldvalue + '"' }
  #  link_url = main_app.search_catalog_path(p)
  #  display = displayvalue.blank? ? fieldvalue : displayvalue
  #  link_to(display, link_url)
  #end

  def t_uri(key, scope: [])
    new_scope = scope.collect do |arg|
      if arg.is_a?(String)
        arg.gsub('.', '_')
      else
        arg
      end
    end
    I18n.t(key, scope: new_scope)
  end

  def default_page_title
    text = controller_name.singularize.titleize
    if action_text = action_name.titleize
      if text == 'Static'
        text = action_text
      else
        text = "#{action_text} " + text
      end
    end
    construct_page_title(text)
  end

end
