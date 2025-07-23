local Library = {}
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
Library.Tabs = {}

local state = {}
local saveFolder = "Anomaly"
local saveFile = saveFolder .. "/Data.json"

local function loadState()
    if isfile(saveFile) then
        state = HttpService:JSONDecode(readfile(saveFile)) or {}
    end
end

local function saveState()
    if not isfolder or not makefolder or not writefile then return end 
    if not isfolder(saveFolder) then
        makefolder(saveFolder)
    end

    writefile(saveFile, HttpService:JSONEncode(state))
end

loadState()

local RED = Color3.fromRGB(255, 0, 0)
local DARK_GREY = Color3.fromRGB(33, 33, 33)
local GREY_50 = Color3.fromRGB(50, 50, 50)
local BLACK = Color3.fromRGB(0, 0, 0)
local GREEN = Color3.fromRGB(0, 255, 0)

local oldZIndex = 100

local function len(t)
    local count = 0
    for _ in pairs(t) do
        count += 1
    end
    return count
end

function Library:MakeDraggable(dragHandle, draggableFrame)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        draggableFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = draggableFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput then
            update(input)
        end
    end)
end

function Library:CreateWindow(name)
    local Main = Instance.new("ScreenGui")
    Main.Name = "Main"
    Main.Parent = CoreGui
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainBackground = Instance.new("Frame")
    MainBackground.Name = "MainBackground"
    MainBackground.Parent = Main
    MainBackground.BackgroundColor3 = DARK_GREY
    MainBackground.BorderSizePixel = 0
    MainBackground.Position = UDim2.new(0.31, 0, 0.32, 0)
    MainBackground.Size = UDim2.new(0, 411, 0, 289)

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainBackground
    TopBar.BackgroundColor3 = GREY_50
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0, 0, -0.0865, 0)
    TopBar.Size = UDim2.new(0, 411, 0, 25)

    local ScriptHubName = Instance.new("TextLabel")
    ScriptHubName.Name = "ScriptHubName"
    ScriptHubName.Parent = TopBar
    ScriptHubName.BackgroundTransparency = 1
    ScriptHubName.Size = UDim2.new(0, 71, 0, 25)
    ScriptHubName.Font = Enum.Font.Ubuntu
    ScriptHubName.Text = name
    ScriptHubName.TextColor3 = RED
    ScriptHubName.TextSize = 14

    local Close = Instance.new("TextButton")
    Close.Name = "Close"
    Close.Parent = TopBar
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(0.925, 0, 0, 0)
    Close.Size = UDim2.new(0, 31, 0, 24)
    Close.Font = Enum.Font.Unknown
    Close.Text = "X"
    Close.TextColor3 = RED
    Close.TextSize = 14
    Close.MouseButton1Click:Connect(function()
        Main:Destroy()
    end)

    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = MainBackground
    Line.BackgroundColor3 = RED
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0, 0, -0.0035, 0)
    Line.Size = UDim2.new(0, 411, 0, 2)

    local TabBtns = Instance.new("Frame")
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = MainBackground
    TabBtns.BackgroundColor3 = GREY_50
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.0035, 0)
    TabBtns.Size = UDim2.new(0, 112, 0, 287)

    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabBtns
    TabScroll.Active = true
    TabScroll.BackgroundTransparency = 1
    TabScroll.Size = UDim2.new(0, 107, 0, 287)
    TabScroll.ScrollBarThickness = 0
    TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabScroll
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = TabScroll
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.PaddingTop = UDim.new(0, 5)

    local TabsHolder = Instance.new("Frame")
    TabsHolder.Name = "TabsHolder"
    TabsHolder.Parent = MainBackground
    TabsHolder.BackgroundTransparency = 1
    TabsHolder.Position = UDim2.new(0.273, 0, 0, 0)
    TabsHolder.Size = UDim2.new(0, 299, 0, 288)

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TabsHolder
    TabContainer.Active = true
    TabContainer.BackgroundColor3 = GREY_50
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0.017, 0, 0.0036, 0)
    TabContainer.Size = UDim2.new(0, 285, 0, 276)
    TabContainer.ScrollBarThickness = 0
    TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local TabsHolderPadding = Instance.new("UIPadding")
    TabsHolderPadding.Parent = TabsHolder
    TabsHolderPadding.PaddingBottom = UDim.new(0, 5)
    TabsHolderPadding.PaddingLeft = UDim.new(0, 2)
    TabsHolderPadding.PaddingRight = UDim.new(0, 2)
    TabsHolderPadding.PaddingTop = UDim.new(0, 5)

    self:MakeDraggable(TopBar, MainBackground)

    return MainBackground
