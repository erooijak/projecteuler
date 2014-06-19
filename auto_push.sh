#!/bin/bash
#
# gitwait - watch file and git commit all changes as they happen
#

while true; do
  git add . ; git commit -a -m 'autocommit every two hours'; git push
  sleep 7200
done