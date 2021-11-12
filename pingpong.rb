#
require 'discordrb';
require 'yaml';
require 'date';
require 'securerandom';
include Math;


##########  Configuration  ########
junk = YAML.load(File.read("data.yml"));
token = junk[0]+junk[1]+junk[2];

prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

puts;
@armour = YAML.load(File.read("armourClass.yml"));
puts "          The Tiny Tiger is prepared for battle"
puts;
@HP = YAML.load(File.read("hitPoints.yml"));
@weapon = YAML.load(File.read("weaponDamage.yml"));
@player = YAML.load(File.read("ABSmods.yml"));
@RE = YAML.load(File.read("relentEndure.yml"));

@dmg1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg3 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg4 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

@gmBonus = 5;
###### End of Configuration ####


def check_user_or_nick(event)
  if event.user.nick != nil
    @user = event.user.nick
  else
    @user = event.user.name
  end
end
#####################################

def valTheInny(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheInny = true;
  length = inputStr.length;
  @charInit = inputStr.slice(2,1);
  chkLtr = ("acdoqsz").index(@charInit); # test this sample character 
  numbVal = inputStr.slice(3,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 4) || (chkLtr == nil) || (chkNum == false) then;
    @valTheInny = false;
  end;
end; 


def validate_integer(numbVal);
    @intVal = Integer(numbVal) rescue false;
end;


def valTheRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(4,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 5) || (chkNum == false) then;
    @valTheRTH = false;
  end;
end;

def valTheARTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheARTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(5,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 6) || (chkNum == false) then;
    @valTheARTH = false;
  end;
end;

####### RAGE check ######
def valTheRARTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheRARTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(6,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 7) || (chkNum == false) then;
    @valTheRARTH = false;
  end;
end;


def valTheBRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheBRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(5,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 6) || (chkNum == false) then;
    @valTheBRTH = false;
  end;
end; 

def valTheABRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheABRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(6,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 7) || (chkNum == false) then;
    @valTheABRTH = false;
  end;
end; 


def str_2_number(value);
  if value == "0" then;
     @numba = 0;
  else
    @numba = Integer(value);
  end;  
end;

def check_char_name(code);
   case code;
       when "a";  @charName = "Allen";
       when "c";  @charName = "Cordax Glimscale";
       when "d";  @charName = "Daisho/ Samurai War Priest";
       when "o";  @charName = "Ollodash";
       when "q";  @charName = "Quincey";
       when "s";  @charName = "Squee / Rogue";
       when "z";  @charName = "Zalos / Bladesinger";
    end;
end;

bot = Discordrb::Bot.new token: token

##################################################################################################################
###                                  Testing things                                                            ###
##################################################################################################################
bot.message(start_with:"print") do |event|
  tick = "```"; nl = "\n"; html = "html"; 
  say = "**WOW**" + nl;
  say = say + tick + html + nl;
  say = say + "<Bold>Tell Me What?</Bold>" + nl;
  say = say + "*" + "This was an asterisk" + "*"+ nl;
  say = say + "-" +  "This was a hyphen" + "-" + nl;
  say = say + "_" + "this was an underscore" + "_" + nl;
  say = say + "(" + "using brackets here" + ")" + nl;
  say = say + "[" + "using square brackets here" + "]" + nl;
  say = say + "{" + "curly brackets" + "}" + nl;
  say = say + "." + "using a period now" + "." + nl;
  say = say + "!" + "using and exclamation point" + "!" + nl;
  say = say + tick + nl;
  say = say +"**What up now?**"; 
  event.respond say;
end;

################## help ############################################ help ##########################
################## help ############################################ help ##########################
bot.message(start_with:"help") do |event|
  say = "help: COMMAND [space] COMMENT\n";
  say = say + "   d4.   d6.   d8.   d10.   d12.   d20.  or d100.  \n";
  say = say + "d20.  rolls 1d20 + 0           d20.6   rolls 1d20 + 6 \n";
  say = say + "d20a.4   rolls Advantage     =>  1d20 + 4   \n";
  say = say + "d20d.-5  rolls Dis-Advantage =>  1d20 - 5   \n";
  say = say + "d4.3  rolls 1d4 + 3       d6.-2    rolls 1d6 -2 \n";
  say = say + "2d8.  rolls 2d8 + 0       3d8.-1   rolls 3d8 -1 \n";
  say = say + "   \n";
  say = say + "RTH is the standard melee attack command \n";
  say = say + "add a capital letter, such as A, \n";
  say = say + "to indicate the target of the attack.\n";
  say = say + "Add lower case Modifying Switches:\n";
  say = say + "m = missile attack \n";
  say = say + "a = advantage \n";
  say = say + "d = disadvantage \n";
  say = say + "b = blessed bonus \n";
  say = say + "  \n";   
  say = say + "Use **pchelp** for character management options \n";
  event.respond say;
end;
################## pchelp ############################################ pchelp ##########################
################## pchelp ############################################ pchelp ##########################
bot.message(start_with:"pchelp") do |event|
  say = "pchelp [command] HELP for PC commands  \n";
  say = say + "**myabs** - view character details \n"; 
  say = say + "$EDITst# set Strength mod \n";
  say = say + "$EDITdx# set Dexterity mod \n";  
  say = say + "$EDITco# set Constitution mod \n";
  say = say + "$EDITin# set Intelligence mod \n";
  say = say + "$EDITwi# set Wisdom mod \n"; 
  say = say + "$EDITch# set Charisma mod \n";     
  say = say + "$EDITpb# set Proficiency Bonus \n";
  say = say + "**$DAMAGE  will list damage index** \n";
  say = say + "**for $EDITme & $EDITra** \n";  
  say = say + "..  $EDITme# set Melee Damage index \n";
  say = say + "..  $EDITra# set Range Damage index \n";   
  say = say + "$EDITcs# set Casting ABS Stat \n";  
  say = say + "$EDITsh# set Sharp Shooter";    
  event.respond say;
end;
################## gmhelp ############################################ 2help ##########################
################## gmhelp ############################################ 2help ##########################
bot.message(start_with:"gmhelp") do |event|
  say = "gmhelp [command] HELP for the GM commands  \n";  
  say = say + "$sethp@#  **$setallhp##**  $abclist \n";
  say = say + "$setac@#  **$setallac##**  $abclist \n";
  say = say + "cash[CRval] treasure dropped by CR value \n";
  say = say + "Agem ... Fgem  DESCRIPTION of gem \n";
  say = say + "gemA ... gemF  VALUE of gem type \n";
  say = say + "uncutgems \n";
  say = say + "mTableA ... mTableI (value of gem type)\n";
  say = say + "20d20:5 => 20 d20+5 rolls NOTE >>> : <<< \n";
  say = say + "Determine rarity:  $rarity  \n";  
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "myabs") do |event|;
  if event.user.nick != nil;  theUser = event.user.nick;  else;  theUser = event.user.name;  end;
   player = YAML.load(File.read("testABSmods.yml"));  pIndex = nil;
   (0..(player.length-1)).each do |y|
       if (player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
   end;

   if pIndex != nil then;
     say = "ST=" + player[pIndex][1].to_s + "   DX=" + player[pIndex][2].to_s + "   CO=" + player[pIndex][3].to_s +
           "   IN=" + player[pIndex][4].to_s + "   WI=" + player[pIndex][5].to_s + "   CH=" + player[pIndex][6].to_s + "\n";
     say = say + "Prof B=" + player[pIndex][7].to_s +  "   Casting Stat=" + player[pIndex][10].to_s + "  [Int:4, Wis:5, Cha:6] \n";
     say = say + "Melee W=" + player[pIndex][8].to_s + "   Range W=" + player[pIndex][9].to_s + "\n";
 #    say = say + "SharpShooter=" + player[pIndex][11].to_s + "\n";
     say = say + "Use **pchelp** to view modification commands. \n";
   else;
     say = "That didn't work. Discord nick name not found.";
   end;
   event.respond say;
end;          
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$abclist") do |event|;  
   monsterHP = YAML.load(File.read("testHPAC.yml"));   alphabet = "ABCDEFGHIJKLMNOPQRST";   say = "Hit Points & AC\n";
   (0..(monsterHP.length-1)).each do |x|;
       target = alphabet.slice(x,1);
       say = say + "**" + target + "**   " + monsterHP[x][0].to_s + "  of  " + monsterHP[x][1].to_s + "     AC " + monsterHP[x][2].to_s + "\n";
   end;              
      event.respond say;
 end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$sethp") do |event|;  
   monsterHP = YAML.load(File.read("testHPAC.yml"));
   alphabet = "ABCDEFGHIJKLMNOPQRST";   critter = event.content.slice(6,1);   position = alphabet.index(critter); 
   hitPoints = event.content.slice(7,3).to_i;
   if (position != nil) && (hitPoints != 0) then;  
       monsterHP[position][0] = hitPoints;
       monsterHP[position][1] = hitPoints * 1.0;
       data = "---\n"
#  Go through the list of critters and append the data to the preceeding data
       (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
              File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
      say = "Set HP process complete.";
   else
      say = "Nothing happened.";
   end;
      event.respond say;
 end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setallhp") do |event|;  
    monsterHP = YAML.load(File.read("testHPAC.yml"));   hitPoints = event.content.slice(9,3).to_i;
    if (hitPoints != nil) && (hitPoints != 0) then;
       (0..(monsterHP.length-1)).each do |z|
          monsterHP[z][0] = hitPoints;
          monsterHP[z][1] = hitPoints * 1.0;
       end;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Setting ALL HP process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setac") do |event|;  
    monsterAC = YAML.load(File.read("testHPAC.yml"));
    alphabet = "ABCDEFGHIJKLMNOPQRST";   critter = event.content.slice(6,1);   position = alphabet.index(critter); 
    theAC = event.content.slice(7,3).to_i;
    if (position != nil) && (theAC != 0) then;  
        monsterAC[position][2] = theAC;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterAC.length-1)).each do |x|;    data = data + "- " + monsterAC[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Set AC process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setallac") do |event|;  
    monsterHP = YAML.load(File.read("testHPAC.yml"));   armour = event.content.slice(9,2).to_i;
    if (armour != nil) && (armour != 0) then;
       (0..(monsterHP.length-1)).each do |z|
          monsterHP[z][2] = armour;
       end;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Setting ALL HP process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$hitdmg") do |event|;  
   toHitDmg = YAML.load(File.read("toHit&Damage.yml"));  alphabet="AB"; say = "To Hit & Damage Details\n";
   
   (0..(toHitDmg.length-1)).each do |x|;
       target = alphabet.slice(x,1);
       say = say + target + " --> " + toHitDmg[x][0].to_s + "  d" + toHitDmg[x][1].to_s + "  d" + toHitDmg[x][2].to_s + 
                            "  d" + toHitDmg[x][3].to_s + "  d" + toHitDmg[x][4].to_s + "  plus " + toHitDmg[x][5].to_s + "\n";
   end;              
      event.respond say;
 end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "enA") do |event|;  
    toHitDmg = YAML.load(File.read("toHit&Damage.yml")); say = "Enemy Makes an Attack\n";
    bonus = toHitDmg[0][0];  roll = rand(1..20); roll = roll + bonus;
    say = say + "Attack roll result is: " + roll.to_s;
    event.respond say;
