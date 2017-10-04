#!/usr/local/bin/bash
#######################################
# for mac os x you may need to enable #
# shopt -s extglob                    #
#######################################
sep='##########'
localpath=`pwd`
for x in */; do
  if
    [ "$x" == "classroom-control-pi/" ] || \			                # List of repos you don’t want
    [ "$x" == "classroom-control-vf/" ] || \			                # to auto-update
    [ "$x" == "classroom-control-vp/" ] ; then
    continue;
  fi
  x=`echo $x | sed s#/##`                                         #Get repo name from base directory structure
  header="$(tput setaf 1)$sep Processing $x $d$sep$(tput sgr0)"   #Set header for printing repo info
  head=`git -C $localpath/$x rev-parse --abbrev-ref HEAD`         #Set head name
  hash=`git -C $localpath/$x rev-parse HEAD`                      #Set head hash
  echo $header                                                    #Print header
  cd $localpath/$x                                                #Change directory to working repo
  remote=`git ls-remote upstream -h $head \
    $(git rev-parse --abbrev-ref @{u}|sed 's/\// /g') | cut -f1`  #Set upstream hash for comparison
  git -C $localpath/$x checkout master                            #Ensure your on the HEAD
  if [ $hash == $remote ];                                        #Compare local hash to upstream hash
  then
    echo "$(tput setaf 2)Everything is up to date$(tput sgr0)"    #Print if nothing needs to update
  else                                                            #else pull updates and update remote
    git -C $localpath/$x pull upstream master
    git -C $localpath/$x push --all origin -u
  fi
  cd ..
done
