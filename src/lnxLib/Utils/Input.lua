--[[
    Input Utils
]]

---@class Input
local Input = {}

-- Contains pairs of keys and their names
---@type table<integer, string>
local KeyNames = {
    [KEY_SEMICOLON] = "SEMICOLON",
    [KEY_APOSTROPHE] = "APOSTROPHE",
    [KEY_BACKQUOTE] = "BACKQUOTE",
    [KEY_COMMA] = "COMMA",
    [KEY_PERIOD] = "PERIOD",
    [KEY_SLASH] = "SLASH",
    [KEY_BACKSLASH] = "BACKSLASH",
    [KEY_MINUS] = "MINUS",
    [KEY_EQUAL] = "EQUAL",
    [KEY_ENTER] = "ENTER",
    [KEY_SPACE] = "SPACE",
    [KEY_BACKSPACE] = "BACKSPACE",
    [KEY_TAB] = "TAB",
    [KEY_CAPSLOCK] = "CAPSLOCK",
    [KEY_NUMLOCK] = "NUMLOCK",
    [KEY_ESCAPE] = "ESCAPE",
    [KEY_SCROLLLOCK] = "SCROLLLOCK",
    [KEY_INSERT] = "INSERT",
    [KEY_DELETE] = "DELETE",
    [KEY_HOME] = "HOME",
    [KEY_END] = "END",
    [KEY_PAGEUP] = "PAGEUP",
    [KEY_PAGEDOWN] = "PAGEDOWN",
    [KEY_BREAK] = "BREAK",
    [KEY_LSHIFT] = "LSHIFT",
    [KEY_RSHIFT] = "RSHIFT",
    [KEY_LALT] = "LALT",
    [KEY_RALT] = "RALT",
    [KEY_LCONTROL] = "LCONTROL",
    [KEY_RCONTROL] = "RCONTROL",
    [KEY_LWIN] = "LWIN",
    [KEY_RWIN] = "RWIN",
    [KEY_APP] = "APP",
    [KEY_UP] = "UP",
    [KEY_LEFT] = "LEFT",
    [KEY_DOWN] = "DOWN",
    [KEY_RIGHT] = "RIGHT",
    [MOUSE_LEFT] = "LMB",
    [MOUSE_RIGHT] = "RMB",
    [MOUSE_MIDDLE] = "MMB",
    [MOUSE_4] = "MOUSE4",
    [MOUSE_5] = "MOUSE5",
    [MOUSE_WHEEL_UP] = "MWHEELUP",
    [MOUSE_WHEEL_DOWN] = "MWHEELDOWN",
}

-- Contains pairs of keys and their values
---@type table<integer, string>
local KeyValues = {
    [KEY_LBRACKET] = "[",
    [KEY_RBRACKET] = "]",
    [KEY_SEMICOLON] = ";",
    [KEY_APOSTROPHE] = "'",
    [KEY_BACKQUOTE] = "`",
    [KEY_COMMA] = ",",
    [KEY_PERIOD] = ".",
    [KEY_SLASH] = "/",
    [KEY_BACKSLASH] = "\\",
    [KEY_MINUS] = "-",
    [KEY_EQUAL] = "=",
    [KEY_SPACE] = " ",
}

-- Fill the tables
local function D(x) return x, x end
for i = KEY_0, KEY_9 do KeyNames[i], KeyValues[i] = D(tostring(i - KEY_0)) end
for i = KEY_A, KEY_Z do KeyNames[i], KeyValues[i] = D(string.char(i - KEY_A + 65)) end
for i = KEY_PAD_0, KEY_PAD_9 do KeyNames[i], KeyValues[i] = "KP_" .. (i - KEY_PAD_0), tostring(i - KEY_PAD_0) end
for i = KEY_F1, KEY_F12 do KeyNames[i] = "F" .. (i - KEY_F1 + 1) end

-- Returns the name of a keycode
---@param key integer
---@return string
function Input.GetKeyName(key)
    return KeyNames[key] or "UNKNOWN"
end

-- Returns the string value of a keycode
---@param key integer
---@return string?
function Input.KeyToChar(key)
    return KeyValues[key]
end

-- Returns the keycode of a string value
---@param char string
---@return integer?
function Input.CharToKey(char)
    for k, v in pairs(KeyValues) do
        if v == string.upper(char) then
            return k
        end
    end
    return nil
end

-- Returns the currently pressed key
---@return integer?
function Input.GetPressedKey()
    for i = KEY_FIRST, KEY_LAST do
        if input.IsButtonDown(i) then
            return i
        end
    end
    return nil
end

-- Returns all currently pressed keys as a table
---@return integer[]
function Input.GetPressedKeys()
    local keys = {}
    for i = KEY_FIRST, KEY_LAST do
        if input.IsButtonDown(i) then
            table.insert(keys, i)
        end
    end
    return keys
end

-- Returns a pressed key suitable for typing (alphanumeric and punctuation)
---@return integer?
function Input.GetTypingKey()
    for i = KEY_0, KEY_Z do
        if input.IsButtonDown(i) then
            return i
        end
    end
    for _, key in ipairs({
        KEY_SPACE, KEY_ENTER, KEY_BACKSPACE, KEY_TAB, KEY_SEMICOLON, 
        KEY_APOSTROPHE, KEY_COMMA, KEY_PERIOD, KEY_SLASH, KEY_BACKSLASH, 
        KEY_MINUS, KEY_EQUAL
    }) do
        if input.IsButtonDown(key) then
            return key
        end
    end
    return nil
end

-- Returns a pressed key suitable for operations (function keys, arrows, etc.)
---@return integer?
function Input.GetOperationKey()
    for i = KEY_F1, KEY_F12 do
        if input.IsButtonDown(i) then
            return i
        end
    end
    for _, key in ipairs({
        KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_HOME, KEY_END, 
        KEY_PAGEUP, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, KEY_ESCAPE
    }) do
        if input.IsButtonDown(key) then
            return key
        end
    end
    return nil
end

-- Returns if the cursor is in the given bounds
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@return boolean
function Input.MouseInBounds(x1, y1, x2, y2)
    local mx, my = table.unpack(input.GetMousePos())
    return mx >= x1 and mx <= x2 and my >= y1 and my <= y2
end

return Input