end;
###############################################################################################
###############################################################################################
#             Proof of concept. Reading and writing data to a text file. 
###############################################################################################
###############################################################################################
bot.message(start_with: "$EDIT") do |event|;  
   player = YAML.load(File.read("testABSmods.yml"));
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   flag= false;
   pIndex = nil;
   (0..(player.length-1)).each do |y|
       if (player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
   end;
   case  event.content.slice(0,7);
      when "$EDITst"; flag = true; stat=1;
      when "$EDITdx"; flag = true; stat=2;
      when "$EDITco"; flag = true; stat=3;
      when "$EDITin"; flag = true; stat=4;
      when "$EDITwi"; flag = true; stat=5;
      when "$EDITch"; flag = true; stat=6;
      when "$EDITpb"; flag = true; stat=7;
      when "$EDITme"; flag = true; stat=8;
      when "$EDITra"; flag = true; stat=9;
      when "$EDITcs"; flag = true; stat=10;
      when "$EDITsh"; flag = true; stat=11;
   end;
   if flag == true then;
     say = "st:" + player[pIndex][1].to_s + "  dx:" + player[pIndex][2].to_s + "  co:" + player[pIndex][3].to_s +
          "  in:" + player[pIndex][4].to_s + "  wi:" + player[pIndex][5].to_s + "  ch:" + player[pIndex][6].to_s + "\n";
     say = say + "ProfB:" + player[pIndex][7].to_s +  "   CastStat:" + player[pIndex][10].to_s  + "\n";
     say = say + "MeleeW:" + player[pIndex][8].to_s + "   RangeW:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s + "\n";
          
     player[pIndex][stat]=event.content.slice(7,3).to_i; #assignment of new stat modifier

     say = say + "\n The player stat mod for [" + event.content.slice(5,2) + "] is now: " + player[pIndex][stat].to_s + "\n";
     say = say + "\n st:" + player[pIndex][1].to_s + "  dx:" + player[pIndex][2].to_s + "  co:" + player[pIndex][3].to_s +
               "  in:" + player[pIndex][4].to_s + "  wi:" + player[pIndex][5].to_s + "  ch:" + player[pIndex][6].to_s + "\n";
     say = say + "ProfB:" + player[pIndex][7].to_s +  "   CastStat:" + player[pIndex][10].to_s + "  [Int:4, Wis:5, Cha:6] \n";
     say = say + "MeleeW:" + player[pIndex][8].to_s + "   RangeW:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s;
               
data = "---\n";
#     we go through the list of characters and append the data to the preceeding data
       (0..(player.length-1)).each do |x|; 
           a1 = "- " + player[x].to_s + "\n";
           data = data + a1;
       end;               
       File.open("testABSmods.yml", 'w+') {|f| f.write(data) };
   end;
   event.respond say;
end;
###############################################################################################
###############################################################################################
bot.message(start_with: "$DAMAGE") do |event|;  
   damage = YAML.load(File.read("weaponDamage.yml")); say = "  Index Value => Damage Dice \n";
   (0..4).each do |y|
       say = say + y.to_s + " => " + damage[y] + "          " + (y+4).to_s + " => " + damage[y+4] + "\n";
   end;
   event.message.delete;
   event.respond say;
end;
###############################################################################################
###############################################################################################
#             Read the ABS details for a character
###############################################################################################
###############################################################################################
bot.message(start_with: "$READ") do |event|;  
   player = YAML.load(File.read("testABSmods.yml"));
   theUser = event.content.slice(5,5);    pIndex = nil;
   (0..(player.length-1)).each do |y|
       if (player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
   end;

   if pIndex != nil then;
     say = "ST:" + player[pIndex][1].to_s + "   DX:" + player[pIndex][2].to_s + "   CO:" + player[pIndex][3].to_s +
           "   IN:" + player[pIndex][4].to_s + "   WI:" + player[pIndex][5].to_s + "   CH:" + player[pIndex][6].to_s + "\n";
     say = say + "Prof B:" + player[pIndex][7].to_s +  "   Cast Stat:" + player[pIndex][10].to_s  + "\n";
     say = say + "Melee W:" + player[pIndex][8].to_s + "   Range W:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s + "\n";
   else;
     say = "That didn't work.";
   end;
   event.respond say;
end;          
###############################################################################################
###############################################################################################
#             Proof of concept. Reading and writing data to CREATURE Hit Points file. 
###############################################################################################
###############################################################################################
bot.message(start_with: "dmg") do |event|;
   monsterHP = YAML.load(File.read("testHPAC.yml")); comment = "No description provided";
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   flag= false;
   pIndex = nil; say = "We read the monsterHP"; alphabet = "ABCDEFGHIJKLMNOPQRST";  critter = event.content.slice(3,1);
   position = alphabet.index(critter);   damageStr = event.content.slice(4,99);   spacePos = damageStr.index(" ");
   if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
      begin; damage = Integer(damageStr.slice(0,spacePos)); rescue; damage = 0; end;
      if damage == 0; comment = damageStr.slice(0,99); else; comment = damageStr.slice(spacePos+1,99); end;
   else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
      begin; damage = Integer(damageStr.slice(0,99)); rescue; damage = 0; end;
      if damageStr.length != 0 && damage == 0 then; comment = damageStr.slice(0,99); end;
   end;
   if (position != nil) && (damage != 0) then;  
       monsterHP[position][0] = monsterHP[position][0] - damage;
       data = "---\n"    #  Go through the list of critters and append the data to the preceeding data
       (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
              File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = comment + "\n"; 
       say = say + "Deducted " + damage.to_s + " hp from Creature " + critter;
       perCent = monsterHP[position][0]/monsterHP[position][1];
       if perCent < 0.00010 then; health = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
       if perCent > 0.00000 then; health = "Battered"; end;
       if perCent > 0.24999 then; health = "Bloodied"; end;
       if perCent > 0.49999 then; health = "Bruised"; end;
       if perCent > 0.74999 then; health = "Healthy"; end;
       say = say + "\nCreature " + critter + " is " + health;       
   else
     say = "Something is wrong with this: " + event.content;
   end;
   event.message.delete;
   one = "```"; nl= "\n"; two =  "```";
   say = one + nl + say + nl + two;
   event.respond say;
end;
###############################################################################################
###############################################################################################
#             Proof of concept. ONE Roll To Hit method with multiple SWITCHES
###############################################################################################
###############################################################################################
bot.message(start_with: "RTH") do |event|;      event.message.delete;   dDice = ""; dmgT = 0;
   theChars = YAML.load(File.read("testABSmods.yml"));  roll = rand(1..20);  r2 = rand(1..20);  r3 = rand(1..20);  r4 = rand(1..20);
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   alphabet = "ABCDEFGHIJKLMNOPQRST";
   switches = event.content.slice(4,99);   pIndex = nil;   target = event.content.slice(3,1);   position = alphabet.index(target);
            (0..(theChars.length-1)).each do |y|
                if (theChars[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value
            end;         #puts "Target: " + target.inspect + "      Position: " + position.inspect; 
   if (position == nil) || (target == "") then;
      say = "Target missing: " + event.content;
   else;
       #---------------------------------------------------------------------------------------------------------------------#
       adv = switches.index("a");   dis = switches.index("d");   range = switches.index("m"); # nil value means NOT found   
       bless = switches.index("b");
       rage = switches.index("r");  huntM = switches.index("h");  smite = switches.index("s");
       #---------------------------------------------------------------------------------------------------------------------#
       say = event.content + " <" + theChars[pIndex][0] + "> vs " + target + ":";
       statMod = [theChars[pIndex][1],theChars[pIndex][2]].max; # max of ST or DX mod
       if (range != nil) then statMod = theChars[pIndex][2]; end; # ranged attack uses DEX abs mod
       if (adv == nil) && (dis == nil) then;
          total = roll + theChars[pIndex][7] + statMod;
          say = say + " [" + roll.to_s + "]+" + theChars[pIndex][7].to_s + "p+" + statMod.to_s + "a";
       else;
          if (adv != nil) then
            roll = [r2,r3].max; total = roll + theChars[pIndex][7] + statMod;
            say = say + " [" + r2.to_s + "][" + r3.to_s + "]+" + theChars[pIndex][7].to_s + "p+" + statMod.to_s + "a";
          else;
            roll = [r3,r4].min; total = roll + theChars[pIndex][7] + statMod;
            say = say + " [" + r3.to_s + "][" + r4.to_s + "]+" + theChars[pIndex][7].to_s + "p+" + statMod.to_s + "a";           
          end;
       end;
       
       if (bless != nil) then; b = rand(1..4); total = total + b; say = say + "+" + b.to_s + "b"; end;
       if (theChars[pIndex][12] != 0) && (range == nil); then total = total + theChars[pIndex][12]; say = say + "+" + theChars[pIndex][12].to_s + "m"; else; say = say;end;
       
       say = say + "= " + total.to_s;
       weaponData = YAML.load(File.read("weaponDamage.yml"));  # melee 1 & 12 range 
       if range == nil then; weaponDmg = theChars[pIndex][8]; else; weaponDmg = theChars[pIndex][9]; end;
       mHPAC = YAML.load(File.read("testHPAC.yml"));   mAC = mHPAC[position][2];
     if (roll > 1) then;
       if total >= mAC then;  
         if (roll != 20) then;
         case weaponDmg;
            when 0; d1=rand(1..6);  d2=rand(1..6);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d6
            when 1; d1=rand(1..12); dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d12
            when 2; d1=rand(1..10); dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d10
            when 3; d1=rand(1..8);  dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d8
            when 4; d1=rand(1..6);  dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d6
            when 5; d1=rand(1..4);  dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d4
            when 6; d1=rand(1..3);  d2=rand(1..3);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d3
            when 7; d1=rand(1..4);  d2=rand(1..4);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d4
            when 8; d1=rand(1..5);  d2=rand(1..5);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d5
         end;
         say = say + "    HIT!";
         else;
         case weaponDmg;
            when 0; d1=rand(1..6);  d2=rand(1..6);d3=rand(1..6);d4=rand(1..6);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d6
            when 1; d1=rand(1..12); d2=rand(1..12);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d12
            when 2; d1=rand(1..10); d2=rand(1..10);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d10
            when 3; d1=rand(1..8);  d2=rand(1..8);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d8
            when 4; d1=rand(1..6);  d2=rand(1..6);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d6
            when 5; d1=rand(1..4);  d2=rand(1..4);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d4
            when 6; d1=rand(1..3);  d2=rand(1..3);d3=rand(1..3);d4=rand(1..3);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d3
            when 7; d1=rand(1..4);  d2=rand(1..4);d3=rand(1..4);d4=rand(1..4);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d4
            when 8; d1=rand(1..5);  d2=rand(1..5);d3=rand(1..5);d4=rand(1..5);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d5
         end;
         say = say + "    CRITICAL HIT!";
       end;
       say = say + "\n\u2937 " + dDice ; huntMDmg = 0;

       if huntM != nil then; 
         huntMDmg = rand(1..6); say = say + "+[" + huntMDmg.to_s + "h]";   dmgT = dmgT + huntMDmg;
       end;

       if (theChars[pIndex][12] != 0) && (range == nil); then; 
         say = say + "+" + theChars[pIndex][12].to_s + "m"; dmgT = dmgT + theChars[pIndex][12]; 
       end;

        mHPAC[position][0] = mHPAC[position][0] - dmgT;
        data = "---\n"    #  Go through the list of critters and append the data to the preceeding data
        (0..(mHPAC.length-1)).each do |x|;    data = data + "- " + mHPAC[x].to_s + "\n";   end;
        
        File.open("testHPAC.yml", 'w+') {|f| f.write(data) };     
        say = say + "= " + dmgT.to_s + " hp deducted, Creature " + target;     
        perCent = mHPAC[position][0]/mHPAC[position][1];
        if perCent < 0.00010 then; health = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
        if perCent > 0.00000 then; health = "Battered"; end;
        if perCent > 0.24999 then; health = "Bloodied"; end;
        if perCent > 0.49999 then; health = "Bruised"; end;
        if perCent > 0.74999 then; health = "Healthy"; end;
        say = say + " is " + health;
      else;
       say = say + "    **Missed**";
      end;
     else;
       say = say + "    **Natural One**";
     end;
     one = "```html"; nl= "\n"; two =  "```";
     say = one + nl + say + nl + two;
     event.respond say;
   end;
end;
##################################################################################################################
### Rarity chart                                                                                           ###
##################################################################################################################
bot.message(start_with: "$rarity") do |event|;  
   roll = rand(1..512);
   case roll;
       when 1; say = "Extremely Rare [I] Extreme Violet (9/9)";
       when 2..3; say = "Very Rare [H] Violet (8/9)";
       when 4..7; say = "Significantly Rare [G] Indigo (7/9)";
       when 8..15; say = "Quite Rare [F] Blue (6/9)";
       when 16..31; say = "Rare [E] Green (5/9)";
       when 32..63; say = "Very Uncommon [D] Yellow (4/9)";
       when 64..127; say = "Uncommon [C] Orange (3/9)";
       when 128..255;  say = "Common [B] Red (2/9)";
       when 256..512; say = "Mundane [A] Pink (1/9)";
   end;
   base = "The roll " + roll.to_s + " makes the rarity ... \n";
   event.message.delete;
   event.respond base + say;
end;
##################################################################################################################
### Testing things                                                                                             ###
##################################################################################################################

##################################################################################################################
##################################################################################  d4. ##########################
##################################################################################################################
bot.message(contains:"d4.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d4.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d4.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d4" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..4);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d6. ##########################
bot.message(contains:"d6.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d6.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d6.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d6" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..6);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d8. ##########################
bot.message(contains:"d8.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d8.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d8.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d8" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..8);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d10. ##########################
bot.message(contains:"d10.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d10.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d10.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d10" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..10);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d12. ##########################
bot.message(contains:"d12.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d12.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d12.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d12" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..12);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d20. ##########################
bot.message(contains:"d20.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d20.");
  
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  
  spacePos = afterDieStr.index(" "); comment = "#d20.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d20" + "+" + numbB.to_s + "  {" + theString.slice(0,19) + "}" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..20);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## b20. with special second d20 critical marker ##########################
bot.message(contains:"h20.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("h20.");
  afterDieStr = theString.slice((diePosition+4),99).strip;
  
  spacePos = afterDieStr.index(" "); comment = "#h20.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = rand(1..20); uberCrit = rand(1..20); uC = ""; if uberCrit == 20 then uC ="*";
  say = @user.to_s + " rolled h20" + "+" + numbB.to_s + "  {" + theString.slice(0,19) + "}" + "\n";
  say = say + "[" + theDice.to_s + "]" + uC;  total = total + theDice;  end; 
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;
################## d20: ##########################
bot.message(contains:"d20:") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d20:");
  
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  
  spacePos = afterDieStr.index(" "); comment = "#d20:# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d20" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;
      theDice = rand(1..20);      total = theDice + numbB;
        say = say + "." + x.to_s + "...[";
        if theDice == 20 then; say = say + "**" + theDice.to_s + "**]+" + numbB.to_s + "=" + total.to_s + "\n" ;
        else;   say = say + theDice.to_s + "]+" + numbB.to_s + "=" + total.to_s + "\n" ;
        end;
  end; #rolls the required dice
  say = say + "REASON: " + comment;
  event.respond say;
end;
################## d20a. ##########################
bot.message(start_with:"d20a.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("d20a.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d20a. requires  d20a. OR  ?d20a.? where ? are integers (1 to 9)."
    else
       say = @user.to_s + " rolled 2d20" + " + " + @whatPlus.to_s + " with Advantage \n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..1).each do |x|;
           die[x]=(rand 20)+1;
           say = say + "[" + die[x].to_s + "]";
       end;
       bigDie = [die[0],die[1]].max;
       total = bigDie + @whatPlus;
       say = say + "       [" + bigDie.to_s + "] + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~";
    end;
    event.respond say;
end;

################## d20d. ##########################
bot.message(start_with:"d20d.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d20d.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d20d. requires  d20d. OR  ?d20d.? where ? are integers (1 to 9)."
    else
       say = @user.to_s + " rolled 2d20" + " + " + @whatPlus.to_s + " with Dis-Advantage \n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..1).each do |x|;
           die[x]=(rand 20)+1;
           say = say + "[" + die[x].to_s + "]";
       end;
       bigDie = [die[0],die[1]].min;
       total = bigDie + @whatPlus;
       say = say + "       [" + bigDie.to_s + "] + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n---------------";
    end;
    event.respond say;
end;
##################################################################################################################
################################################################################################################## TREASURE CALCULATIONS
########################0123456789################################################################################
bot.message(start_with:"cash") do |event|;
  def cr0to4(theRoll,crTreasure);
    theRoll = theRoll+(crTreasure*10);
    case theRoll;
      when 1..30; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " copper";
      when 31..60; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " silver";
      when 61..69; cash=rand(1..6)+rand(1..6)+rand(1..6)+1; cash=(cash/2).to_s + " gold";
      when 70; cash=rand(1..6)+rand(1..6)+rand(1..6)+1; cash=(cash/2).to_s + " gold & SPECIAL";
      when 71..95; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " gold";
      when 96..140; cash=rand(1..6); cash=cash.to_s + " platinum";
    end;
    return cash; 
  end;
  def cr5to10(theRoll,crTreasure);
    theRoll = theRoll+((crTreasure-5)*5);
    case theRoll;
      when 1..30; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6); cash=(cash1*100).to_s + " copper & " + (cash2*5).to_s + " gold";
      when 31..60; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6)+rand(1..6); cash=(cash1*10).to_s + " silver" + " & " + (cash2*10).to_s + " gold";
      when 61..70; cash1=rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6)+rand(1..6);cash=((cash1*5)+(cash2*10)).to_s + " gold";
      when 71..95; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=(cash*10).to_s + " gold";
      when 96..120; cash1=rand(1..6)+rand(1..6); cash2=rand(1..6)+rand(1..6)+rand(1..6);cash=(cash1*10).to_s + " gold & " + (cash2*10).to_s + " platinum";
    end;
    return cash; 
  end;  
  def cr11to16(theRoll);
    case theRoll;
      when 1..20; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6);cash1=(cash1*100).to_s + " silver & " + (cash2*100).to_s + " gold";
      when 21..35; cash1=rand(1..6);cash2=rand(1..6); cash=((cash1*50)+(cash2*100)).to_s + " gold";
      when 36..75; cash1=rand(1..6)+rand(1..6);cash2=rand(1..6);cash=(cash1*100).to_s + " gold & " + (cash2*10).to_s + " platinum";
      when 76..100; cash1=rand(1..6)+rand(1..6); cash2=rand(1..6)+rand(1..6);cash=(cash1*100).to_s + " gold & " + (cash2*10).to_s + " platinum";
    end;
    return cash; 
  end;
  def cr17to30(theRoll);
    case theRoll;
      when 1..15; cash1=rand(1..6)+rand(1..6);cash2=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash=((cash1*500)+(cash2*100)).to_s + " gold";
      when 16..55; cash1=rand(1..6)*1000;cash2=rand(1..6)*100;cash=cash1.to_s + " gold & " + cash2.to_s + " platinum";
      when 56..100; cash1=rand(1..6)*1000;cash2=(rand(1..6)+rand(1..6))*100;cash=cash1.to_s + " gold & " + cash2.to_s + " platinum";
    end;
    return cash; 
  end;
      
  event.message.delete
  crTreasure = event.content.slice(4,5).to_i;
  theRoll = rand(1..100);
  if crTreasure > 30 then; cash = "Too large a CR number."; end;
  if crTreasure < 31 then; cash = cr17to30(theRoll); end;  
  if crTreasure < 17 then; cash = cr11to16(theRoll); end;
  if crTreasure < 11 then; cash = cr5to10(theRoll,crTreasure); end;   
  if crTreasure < 5 then; cash = cr0to4(theRoll,crTreasure); end;
 
  say = "CR value is " + crTreasure.to_s + "\n" + cash + "   [  GOLDGEM12345  ]";
  
  event.respond say;
end;
##################################################################################################################
############################## GOLD TO GEMS  ########## GOLD TO GEMS  ############################################
############################## GOLD TO GEMS  ########## GOLD TO GEMS  ############################################
##################################################################################################################
bot.message(start_with:"GOLDGEM") do |event|;
  def ffGem(halfGold);
    fGem = halfGold/5000;
    remain1 = halfGold - (fGem * 5000);
    eGem = remain1/1000;
    remain2 = remain1 - (eGem * 1000);
    dGem = remain2/500;
    remain3 = remain2 - (dGem * 500);
    cGem = remain3/100;
    remain4 = remain3 - (cGem * 100);
    bGem = remain4/50;
    remain5 = remain4 - (bGem * 50);
    aGem = remain5/10;
    remain6 = remain5 - (aGem * 10);
    return (remain6.to_s + " Gold, " + aGem.to_s + " A gems, " + bGem.to_s + " B gems, " + cGem.to_s + " C gems, " + dGem.to_s + " D gems, " + eGem.to_s + " E gems, " + fGem.to_s + " F gems");
  end;
  theGold = event.content.slice(7,9).to_i;  halfGold = theGold/2;
  case halfGold;
    when 1..10000; say = ffGem(halfGold);
  end;
  event.message.delete  
  event.respond say = "Input Gold: " + theGold.to_s + "\n" + say + "\n" + halfGold.to_s + " half the gold unused.";
end;

##################################################################################################################
bot.message(start_with:"Agem") do |event|;
  dieRoll = rand(1..12);
  case dieRoll;  
    when 1; say = "Azurite (opaque mottled deep blue)";
    when 2; say =  "Banded Agate (translucent striped brown, blue, white, or red)";
    when 3; say =  "Blue Quartz (transparent pale blue)";
    when 4; say =  "Eye Agate (translucent circles of gray, white, brown, blue, or green)";
    when 5; say =  "Hematite (opaque gray-black)";
    when 6; say =  "Lapis Lazuli (opaque light and dark blue with yellow flecks)";
    when 7; say =  "Malachite (opaque striated light and dark green)";
    when 8; say =  "Moss Agate (translucent pink or yellow-white with mossy gray or green markings)";
    when 9; say =  "Obsidian (opaque black)";
    when 10; say =  "Rhodochrosite (opaque light pink)";
    when 11; say =  "Tiger Eye (translucent brown with golden center)";
    when 12; say =  "Turquoise (opaque light blue-green)";
  end;  
  event.message.delete
  event.respond ("A " + say);
end;
##################################################################################################################
bot.message(start_with:"Bgem") do |event|;
  dieRoll = rand(1..12);
  case dieRoll;  
    when 1; say = "Bloodstone (opaque dark gray with red flecks)";
    when 2; say = "Carnelian (opaque orange to red-brown)";
    when 3; say = "Chalcedony (opaque white)";
    when 4; say = "Chrysoprase (translucent green)";
    when 5; say = "Citrine (transparent pale yellow-brown)";
    when 6; say = "Jasper (opaque blue, black, or brown)";
    when 7; say = "Moonstone (translucent white with pale blue glow)";
    when 8; say = "Onyx (opaque bands of black and white, or pure black or white)";
    when 9; say = "Quartz (transparent white, smoky gray, or yellow)";
    when 10; say = "Sardonyx (opaque bands of red and white)";
    when 11; say = "Star Rose Quartz (translucent rosy stone with white star-shaped center)";
    when 12; say = "Zircon (transparent pale blue-green)";
  end;  
  event.message.delete
  event.respond ("B " + say);
end;
##################################################################################################################
bot.message(start_with:"Cgem") do |event|;
  dieRoll = rand(1..10);
  case dieRoll;  
    when 1; say = "Amber (transparent watery gold to rich gold)";
    when 2; say = "Amethyst (transparent deep purple)";
    when 3; say = "Chrysoberyl (transparent yellow-green to pale green)";
    when 4; say = "Coral (opaque crimson)";
    when 5; say = "Garnet (transparent red, brown-green, or violet)";
    when 6; say = "Jade (translucent light green, deep green , or white)";
    when 7; say = "Jet (opaque deep black)";
    when 8; say = "Pearl (opaque lustrous white, yellow, or pink)";
    when 9; say = "Spinel (transparent red, red-brown, or deep green)";
    when 10; say = "Tourmaline (transparent pale green, blue, brown, or red)";
  end;  
  event.message.delete
  event.respond ("C " + say);
end;
##################################################################################################################
bot.message(start_with:"Dgem") do |event|;
  dieRoll = rand(1..6);
  case dieRoll;  
    when 1; say = "Alexandrite (transparent dark green)";
    when 2; say = "Aquamarine (transparent pale blue-green)";
    when 3; say = "Black Pearl (opaque pure black)";
    when 4; say = "Blue Spinel (transparent deep blue)";
    when 5; say = "Peridot (transparent rich olive green)";
    when 6; say = "Topaz (transparent golden yellow)";
  end;  
  event.message.delete
  event.respond ("D " + say);
end;
##################################################################################################################
bot.message(start_with:"Egem") do |event|;
  dieRoll = rand(1..8);
  case dieRoll;  
    when 1; say = "Black Opal (translucent dark green with black mottling and golden flecks)";
    when 2; say = "Blue Sapphire (transparent blue-white to medium blue)";
    when 3; say = "Emerald (transparent deep bright green)";
    when 4; say = "Fire Opal (translucent fiery red)";
    when 5; say = "Opal (translucent pale blue with green and golden mottling)";
    when 6; say = "Star Ruby (translucent ruby with white star-shaped center)";
    when 7; say = "Star Sapphire (translucent blue sapphire with white star-shaped center)";
    when 8; say = "Yellow Sapphire (transparent fiery yellow or yellow·green)";
  end;  
  event.message.delete
  event.respond ("E " + say);
end;
##################################################################################################################
bot.message(start_with:"Fgem") do |event|;
  dieRoll = rand(1..4);
  case dieRoll;  
    when 1; say = "Black Sapphire (translucent lustrous black with glowing highlights)";
    when 2; say = "Diamond (transparent blue-white, canary, pink, brown, or blue)";
    when 3; say = "Jacinth (transparent fiery orange)";
    when 4; say = "Ruby (transparent clear red to deep crimson)";
  end;  
  event.message.delete
  event.respond ("F " + say);
end;
##################################################################################################################
bot.message(start_with:"gem") do |event|;
  say = "**Gemstone Value** \n";
  gemType = event.content.slice(3,1); result = "ABCDEF".index(gemType)
  if result != nil then;    
    case gemType;  
      when "A"; value = 10;
      when "B"; value = 50;
      when "C"; value = 100;
      when "D"; value = 500;
      when "E"; value = 1000;
      when "F"; value = 5000;
    end;
    (1..5).each do |x|;
      dieRoll = rand(1..4)+rand(1..4)+rand(1..4)+rand(1..4);
      case dieRoll;
        when 4; dieRoll = 16;
        when 5; dieRoll = 15;
        when 6; dieRoll = 14;
        when 7; dieRoll = 13;
        when 8; dieRoll = 12; 
        when 9; dieRoll = 11;
      end;
      fValue = (value * (dieRoll*10)) / 100;
      say = say + "Gem "+ gemType.upcase + "  value of " + fValue.to_s + " gold pieces. \n";
    end;
  else;
    say = event.content + " invalid gem type";
  end;  
  event.message.delete
  event.respond say;
end;
##################################################################################################################
###  uncut gemstones                                                                                           ###
##################################################################################################################
bot.message(start_with:"uncutgems") do |event|;
  say = "**Uncut Gemstones** (Grade) \n";
  (1..10).each do |x|;
      theRoll = rand(1..100);
      case theRoll;
        when 1..69; cash = "Gem Type A";
        when 70..85; cash = "Gem Type B";
        when 86..93; cash = "Gem Type C";
        when 94..97; cash = "Gem Type D";
        when 98..99; cash = "Gem Type E";
        when 100; cash = "Gem Type F";
      end;
      say = say + cash + "\n";
  end;
  event.message.delete
  event.respond say;
end;
##################################################################################################################
###  Art and Precious Gemstones                                                                                ###
##################################################################################################################
bot.message(start_with:"TESTTEST") do |event|;
  cp = rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cp = cp * 100;
  sp = rand(1..6)+rand(1..6)+rand(1..6); sp = sp * 100;
  gp = rand(1..6)+rand(1..6); gp = gp * 10;
  theDieRoll = rand(1..100);
  case theDieRoll;
    when 1..100;
say = "```diff
-Is this RED?
+Is this GREEN?
```";
say = say + "\n" + "```css
[RED? text found here?]
```";
say = say + "\n" + "```css
.Blue_text_found_here?
```";
say = say + "\n" + "```ini
[BLUE? text found here?]
```";
say = say + "\n" + "```json \n"  +
 '"This is greeN right"' + " \n ```";
  end;

  event.message.delete
  event.respond say;
end;
##################################################################################################################
################## HOARD ###### HOARD #####  HOARD ###############################################################
bot.message(start_with:"Hoard04") do |event|;
  cp = rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cp = cp * 100;
  sp = rand(1..6)+rand(1..6)+rand(1..6); sp = sp * 100;
  gp = rand(1..6)+rand(1..6); gp = gp * 10;
  theDieRoll = rand(1..100);
  case theDieRoll;
    when 1..6; reso = (rand(1..6)+rand(1..6)+rand(1..6)).to_s + " X uncut gems";
    when 7..16; reso = (rand(1..6)+rand(1..6)).to_s + " X 10 GP gems";
    when 17..26; reso = (rand(1..4)+rand(1..4)).to_s + " X 25 GP Art";
    when 27..36; reso = (rand(1..6)+rand(1..6)).to_s + " X 50 GP gems";
    when 37..44; reso = (rand(1..6)+rand(1..6)).to_s + " X 10 GP gems & " + rand(1..6).to_s + " X A-magic items";
    when 45..52; reso = (rand(1..4)+rand(1..4)).to_s + " X 25 GP Art & " + rand(1..6).to_s + " X A-magic items";
    when 53..60; reso = (rand(1..6)+rand(1..6)).to_s + " X 50 GP gems & " +  rand(1..6).to_s + " X A-magic items";
    when 60..100; reso = "Working on it.";
  end;
  say = cp.to_s + " Copper. " + sp.to_s + " Silver. " + gp.to_s + " Gold. \n";
  say = say + reso;
  event.message.delete
  event.respond say;
end;
##################################################################################################################
################## HOARD00 ###### HOARD00 #####  HOARD00 #########################################################
bot.message(start_with:"Hoard00") do |event|;
  one = "```json";  nl= "\n"; qq ='"';
  two =  "This is GREEN right";
  thr =  "```";
 say = one + nl + + qq + two + qq + nl + thr;
  event.message.delete
  event.respond say;
end;
################################## magic item #############################################################################
################################### Table A ###############################################################################
bot.message(start_with:"mTableA") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
     when 01..50; item="Potion of healing";
     when 51..60; item="Spell scroll (cantrip)";
     when 61..70; item="Potion of climbing";
     when 71..90; item="Spell scroll (1st level)";
     when 91..94; item="Spell scroll (2nd level)";
     when 95..98; item="Potion of greater healing";
     when 99;     item="Bag of holding";
     when 100;    item="Driftglobe";
  end;
  say = "Magic Item Table A: " + item;
  event.message.delete
  event.respond say;  
end;
################################## magic item #############################################################################
################################### Table B ###############################################################################
bot.message(start_with:"mTableB") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
     when 01..15; item="Potion of greater healing";
     when 16..22; item="Potion of fire breath";
     when 23..29; item="Potion of resistance";
     when 30..34; item="Ammunition , +1";
     when 35..39; item="Potion of animal friendship";
     when 40..44; item="Potion of hill giant strength";
     when 45..49; item="Potion of growth";
     when 50..54; item="Potion of water breathing";
     when 55..59; item="Spell scroll (2nd level)";
     when 60..64; item="Spell scroll (3rd leve l)";
     when 65..67; item="Bag of holding";
     when 68..70; item="Keoghtom's ointment";
     when 71..73; item="Oil of slipperiness";
     when 74..75; item="Dust of disappearance";
     when 76..77; item="Dust ·of dryness";
     when 78..79; item="Dust of sneezing and choking";
     when 80..81; item="Elemental gem";
     when 82..83; item="Philter of love";
     when 84; item="Alchemy jug";
     when 85; item="Cap of water breathing";
     when 86; item="Cloak of the manta ray";
     when 87; item="Driftglobe";
     when 88; item="Goggles of night";
     when 89; item="Helm of comprehending languages";
     when 90; item="Immovable rod";
     when 91; item="Lantern of revealing";
     when 92; item="Mariner's armor";
     when 93; item="Mithral armor";
     when 94; item="Potion of poison";
     when 95; item="Ring of swimming";
     when 96; item="Robe of useful items";
     when 97; item="Rope of climbing";
     when 98; item="Saddle of the cavalier";
     when 99; item="Wand of magic detection";
     when 100; item="Wand of secrets";
  end;
  say = "Magic Item Table B: " + item;
  event.message.delete
  event.respond say; 
end;   
################################## magic item #############################################################################
################################### Table C ###############################################################################
bot.message(start_with:"mTableC") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
     when 01..15; item='Potion of superior healing';
     when 16..22; item='Spell scroll (4th level)';
     when 23..27; item='Ammunition, +2';
     when 28..32; item='Potion of clairvoyance';
     when 33..37; item='Potion of diminution';
     when 38..42; item='Potion of gaseous form';
     when 43..47; item='Potion of frost giant strength';
     when 48..52; item='Potion of stone giant strength';
     when 53..57; item='Potion of heroism';
     when 58..62; item='Potion of invu lnerabil ity';
     when 63..67; item='Potion of mind reading';
     when 68..72; item='Spell scroll (5th le vel)';
     when 73..75; item='Elixir of health';
     when 76..78; item='Oil of etherealness';
     when 79..81; item='Potion of fire giant strength';
     when 82..84; item="Quaal's feather token";
     when 85..87; item='Scroll of protection';
     when 88..89; item='Bag of beans';
     when 90..91; item='Bead of force';
     when 92; item='Chime of opening';
     when 93; item='Decanter of endless water';
     when 94; item='Eyes of minute seeing';
     when 95; item='Folding boat';
     when 96; item="Heward's handy haversack";
     when 97; item='Horseshoes of speed';
     when 98; item='Necklace of fireballs';
     when 99; item='Periapt of health';
     when 100; item='Sending stone';
  end;
  say = "Magic Item Table C: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table D ###############################################################################
bot.message(start_with:"mTableD") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
    when 01..20; item='Potion of supreme healing';
    when 21..30; item='Potion of invisibility';
    when 31..40; item='Potion of speed';
    when 41..50; item='Spell scroll (6th level)';
    when 51..57; item='Spell scroll (7th level)';
    when 58..62; item='Ammunition, +3';
    when 63..67; item='Oil of sharpness';
    when 68..72; item='Potion of fl yi ng';
    when 73..77; item='Potion of cloud giant strength';
    when 78..82; item='Potion of longevity';
    when 83..87; item='Potion of vitality';
    when 88..92; item='Spell scroll (8th level)';
    when 93..95; item='Horseshoes of a zephyr';
    when 96..98; item="Nolzur's marvelous pigments";
    when 99; item='Bag of devouring';
    when 00; item='Portable hole';
  end;
  say = "Magic Item Table D: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table E ###############################################################################
bot.message(start_with:"mTableE") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
    when 01..30; item="Spell scroll (8th level)";
    when 31..55; item="Potion of storm giant strength";
    when 56..70; item="Potion of supreme healing";
    when 71..85; item="Spell scroll (9th level)";
    when 86..93; item="Universal solvent";
    when 94..98; item="Arrow of slaying";
    when 99..00; item="Sovereign glue";
  end;
  say = "Magic Item Table E: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table F ###############################################################################
bot.message(start_with:"mTableF") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
    when 01..15; item="Weapon, +1";
    when 16..18; item="Shield,+ 1";
    when 19..21; item="Sentinel shield";
    when 22..23; item="Amulet of proof against detection and location";
    when 24..25; item="Boots of elvenkind";
    when 26..27; item="Boots of striding and springing";
    when 28..29; item="Bracers of archery";
    when 30..31; item="Brooch of shielding";
    when 32..33; item="Broom of flying";
    when 34..35; item="Cloak of elvenkind";
    when 36..37; item="Cloak of protection";
    when 38..39; item="Gauntlets of ogre power";
    when 40..41; item="Hat of disguise";
    when 42..43; item="Javelin of lightning";
    when 44..45; item="Pearl of power";
    when 46..47; item="Rod of the pact keeper, + 1";
    when 48..49; item="Slippers of spider climbing";
    when 50..51; item="Staff of the adder";
    when 52..53; item="Staff of the python";
    when 54..55; item="Sword of vengeance";
    when 56..57; item="Trident of fish command";
    when 58..59; item="Wand of magic missiles";
    when 60..61; item="Wand of the war mage, + 1";
    when 62..63; item="Wand of web";
    when 64..65; item="Weapon of warning";
    when 66; item="Adamantine armor (chain mail)";
    when 67; item="Adamantine armor (chain shirt)";
    when 68; item="Adamantine armor (scale mail)";
    when 69; item="Bag of tricks (gray)";
    when 70; item="Bag of tricks (rust)";
    when 71; item="Bag of tricks (tan)";
    when 72; item="Boots of the winterlands";
    when 73; item="Circlet of blasting";
    when 74; item="Deck of illusions";
    when 75; item="Eversmoking bottle";
    when 76; item="Eyes of charming";
    when 77; item="Eyes of the eagle";
    when 78; item="Figurine of wondrous power (silver raven)";
    when 79; item="Gem of brightness";
    when 80; item="Gloves of missile snaring";
    when 81; item="Gloves of swimming and climbing";
    when 82; item="Gloves of thievery";
    when 83; item="Headband of intellect";
    when 84; item="Helm of telepathy";
    when 85; item="Instrument of the bards (Doss lute)";
    when 86; item="Instrument of the bards (Fochlucan bandore)";
    when 87; item="Instrument of the bards (Mac-Fuimidh cittern)";
    when 88; item="Medallion of thoughts";
    when 89; item="Necklace of adaptation";
    when 90; item="Periapt of wound closure";
    when 91; item="Pipes of haunting";
    when 92; item="Pipes of the sewers";
    when 93; item="Ring of jumping";
    when 94; item="Ring of mind shielding";
    when 95; item="Ring of warmth";
    when 96; item="Ring of water walking";
    when 97; item="Quiver of Ehlonna";
    when 98; item="Stone of good luck";
    when 99; item="Wind fan";
    when 100; item="Winged boots";
  end;
  say = "Magic Item Table F: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table G ###############################################################################
bot.message(start_with:"mTableG") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
    when 01..11; item="Weapon, +2";
    when 12..14; item="Figurine of wondrous power (roll d8) [1 Bronze griffon 2 Ebony fly 3 Golden lions 4 Ivory goats 5 Marble elephant 6-7 Onyx dog 8 Serpentine owl]";
    when 15; item="Adamantine armor (breastplate)";
    when 16; item="Adamantine armor (splint)";
    when 17; item="Amulet of health";
    when 18; item="Armor of vulnerability";
    when 19; item="Arrow-catching shield";
    when 20; item="Belt of dwarvenkind";
    when 21; item="Belt of hill giant strength";
    when 22; item="Berserker axe";
    when 23; item="Boots of levitation";
    when 24; item="Boots of speed";
    when 25; item="Bowl of commanding water elementals";
    when 26; item="Bracers of defense";
    when 27; item="Brazier of commanding fire elementals";
    when 28; item="Cape of the mountebank";
    when 29; item="Censer of controlling air elementals";
    when 30; item="Armor, +1 chain mail";
    when 31; item="Armor of resistance (chain mail)";
    when 32; item="Armor,+ 1 chain shirt";
    when 33; item="Armor of resistance (chain shirt)";
    when 34; item="Cloak of displacement";
    when 35; item="Cloak of the bat";
    when 36; item="Cube afforce";
    when 37; item="Daern's instant fortress";
    when 38; item="Dagger of venom";
    when 39; item="Dimensional shackles";
    when 40; item="Dragon slayer";
    when 41; item="Elven chain";
    when 42; item="Flame tongue";
    when 43; item="Gem of seeing";
    when 44; item="Giant slayer";
    when 45; item="Clamoured studded leather";
    when 46; item="Helm of teleportation";
    when 47; item="Horn of blasting";
    when 48; item="Horn of Valhalla (silver or brass)";
    when 49; item="Instrument of the bards (Canaith mandolin)";
    when 50; item="Instrument ofthe bards (Cli Lyre)";
    when 51; item="Ioun stone (awareness)";
    when 52; item="Ioun stone (protection)";
    when 53; item="Ioun stone (reserve)";
    when 54; item="Ioun stone (sustenance)";
    when 55; item="Iron bands of Bilarro";
    when 56; item="Armor, + 1 leather";
    when 57; item="Armor of resistance (leather)";
    when 58; item="Mace of disruption";
    when 59; item="Mace of smiting";
    when 60; item="Mace of terror";
    when 61; item="Mantle of spell resistance";
    when 62; item="Necklace of prayer beads";
    when 63; item="Periapt of proof against poison";
    when 64; item="Ring of animal influence";
    when 65; item="Ring of evasion";
    when 66; item="Ring of feather falling";
    when 67; item="Ring of free action";
    when 68; item="Ring of protection";
    when 69; item="Ring of resistance";
    when 70; item="Ring of spell storing";
    when 71; item="Ring of the ram";
    when 72; item="Ring of X-ray vision";
    when 73; item="Robe of eyes";
    when 74; item="Rod of rulership";
    when 75; item="Rod of the pact keeper, +2";
    when 76; item="Rope of entanglement";
    when 77; item="Armor, +1 scale mail";
    when 78; item="Armor of resistance (scale mail)";
    when 79; item="Shield, +2";
    when 80; item="Shield of missile attraction";
    when 81; item="Staff of charming";
    when 82; item="Staff of healing";
    when 83; item="Staff of swarming insects";
    when 84; item="Staff of the woodlands";
    when 85; item="Staff of withering";
    when 86; item="Stone of controlling earth elementals";
    when 87; item="Sun blade";
    when 88; item="Sword of life stealing";
    when 89; item="Sword of wounding";
    when 90; item="Tentacle rod";
    when 91; item="Vicious weapon";
    when 92; item="Wand of binding";
    when 93; item="Wand of enemy detection";
    when 94; item="Wand of fear";
    when 95; item="Wand of fireballs";
    when 96; item="Wand of lightning bolts";
    when 97; item="Wand of paralysis";
    when 98; item="Wand of the war mage, +2";
    when 99; item="Wand of wonder";
    when 100; item="Wings of flying";
  end;
  say = "Magic Item Table G: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table H ###############################################################################
bot.message(start_with:"mTableH") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
      when 01..10; item="Weapon, +3";
      when 11..12; item="Amulet of the planes";
      when 13..14; item="Carpet of flying";
      when 15..16; item="Crystal ball (very rare version)";
      when 17..18; item="Ring of regeneration";
      when 19..20; item="Ring of shooting stars";
      when 21..22; item="Ring of telekinesis";
      when 23..24; item="Robe of scintillating colors";
      when 25..26; item="Robe of stars";
      when 27..28; item="Rod of absorption";
      when 29..30; item="Rod of alertness";
      when 31..32; item="Rod of security";
      when 33..34; item="Rod of the pact keeper, +3";
      when 35..36; item="Scimitar of speed";
      when 37..38; item="Shield, +3";
      when 39..40; item="Staff of fire";
      when 41..42; item="Staff of frost";
      when 43..44; item="Staff of power";
      when 45..46; item="Staff of striking";
      when 47..48; item="Staff of thunder and lightning";
      when 49..50; item="Sword of sharpness";
      when 51..52; item="Wand of polymorph";
      when 53..54; item="Wand of the war mage, +3";
      when 55; item="Adamantine armor (half plate)";
      when 56; item="Adamantine armor (plate)";
      when 57; item="Animated shield";
      when 58; item="Belt of fire giant strength";
      when 59; item="Belt of frost (or stone) giant strength";
      when 60; item="Armor, + 1 breastplate";
      when 61; item="Armor of resistance (breastplate)";
      when 62; item="Candle of invocation";
      when 63; item="Armor, +2 chain mail";
      when 64; item="Armor, +2 chain shirt";
      when 65; item="Cloak of arachnida";
      when 66; item="Dancing sword";
      when 67; item="Demon armor";
      when 68; item="Dragon scale mail";
      when 69; item="Dwarven pla te";
      when 70; item="Dwarven thrower";
      when 71; item="Efreeti bottle";
      when 72; item="Figurine of wondrous power (obsidian steed)";
      when 73; item="Frost brand";
      when 74; item="Helm of brilliance";
      when 75; item="Horn ofValhalla (bronze)";
      when 76; item="Instrument of the bards (Anstruth harp)";
      when 77; item="Ioun stone (absorption)";
      when 78; item="Ioun stone (agility)";
      when 79; item="Ioun stone (fortitude)";
      when 80; item="Ioun stone (insight)";
      when 81; item="Ioun stone (intellect)";
      when 82; item="Ioun stone (leadership)";
      when 83; item="Ioun stone (strength)";
      when 84; item="Armor, +2 leather";
      when 85; item="Manual of bodily health";
      when 86; item="Manual of gainful exercise";
      when 87; item="Manual of golems";
      when 88; item="Manual of quickness of action";
      when 89; item="Mirror of life trapping";
      when 90; item="Nine Lives stealer";
      when 91; item="Oath bow";
      when 92; item="Armor, +2 scale mail";
      when 93; item="Spellguard shield";
      when 94; item="Armor, + 1 splint";
      when 95; item="Armor of res istance (splint)";
      when 96; item="Armor, + 1 studded leather";
      when 97; item="Armor of resistance (studded leather)";
      when 98; item="Tome of clear thought";
      when 99; item="Tome of leadership and influence";
      when 100; item="Tome of understandin";
  end;
  say = "Magic Item Table H: " + item;
  event.message.delete
  event.respond say; 
end;
################################## magic item #############################################################################
################################### Table I ###############################################################################
bot.message(start_with:"mTableI") do |event|;
  theRoll = (rand 100)+1;
  case theRoll;
      when 01..05; item="Defender";
      when 06..10; item="Hammer of thunderbolts";
      when 11..15; item="Luck blade";
      when 16..20; item="Sword of answering";
      when 21..23; item="Holy avenger";
      when 24..26; item="Ring of djinni summoning";
      when 27..29; item="Ring of invisibility";
      when 30..32; item="Ring of spell turning";
      when 33..35; item="Rod of lordly might";
      when 36..38; item="Staff of the magi";
      when 39..41; item="Vorpal sword";
      when 42..43; item="Belt of cloud giant strength";
      when 44..45; item="Armor, +2 breastplate";
      when 46..47; item="Armor, +3 chain mail";
      when 48..49; item="Armor, +3 chain shirt";
      when 50..51; item="Cloak of invisibility";
      when 52..53; item="Crystal ball (legendary version)";
      when 54..55; item="Armor, + 1 half plate";
      when 56..57; item="Iron flask";
      when 58..59; item="Armor, +3 leather";
      when 60..61; item="Armor, +1 plate";
      when 62..63; item="Robe of the archmagi";
      when 64..65; item="Rod of resurrection";
      when 66..67; item="Armor, +1 scale mail";
      when 68..69; item="Scarab of protection";
      when 70..71; item="Armor, +2 splint";
      when 72..73; item="Armor, +2 studded leather";
      when 74..75; item="Well of many worlds";
      when 76; item="Magic armor (ARMOUR +2/+3 roll dl2)";
      when 77; item="Apparatus of Kwalish";
      when 78; item="Armor of invulnerability";
      when 79; item="Belt of storm giant strength";
      when 80; item="Cubic gate";
      when 81; item="Deck of many things";
      when 82; item="Efreeti chain";
      when 83; item="Armor of resistance (half plate)";
      when 84; item="Horn ofValhalla (iron)";
      when 85; item="Instrument of the bards (OIIamh harp)";
      when 86; item="loun stone (greater absorption)";
      when 87; item="loun stone (mastery)";
      when 88; item="loun stone (regeneration)";
      when 89; item="Plate armor of etherealness";
      when 90; item="Plate armor of resistance";
      when 91; item="Ring of air elemental command";
      when 92; item="Ring of earth elemental command";
      when 93; item="Ring of fire elemental command";
      when 94; item="Ring of three wishes";
      when 95; item="Ring of water elemental command";
      when 96; item="Sphere of annihilation";
      when 97; item="Talisman of pure good";
      when 98; item="Talisman of the sphere";
      when 99; item="Talisman of ultimate evil";
      when 100; item="Tome of the stilled tongue";
  end;
  say = "Magic Item Table I: " + item;
  event.message.delete
  event.respond say; 
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with:"55555") do |event|;
  def tis_this(input);
    bork = input;
    say = bork.to_s + " this.";
    return say; 
  end;  
  event.message.delete
  theSay = tis_this(event.content)
  event.respond theSay;
end;


bot.message(contains:"fly") do |event|;
  event.message.delete;  theString = event.content; flyStartsHere = theString.index("fly")
  numbA = theString.slice(0,flyStartsHere); numbB = theString.slice((flyStartsHere+3),99);
  numbA = numbA.to_i; numbB = numbB.to_i;
  numbC = Math.sqrt((numbA * numbA) + (numbB * numbB))
  theSay = numbA.to_s + " fly " + numbB.to_s + " = " + numbC.round(1).to_s;
  event.respond theSay;
end;


bot.message(start_with: ";deleteme") do |event|;
      say = "The Message ID was: " + event.message.id.to_s;
      say = say + "\nThe Author ID was: " + event.author.id.to_s;
      say = say + "\nThe Autthor name was: " + event.author.username.to_s
#      say = say + "\n" + event.author.discriminator.to_s. #      say = say + "\n" + event.author.server.name.to_s
#      say = say + "\n" + event.author.server.id.to_s.     #      say = say + "\n" + event.channel.inspect.to_s
#      say = say + "\n" + event.content.to_s;              #      say = say + "\n" + event.file.to_s;
#      say = say + "\n" + event.message.to_s;              #      say = say + "\n" + event.saved_message.to_s;
#      say = say + "\n" + event.server.to_s;               #      say = say + "\n" + event.timestamp.to_s;
#      say = say + "\n\n" + event.author.inspect.to_s;
       say = say + "\nWhom said: " + event.content.to_s;
       say = say  + "\n\nI just deleted it!";
       event.message.delete;
      event.respond say;
end;

bot.message(start_with: ".i") do |event|
     check_user_or_nick(event)
     inputStr = event.content; mod = 0; moreChars = true;
     docMsg = "Rolling initiative? Use:  .i  or  .i-1  or  .i2   \nFor Advantage/Disadvantage append an  a or d => .ia or .i2a"
     lenInputStr = inputStr.length;
     
     if lenInputStr > 2 then
        extraCharLen = lenInputStr - 2; # how many characters we will check
        extras = inputStr.slice(2,extraCharLen) # extract extra characters
        (0..(extraCharLen-1)).each do |x|;
          sample = extras.slice(x,1)   # get one character to sample
          chkResult = ("-1234567890ad").index(sample); # test this sample character     
             if chkResult == nil then;
                moreChars = false;  #if the sample character was not found set moreChars to false
             end;
        end;     
     end;
     
     adv = inputStr.index('a'); dis = inputStr.index('d');  # was a d or a found in the input string?
     if (adv != nil) && (dis != nil) then; moreChars = false; end; # if both a & d found, bail out.
     
     if moreChars == true then;   #bail if bad chars already detected
        if (adv != nil) || (dis != nil) then;  # if an a or a d were found :
           endChar = extras.slice((extraCharLen-1),1); # grab the last character
           if (endChar != "a") && (endChar != "d") then # if last character is NOT a AND not d, bail
              moreChars = false;
           end;
        end;
     end;  
     
     if ( (inputStr.slice(0,2) == '.i';) && ( moreChars == true ) )then;  
       # a or d found (or not) in above code
         if (adv != nil) || (dis != nil) then;  # if an a or a d were found :
             mod = (inputStr.slice(2,lenInputStr-1)).to_i;  # drop the last letter
             rollOne = (rand 20)+1; rollTwo = (rand 20)+1; #make two rolls
             theRolls = "[" + rollOne.to_s + "," + rollTwo.to_s + "]";
             if adv != nil then;
                theRoll = [rollOne,rollTwo].max;
             else;
               theRoll = [rollOne,rollTwo].min;
             end;
         else;
             mod = (inputStr.slice(2,lenInputStr)).to_i;  #keep all of the characters
             theRoll = (rand 20) + 1;
             theRolls = "[" + theRoll.to_s + "]";
         end;   
         say = @user.to_s + " has rolled an initiative of: " + theRolls.to_s + " + " + mod.to_s + " = " + (theRoll+mod).to_s;
     else
         say = docMsg; 
     end;
    event.message.delete;     
     event.respond say;
end;

bot.message(start_with: ";i") do |event|
    inputValue = event.content;
    event.message.delete;
    if inputValue == ";i"; then;
       responseValue = "@everyone Please pause whatever you are doing.\n" +
                       "Roll initiative using the command: ii \n (two lower case 'eyes') \n" +
                       "(The bot knows your character ability score modifiers.)";
       event.respond responseValue;
    end;
end;

########## Unique INITIATIVE ########
bot.message(start_with: "ii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    mod = @player[pIndex][3] + @player[pIndex][9];     initRoll=(rand 20)+1;      result = initRoll + mod;
    responseValue = theUser.to_s + " has rolled initiative: [" + initRoll.to_s + "] + " + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

########## Advantage Unique INITIATIVE ########
bot.message(start_with: "aii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    initRoll1=(rand 20)+1;     initRoll2=(rand 20)+1;     initRoll = [initRoll1,initRoll2].max;
    result = initRoll + mod + @player[pIndex][9];
    responseValue = theUser.to_s + " has rolled initiative with ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

########## DisAdvantage Unique INITIATIVE ########
bot.message(start_with: "dii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    initRoll1=(rand 20)+1;     initRoll2=(rand 20)+1;     initRoll = [initRoll1,initRoll2].min;
    result = initRoll + mod + @player[pIndex][9];
    responseValue = theUser.to_s + " has rolled initiative with DIS-ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

#################################################################################
################## manual CREATURE/MONSTER damage ###############################
bot.message(start_with:"dmgOLDONE") do |event|
    event.message.delete;   check_user_or_nick(event);    letterDamage = event.content.slice(3,99); # creature LETTER and DAMAGE should be in the string
    sym = "\u2193"+"\u2193"+"\u2193";   blank = letterDamage.index(' ');     comment = "There was no comment provided."
    if blank != nil then; # in the case where there is a BLANK, there is a comment to extract
      comment = letterDamage.slice(blank,99);  #extracting the comment (anything after the blank)
    end; 
       alphaVal = letterDamage.slice(0,1);  # FIRST character should be a CAPITAL LETTER
       begin; target = "ABCDEFGHIJKLMNOPQRSTU".index(alphaVal); rescue; target = false; end; # translate the LETTER to a number
       begin; hpDamage = ((letterDamage.slice(1,3)).chomp).to_i; rescue; hpDamage = 0; end;  # up to 3 characters of DAMAGE converted to an integer

       if (target != false) && (hpDamage != 0) && (@user.slice(0,5) == "Allen") then;  # ensure VALID damage value & VALID creature Number
            @HP[target][0] = @HP[target][0] - hpDamage;  # deduct the HP from the creature
            if (@RE[target]==1) && (@HP[target][0] < 1) then;    @RE[target] = 0; @HP[target][0] = 1;   end;
            say = sym + "  " + comment + "  " + sym + "\n";  
            say = say + "Creature " + alphaVal + "  (" + target.to_s + ") reduced by " + hpDamage.to_s + " hit points.";
            health_check(@HP[target][0], @HP[target][1]);
            say = say + "\nCreature " + alphaVal + "  (" + target.to_s + ")  is " + @healthStat;
       else;
            say = "(" + event.content + ") dmgAB where A is Target Letter and B is the HP (integer)"
       end;
    event.respond say;
end;

######## HEALTH CHECK ########## ######## HEALTH CHECK ##########
def health_check(currentHp, originalHp);
  perCent = currentHp/originalHp;
  if perCent < 0.00010 then; @healthStat = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
  if perCent > 0.00000 then; @healthStat = "Battered"; end;
  if perCent > 0.24999 then; @healthStat = "Bloodied"; end;
  if perCent > 0.49999 then; @healthStat = "Bruised"; end;
  if perCent > 0.74999 then; @healthStat = "Healthy"; end;
end;

####### GET_DAMAGES #########
def get_damages(pIndex)
  theWeaponIndex = @weapon[(@player[pIndex][1])];
  case theWeaponIndex;
       when "2d6";  @dmg1 = (rand 6)+1;  @dmg2 = (rand 6)+1; @dmg3 = (rand 6)+1;  @dmg4 = (rand 6)+1;
       when "1d12"; @dmg1 = (rand 12)+1; @dmg2 = -99;        @dmg3 = (rand 12)+1; @dmg4 = -99;
       when "1d10"; @dmg1 = (rand 10)+1; @dmg2 = -99;        @dmg3 = (rand 10)+1; @dmg4 = -99;
       when "1d8";  @dmg1 = (rand 8)+1;  @dmg2 = -99;        @dmg3 = (rand 8)+1;  @dmg4 = -99;
       when "1d6";  @dmg1 = (rand 6)+1;  @dmg2 = -99;        @dmg3 = (rand 6)+1;  @dmg4 = -99;
       when "1d4";  @dmg1 = (rand 4)+1;  @dmg2 = -99;        @dmg3 = (rand 4)+1;  @dmg4 = -99;
       when "2d4";  @dmg1 = (rand 4)+1;  @dmg2 = (rand 4)+1; @dmg3 = (rand 4)+1;  @dmg4 = (rand 4)+1;
       when "2d3";  @dmg1 = (rand 3)+1;  @dmg2 = (rand 3)+1; @dmg3 = (rand 3)+1;  @dmg4 = (rand 3)+1;
  end;
end;

####### GET_DAMAGES #########
def get_Rdamages(pIndex)
  theWeaponIndex = @weapon[(@player[pIndex][12])];
  case theWeaponIndex;
       when "2d6";  @dmg1 = (rand 6)+1;  @dmg2 = (rand 6)+1; @dmg3 = (rand 6)+1;  @dmg4 = (rand 6)+1;
       when "1d12"; @dmg1 = (rand 12)+1; @dmg2 = -99;        @dmg3 = (rand 12)+1; @dmg4 = -99;
       when "1d10"; @dmg1 = (rand 10)+1; @dmg2 = -99;        @dmg3 = (rand 10)+1; @dmg4 = -99;
       when "1d8";  @dmg1 = (rand 8)+1;  @dmg2 = -99;        @dmg3 = (rand 8)+1;  @dmg4 = -99;
       when "1d6";  @dmg1 = (rand 6)+1;  @dmg2 = -99;        @dmg3 = (rand 6)+1;  @dmg4 = -99;
       when "1d4";  @dmg1 = (rand 4)+1;  @dmg2 = -99;        @dmg3 = (rand 4)+1;  @dmg4 = -99;
       when "2d4";  @dmg1 = (rand 4)+1;  @dmg2 = (rand 4)+1; @dmg3 = (rand 4)+1;  @dmg4 = (rand 4)+1;
       when "2d3";  @dmg1 = (rand 3)+1;  @dmg2 = (rand 3)+1; @dmg3 = (rand 3)+1;  @dmg4 = (rand 3)+1;
  end;
end;

def prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
  @sayValue = "";
  iTarget = "ABCDEFGHIJKLMNOPQRSTU".slice(target,1);
  get_damages(pIndex); # go to method to get the damages
  if rage == 0; then ra = ""; end;  
  if rage == 2; then ra = "+(2)"; end;
  if rage == 3; then ra = "+(3)"; end;
  if rage == 4; then ra = "+(4)"; end;
  if rage == 5; then ra = "+(5)"; end;
  #puts "----> " + @dmg1[pIndex].to_s + " - " + @dmg2[pIndex].to_s + " - " + @dmg3[pIndex].to_s + " - " + @dmg4[pIndex].to_s;
  if iRoll != 20 then;
       if (@weapon[(@player[pIndex][1])] != "2d6") && (@weapon[(@player[pIndex][1])] != "2d4") && (@weapon[(@player[pIndex][1])] != "2d3") then;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + rage).to_s + " points of damage.";
         #puts "HP: " + @HP[target][0].to_s + "   @dmg1: " +  @dmg1.to_s + "  mod: " +  mod.to_s + "  target: " + target.to_s + " @healthStat: " +  @healthStat.inspect; 
         @HP[target][0] = @HP[target][0] - @dmg1 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       else;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg2 + rage).to_s + " points of damage.";
         @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       end;
  else;   # NATURAL 20
       if (@weapon[(@player[pIndex][1])] != "2d6") && (@weapon[(@player[pIndex][1])] != "2d4") && (@weapon[(@player[pIndex][1])] != "2d3") then;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg3.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg3 + rage).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg3 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       else;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "][" + @dmg3.to_s + "][" + @dmg4.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg2 + @dmg3 + @dmg4 + rage).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - @dmg3 - @dmg4 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       end;              
  end;
end;

######### easy ATTACK TARGET creature #####################################
bot.message(start_with: "mrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " made a MELEE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "MELEE Roll To Hit needs  mrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;


######### HexBlade Agonizing Blast ATTACK TARGET creature #####################################
######### HexBlade Agonizing Blast ATTACK TARGET creature #####################################
bot.message(start_with: "agblast") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][7];   mod2 = @player[pIndex][7];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " Ag Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "Ag Blast Roll To Hit needs  agblast?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;



######### WOLF ATTACK TARGET creature #####################################
bot.message(start_with: "wolf") do |event|
    if event.user.nick != nil; theUser = "Wolfs"; else; theUser = "Wolfs"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Wolf made a BITE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "wolf needs  wolf?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### WOLF ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "awolf") do |event|
    if event.user.nick != nil; theUser = "Wolfs"; else; theUser = "Wolfs"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  

    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "Wolf made a BITE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end;      
    else;
      say = "wolf needs  wolf?   ?= target letter A to K";
    end;    
    event.respond say;
end;

######### BEAR BITE ATTACK TARGET creature #####################################
bot.message(start_with: "bite") do |event|
    if event.user.nick != nil; theUser = "Bear2"; else; theUser = "Bear2"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "BEAR made a BITE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "bite needs  bite?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR ADVANTAGE BITE ATTACK TARGET creature #####################################
bot.message(start_with: "abite") do |event|
    if event.user.nick != nil; theUser = "Bear2"; else; theUser = "Bear2"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "BEAR made a BITE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "abite needs  abite?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR CLAW ATTACK TARGET creature #####################################
bot.message(start_with: "claw") do |event|
    if event.user.nick != nil; theUser = "Bear1"; else; theUser = "Bear1"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "BEAR made a CLAW roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "claw needs  claw?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR ADVANTAGE CLAW ATTACK TARGET creature #####################################
bot.message(start_with: "aclaw") do |event|
    if event.user.nick != nil; theUser = "Bear1"; else; theUser = "Bear1"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "BEAR made a CLAW Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "aclaw needs  aclaw?   ?= target letter A to K";
    end;
    event.respond say;
end;

#####
#####
#####
######### HEX BLADE ELDRITCH BLAST ATTACK TARGET creature #####################################
bot.message(start_with: "eblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Eldritch Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "eblast needs eblast?  ?= target letter A to K";
    end;
    event.respond say;
end;

###################################################################################################

###################################################################################################

######### HEX BLADE ELDRITCH BLAST HEX ATTACK TARGET creature #####################################
bot.message(start_with: "hceb") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO EBLAS
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Hexblade Curse Eldritch Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
      if iRoll == 19 then iRoll = 20; end;    
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";               rage = profB; # using rage to carry the Hex Blade added damage (prof bonus)
              prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "hceb needs hceb?  ?= target letter A to K";
    end;
    event.respond say;
end;

######### HEX BLADE ELDRITCH BLAST ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "aeblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "Eldritch Blast Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "aeblast needs aeblast?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### HEX BLADE ELDRITCH BLAST DIS-ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "deblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB;
       say = "Eldritch Blast Dis roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "dblasta needs dblast?   ?= target letter A to K";
    end;
    event.respond say;
end;

####
####
####

######### easy ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "marth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  

    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = theUser + " made a MELEE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end;      
    else;
    say = "MELEE Advanatage Roll To Hit needs  marth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy RAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mRrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " made a MELEE roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=2; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "MELEE RAGE Roll To Hit needs  mrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;

#########  RAGE ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mRarth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = theUser + " made a MELEE RAGE Adv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=2; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "RAGE MELEE Advanatage Roll To Hit needs  Rmarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy DISADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mdrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB;
       say = theUser + " made a MELEE DisA roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
    say = "MELEE Dis-Advanatage Roll To Hit needs  mdrth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;      
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;  bless=(rand 4)+1;  iRoll=(rand 20)+1; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE Blessed roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "]+[" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
    say = "MELEE Blessed Roll To Hit needs  mbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mabrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;      
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   bless=(rand 4)+1;  roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE Adv Bless roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][ " + roll2.to_s + "] + [" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "MELEE Advantage Blessed Roll To Hit needs  mabrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy Melee DIS-ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mdbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   bless=(rand 4)+1;  roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE DisA Bless roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][ " + roll2.to_s + "] + [" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "Melee Dis-Advantage Blessed Roll To Hit needs  mdbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;
############
############
############
############ RANGE ATTACK DAMAGE REPORT
def prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
  @sayValue = "";
  iTarget = "ABCDEFGHIJKLMNOPQRSTU".slice(target,1);
  get_damages(pIndex); # go to method to get the damages
  if sharp == 10; then shsh = "+(10)"; else; shsh = ""; end;
  #puts "----> " + @dmg1[pIndex].to_s + " - " + @dmg2[pIndex].to_s + " - " + @dmg3[pIndex].to_s + " - " + @dmg4[pIndex].to_s;
  if iRoll != 20 then;
       if (@weapon[(@player[pIndex][12])] != "2d6") && (@weapon[(@player[pIndex][12])] != "2d4") && (@weapon[(@player[pIndex][12])] != "2d3") then;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + sharp).to_s + " points of damage.";
         #puts "HP: " + @HP[target][0].to_s + "   @dmg1: " +  @dmg1.to_s + "  mod: " +  mod.to_s + "  target: " + target.to_s + " @healthStat: " +  @healthStat.inspect; 
         @HP[target][0] = @HP[target][0] - @dmg1 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       else;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg2 + sharp).to_s + " points of damage.";
         @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - mod;     health_check(@HP[iTarget][0], @HP[iTarget][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       end;
  else;   # NATURAL 20
       if (@weapon[(@player[pIndex][12])] != "2d6") && (@weapon[(@player[pIndex][12])] != "2d4") && (@weapon[(@player[pIndex][12])] != "2d3") then;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg3.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg3 + sharp).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg3 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       else;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "][" + @dmg3.to_s + "][" + @dmg4.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg2 + @dmg3 + @dmg4 + sharp).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - @dmg3 - @dmg4 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       end;              
  end;
