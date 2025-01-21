local m = {}

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
