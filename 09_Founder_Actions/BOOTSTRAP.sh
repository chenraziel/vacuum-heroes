#!/usr/bin/env bash
# Run on founder machine after installing git
set -e
echo "VACUUM HEROES bootstrap"
if [ -d vacuum-heroes ]; then
  cd vacuum-heroes && git pull && echo "Updated."
else
  git clone https://github.com/chenraziel/vacuum-heroes.git
  echo "Cloned. Open Godot → Import → select folder OR New Project and copy 05_Godot/scripts"
fi
echo "Next: open 09_Founder_Actions/DAY1_EXACT_STEPS_HE.md"