end;


######### Sharp Shooter +10 RANGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB -5;
      say = theUser + " made a Sharp Shooter RANGE roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n"; puts "That was a miss.";
          else;
              say = say + "     ... HIT!"; puts "That was a hit.";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
      say = "Sharp Shooter RANGE Roll To Hit needs  Srrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;

######### Sharp Shooter +10 damage RANGE ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srarth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
 #   inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(6,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 7) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB - 5;
       say = theUser + " Sharp Shooter RANGE Adv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            get_Rdamages(pIndex); # go to method to get the damages
            sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
            say = say + @sayValue;
        end;
    else;
    say = "Sharp Shooter RANGE Adv Roll To Hit needs  Srarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### Sharp Shooter +10 damage RANGE DIS-ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srdrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  #  inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(6,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 7) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB - 5;
       say = theUser + " Sharp Shooter RANGE DisAdv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            get_Rdamages(pIndex); # go to method to get the damages
            sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
            say = say + @sayValue;
        end;     
    else;
    say = "Sharp Shooter RANGE DisAdv Roll To Hit needs  Srarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy RANGED ROLL TO HIT  TARGET creature #####################################
######### easy RANGED ROLL TO HIT  TARGET creature #####################################
bot.message(start_with: "rrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
 #   inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(4,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 5) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
       say = theUser + " made a RANGED roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "      ... Missed! \n";
          else;
              say = say + "      ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "Ranged Roll To Hit needs  rrth?   ?= target number (0 to 9)";
    end;
    #event.message.delete;
    event.respond say;
end;

######### easy ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "rarth") do |event|
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
   (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
   inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
   if (validInput == true) then;
      mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].max;  result = iRoll + mod1 + mod3 + profB;
      say = @user.to_s + " made a RANGED Advantage roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The RANGED Advantage roll to hit ... Missed!";
          else;
              say = say + "     The RANGED Advantage roll to hit ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "Ranged Advanatage Roll To Hit needs  rarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy DISADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "rdrth") do |event|
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
   (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
   inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
   if (validInput == true) then;
      mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].min;  result = iRoll + mod1 + mod3 + profB;
      say = @user.to_s + " made a RANGED Dis-Adv roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
         if (result < @armour[target]) then;
             say = say + "     ... Missed!";
         else;
             say = say + "     ... HIT!";
             get_Rdamages(pIndex); # go to method to get the damages
             sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
             say = say + @sayValue;
         end;
   else;
       say = "RANGED Dis-Adv Roll To Hit needs  rdrth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll=(rand 20)+1; bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll.to_s + "]+[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rabrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1; iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].max;  bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Adv Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Adv Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy DIS-ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rdbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1; iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].min;  bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Dis-Adv Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Dis-Adv Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ARTIFICER ATTACK TARGET creature #####################################
