module AresMUSH
  module Zatemods
    class HackingScriptAction < CombatAction
      attr_accessor :script_obj

      def prepare
        # Get stuff ready so later we can process where this is going to
        puts "in Prepare"

        if (self.action_args =~ /\//)
          script_name = self.action_args.before("/")
          targets = self.action_args.after("/")
        else
          script_name = self.action_args
          targets = []
        end

        # Can the character actually cast this script?
        self.script_obj = Zatemods.find_script_on_character(self.combatant.character, script_name)
        if (!self.script_obj)
          return "You do not have that script"
        end

        error = self.parse_targets(targets)
        return error if error

        return t("fs3combat.only_one_target") if (self.targets.count > 1)

        return nil
        # self.is_burst = false
        # self.called_shot = nil
        # self.mod = 0
        # self.crew_hit = false
        # self.mount_hit = false

        # error = self.parse_specials(specials)
        # return error if error

        # supports_burst = FS3Combat.weapon_stat(self.combatant.weapon, "is_automatic")
        # return t("fs3combat.burst_fire_not_allowed") if self.is_burst && !supports_burst

        # return t("fs3combat.no_fullauto_called_shots") if self.called_shot && self.is_burst

        # return t("fs3combat.invalid_called_shot_loc") if self.called_shot && !FS3Combat.has_hitloc?(target, self.called_shot)

        # return t("fs3combat.out_of_ammo") if !FS3Combat.check_ammo(self.combatant, 1)
        # return t("fs3combat.not_enough_ammo_for_burst") if self.is_burst && !FS3Combat.check_ammo(self.combatant, 2)

        # return nil
      end

      def print_action
        msg = "#{self.name} uses script #{self.script_obj.name} on #{print_target_names}"
        msg
      end

      def print_action_short
        msg = "#{self.script_obj.name} on #{print_target_names}"
        return msg
      end

      def resolve
        # Okay we now need to get the script logged on the combatant.

        # Lets think overall
        # What the steps in resovling an attack script

        puts "In Resolve"

        combatant.weapon_script = script_obj
        msg = ScriptCombat.attack_target(combatant, target)

        return msg
      end
    end
  end
end
