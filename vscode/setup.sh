#!/usr/bin/env bash


yes | cp settings.json ~/.config/Code/User/settings.json

cat extensions.txt | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done