######### easy SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "arth") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     spellCastMod = @player[pIndex][(@player[pIndex][10])] +1; #assigns the spell ABS mod
     abs_num_to_name(@player[pIndex][10]);           iRoll=(rand 20)+1;         profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + spellCastMod + profB;  
     if (iRoll == 20) then sayHit = "The Artificer Spell attack against Creature " + iTarget.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Artificer Spell attack against Creature " + iTarget.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a (" + @ABSname + ") SPELL attack: [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Artificer Spell attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Roll To Hit needs  arth?   ?= target (A,B,C ...)";
     end;    
        event.respond say;
end;
######### Artificer Companion ATTACK TARGET creature #####################################
######### Artificer Companion ATTACK TARGET creature #####################################
bot.message(start_with: "comp") do |event|
  theUser = "COMP!"; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     iRoll=(rand 20)+1;      mod1 = @player[pIndex][2];     profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + profB + mod1;  
     if (iRoll == 20) then sayHit = "The Artificer Companion melee against Creature " + iTarget.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Artificer Companion attack against Creature " + iTarget.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a melee attack: [" + iRoll.to_s + "] +" + mod1.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Artificer Companion attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Artificer COMPanion needs  comp?   ?= target (A,B,C ...)";
     end;    
        event.respond say;
