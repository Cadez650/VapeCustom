local function getScript(URL)
    print('https://raw.githubusercontent.com/Cadez650/VapeCustom/main/'..url)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/Cadez650/VapeCustom/main/'..url, true))
end

local mainVape = getScript('best.lua')

print('Vape Custom: Loading Vape Custom...')