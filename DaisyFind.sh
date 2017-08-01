# DaisyFind

# This program searches the Daisy stock of the DZB and DBB by keywords

# Copyright (c) 2017  Falk Rismansanj

# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.

echo ""
echo "*** Welcome to DaisyFind! ***"
echo "** Version: 1.0 by z1tr0t3c - http://zitrotec.de **"
echo ""
sleep 3
echo "--->> Checking Enviroment..."

echo -e "GET https://google.de HTTP/1.0\n\n" | nc google.de 80 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo ""
    echo "--->> NETWORK: OK, Connected!"
else
    echo ""
    echo "--->> NETWORK: Failed! Please ensure you are online."
    echo ""
    exit
fi

command -v curl >/dev/null

if [[ $? -eq 0 ]]; then
  echo ""
  echo "--->> SYSTEM 1/2: OK, curl is installed!"
else
  echo ""
  echo "--->> SYSTEM 1/2: ERROR, please install curl first!"
  echo ""
  exit
fi

command -v links >/dev/null

if [[ $? -eq 0 ]]; then
  echo ""
  echo "--->> SYSTEM 2/2: OK, links is installed!"
  echo ""
else
  echo ""
  echo "--->> SYSTEM 2/2: ERROR, please install links first!"
  echo ""
  exit
fi

echo -n "Type in the first name of the author for your searched daisybook ONLY ONE WORD --->> "
read k1
echo -n "Type in the last name of the author for your searched daisybook ONLY ONE WORD --->> "
read k2
echo -n "Type in ONLY ONE KEYWORD for your searched daisybook --->> "
read k3
echo ""
echo "--->> Searching for $k1 $k2 $k3 ..."
echo ""
echo ""

webserv="https://www.dzb.de/index.php?site_id=2.2.2.4&s=$k1+$k2+$k3"

if curl -s "$webserv" | grep "$k1 $k2 $k3"
then
    echo ""
    echo "--->> DZB: SUCESS, daisybook $k1 $k2 $k3 found!"
    read -p "Do you want to open it now? [y/n] --->> " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "--->> You can close links with q."
    sleep 3
    links "https://www.dzb.de/index.php?site_id=2.2.2.4&s=$k1+$k2+$k3"
    clear


    webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

    if curl -s "$webserv" | grep "keinen Treffer"
    then
      echo ""
      echo "--->> DBB: ERROR, daisybook $k1 $k2 $k3 not found!"
      echo ""
    else
      echo ""
      echo "--->> DBB: SUCESS, daisybook $k1 $k2 $k3 found!"
      read -p "Do you want to open it now? [y/n] --->> " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo ""
      echo "--->> You can close links with q."
      sleep 3
      links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
      echo "Bye!"
  else
    echo ""
    echo "Bye!"
    echo ""
    exit
  fi
    fi



else
  webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

  if curl -s "$webserv" | grep "keinen Treffer"
  then
    echo ""
    echo "--->> DBB: ERROR, daisybook $k1 $k2 $k3 not found!"
    echo ""
  else
    echo ""
    echo "--->> DBB: SUCESS, daisybook $k1 $k2 $k3 found!"
    read -p "Do you want to open it now? [y/n] --->> " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "--->> You can close links with q."
    sleep 3
    links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
    echo "Bye!"
else
  echo ""
  echo "Bye!"
  echo ""
  exit
fi
  fi
fi
else
    echo ""
    echo "--->> DZB: ERROR, daisybook $k1 $k2 $k3 not found!"
    echo ""



    webserv="http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"

if curl -s "$webserv" | grep "keinen Treffer"
    then

      echo ""
      echo "--->> DBB: ERROR, daisybook $k1 $k2 $k3 not found!"
      echo ""

    else
      echo ""
      echo "--->> DBB: SUCESS, daisybook $k1 $k2 $k3 found!"
      read -p "Do you want to open it now? [y/n] --->> " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo ""
      echo "--->> You can close links with q."
      sleep 3
      links "http://www.katalog.blista.de/allegro/xnull/xnull/xnull/xnull/xnull/xnull/$k1+$k2+$k3/xnull/0000/xnull/25/0"
      echo "Bye!"
  else
    echo ""
    echo "Bye!"
    echo ""
    exit
  fi
    fi



fi