end;

######### easy SPELL ATTACK TARGET creature #####################################
######### easy SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "srth") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod
     abs_num_to_name(@player[pIndex][10]);           iRoll=(rand 20)+1;         profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + spellCastMod + profB;  
     if (iRoll == 20) then sayHit = "The SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The SPELL attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a (" + @ABSname + ") SPELL attack: [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Spell Roll To Hit needs  srth?   ?= target number (0 to 9)";
     end;    
        event.respond say;
end;

######### easy ADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "sarth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(5,1)) rescue false;
    if ( target!= false ) then;
        if event.user.nick != nil;
           theUser = event.user.nick;
        else;
           theUser = event.user.name;
        end;
        pIndex = nil;
        (0..(@player.length-1)).each do |y|
            if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
        end;
        spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod 
        profB=@player[pIndex][8]; # Assigns Proficiency Bonus
        iRoll1 = (rand 20)+1;  iRoll2 = (rand 20)+1;    iRoll= [iRoll1,iRoll2].max;
        result = iRoll + spellCastMod + profB;
        if (iRoll == 20) then sayHit = "The SPELL Advantage attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The SPELL Advantage attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled an SPELL Advantage attack: [" + iRoll1.to_s + "][" + iRoll2.to_s + "]    [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The SPELL Advantage attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "SPELL Advantage Roll To Hit needs  sarth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

