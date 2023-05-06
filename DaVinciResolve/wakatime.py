#!/usr/bin/env python
import os
import subprocess
import sys
import time

sys.path.append('/opt/resolve/Developer/Scripting/Modules')

import DaVinciResolveScript

pluginName = "davinci-resolve-wakatime"
version = "0.0.1"

USER_HOME = os.path.expanduser("~")
CONFIG_FILENAME = os.path.join(USER_HOME, ".wakatime.cfg")

resolve = DaVinciResolveScript.scriptapp('Resolve')
projectManager = resolve.GetProjectManager()

def resolve_is_focused():
  output = subprocess.check_output('xdotool getwindowfocus getwindowname', shell=True)
  windowName = output.decode()
  if "DaVinci Resolve" in windowName:
    return True

  return False

while True:
  if resolve_is_focused():
    project = projectManager.GetCurrentProject()
    if project is not None:
      projectName = project.GetName()
      currentPage = resolve.GetCurrentPage()
      if currentPage is not None:
        cmd = f"wakatime \
                --project \"{projectName}\" \
                --entity-type domain \
                --entity \"{currentPage}\" \
                --plugin \"{pluginName}/{version}\"\
                --category designing \
                --config \"{CONFIG_FILENAME}\""

        os.system(cmd)

  time.sleep(30)