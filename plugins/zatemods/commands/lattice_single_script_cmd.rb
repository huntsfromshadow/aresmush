module AresMUSH
  module Zatemods
    class LatticeSingleScriptCmd
      include CommandHandler

      attr_accessor :script_name

      def parse_args
        self.script_name = cmd.args ? titlecase_arg(cmd.args) : nil
      end

      def handle
        script = Global.read_config("zatehacking", "script_library", self.script_name)
        theText =
          "%r%xhMemory Blocks:%xn #{script["memory_blocks"]}%r" +
          "%xhTarget:%xn #{script["target"]}%r" +
          "%xhType:%xn #{script["type"]}%r" +
          "%r%r#{script["description"]}%r"

        theTitle = "Lattice Script Library"
        theSubfooter = nil
        theSubtitle = self.script_name

        template = BorderedDisplayTemplate.new theText, theTitle, theSubfooter, theSubtitle
        client.emit template.render
      end
    end
  end
end