######### easy DISADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "sdrth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(5,1)) rescue false;
    if ( target!= false ) then;
        if event.user.nick != nil;
           theUser = event.user.nick;
        else;
           theUser = event.user.name;
        end;
        pIndex = nil;
        (0..(@player.length-1)).each do |y|
            if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
        end;
        spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod 
        profB=@player[pIndex][8]; # Assigns Proficiency Bonus
        iRoll1 = (rand 20)+1;  iRoll2 = (rand 20)+1;    iRoll= [iRoll1,iRoll2].min;
        result = iRoll + spellCastMod + profB;
        if (iRoll == 20) then sayHit = "The Dis-Advantage SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Dis-Advantage SPELL attack against Creature " + target.to_s + "   HIT!" end;
        say = theUser.to_s + " rolled an Dis-Advantage SPELL attack: [" + iRoll1.to_s + "][" + iRoll2.to_s + "]    [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Dis-Advantage SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "SPELL Advantage Roll To Hit  sdrth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

################## where on a humanoid body was the target hit?  ##########
#--------------------
bot.message(start_with: "!bs") do |event|
  spc = "    • ";   hdspc = "    • Head Hit! ";
  rollHit = (rand 100) + 1;  faceHit = (rand 100) + 1;
  case faceHit;
    when 1..5; fHit = hdspc + "Wound to the Nose.";
    when 6..10; fHit = hdspc + "Wound to the Right Eye";
    when 11..15; fHit = hdspc + "Wound to the Left Eye";
    when 16..25; fHit = hdspc + "Smash to the Teeth";
    when 26..30; fHit = hdspc + "Strike to Lips";
    when 31..46; fHit = hdspc + "Blow to the Jaw";
    when 47..49; fHit = hdspc + "Bash to Left Ear";
    when 50..52; fHit = hdspc + "Bash to Right Ear";
    when 53..78; fHit = hdspc + "Smash to the Forehead";
    when 79..82; fHit = hdspc + "Right Cheek";
    when 83..86; fHit = hdspc + "Left Cheek";
    when 87..100; fHit = hdspc + "Nasty Hair Skull Strike"; 
  end; 
  
  case rollHit;
    when 1..4; result = spc + "Back of head.";
    when 5..8; result = fHit;
    when 9; result = spc + "Neck Wound";
    when 10..27; result = spc + "Front Torso Wound";
    when 28..45; result = spc + "Back Torso Wound";
    when 46..54; result = spc + "Front Right Leg Wound";
    when 55..63; result = spc + "Front Left Leg Wound";
    when 64..71; result = spc + "Rear Right Leg Wound";
    when 72; result = spc + "Right Foot Wound";
    when 73..80; result = spc + "Rear Left Leg Wound";
    when 81; result = spc + "Left Foot Wound";
    when 82; result = spc + "Right Shoulder Injury";
    when 83; result = spc + "Left Shoulder Injury"; 
    when 84..86; result = spc + "Right Front Arm Wound";
    when 87; result = spc + "Right Hand Wound";
    when 88..91; result = spc + "Right Back Arm Wound";
    when 92..94; result = spc + "Left Front Arm Wound";
    when 95; result = spc + "Left Hand Wound";
    when 96..99; result = spc + "Left Back Arm Wound";
    when 100; result = spc + "Genital Groin Wound"; 
  end;
  event.respond result;
