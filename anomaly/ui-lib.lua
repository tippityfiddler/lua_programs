local Library = {}

Library.Tabs = {} 

function Library:CreateWindow(name : string)
	local Main = Instance.new("ScreenGui")
	local MainBackground = Instance.new("Frame")
	local TopBar = Instance.new("Frame")
	local ScriptHubName = Instance.new("TextLabel")
	local Close = Instance.new("TextButton")
	local Line = Instance.new("Frame")
	local TabBtns = Instance.new("Frame")
	local TabScroll = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local UIPadding_2 = Instance.new("UIPadding")
	local TabsHolder = Instance.new("Frame")
	local TabContainer = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local TextButton_5 = Instance.new("TextButton")
	local UIPadding_3 = Instance.new("UIPadding")

	local UIPadding_4 = Instance.new("UIPadding")

	Main.Name = "Main"
	Main.Parent = game:GetService("CoreGui")
	Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	MainBackground.Name = "MainBackground"
	MainBackground.Parent = Main
	MainBackground.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	MainBackground.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainBackground.BorderSizePixel = 0
	MainBackground.Position = UDim2.new(0.309545875, 0, 0.317839205, 0)
	MainBackground.Size = UDim2.new(0, 411, 0, 289)

	TopBar.Name = "TopBar"
	TopBar.Parent = MainBackground
	TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopBar.BorderSizePixel = 0
	TopBar.Position = UDim2.new(0, 0, -0.0865051895, 0)
	TopBar.Size = UDim2.new(0, 411, 0, 25)

	ScriptHubName.Name = "ScriptHubName"
	ScriptHubName.Parent = TopBar
	ScriptHubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScriptHubName.BackgroundTransparency = 1.000
	ScriptHubName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScriptHubName.BorderSizePixel = 0
	ScriptHubName.Size = UDim2.new(0, 71, 0, 25)
	ScriptHubName.Font = Enum.Font.Ubuntu
	ScriptHubName.Text = name
	ScriptHubName.TextColor3 = Color3.fromRGB(255, 0, 0)
	ScriptHubName.TextSize = 14.000

	Close.Name = "Close"
	Close.Parent = TopBar
	Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0.924574196, 0, 0, 0)
	Close.Size = UDim2.new(0, 31, 0, 24)
	Close.Font = Enum.Font.Unknown
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(255, 0, 0)
	Close.TextSize = 14.000

	Line.Name = "Line"
	Line.Parent = MainBackground
	Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, -0.00346020772, 0)
	Line.Size = UDim2.new(0, 411, 0, 2)

	TabBtns.Name = "TabBtns"
	TabBtns.Parent = MainBackground
	TabBtns.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabBtns.BorderColor3 = Color3.fromRGB(50, 50, 50)
	TabBtns.BorderSizePixel = 0
	TabBtns.Position = UDim2.new(0, 0, 0.00346020772, 0)
	TabBtns.Size = UDim2.new(0, 112, 0, 287)

	TabScroll.Name = "TabScroll"
	TabScroll.Parent = TabBtns
	TabScroll.Active = true
	TabScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabScroll.BackgroundTransparency = 1.000
	TabScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabScroll.BorderSizePixel = 0
	TabScroll.Size = UDim2.new(0, 107, 0, 287)
	TabScroll.ScrollBarThickness = 0

	UIListLayout.Parent = TabScroll
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	UIPadding.Parent = TabScroll
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)

	UIPadding_2.Parent = MainBackground

	TabsHolder.Name = "TabsHolder"
	TabsHolder.Parent = MainBackground
	TabsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsHolder.BackgroundTransparency = 1.000
	TabsHolder.BorderColor3 = Color3.fromRGB(33, 33, 33)
	TabsHolder.Position = UDim2.new(0.272506088, 0, 0, 0)
	TabsHolder.Size = UDim2.new(0, 299, 0, 288)

	TabContainer.Name = "TabContainer"
	TabContainer.Parent = TabsHolder
	TabContainer.Active = true
	TabContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabContainer.BorderColor3 = Color3.fromRGB(50, 50, 50)
	TabContainer.BorderSizePixel = 0
	TabContainer.Position = UDim2.new(0.0167665649, 0, 0.00359712238, 0)
	TabContainer.Size = UDim2.new(0, 285, 0, 276)
	TabContainer.ScrollBarThickness = 0

	UIListLayout_2.Parent = TabContainer
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 5)

	UIPadding_3.Parent = TabContainer
	UIPadding_3.PaddingLeft = UDim.new(0, 10)
	UIPadding_3.PaddingRight = UDim.new(0, 10)
	UIPadding_3.PaddingTop = UDim.new(0, 5)

	UIPadding_4.Parent = TabsHolder
	UIPadding_4.PaddingBottom = UDim.new(0, 5)
	UIPadding_4.PaddingLeft = UDim.new(0, 2)
	UIPadding_4.PaddingRight = UDim.new(0, 2)
	UIPadding_4.PaddingTop = UDim.new(0, 5)

	local dragging, dragInput, dragStart, startPos
	local UserInputService = game:GetService("UserInputService")

	local function update(input)
		if not dragging then return end
		local delta = input.Position - dragStart
		MainBackground.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	MainBackground.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainBackground.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	MainBackground.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput then
			update(input)
		end
	end)

	return MainBackground 
end


function Library:CreateTab(window : Instance, tabName : string)
	local TabBtnsFolder = window.TabBtns.TabScroll 
	local TabsHolderFolder = window.TabsHolder 

	local NewTabBtn = Instance.new("TextButton", TabBtnsFolder)
	local NewTab = Instance.new("ScrollingFrame", TabsHolderFolder)

	NewTab.Name = tabName
	NewTab.Active = true
	NewTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	NewTab.BorderColor3 = Color3.fromRGB(50, 50, 50)
	NewTab.BorderSizePixel = 0
	NewTab.Position = UDim2.new(0.0167665649, 0, 0.00359712238, 0)
	NewTab.Size = UDim2.new(0, 285, 0, 276)
	NewTab.ScrollBarThickness = 0
	NewTab.Visible = false

	NewTabBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	NewTabBtn.Text = tabName
	NewTabBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NewTabBtn.BorderSizePixel = 0
	NewTabBtn.Size = UDim2.new(0, 107, 0, 22)
	NewTabBtn.Font = Enum.Font.Ubuntu
	NewTabBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	NewTabBtn.TextSize = 14.000


	self.Tabs[tabName] = {
		TabBtn = NewTabBtn,
		TabFrame = NewTab,
	}

	if #self.Tabs == 1 then
		NewTab.Visible = true
	end


	NewTabBtn.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do
			t.TabFrame.Visible = false
			t.TabBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
		end

		NewTab.Visible = true
	end)

	return NewTab
end

function Library:CreateButton(tabName : string, btnName : string, callback : func) 
	local tab = self.Tabs[tabName]
	if not tab then
		warn("Tab '" .. tabName .. "' does not exist!")
		return
	end

	local NewBtn = Instance.new("TextButton", tab.TabFrame)
	NewBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	NewBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NewBtn.BorderSizePixel = 0
	NewBtn.Size = UDim2.new(0, 107, 0, 22)
	NewBtn.Font = Enum.Font.Ubuntu
	NewBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
	NewBtn.TextSize = 14.000
	NewBtn.Text = btnName 

	NewBtn.MouseButton1Click:Connect(callback) 

	return NewBtn
end
return Library
