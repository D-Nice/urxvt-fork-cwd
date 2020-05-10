#!/bin/bash

# script to open CWD of a focused window, @ its
# most deepest bash child process.
# currently built for urxvt - bash setup, but should
# be easily modifiable for any other

# credits to Victor
# https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/
# for inspiring parts of this script
exec &>/dev/null

ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
PID=$(xprop -id "$ID" | grep -m 1 PID | cut -d " " -f 3)

# get lowest bash child process of focused
while [ -z "$TPID" ]
do
  # analyze the process chain, and find deepest bash PID
  TPID=$(pstree -g | grep "$PID" | grep -Po "bash\(\d+\)" | tail -1 | grep -Po "(?<=\()\d+(?=\))")
  PID=$(pgrep -P "$PID" 2> /dev/null)
  # if we ran out of child PIDs or some other pgrep error
  # let's break the loop
  if [ $? -ne 0 ]
  then
    break
  fi
done

# if we've got PID with cwd, let's use it
# else start at home like normal
if [ -e "/proc/$TPID/cwd" ]
then
  urxvt -cd "$(readlink /proc/"$TPID"/cwd)" &
else
  urxvt &
fi
