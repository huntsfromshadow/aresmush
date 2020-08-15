---
toc: 5 - After the End Mechanics
summary: Hacking the Lattice
aliases:
- hacking
- scripts
---
#Hacking
Hacking is the process of using the remians of the pre-end Lattice to trigger 'scripts' that can effect your nano cloud, an oponents, or the general local latice network. If people belived in magic then hacking would be like spells.

* Notes
- Hacking basically does the following
-> Offensive - Used in combat (or not in combat but rarer) to do damage. 
-> Defensive - Apply shields for incoming attack/damage
-> Utility - Non combat. Enviornmental (GMed)s

Information & Learning Scripts
-----------------------------
`lattice/scripts` - Shows list of scripts available to you.
`lattice/script <script name>` - See the details of a script that is availble in the local lattice.

`hacking` - Display your current loadout
`hacking/scripts` - Dispay your Scripts
`hacking/learn <script name>` - Learn new script with xp

`combat/script <script name>/[list of targets seperated by ,]` - Use Script in Combat

`hacking/activate <script name>` - activates script 


---


hacking Rules



Casting Spells
--------------

spell/cast <spell>[+/-mod] - Cast a spell on yourself, the environment, or an object.
spell/cast <spell>[+/-mod]/<target>[<target> <target>] - Cast a spell on one or more targets.
Tip: You can use cast instead of spell/cast
spell/npc <npc>/<dice>=<spell>[/<target> <target>] - Have an NPC cast a spell. NPCs can cast any spell. The dice chosen should reflect their Magic attribute + their School rating.

shield/off <shield> - Out of combat, turn off a protective shield such as Mind Shield, Endure Fire, or Endure Cold.

combat/spell <spell> - Cast a spell on yourself, the environment, or an object in combat.
combat/spell <spell>/<target>[<target> <target>] - Cast a spell on one or more targets in combat.
combat/spell <npc>=<spell>[/<target>] - Make NPCs and other combatants cast in combat.
combat/luck spell - Spend Luck to gain a +3 dice bonus to your spellcasting for one round.
Tip: You can use combat/cast instead of combat/spell

Combat Organizer Commands
-------------------------

spell/mod <name>=<mod> - Set someone's spell mod to affect their spell rolls.
Tip: Mods only last for one round.

Admin commands
--------------

spell/add <name>=<spell> - Add a spell to someone's spell list without spending XP.
spell/remove <name>=<spell> - Remove a spell from someone's spell list.
shield/off <name>=<shield> - Out of combat, turn off a protective shield such as Mind Shield, Endure Fire, or Endure Cold.
