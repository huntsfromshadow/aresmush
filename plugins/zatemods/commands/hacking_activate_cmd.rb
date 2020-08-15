module AresMUSH
  module Zatemods
    class HackingActivateCmd
      include CommandHandler
      include FS3Combat::NotAllowedWhileTurnInProgress

      attr_accessor :names, :script_name, :script_def #:specials

      def parse_args
        #if (cmd.args =~ /=/)
        #  args = cmd.parse_args(/(?<arg1>[^\=]+)\=(?<arg2>[^\+]+)\+?(?<arg3>.+)?/)
        #  self.names = list_arg(args.arg1)
        #  self.weapon = titlecase_arg(args.arg2)
        #  specials_str = titlecase_arg(args.arg3)
        #else
        args = cmd.parse_args(/(?<arg1>[^\+]+)\+?(?<arg2>.+)?/)
        self.names = [enactor.name]
        self.script_name = titlecase_arg(args.arg1)
        #  specials_str = titlecase_arg(args.arg2)
        #end

        #self.specials = specials_str ? specials_str.split("+") : nil
      end

      def required_args
        [self.names, self.script_name]
      end

      #def check_special_allowed
      #  return nil if !self.specials
      #  allowed_specials = FS3Combat.weapon_stat(self.weapon, "allowed_specials") || []
      #  self.specials.each do |s|
      #    return t("fs3combat.invalid_weapon_special", :special => s) if !allowed_specials.include?(s)
      #  end
      #  return nil
      #end

      def check_a_real_script
        self.script_def = Zatemods.get_lattice_script(self.script_name)

        return "That is not a valid script" if !self.script_def
        return nil
      end

      def check_character_has_script
        return "You do not have that script" if !Zatemods.find_script_on_character(enactor, self.script_name)
        return nil
      end

      def handle
        # We need to know what this script acts like, 'weapon', 'armor'
        self.names.each do |name|
          case self.script_def["acts_like"]
          when "weapon"
            client.emit "Weapon"
          else
            client.emit "No idea"
          end

          # We let FS3 do the check if htis is a combatant, and pass along the block
          #  We want it to execute if all checks out
          #  We can't use the std weapon code as zatemods scripts aren't stored in the weapon blocks
          FS3Combat.with_a_combatant(name, client, enactor) do |combat, combatant|
            #def self.set_weapon(enactor, combatant, weapon, specials = nil)

            #max_ammo = weapon ? FS3Combat.weapon_stat(weapon, "ammo") : 0
            max_ammo = 100 # For now all scripts are 100

            prior_ammo = combatant.prior_ammo || {}

            current_ammo = max_ammo

            if (self.script_def && prior_ammo[self.script_name] != nil)
              current_ammo = prior_ammo[self.script_name]
            end

            prior_ammo[combatant.weapon_name] = combatant.ammo
            combatant.update(prior_ammo: prior_ammo)

            combatant.update(weapon_name: self.script_name)
            #combatant.update(weapon_specials: specials ? specials.map { |s| s.titlecase }.uniq : [])
            combatant.update(ammo: current_ammo)
            combatant.update(max_ammo: max_ammo)
            combatant.update(action_klass: nil)
            combatant.update(action_args: nil)

            message = t("fs3combat.weapon_changed", :name => combatant.name,
                                                    :weapon => combatant.weapon)
            FS3Combat.emit_to_combat combatant.combat, message, FS3Combat.npcmaster_text(combatant.name, enactor)
          end
        end
      end
    end
  end
end