end;
#---------------

#######################################################
#######################################################
########## DAMAGE Sneak Attack Dagger d4 ##############
bot.message(start_with: "SAD2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2];
       (0..1).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (2 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Dagger d4 CRITICAL ##############
bot.message(start_with: "!SAD2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..3).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (2 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 ##############
bot.message(start_with: "SAD3") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (3 dice ) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 CRITICAL ##############
bot.message(start_with: "!SAD3") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (3 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3];
       (0..3).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (4 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7];
       (0..7).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (4 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + 
                                                                dDie[4].to_s + "][" + dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD5") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4];
       (0..4).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (5 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD5") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7,8,9];
       (0..9).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (5 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + 
                                    dDie[4].to_s + "][" + dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "][" + dDie[8].to_s +  "][" + dDie[8].to_s +  "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (6 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7,8,9,10,11];
       (0..11).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (6 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" +
                                      dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "][" + dDie[8].to_s +  "][" + dDie[9].to_s + "][" + dDie[10].to_s + "][" + dDie[10].to_s + "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

######### Ability Score Damage ######
bot.message(start_with: "absdmg") do |event|;
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  dmgRoll = (rand 10)+1;
  case dmgRoll;
    when 1..4; damage =1;
    when 5..7; damage =2;
    when 8..9; damage =3;
    when 10; damage =4;
  end;
    responseValue = @user.to_s + " Constitution Score Damage value is: " + damage.to_s;
    event.respond responseValue;
end;



########## SHILLELAGH ##############
bot.message(start_with: "shill") do |event|;
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
  if validInput == true then;
    case inputStr.slice(6,1); when "I"; abs=5; when "W"; abs=6; when "C"; abs=7; end;
    roll2hit = (rand 20) +1; profB = @player[pIndex][8]; absMod = @player[pIndex][abs]; final2hit = roll2hit + profB + absMod;  
    targetAC= @armour[target];
       responseValue = @user.to_s + " Shillelagh roll to hit: " + roll2hit.to_s + " (" + profB.to_s + "+" + absMod.to_s + ") = " + final2hit.to_s;
    else;
      responseValue = "Sorry, shill needs shill?$, where ? = target (ABC..) and $ = stat (Int, Wis, Char)";
    end;
    event.respond responseValue;
end;




########## DAMAGE Grave Bolt ##############
bot.message(start_with: ";GB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];
         end;
       totalDmg = totalDmg +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " Grave Bolt damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "]  + 3 = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Booming Blade ##############
bot.message(start_with: ";BB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 8) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + " Booming Blade damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Frost Bite ##############
bot.message(start_with: ";FB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 6) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Frost Bite damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s +
                  "\nIf target makes a CON save, no damage or effect. Failure means damage & Disadvantage on next attack.";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Shocking Grasp ##############
bot.message(start_with: ";SG") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 8) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Shocking Grasp damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Toll of the Dead ##############
bot.message(start_with: ";TD") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        lDmg = (rand 8) +1; bDmg = (rand 12) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Toll of the Dead damage: full HP:[" + lDmg.to_s + "]  or   Injured HP:[" + bDmg.to_s + "]\n" + 
                                    "Target makes a WIS save to take no damage.";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Chromatic Orb ##############
bot.message(start_with: ";CO") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 8)+1;
              totalDmg=totalDmg + dDie[x];
         end;
         lesserDmg = totalDmg - dDie[3];
         responseValue = @user.to_s + " Chromatic Orb damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + lesserDmg.to_s +
                                       "\nUp Cast damage would add [" + dDie[3].to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Dragon Breath ##############
bot.message(start_with: ";DB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];
         end;
         responseValue = @user.to_s + " Dragon Breath damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s +
                                       "\nHalf damage to target with a successful DEX save";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;


########## DAMAGE Magic Missle ##############
bot.message(start_with: ";MM") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 4)+1;
              totalDmg=totalDmg + dDie[x] + 4;
         end;
         lesserDmg = totalDmg - dDie[3] -1;
         responseValue = @user.to_s + " Magic Missile damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] +3 = " + lesserDmg.to_s + "\nUp Cast damage would add [" + dDie[3].to_s + "] +1 = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Aganazzar's Scorcher ##############
bot.message(start_with: ";AS") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 8)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " Aganazzar's Scorcher damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s + "\nTarget makes a DEX save to take half damage";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Scorching Ray ##############
bot.message(start_with: ";SR") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3,4,5]; totalDmg=0;
         (0..5).each do |x|;
              dDie[x]=(rand 6)+1;
         end;
         ray1 = dDie[0] + dDie[1];
         ray2 = dDie[2] + dDie[3];
         ray3 = dDie[4] + dDie[5];
         
         responseValue = @user.to_s + " Scorching Ray damage, for each of the three (3) rays: " + 
                                      "\n[" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + ray1.to_s +
                                      "\n[" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + ray2.to_s +
                                      "\n[" + dDie[4].to_s + "][" + dDie[5].to_s + "] = " + ray3.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE ACID vial ##############
bot.message(start_with: ";ACID") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1]; totalDmg=0;
         (0..1).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " has used Acid to cause disfiguration and damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s;
    event.respond responseValue;
end;

########## DAMAGE !ACID vial ##############
bot.message(start_with: ";!ACID") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " has used Acid with a Critical Hit: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
    event.respond responseValue;
end;

########## DAMAGE AFIRE ##############
bot.message(start_with: ";AFIRE") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0]; totalDmg=0;
         dDie[0]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0];
         responseValue = @user.to_s + " has used Alchemical Fire to cause disfiguration and damage: [" + dDie[0].to_s +  "] = " + totalDmg.to_s; + 
                                      "\nTarget keeps burning (burn baby, burn) until they use their action to extinguish the flames (DC10 Dex)";
    event.respond responseValue;
end;

########## DAMAGE !AFIRE ##############
bot.message(start_with: ";!AFIRE") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1]; totalDmg=0;
         dDie[0]=(rand 4)+1; dDie[1]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0] + dDie[1];
         responseValue = @user.to_s + " has used Alchemical Fire with a Critical Hit: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s; + 
                                      "\nTarget keeps burning (burn baby, burn) until they use their action to extinguish the flames (DC10 Dex)";
    event.respond responseValue;
end;

##########  Heat Metal 2 ##############
bot.message(start_with: "heatmetal2") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; totalDmg = theRoll1 + theRoll2;
  say = theUser.to_s + " has used\nHEAT METAL to cause (2d8) damage. CONSTITUTION saving throw...";
  say = say + "\nOn a save a hot object may be held and used at DisAdvantage. (full damage regardless).";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Heat Metal 3 ##############
