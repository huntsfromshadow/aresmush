Hacking new Rules .

  .  FS3 is really built at one roll per 'thing.
  .  So using a script should be 1 roll.
    .  Sure we could do a very deep roll to activate, roll to hit thing but really that is gettin a bit much.
    .  Can we sub specalize Hacking?
      .  Not Easily
    .  Spirit Lake Uses 'Magic' as an attribute and the schools as skills.
      . I do kind of like that. Maybe Hacking isn't a skill at all.
      

Notes about the dual nature of the world .
  .  The world is split into 3 zones.
    .  Physical
    .  Lattice
    .  Liminal
    .  Note - Why? Is this an artifact from the LARP.
      .  Look at Fractile the line between virtual and phyiscal is razer thin.
      .   


Algo version of how this works .
* Attack Script
  #  Lattice + Offensive Hacking
    . If failure script - > dosen't go off no penalty
    . If crit failure -> dosen't go off penalty of some sort
    . If success -> proceed forward
    . If crit succ -> proceed forwrard as crit



steps in a weapon attack .
# In prepare
  .  Setup the target
# In resolve (attack_target function)
  .  Determine attack margin (determine attack margin function)
    .  Roll Attack (roll_attack function) 
      .  passing in combatant, target, (mod - weapon recoil)
        .  function calculates final mod for dice roller
        .  final mod = weapon accuracy + [combatanta.total_damage_mod] + stance mod + aiming mod (either 3 or 0) + luck_mod (3 or 0) - [combatant.stress] + [combatanta.attack_mod] + mount_mod [stat on mount]
        .  roll dice (ability, final mod)
          .  Either pc or NPC roll ability with mod
          .  return success and title
    .  Roll Defense (target, weapon)
      .  get final mod 
        .  stance_mod + luck_mod (3 or 0) + [total_damage_mod] + [Special_mod] + dodge_mod (vehicle) + armor_mod (specifically defense stat)
        .  roll ability
          .  return success & title
    .  get net (attack - defense)
    .  does target have stance: cover?
      .  if so run stopped_by_cover(atk net succ, combatant)
        .  0,1 atk succ -> 50% cover chance
        .  2 atk succ -> 25% cover chance
        .  3 atk succ -> 0% cover chance
        .  Roll % check - return true/false
    .  If attack roll (not net succ) <= 0 -> attack_missed
    .  If called shot and net succ is 1 -> near miss
    .  If stopped by cover -> hits cover
    .  If net succ is smaller than 0    
      .  if weapon is melee
        .  if net succ smaller than -2 -> dodged Easily
        .  or -> dodged
      .  or -> near miss
    .  else -> set hit flag
    .  return { msg, hit, net succ}
  .  get recoil from weapon
  .  update recoil on combatant to prevous recoil + new recoil
  .  if didn't hit return message up.
  .  grab weapon from combatant
  .  trigger resolve_attack(combatant, target, weapon, net_succ, caled_shot, crew_hit)
    .  if called_shot active and succ >= 3 -> returned called_shot
    .  get hitloc chart
    .  if called_shot get hitloc location
      .  else returns just fir location
    . where did it land (random + net succ. higher better)
    . determine armor from target, hitloc, weapon, and success
    . if armor >= 100 -> return stopped by armor
    . work out damage (if melee use strenght)
    . apply damage - pass back up chain
    

