module AresMUSH
  module Zatemods
    class CharacterScriptsTemplate < ErbTemplateRenderer
      attr_accessor :char

      def initialize(char, client)
        @char = char
        @client = client
        super File.dirname(__FILE__) + "/character_scripts.erb"
      end

      def learned_scripts_by_group
        tmp = char.lattice_scripts.select { |v| (v.learning_complete?) }
        tmp.group_by { |obj| obj.use_case }
      end

      def learning_scripts_by_group
        (char.lattice_scripts.select { |v| (v.learning_complete? == false) }).group_by { |obj| obj.use_case }
      end

      def section_line(title)
        @client.screen_reader ? title : line_with_text(title)
      end

      def display(script)
        "#{left(script.name, 25)} #{left(script.tier, 3)} #{progress(script)} #{detail(script)}     #{days_left(script)}"
      end

      def progress(lscr)
        ProgressBarFormatter.format(lscr.xp, lscr.xp_needed)
      end

      def detail(script)
        status = "(#{script.xp}/#{script.xp_needed})"
        status.ljust(8)
      end

      def days_left(script)
        time_left = script.days_to_next_learn
        message = time_left == 0 ? t("fs3skills.xp_days_now") : t("fs3skills.xp_days", :days => time_left)
        center(message, 5)
      end
    end
  end
end
