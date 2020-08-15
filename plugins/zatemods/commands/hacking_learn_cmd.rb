module AresMUSH
  module Zatemods
    class HackingLearnCmd
      # Borrows heavily from the fs3skill learn command
      include CommandHandler

      attr_accessor :script_name

      def parse_args
        self.script_name = cmd.args ? titlecase_arg(cmd.args) : nil
      end

      def required_args
        [self.script_name]
      end

      def check_chargen_locked
        # FS3 Text is fine
        return t("fs3skills.must_be_approved") if !enactor.is_approved?
        return nil
      end

      def check_xp
        # FS3 Text is fine
        return t("fs3skills.not_enough_xp") if enactor.xp <= 0
      end

      def handle
        retval = Zatemods.learn_script(enactor, self.script_name)
        if (retval.instance_of? String)
          client.emit_failure retval
        else
          #FS3 Text is fine
          if retval.script_learned?
            client.emit_success "#{self.script_name} learned."
          else
            client.emit_success t("fs3skills.xp_spent", :name => self.script_name)
          end
        end
      end
    end
  end
end
