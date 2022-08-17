#!/bin/sh

# update-website.sh version 3.2.0

scripts/genrecords.sh > /var/git/tns-nomic-records/README.org
cd /var/git/tns-nomic-records
git add README.org
git commit -m "$*"
git push
../org2html/org2html < README.org > /var/www/htdocs/nomic/scoreboard.html