bot.message(start_with: "heatmetal3") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; theRoll3 = (rand 8)+1; totalDmg = theRoll1 + theRoll2 + theRoll3;
  say = theUser.to_s + " has used\nHEAT METAL to cause (3d8) damage. CONSTITUTION saving throw...";
  say = say + "\nOn a save a hot object may be held and used at DisAdvantage. (full damage regardless).";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] + [" + theRoll3.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Thunder Wave ##############
bot.message(start_with: "thunderwave2") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; totalDmg = theRoll1 + theRoll2;
  say = theUser.to_s + " has used\nTHUNDERWAVE to cause (2d8) damage. CONSTITUTION saving throw.";
  say = say + "\nOn a failed save they will be pushed 10 ft away from caster.";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Thunder Wave 3##############
bot.message(start_with: "thunderwave3") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; theRoll3 = (rand 8)+1; totalDmg = theRoll1 + theRoll2 + theRoll3;
  say = theUser.to_s + " has used\nTHUNDERWAVE to cause (3d8) damage. CONSTITUTION saving throw.";
  say = say + "\nOn a failed save they will be pushed 10 ft away from caster.";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] + [" + theRoll3.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;
##########  Healing Word ##############
bot.message(start_with: "healingword") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputValue = event.content;
  absMod = @player[pIndex][6];
  theRoll = (rand 4)+1; totalHeal = theRoll + absMod;
  responseValue = theUser.to_s + " has used\nHealing Word (1d4) to heal someone for: [" + theRoll.to_s +  "] + " + absMod.to_s + " = " + totalHeal.to_s + " HP";
  event.respond responseValue;
end;

################## g20. gm roll d20  ##########################
bot.message(contains:"g20.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("g20.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " g20. requires  g20.  OR   ?g20.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d20 " + " + ?\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 20)+1+@gmBonus;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       say = say + "   REASON: " + comment;
       say = say + "\n= = = = = = = = = = = = = = =";
       event.message.delete;  
    end;
    event.respond say;
end;


################## d24. ##########################
bot.message(contains:"d24.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("d24.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d24. requires  ?d24.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d24 " ++ " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 24)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "\nREASON: " + comment;
    end;
    event.respond say;
end;

################## d100. ##########################
bot.message(contains:"d100.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d100.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d100. requires  d100.  OR   ?d100.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d100" + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 100)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n- - - - - - - - - - - - - -";
    end;
    event.respond say;
end;

################## d500. ##########################
bot.message(contains:"d500.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d500.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d500. requires  d500.  OR   ?d500.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d500" + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 500)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "\nREASON: " + comment;
    end;
    event.respond say;
end;

################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
bot.message(contains:"D500.") do |event|
    event.message.delete;  say = "SHIT";
    check_user_or_nick(event);  @tempVar = event.content;  comment = "Unknown";  blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    locationValue = @tempVar.index('D500.');
    chkNum = Integer(locationValue) rescue false;
    if ( chkNum == false ) then;
      say = "Busted: " + chkNum.to_s;
    else;
         if chkNum > 0 then;
            howManyDice = @tempVar.slice(0,(locationValue.to_i));
            puts howManyDice.to_s + "     <----";
            say = @user.to_s + " rolled " + howManyDice.to_s + "D500." + " + " + @whatPlus.to_s + "\n";
            die=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; total=0;
            (0..(howManyDice.to_i)).each do |x|;
               die[x]=(rand 500)+1;
               say = say + "[" + die[x].to_s + "]";
               total=total + die[x];
            end;
            total = total + @whatPlus;
            say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
            say = say + "\nREASON: " + comment;
         else;
            say = "Only rolled one."
         end;      
    end;
    event.respond say;
end;


####### parse_the_d accepts and incoming value of something like d20. to help location the core of the command
def parse_the_d(incoming);
  #puts "the value of @tempVar is: " + @tempVar.inspect;
  theIndex1 = @tempVar.index(incoming).to_i;          #puts "The Index Value: " + theIndex1.to_s;
  if theIndex1 == false then; theIndex1 = 1; end;     #puts " the value of theIndex1 is: " + theIndex1.inspect;
  @howManyDice = Integer(@tempVar.slice(0,(theIndex1))) rescue false;
  if @howManyDice == false then; @howManyDice = 1; end; #puts "the value of @howManyDice is: " + @howManyDice.inspect;
  if ( @howManyDice == "0" || @howManyDice == "" ) then @howManyDice = 1; end; #puts "the value of @tempVar is: " + @tempVar.inspect;
  theIndex2 = @tempVar.index('.');         #puts "the value of theIndex2 is: " + theIndex2.inspect;
  tempVarLen = @tempVar.length;            #puts "the value of tempVarLen  is: " + tempVarLen.inspect;
  if @tempVar.slice((theIndex2+1),1) != nil then;
     @whatPlus = @tempVar.slice((theIndex2+1),(tempVarLen-theIndex2));
  else 
    @whatPlus = 0;
  end;
  validate_integer(@whatPlus);
  if @intVal == false then; 
     @whatPlus = 0;
  else;
    @whatPlus = Integer(@whatPlus);
  end;
end;

#########################################
###########  WEAPONS  ##############
#########################################
bot.message(start_with:"$Wlist") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;  pIndex = nil;
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    say = "Greetings, " + theUser + "\n";
    say = say + "Your MELEE weapon damage: " + @weapon[(@player[pIndex][1])].to_s + "\n";
    say = say + "Your RANGED weapon damage: " + @weapon[(@player[pIndex][12])].to_s + "\n";
    say = say +  "To change use   $Mset? (melee)   or   $Rset?  (ranged)  \n";
    say = say +  "where ? is an Integer, as shown below. ($Mset3  or  $Rset3)  \n\n";
    (0..7).each do |x|;
          say = say + "[" + @weapon[x] + " = " + x.to_s  + "]   ";
    end;                 
    event.respond say;
end;

bot.message(start_with:"$Mset") do |event|
    inputStr = event.content; # this should contain "$Wset#" where # is a single digit
    if event.user.nick != nil
      theUser = event.user.nick
    else
      theUser = event.user.name
    end
    pIndex = nil;  #fetch the value of @user & set pIndex
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    weaponInt = Integer(inputStr.slice(5,1)) rescue false; #will detect integer or non integer input
    if (pIndex != nil) && (weaponInt != false) && (weaponInt < 8) then; 
           @player[pIndex][1]=weaponInt;
           say = theUser.to_s + " MELEE weapon damage has been set to " + @weapon[(@player[pIndex][1])].to_s;
    else
       say = "Please try: $Mset?  where ? is a single number ( 0 to 5 )"; 
    end;
    event.respond say;
end;

bot.message(start_with:"$Rset") do |event|
    inputStr = event.content; # this should contain "$Wset#" where # is a single digit
    if event.user.nick != nil
      theUser = event.user.nick
    else
      theUser = event.user.name
    end
    pIndex = nil;  #fetch the value of @user & set pIndex
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    weaponInt = Integer(inputStr.slice(5,1)) rescue false; #will detect integer or non integer input
    if (pIndex != nil) && (weaponInt != false) && (weaponInt < 8) then; 
           @player[pIndex][12]=weaponInt;
           say = theUser.to_s + " RANGED weapon damage has been set to " + @weapon[(@player[pIndex][12])].to_s;
    else
       say = "Please try: $Mset?  where ? is a single number ( 0 to 5 )"; 
    end;
    event.respond say;
end;

####### GET THE PLAYER INDEX ##########
def get_the_player();
    player5Char = @user.slice(0,5); #taking first 5 characters of @user
    y=0; #used to track the current index value for the array
    @player.each do |x|;
           if x[0] == player5Char then; # find the player Index matching player5Char
              @playerIndex = y;
           end;
      y=y+1
    end;
end;

#########################################
###########  Armour Class  ##############
#########################################
bot.message(start_with:"$AClist") do |event|
    check_user_or_nick(event); say = "";
    if @user.slice(0,5) == "Allen" then; # as long as the user is Allen, perform the following
            (0..19).each do |x|;
                acVal = @armour[x].to_s;
                alphaVal = "ABCDEFGHIJKLMNOPQRSTU"[x];
                say = say + "Creature " + alphaVal + "  (" + x.to_s + ")  currently has " + acVal + " Armour Class. \n";
            end;           
    end;
    event.respond say;
end;

bot.message(start_with:"$ACset") do |event|
    check_user_or_nick(event);
    creatAC= false;
    inputStr = event.content.slice(6,3);   # creature Number and AC should be in the string
    strLength = inputStr.length;
    creatNum = inputStr.slice(0,1); 
    if strLength == 3 then;
       creatAC = inputStr.slice(1,2); 
    end;
    if strLength == 2 then;
       creatAC = inputStr.slice(1,1);
    end;
    cNum = Integer(creatNum) rescue false; #creature Number
    acVal = Integer(creatAC) rescue false;  #Value of AC
    if (  (cNum != false) && (acVal != false) && (@user.slice(0,5) == "Allen") ) then;
          @armour[cNum]=acVal;
          say = "Armour Class for Creature " + cNum.to_s + " was set to AC: " + acVal.to_s;
    else;
      say = @user.to_s + " , these is something wrong. \n cNum:" + cNum.to_s + " acVal:" + acVal.to_s + " inputStr:" + inputStr.to_s;   
      say = say + "  input length:" + (inputStr.length).to_s;
    end;
    event.respond say;
end;

bot.message(start_with:"$ACall") do |event|
    check_user_or_nick(event);
    theString = event.content;
    acVal = Integer(theString.slice(6,2)) rescue false
    if ( (@user.slice(0,5) == "Allen") && (acVal != false) ) then;
             (0..19).each do |x|;
                  @armour[x]=acVal.to_i;
             end;
             say = "ALL creatures now have an AC of: " + acVal.to_s;
    else;     
     say = @user.to_s + ", Something isn't right:" + acVal.to_s;
    end;
    event.respond  say;
end;


bot.message(start_with:"$HPlist") do |event|
    check_user_or_nick(event); say = "";
    if @user.slice(0,5) == "Allen" then; # as long as the user is Allen, perform the following
            (0..19).each do |x|;
                hpVal = @HP[x][0].to_s;
                alphaVal = "ABCDEFGHIJKLMNOPQRSTU"[x];
                say = say + "Creature " + alphaVal + "  (" + x.to_s + ")  currently has " + hpVal + " hit points. \n";
            end;           
    end;
    event.respond say;
end;

bot.message(start_with:"$HPset") do |event|
    check_user_or_nick(event);
    inputStr = event.content.slice(6,4);   # creature Number and AC should be in the string
    creatNum = inputStr.slice(0,1); creatHP = inputStr.slice(1,3); 
    cNum = Integer(creatNum) rescue false; #creature Number
    hpVal = Integer(creatHP) rescue false;  #Value of HP
    if ( (inputStr.length > 1) && (cNum != false) && (hpVal != false) && (@user.slice(0,5) == "Allen") ) then;
          @HP[cNum][0]=hpVal;  @HP[cNum][1]= hpVal + 0.0;
          say = "Hit Points for Creature " + cNum.to_s + " was set to: " + hpVal.to_s + "  " + (hpVal + 0.0).to_s;
    else;
      say = @user.to_s + "$HPset?? where first ? is Target Integer and second ? is the HP integers."
    end;
    event.respond say;
end;

bot.message(start_with:"$HPall") do |event|
    check_user_or_nick(event);  theString = event.content;
    hpVal = Integer(theString.slice(6,3)) rescue false
    if ( (@user.slice(0,5) == "Allen") && (hpVal != false) ) then;
             (0..19).each do |x|;
                  @HP[x][0]=hpVal.to_i;
                  @HP[x][1]=(hpVal.to_i)+0.1;
             end;
             say = "ALL creatures now have HP of: " + hpVal.to_s;
    else;     
     say = @user.to_s + ", Something isn't right:" + hpVal.to_s;
    end;
    event.respond  say;
end;


################# Character Generator #########################
bot.message(start_with:"charGen") do |event|
    check_user_or_nick(event); say="";
    results = [0,0,0,0,0,0];   rolls = [0,0,0,0];   bigTotal = 0; total = 0;
       (0..5).each do |z|;
            (0..3).each do |y|;
               rolls[y]= SecureRandom.random_number(6)+1;
               total = total + rolls[y];
            end;
            minimum = rolls.min;
            results[z] = rolls[0]+rolls[1]+rolls[2]+rolls[3]-minimum;
            bigTotal = bigTotal + results[z]; 
            say = say + "[" + rolls[0].to_s + "]" + "[" + rolls[1].to_s + "]" + "[" + rolls[2].to_s + "]" + "[" + rolls[3].to_s + "]" + " = " + results[z].to_s + "\n";
       end;
       say = say + "Average: " + ('%.2f' % (bigTotal/6.0)).to_s; 
    event.respond say;
end;


################## RELENTLESS ENDURANCE ###############################
bot.message(start_with:"RELE") do |event|
    check_user_or_nick(event);
       inputStr = event.content.slice(4,1);   # creature Number and DAMAGE should be in the string
       creatNum = Integer(inputStr.slice(0,1));
       @RE[creatNum] = 1;
       say = "creature " + creatNum.to_s + " Relentless Endurance reset to 1.";
    event.respond say;
end;


########## CHAOS 
bot.message(start_with:"boon") do |event|
  say = ""
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;
    timeText = (DateTime.now).to_s;
    hour = timeText.slice(11,2);
    min = timeText.slice(14,2);    
    if ( hour == "12") && (min.to_i < 56) then;
       result = rand 11;
       case result;
           when 0; say = say + "You have two (2) additional recovery Hit Dice until you long rest.";
           when 1; say = say + "You have +2 on all saving throws until you long rest.";
           when 2; say = say + "You do +2 damage on all hits until you roll a Natural 20."
           when 3; say = say + "You get +2 on all heal dice until you long rest."
           when 4; say = say + "You may re-roll 1 on a SAVE or SKILL check until you long rest."
           when 5; say = say + "You add +2 to all SKILL checks until you long rest."
           when 6; say = say + "You roll with advantage on SKILL checks until you long rest."
           when 7; say = say + "You may re-roll all the one (1) values on MELEE damage rolls until you long rest."
           when 8; say = say + "You have INSPIRATION X 5.";
           when 9; say = say + "You have three (3) automatic hits for this game." 
           when 10; say = say + "Your character is able to cast SCORCHING RAY (+7 to hit) three (3) times this game." 
       end;
       say = "This boon replaces any and all previous boons.\n" + theUser + ", your Boon is " + say;
     else
       say = "The time is " + hour + ":" + min + " the Boon opportunity ended at 12:55 am"
     end;
    event.respond say;
end;


def get_the_player();
    player5Char = @user.slice(0,5); #taking first 5 characters of @user
    y=0; #used to track the current index value for the array
    @player.each do |x|;
           if x[0] == player5Char then; # find the player Index matching player5Char
              @playerIndex = y;
           end;
      y=y+1
    end;
end;

######## ABS score modifier is asigned a name
def abs_num_to_name(numb)
  case numb
      when 2; @ABSname = "Strength";
      when 3; @ABSname = "Dexterity";
      when 4; @ABSname = "Constitution";
      when 5; @ABSname = "Intelligence";
      when 6; @ABSname = "Wisdom";
      when 7; @ABSname = "Charisma";
  end;
end;


def roll_damage(damType);
  case damType;
     when "2d6"; @damage1 = (rand 6)+1; @damage2 = (rand 6)+1; @damage3 = (rand 6)+1; @damage4 = (rand 6)+1;
     when "1d12"; @damage1 = (rand 12)+1; @damage2 = -99; @damage3 = (rand 12)+1; @damage4 = -99;
     when "1d10"; @damage1 = (rand 10)+1; @damage2 = -99; @damage3 = (rand 10)+1; @damage4 = -99;
     when "1d8"; @damage1 = (rand 8)+1; @damage2 = -99; @damage3 = (rand 8)+1; @damage4 = -99;
     when "1d6"; @damage1 = (rand 6)+1; @damage2 = -99; @damage3 = (rand 6)+1; @damage4 = -99;
     when "1d4"; @damage1 = (rand 4)+1; @damage2 = -99; @damage3 = (rand 4)+1; @damage4 = -99;
     when "2d4"; @damage1 = (rand 4)+1; @damage2 = (rand 4)+1; @damage3 = (rand 4)+1; @damage4 = (rand 4)+1;
  end;
end;


bot.run