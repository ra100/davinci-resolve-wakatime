#!/usr/bin/env python
import importlib
import os
import sys
import time

pluginName = "davinci-resolve-wakatime"
version = "0.0.1"

USER_HOME = os.path.expanduser("~")
CONFIG_FILENAME = os.path.join(USER_HOME, ".wakatime.cfg")

pathlib = '/opt/resolve/libs/Fusion/fusionscript.so'
spec = importlib.util.spec_from_file_location('fusionscript', pathlib)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

resolve = module.scriptapp('Resolve')
projectManager = resolve.GetProjectManager()

project = projectManager.GetCurrentProject()

while True:
    if project is not None:
        projectName = project.GetName()
        currentPage = resolve.GetCurrentPage()
        if currentPage is not None:
            cmd = f"wakatime --project \"{projectName}\" \
                            --entity-type domain \
                            --entity \"{currentPage}\" \
                            --plugin \"{pluginName}/{version}\"\
                            --category designing \
                            --config \"{CONFIG_FILENAME}\""
            print(cmd)
            os.system(cmd)

    # wait for 60 seconds before running the loop again
    time.sleep(30)