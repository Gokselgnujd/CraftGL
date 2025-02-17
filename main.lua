local m = {}

local m.Vector2 = {}

function m.Vector2.New(X,Y)
    return {x = X, y = Y}
end

local function CreatePixelData(x,y,color)
    return {X=x,Y=y,Color=color}
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
    function window.createBufferObject(this,x,y,Sx,Sy,color)
        local returnable = {}

        xp = false -- true if x is a pixel
        yp = false -- same as xp

        if pcall(checkIfTable(Sx)) then
            xp = false
        else
            xp = true
            this.logs[#logs+1] = "creating buffer with Sx being 1 pixel"
        end
        if pcall(checkIfTable(Sy)) then
            yp = false
        else
            yp = true
            this.logs[#logs+1] = "creating buffer with Sy being 1 pixel"
        end
        -- Sx Sy checked
        returnable.x=x
        returnable.y=y
        returnable.Sy=Sy
        returnable.Sx=Sx
        returnable.clr=color
    end
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
