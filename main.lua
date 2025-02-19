local m = {}

local m.Vector2 = {}

function m.Vector2.New(X,Y)
    local r = {x = X, y = Y}
end

local function CreatePixelData(x,y,color)
    return {X=x,Y=y,Color=color}
end

local function DrawBuffer(buffer)
    for _,obj in buffer do
        term.setTextColor(obj.Color)
        term.setCursorPos(obj.X,obj.Y)
        term.write("_")
    end
end

local function fetchBufferFunctions()
    local list = {}
    
    function list.PQuad(this,x,y,Sx,Sy,color)
        if x<0 or y<0 or Sx<0 or Sy<0 then return end
        local pixels = {}
        for X=1,Sx do
            for X=1,Sy do
                list[#list+1] = CreatePixelData(x+X,y+Y,color)
            end
        end
    end
    function list.PQuadShader(this,x,y,Sx,Sy,ShaderFunc)
        if x<0 or y<0 or Sx<0 or Sy<0 and ShaderFunc ~= nil then return end
        local pixels = {}
        for X=1,Sx do
            for Y=1,Sy do
                list[#list+1] = CreatePixelData(x+X,y+Y,ShaderFunc(X,Y))
            end
        end
    end
    function list.CreateText(Text,x,y,Color)
        if Text==nil or x<0 or y<0 or color== nil then return end

    end
    function list.setBackgroundColor(color)
        term.setBackgroundColor(color)
    end
    return list
end

function checkIfTable(v)
    x=1+v -- must be called in pcall
end

function m.createWindow()
    local window = {}
    window.Term = term.current()
    window.primaryBuffer = {}
    window.secondaryBuffer = {}
    window.logs = {}
    function window.clearBuffer(this)
        this.secondaryBuffer = nil
    end
    function window.swapBuffers(this)
        local temp = this.primaryBuffer
        this.primaryBuffer = this.secondaryBuffer
        this.secondaryBuffer = temp
        temp = nil
    end
    function window.addToBuffer(Data,buffer)
        buffer.append(Data)
    end
    buffer.append(fetchBufferFunctions())
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

