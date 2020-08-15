module AresMUSH
  module Zatemods
    # Pretty much completley 'borrowed' from f3skills plugin xp.rb

    def self.learn_script(char, script_name)
      # FS3 Text is fine
      return t("fs3skills.not_enough_xp") if char.xp <= 0

      # Check if script is in script library (spelling check)
      if !(Zatemods.get_lattice_script(script_name))
        return "#{script_name} not a valid script"
      end

      script = Zatemods.find_script_on_character(char, script_name)

      if (!script)
        script_name = script_name ? script_name.titleize : nil

        script = LatticeScript.create(character: char, name: script_name)
        script.xp = 1
        script.save
        Zatemods.create_xp_job(char, script)
      else
        if (!script.can_learn?)
          time_left = script.days_to_next_learn
          #return t("fs3skills.cant_raise_yet", :days => time_left)
          return "You must wait #{time_left} to raise that script again."
        else
          script.learn
        end
      end

      FS3Skills.modify_xp(char, -1)
      return script
    end

    #def self.days_to_next_learn
    #  (self.time_to_next_learn / 86400).ceil
    #end

    def self.create_xp_job(char, script)
      message = t("fs3skills.xp_raised_job", :name => char.name, :ability => script.name, :rating => "nil")
      category = Jobs.system_category
      Jobs.create_job(category, t("fs3skills.xp_job_title", :name => char.name), message, Game.master.system_character)
    end

    def self.can_manage_xp?(actor)
      actor.has_permission?("manage_abilities")
    end

    def self.days_between_learning
      # We are using our own speed on days_between_learning for scripts
      Global.read_config("zatehacking", "days_between_learning")
    end

    def self.xp_needed(script_name)
      # For now it's 5.
      # We need to tweak this
      return 5
    end
  end
end
