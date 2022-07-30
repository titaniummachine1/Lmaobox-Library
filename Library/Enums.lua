--[[
    Enums
]]

---@class Enums
local Enums = { }

--[[ Generic Enums ]]

-- File Attributes
Enums.FileAttribute = {
    FILE_ATTRIBUTE_ARCHIVE = 0x20,
    FILE_ATTRIBUTE_COMPRESSED = 0x800,
    FILE_ATTRIBUTE_DEVICE = 0x40,
    FILE_ATTRIBUTE_DIRECTORY = 0x10,
    FILE_ATTRIBUTE_ENCRYPTED = 0x4000,
    FILE_ATTRIBUTE_HIDDEN = 0x2,
    FILE_ATTRIBUTE_INTEGRITY_STREAM = 0x8000,
    FILE_ATTRIBUTE_NORMAL = 0x80,
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 0x2000,
    FILE_ATTRIBUTE_NO_SCRUB_DATA = 0x20000,
    FILE_ATTRIBUTE_OFFLINE = 0x1000,
    FILE_ATTRIBUTE_READONLY = 0x1,
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = 0x400000,
    FILE_ATTRIBUTE_RECALL_ON_OPEN = 0x40000,
    FILE_ATTRIBUTE_REPARSE_POINT = 0x400,
    FILE_ATTRIBUTE_SPARSE_FILE = 0x200,
    FILE_ATTRIBUTE_SYSTEM = 0x4,
    FILE_ATTRIBUTE_TEMPORARY = 0x100,
    FILE_ATTRIBUTE_VIRTUAL = 0x10000,
    FILE_ATTRIBUTE_PINNED = 0x80000,
    FILE_ATTRIBUTE_UNPINNED = 0x100000,
    INVALID_FILE_ATTRIBUTES = 0xFFFFFFFF
}

Enums.HexColor = {
    Red = 0xFF0000,
    Green = 0x00FF00,
    Blue = 0x0000FF,
    Yellow = 0xFFFF00,
    Cyan = 0x00FFFF,
    Magenta = 0xFF00FF,
    White = 0xFFFFFF,
    Black = 0x000000,
    Orange = 0xFFA500,
    Brown = 0xA52A2A,
    Gray = 0x808080,
}

--[[ TF2 Enums ]]

Enums.ObserverMode = {
    None = 0,
    Deathcam = 1,
    FreezeCam = 2,
    Fixed = 3,
    FirstPerson = 4,
    ThirdPerson = 5,
    PointOfInterest = 6,
    FreeRoaming = 7
}

Enums.SignonState = {
    None = 0,
    Challenge = 1,
    Connected = 2,
    New = 3,
    Prespawn = 4,
    Spawn = 5,
    Full = 6,
    ChangeLevel = 7
}

return Enums