#!/bin/bash
#
# gitwait - watch file and git commit all changes as they happen
#

while true; do
  inotifywait -qq -e CLOSE_WRITE ~/Desktop/projecteuler/lychrel_quest.txt
  git add . ; git commit -a -m 'autocommit on change'; git push
done