module AresMUSH
  module Zatemods
    def self.get_all_scripts_in_lattice
      Global.read_config("zatehacking", "script_library", "weapon") +
        Global.read_config("zatehacking", "script_library", "other")
    end

    def self.find_script_on_character(char, script_name)
      script_name = script_name.titlecase
      char.lattice_scripts.find(name: script_name).first
    end

    def self.get_lattice_script(script_name)
      val = Global.read_config("zatehacking", "script_library", "weapon", script_name.titlecase)
      if (val.nil?)
        val = Global.read_config("zatehacking", "script_library", "other", script_name.titlecase)
      end
      return val
    end

    #def self.group_into_use_case(script_ohmset_or_hash)
    #  lst = script_ohmset_or_hash

    #So this method will either get data from a Hash or Ohm Set.
    # Basically Hash means we are just talking to the config system
    # Ohm set to a db.
    #  if lst.instance_of? Hash
    # Okay has will go in and a hash out, but sorted by use case

    #  elsif lst.instance_of? Ohm::Set
    #  else
    #    return nil
    #  end
    #end
  end
end
