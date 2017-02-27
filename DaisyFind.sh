# DaisyFind
# This program searches the Daisy stock of the DZB and DBB by keywords

# Copyright (C) 2017  Falk Rismansanj

# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.

txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Red
bldgrn=${txtbld}$(tput setaf 2) # Green
bldblu=${txtbld}$(tput setaf 4) # Blue
txtrst=$(tput sgr0)             # Reset


echo ""
echo "${txtbld}*** Welcome to DaisyFind! ***${txtrst}"
echo "${txtbld}** Version: 1.0 by z1tr0t3c - http://zitrotec.de **${txtrst}"
echo ""
sleep 3
echo "${bldblu}--->>${txtrst} ${txtbld}Checking Enviroment...${txtrst}"

echo -e "GET https://google.de HTTP/1.0\n\n" | nc google.de 80 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo ""
    echo "${bldblu}--->>${txtrst} ${bldgrn}NETWORK 1/1: OK, Connected!${txtrst}"
else
    echo ""
    echo "${bldblu}--->>${txtrst} ${bldred}NETWORK 1/1: Failed! Please ensure you are online.${txtrst}"
    echo ""
    exit
fi

command -v curl >/dev/null

if [[ $? -eq 0 ]]; then
  echo ""
  echo "${bldblu}--->>${txtrst} ${bldgrn}SYSTEM 1/2: ${bldgrn}OK,${txtrst} ${bldblu}curl${txtrst} ${bldgrn}is installed!${txtrst}"
else
  echo ""
  echo "${bldblu}--->>${txtrst} ${bldred}SYSTEM 1/2: ERROR, please install${txtrst} ${bldblu}curl${txtrst} ${bldred}first!${txtrst}"
  echo ""
  exit
fi

command -v links >/dev/null

if [[ $? -eq 0 ]]; then
  echo ""
  echo "${bldblu}--->>${txtrst} ${bldgrn}SYSTEM 2/2: ${bldgrn}OK,${txtrst} ${bldblu}links${txtrst} ${bldgrn}is installed!${txtrst}"
  echo ""
else
  echo ""
  echo "${bldblu}--->>${txtrst} ${bldred}SYSTEM 2/2: ERROR, please install${txtrst} ${bldblu}links${txtrst} ${bldred}first!${txtrst}"
  echo ""
  exit
fi

echo -n "Type in the ${bldblu}first name${txtrst} of the ${bldblu}author${txtrst} for your searched daisybook ${bldblu}ONLY ONE WORD${txtrst} ${bldblu}--->>${txtrst} "
read k1
echo -n "Type in the ${bldblu}last name${txtrst} of the ${bldblu}author${txtrst} for your searched daisybook ${bldblu}ONLY ONE WORD${txtrst} ${bldblu}--->>${txtrst} "
read k2
echo -n "Type in ${bldblu}ONLY ONE KEYWORD${txtrst} for your searched daisybook ${bldblu}--->>${txtrst} "
read k3
echo ""
echo "${bldblu}--->>${txtrst} ${txtbld}Searching for${txtrst} ${bldblu}$k1 $k2 $k3${txtrst} ${txtbld}...${txtrst}"
echo ""
echo ""

webserv="https://www.dzb.de/index.php?site_id=2.2.2.4&s=$k1+$k2+$k3"

if curl -s "$webserv" | grep "$k1 $k2 $k3"
then
    echo ""
    echo "${bldgrn}--->>${txtrst} ${bldblu}DZB:${txtrst} ${bldgrn}SUCESS, daisybook ${bldblu}$k1 $k2 $k3${txtrst} ${bldgrn}found!${txtrst}"
    read -p "Do you want to open it now? [${bldgrn}y${txtrst}/${bldred}n${txtrst}] ${bldblu}--->>${txtrst} " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "${bldblu}--->>${txtrst} ${txtbld}You can close links with${txtrst} ${bldblu}q.${txtrst}"
    sleep 3
    links "https://www.dzb.de/index.php?site_id=2.2.2.4&s=$k1+$k2+$k3"
    clear


    webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

    if curl -s "$webserv" | grep "keinen Treffer"
    then
      echo ""
      echo "${bldred}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldred}ERROR, daisybook ${txtrst} ${bldblu}$k1 $k2 $k3${txtrst} ${bldred}not found! Try different keywords instead.${txtrst}"
      echo ""
    else
      echo ""
      echo "${bldgrn}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldgrn}SUCESS, daisybook ${bldblu}$k1 $k2 $k3${txtrst} ${bldgrn}found!${txtrst}"
      read -p "Do you want to open it now? [${bldgrn}y${txtrst}/${bldred}n${txtrst}] ${bldblu}--->>${txtrst} " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo ""
      echo "${bldblu}--->>${txtrst} ${txtbld}You can close links with${txtrst} ${bldblu}q.${txtrst}"
      sleep 3
      links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
      echo "${txtbld}Bye!${txtrst}"
  else
    echo ""
    echo "${txtbld}Bye!${txtrst}"
    echo ""
    exit
  fi
    fi



else
  webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

  if curl -s "$webserv" | grep "keinen Treffer"
  then
    echo ""
    echo "${bldred}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldred}ERROR, daisybook ${txtrst} ${bldblu}$k1 $k2 $k3${txtrst} ${bldred}not found! Try different keywords instead.${txtrst}"
    echo ""
  else
    echo ""
    echo "${bldgrn}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldgrn}SUCESS, daisybook ${bldblu}$k1 $k2 $k3${txtrst} ${bldgrn}found!${txtrst}"
    read -p "Do you want to open it now? [${bldgrn}y${txtrst}/${bldred}n${txtrst}] ${bldblu}--->>${txtrst} " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "${bldblu}--->>${txtrst} ${txtbld}You can close links with${txtrst} ${bldblu}q.${txtrst}"
    sleep 3
    links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
    echo "${txtbld}Bye!${txtrst}"
else
  echo ""
  echo "${txtbld}Bye!${txtrst}"
  echo ""
  exit
fi
  fi
fi
else
    echo ""
    echo "${bldred}--->>${txtrst} ${bldblu}DZB:${txtrst} ${bldred}ERROR, daisybook ${txtrst} ${bldblu}$k1 $k2 $k3${txtrst} ${bldred}not found! Try different keywords instead.${txtrst}"
    echo ""



    webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

if curl -s "$webserv" | grep "keinen Treffer"
    then

      echo ""
      echo "${bldred}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldred}ERROR, daisybook ${txtrst} ${bldblu}$k1 $k2 $k3${txtrst} ${bldred}not found! Try different keywords instead.${txtrst}"
      echo ""

    else
      echo ""
      echo "${bldgrn}--->>${txtrst} ${bldblu}DBB:${txtrst} ${bldgrn}SUCESS, daisybook ${bldblu}$k1 $k2 $k3${txtrst} ${bldgrn}found!${txtrst}"
      read -p "Do you want to open it now? [${bldgrn}y${txtrst}/${bldred}n${txtrst}] ${bldblu}--->>${txtrst} " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo ""
      echo "${bldblu}--->>${txtrst} ${txtbld}You can close links with${txtrst} ${bldblu}q.${txtrst}"
      sleep 3
      links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
      echo "${txtbld}Bye!${txtrst}"
  else
    echo ""
    echo "${txtbld}Bye!${txtrst}"
    echo ""
    exit
  fi
    fi



fi
