local function getScript(URL)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/Cadez650/VapeCustom/main/'..url, true))()
end

local mainVape = loadstring(getScript('best.lua'))

print('Vape Custom: Loading Vape Custom...')