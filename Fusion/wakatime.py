#!/usr/bin/env python
import importlib
import os
import sys
import time
import subprocess

sys.path.append('/opt/BlackmagicDesign/Fusion18')

import fusionscript

pluginName = "fusion-wakatime"
version = "0.0.1"

USER_HOME = os.path.expanduser("~")
CONFIG_FILENAME = os.path.join(USER_HOME, ".wakatime.cfg")

fusion = fusionscript.scriptapp('Fusion')

def fusion_is_focused():
  output = subprocess.check_output('xdotool getwindowfocus getwindowname', shell=True)
  windowName = output.decode()
  if "Fusion" in windowName:
    return True

  return False

while True:
  composition = fusion.CurrentComp
  attributes = composition.GetAttrs()
  fileName = attributes['COMPS_FileName']
  if fusion_is_focused():
    if fileName is not None:
      cmd = f"wakatime \
              --entity-type file \
              --entity \"{fileName}\" \
              --plugin \"{pluginName}/{version}\"\
              --category designing \
              --config \"{CONFIG_FILENAME}\""

      os.system(cmd)

  time.sleep(30)
