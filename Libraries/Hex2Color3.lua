local LibraryFunctions = {}

LibraryFunctions.Hex2Color3 = function(hex)
    hex = hex and string.gsub(hex, "#", "") or "FFFFFF"
    return Color3.new(tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)))
end

return LibraryFunctions