$:.unshift File.dirname(__FILE__)
load "lib/helpers.rb"
load "lib/info_view_cmd.rb"
load "lib/profile_add_cmd.rb"
load "lib/profile_cmd.rb"
load "lib/profile_delete_cmd.rb"
load "lib/profile_edit_cmd.rb"
load "lib/profile_model.rb"
load "lib/wiki_cmd.rb"
load "templates/char_profile_template.rb"
load "templates/info_template.rb"
load "templates/wiki_template.rb"

module AresMUSH
  module Profile
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("profile", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.help_files
      [ "help/admin_wiki.md", "help/finger.md", "help/info.md", "help/profile.md", "help/wiki.md" ]
    end
 
    def self.config_files
      [ "config_profile.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd)
      case cmd.root
      when "info"
        return InfoViewCmd
      when "profile"
        case cmd.switch
        when "add"
          return ProfileAddCmd
        when "delete"
          return ProfileDeleteCmd
        when "edit"
          return ProfileEditCmd
        when nil
          return ProfileCmd
        end
      when "wiki"
        return WikiCmd
      end
      nil
    end

    def self.get_event_handler(event_name) 
    end
  end
end