$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Zatemods
    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("zatehacking", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "lattice"
        case cmd.switch
        when nil
          return LatticeCmd
        when "script"
          return LatticeSingleScriptCmd
        when "scripts"
          return LatticeScriptsCmd
        end
      when "hacking"
        case cmd.switch
        when nil
          return HackingCmd
        when "scripts"
          return HackingScriptsCmd
        when "learn"
          return HackingLearnCmd
          #when "activate"
          #  return HackingActivateCmd
        end
      end
      nil
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end
  end
end
