module AresMUSH
  module Zatemods
    class LatticeScriptsCmd
      include CommandHandler

      def handle
        list = Zatemods.get_all_scripts_in_lattice().map { |c| format_script(c) }
        tblhead = "Name".ljust(25) + "Description"
        template = BorderedListTemplate.new list, "Scripts Available in Lattice", nil, tblhead
        client.emit template.render
      end

      def format_script(script)
        details = script[1]
        "#{script[0].ljust(24)} #{details["description"]}"
      end
    end
  end
end