end

function Library:CreateTab(window, tabName)
    local TabBtnsFolder = window.TabBtns.TabScroll
    local TabsHolderFolder = window.TabsHolder

    local NewTabBtn = Instance.new("TextButton")
    NewTabBtn.Parent = TabBtnsFolder
    NewTabBtn.BackgroundColor3 = DARK_GREY
    NewTabBtn.BorderSizePixel = 0
    NewTabBtn.Size = UDim2.new(0, 107, 0, 22)
    NewTabBtn.Font = Enum.Font.Ubuntu
    NewTabBtn.TextColor3 = RED
    NewTabBtn.TextSize = 14
    NewTabBtn.Text = tabName

    local NewTab = Instance.new("ScrollingFrame")
    NewTab.Parent = TabsHolderFolder
    NewTab.Name = tabName
    NewTab.Active = true
    NewTab.BackgroundColor3 = GREY_50
    NewTab.BorderSizePixel = 0
    NewTab.Position = UDim2.new(0.017, 0, 0.0036, 0)
    NewTab.Size = UDim2.new(0, 285, 0, 276)
    NewTab.ScrollBarThickness = 0
    NewTab.Visible = false
    NewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = NewTab
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = NewTab
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.PaddingTop = UDim.new(0, 5)

    self.Tabs[tabName] = { TabBtn = NewTabBtn, TabFrame = NewTab }

    if len(self.Tabs) == 1 then
        NewTab.Visible = true
    end

    NewTabBtn.MouseButton1Click:Connect(function()
        local tabs = self.Tabs
        for _, t in pairs(tabs) do
            if t.TabFrame.Visible then
                t.TabFrame.Visible = false
                t.TabBtn.BackgroundColor3 = DARK_GREY
            end
        end
        NewTab.Visible = true
    end)

    local TabObject = {}
    function TabObject:CreateButton(btnName, callback)
        local NewBtn = Instance.new("TextButton")
        NewBtn.Parent = NewTab
        NewBtn.BackgroundColor3 = DARK_GREY
        NewBtn.BorderSizePixel = 0
        NewBtn.Size = UDim2.new(0, 265, 0, 40)
        NewBtn.Font = Enum.Font.Ubuntu
        NewBtn.TextColor3 = RED
        NewBtn.TextSize = 14
        NewBtn.Text = btnName

        NewBtn.MouseButton1Click:Connect(callback)
        return NewBtn
    end

    function TabObject:CreateToggle(toggleName, callback)
        local toggled = state[toggleName] or false
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Parent = NewTab
        TextLabel.BackgroundColor3 = DARK_GREY
        TextLabel.BorderSizePixel = 0
        TextLabel.Size = UDim2.new(0, 265, 0, 50)
        TextLabel.Font = Enum.Font.Ubuntu
        TextLabel.Text = toggleName
        TextLabel.TextColor3 = RED
        TextLabel.TextSize = 14

        local NewToggle = Instance.new("TextButton")
        NewToggle.Parent = TextLabel
        NewToggle.BackgroundColor3 = RED
        NewToggle.BorderSizePixel = 0
        NewToggle.Position = UDim2.new(0.85, 0, 0.25, 0)
        NewToggle.Size = UDim2.new(0, 25, 0, 25)
        NewToggle.Font = Enum.Font.Ubuntu
        NewToggle.Text = ""
        NewToggle.TextColor3 = BLACK
        NewToggle.TextSize = 14

        if state[toggleName] then 
            callback(state[toggleName])
            NewToggle.BackgroundColor3 = GREEN
        end 

        NewToggle.MouseButton1Click:Connect(function()
            toggled = not toggled

            state[toggleName] = toggled
            saveState()
            NewToggle.BackgroundColor3 = toggled and GREEN or RED
            callback(toggled)
        end)

        return NewToggle
    end

    function TabObject:CreateDropdown(dropdownName, dropdownItems, callback)
        local selected = state[dropdownName] or dropdownItems[1]
        local DropdownLabel = Instance.new("TextLabel")
        DropdownLabel.Name = dropdownName
        DropdownLabel.Parent = NewTab
        DropdownLabel.BackgroundColor3 = DARK_GREY
        DropdownLabel.BorderSizePixel = 0
        DropdownLabel.Size = UDim2.new(0, 265, 0, 50)
        DropdownLabel.Font = Enum.Font.Ubuntu
        DropdownLabel.TextColor3 = RED
        DropdownLabel.TextSize = 14
        DropdownLabel.TextWrapped = true
        DropdownLabel.Text = dropdownName .. "\nValue: nil"
        DropdownLabel.ZIndex = oldZIndex
        oldZIndex -= 1

        local DropdownFilterBtn = Instance.new("TextButton")
        DropdownFilterBtn.Parent = DropdownLabel
        DropdownFilterBtn.BackgroundTransparency = 1
        DropdownFilterBtn.BorderSizePixel = 0
        DropdownFilterBtn.Position = UDim2.new(0.85, 0, 0.24, 0)
        DropdownFilterBtn.Size = UDim2.new(0, 25, 0, 25)
        DropdownFilterBtn.Font = Enum.Font.SourceSansBold
        DropdownFilterBtn.Text = "V"
        DropdownFilterBtn.TextColor3 = RED
        DropdownFilterBtn.TextSize = 20

        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Name = "DropdownFrame"
        DropdownFrame.Parent = DropdownLabel
        DropdownFrame.BackgroundColor3 = DARK_GREY
        DropdownFrame.BorderSizePixel = 0
        DropdownFrame.Position = UDim2.new(0, 0, 1, 0)
        DropdownFrame.Size = UDim2.new(0, 265, 0, 214)
        DropdownFrame.ZIndex = 11
        DropdownFrame.Visible = false

        local DropdownLine = Instance.new("Frame")
        DropdownLine.Name = "DropdownLine"
        DropdownLine.Parent = DropdownFrame
        DropdownLine.BackgroundColor3 = RED
        DropdownLine.BorderSizePixel = 0
        DropdownLine.Position = UDim2.new(0, 0, 0.005, 0)
        DropdownLine.Size = UDim2.new(0, 265, 0, -2)
        DropdownLine.ZIndex = 100

        local DropdownBtnContainer = Instance.new("ScrollingFrame")
        DropdownBtnContainer.Name = "DropdownBtnContainer"
        DropdownBtnContainer.Parent = DropdownFrame
        DropdownBtnContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        DropdownBtnContainer.BackgroundTransparency = 1
        DropdownBtnContainer.BorderSizePixel = 0
        DropdownBtnContainer.Size = UDim2.new(0, 265, 0, 214)
        DropdownBtnContainer.ScrollBarThickness = 0
        DropdownBtnContainer.Active = true
        DropdownBtnContainer.ZIndex = 12

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = DropdownBtnContainer
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        local UIPadding = Instance.new("UIPadding")
        UIPadding.Parent = DropdownBtnContainer
        UIPadding.PaddingLeft = UDim.new(0, 5)
        UIPadding.PaddingRight = UDim.new(0, 5)
        UIPadding.PaddingTop = UDim.new(0, 5)

        DropdownFilterBtn.MouseButton1Click:Connect(function()
            DropdownFrame.Visible = not DropdownFrame.Visible
            DropdownFilterBtn.Text = DropdownFrame.Visible and "Λ" or "V"
        end)

        for i, v in ipairs(dropdownItems) do
            local actualDropdownBtn = Instance.new("TextButton")
            actualDropdownBtn.Parent = DropdownBtnContainer
            actualDropdownBtn.BackgroundColor3 = GREY_50
            actualDropdownBtn.BorderSizePixel = 0
            actualDropdownBtn.Size = UDim2.new(0, 254, 0, 50)
            actualDropdownBtn.Font = Enum.Font.Ubuntu
            actualDropdownBtn.TextColor3 = RED
            actualDropdownBtn.TextSize = 14
            actualDropdownBtn.Text = v
            actualDropdownBtn.ZIndex = 23 + i

            if state[dropdownName] then 
                callback(state[dropdownName])
                DropdownLabel.Text = dropdownName .. "\nValue: " .. state[dropdownName]
            end 

            actualDropdownBtn.MouseButton1Click:Connect(function()
                DropdownLabel.Text = dropdownName .. "\n Value: " .. v
                selected = v
                state[dropdownName] = selected
                saveState()
                DropdownFrame.Visible = false
                DropdownFilterBtn.Text = "V"
                callback(v)
            end)
        end

        return DropdownBtnContainer
    end

    function TabObject:CreateSlider(sliderName, minValue, maxValue, defaultValue, callback)
        local savedValue = tonumber(state[sliderName]) or defaultValue
        state[sliderName] = savedValue
        saveState()

        local SliderParent = Instance.new("TextLabel")
        SliderParent.Name = sliderName
        SliderParent.Parent = NewTab
        SliderParent.BackgroundColor3 = DARK_GREY
        SliderParent.BorderSizePixel = 0
        SliderParent.Size = UDim2.new(0, 265, 0, 60)
        SliderParent.Font = Enum.Font.Ubuntu
        SliderParent.Text = sliderName .. ":"
        SliderParent.TextColor3 = RED
        SliderParent.TextSize = 14

        local SliderValue = Instance.new("TextBox")
        SliderValue.Parent = SliderParent
        SliderValue.BackgroundColor3 = DARK_GREY
        SliderValue.BorderSizePixel = 0
        SliderValue.Position = UDim2.new(0.75, 0, 0.25, 0)
        SliderValue.Size = UDim2.new(0, 60, 0, 30)
        SliderValue.Font = Enum.Font.Ubuntu
        SliderValue.Text = tostring(savedValue)
        SliderValue.TextColor3 = RED
        SliderValue.TextSize = 14

        local SliderLine = Instance.new("Frame")
        SliderLine.Parent = SliderParent
        SliderLine.BackgroundColor3 = GREY_50
        SliderLine.BorderSizePixel = 0
        SliderLine.Position = UDim2.new(0.05, 0, 0.75, 0)
        SliderLine.Size = UDim2.new(0.9, 0, 0, 4)

        local SliderBtn = Instance.new("TextButton")
        SliderBtn.Parent = SliderLine
        SliderBtn.BackgroundColor3 = RED
        SliderBtn.BorderSizePixel = 0
        SliderBtn.Size = UDim2.new(0, 14, 0, 14)
        SliderBtn.Position = UDim2.new((savedValue - minValue) / (maxValue - minValue), -7, -0.75, 0)
        SliderBtn.AutoButtonColor = false
        SliderBtn.Text = ""

        local dragging = false

        local function updateValueFromPos(x)
            local relX = math.clamp((x - SliderLine.AbsolutePosition.X) / SliderLine.AbsoluteSize.X, 0, 1)
            local newValue = math.floor(minValue + (maxValue - minValue) * relX)
            SliderBtn.Position = UDim2.new(relX, -7, -0.75, 0)
            SliderValue.Text = tostring(newValue)
            state[sliderName] = newValue
            saveState()
            callback(newValue)
        end

        local function startDrag()
            dragging = true
            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not dragging then
                    conn:Disconnect()
                    return
                end
                local mouse = UserInputService:GetMouseLocation()
                updateValueFromPos(mouse.X)
            end)
        end


        SliderBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                startDrag()
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateValueFromPos(input.Position.X)
            end
        end)

        SliderValue.FocusLost:Connect(function()
            local val = tonumber(SliderValue.Text)
            if val then
                val = math.clamp(val, minValue, maxValue)
                SliderBtn.Position = UDim2.new((val - minValue) / (maxValue - minValue), -7, -0.75, 0)
                state[sliderName] = val
                saveState()
                callback(val)
            else
                SliderValue.Text = tostring(state[sliderName])
            end
        end)

        if state[sliderName] then 
            SliderBtn.Position = UDim2.new((state[sliderName] - minValue) / (maxValue - minValue), -7, -0.75, 0)
            SliderValue.Text = tostring(state[sliderName])
        end 

        callback(savedValue)
        return SliderBtn
    end



    TabObject.Frame = NewTab
    return TabObject
end

return Library
