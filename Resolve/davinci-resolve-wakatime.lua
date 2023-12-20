local pluginName = "davinci-resolve-wakatime"
local version = "1.0.1"
local DEBUG = true

resolve = Resolve()

local USER_HOME = os.getenv("HOME")

local categoryMap = {
  ["media"] = "researching",
  ["cut"] = "designing",
  ["edit"] = "designing",
  ["fusion"] = "coding",
  ["color"] = "designing",
  ["fairlight"] = "designing",
  ["deliver"] = "building",
  ["*"] = "designing"
}

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
  local projectManager = resolve:GetProjectManager()
  local project = projectManager:GetCurrentProject()
  if project ~= nil then
    local projectName = project:GetName()
    local currentPage = resolve:GetCurrentPage()
    if currentPage ~= nil then
      local resolveVersion = resolve:GetVersionString()
      local wakatimePath = get_wakatime_path()
      local category = categoryMap[currentPage] or categoryMap["*"]
      local cmd = string.format("%s --project \"%s\" --entity-type domain --entity \"%s\" --plugin \"DaVinci Resolve/%s %s/%s\" --language \"%s\" --verbose --category %s", wakatimePath, projectName, currentPage, resolveVersion, pluginName, version, currentPage, category)
      log(cmd)
      os.execute(cmd)
    end
  end
end

hearbeat()