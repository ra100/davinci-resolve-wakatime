#!/usr/bin/env -S /opt/BlackmagicDesign/Fusion18/fuscript -l lua
local pluginName = "fusion-studio-wakatime"
local version = "1.0.0"
local DEBUG = true

fusion = fu

if fusion == nil then
  fusion = Fusion()
end

local USER_HOME = os.getenv("HOME")

function log(message)
  if DEBUG then
    print(message)
  end
end

function get_wakatime_path()
  return USER_HOME .. "/.wakatime/wakatime-cli-linux-amd64"
end

function hearbeat()
  log('Trying to send a heartbeat')
  local composition = fusion.CurrentComp
  if composition ~= nil then
    local attributes = composition:GetAttrs()
    local fileName = attributes.COMPS_FileName
    if fileName ~= "" then
      local fusionVersion = fusion:GetAttrs().FUSIONS_Version
      local wakatimePath = get_wakatime_path()
      local cmd = string.format("%s \\\
              --entity-type file \\\
              --entity \"%s\" \\\
              --plugin \"Fusion Studio/%s %s/%s\" \\\
              --language Fusion \\\
              --verbose \\\
              --category designing",
              wakatimePath, fileName, fusionVersion, pluginName, version)
      log(cmd)
      os.execute(cmd)
    end
  else
    log('Composition is nil')
  end
end

hearbeat()