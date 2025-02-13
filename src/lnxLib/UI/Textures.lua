---@class Textures
local Textures = {}

---@alias TColor table<integer, integer, integer, integer?>
---@alias TSize table<integer, integer>

local byteMap = {}
for i = 0, 255 do byteMap[i] = string.char(i) end

---@type table<string, Texture>
local textureCache = {}

---@param color TColor
---@return integer, integer, integer, integer
local function UnpackColor(color)
    local r, g, b, a = table.unpack(color)
    a = a or 255
    return r, g, b, a
end

---@param size TSize
---@return integer, integer
local function UnpackSize(size)
    local w, h = table.unpack(size)
    w, h = w or 256, h or 256
    return w, h
end

---@param name string
---@vararg any
---@return string
local function GetTextureID(name, ...)
    return table.concat({name, ...})
end

-- Creates and caches the texture from RGBA data
---@param id string
---@param width integer
---@param height integer
---@param data table
local function CreateTexture(id, width, height, data)
    local binaryData = table.concat(data)
    local texture = draw.CreateTextureRGBA(binaryData, width, height)
    textureCache[id] = texture
    return texture
end

-- [PERFORMANCE INTENSIVE] Creates a linear gradient
---@param startColor TColor
---@param endColor TColor
---@param size TSize
---@return Texture
function Textures.LinearGradient(startColor, endColor, size)
    local sR, sG, sB, sA = UnpackColor(startColor)
    local eR, eG, eB, eA = UnpackColor(endColor)
    local w, h = UnpackSize(size)

    -- Check if the texture is already cached
    local id = GetTextureID("LG", sR, sG, sB, sA, eR, eG, eB, eA, w, h)
    local cache = textureCache[id]
    if cache then return cache end

    local dataSize = w * h * 4
    local data, bm = {}, byteMap
    
    local i = 1
    while i < dataSize do
        local idx = (i / 4)
        local x, y = idx % w, idx // w

        data[i] = bm[sR + (eR - sR) * x // w]
        data[i + 1] = bm[sG + (eG - sG) * y // h]
        data[i + 2] = bm[sB + (eB - sB) * x // w]
        data[i + 3] = bm[sA + (eA - sA) * y // h]

        i = i + 4
    end

    return CreateTexture(id, w, h, data)
end

-- [PERFORMANCE INTENSIVE] Creates a circle with a given color
---@param radius number
---@param color table<number, number, number, number>
---@return Texture
function Textures.Circle(radius, color)
    local r, g, b, a = UnpackColor(color)

    -- Check if the texture is already cached
    local id = GetTextureID("C", r, g, b, a, radius)
    local cache = textureCache[id]
    if cache then return cache end

    local diameter = radius * 2
    local dataSize = diameter * diameter * 4
    local data, bm = {}, byteMap

    local i = 1
    while i < dataSize do
        local idx = (i / 4)
        local x, y = idx % diameter, idx // diameter
        local dx, dy = x - radius, y - radius
        local dist = math.sqrt(dx * dx + dy * dy)

        if dist <= radius then
            data[i] = bm[r]
            data[i + 1] = bm[g]
            data[i + 2] = bm[b]
            data[i + 3] = bm[a]
        else
            data[i] = bm[0]
            data[i + 1] = bm[0]
            data[i + 2] = bm[0]
            data[i + 3] = bm[0]
        end

        i = i + 4
    end

    return CreateTexture(id, diameter, diameter, data)
end

return Textures
