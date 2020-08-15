module AresMUSH
  class Character
    collection :lattice_scripts, "AresMUSH::LatticeScript"

    #before_delete :delete_lattice_scripts

    #def delete_lattice_scripts
    #[self.fs3_attributes, self.fs3_action_skills, self.fs3_background_skills, self.fs3_languages, self.fs3_advantages].each do |list|
    #  list.each do |a|
    #    a.delete
    #  end
    #end
    #end
  end
end
