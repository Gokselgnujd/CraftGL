local m = {}

function m.createWindow()
    local window = {}
    window.Term = term.current()
end

function m.isTrue(v)
    if v == true then
        return true
    elseif v == false then
        return false
    else
        return "Invalid"
    end
end

return m
