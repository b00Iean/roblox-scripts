-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Colors = {}

-- Options
local Default = {
	MainColor = Color3.fromRGB(41, 74, 122):ToHex(),
	MinSize = { X = 500, Y = 500 },
	ToggleKey = "RightShift",
	CanResize = true,
}

if not readfile and writefile and isfile then
	return Default
end

local Success, Setting = pcall(function()
	if readfile and writefile and isfile then
		if isfile("EleriumSettings.json") then
			return HttpService:JSONDecode(readfile("EleriumSettings.json"))
		else
			writefile("EleriumSettings.json", HttpService:JSONEncode(Default))
			return Default
		end
	else
		warn("Missing reafile/writefile/isfile, using default settings")
		return Default
	end
end)

if Success and writefile then
	for i in pairs(Setting) do
		if not Default[i] then
			Setting[i] = nil
		end
	end

	for i, v in pairs(Default) do
		if not Setting[i] then
			Setting[i] = v
		end
	end

	writefile("EleriumSettings.json", HttpService:JSONEncode(Setting))
end

-- Destroy Old Instance
pcall(function()
	getgenv().OldInstance:Destroy()
end)

-- Instance
local NewInstance = Instance.new("ScreenGui")
NewInstance.Name = HttpService:GenerateGUID(false)

if gethui then
	NewInstance.Parent = gethui()
elseif not is_sirhurt_closure and (syn and syn.protect_gui) then
	syn.protect_gui(NewInstance)
	NewInstance.Parent = CoreGui
else
	NewInstance.Parent = CoreGui
end

getgenv().OldInstance = NewInstance

local Prefabs = Instance.new("Frame")
Prefabs.Name = "Prefabs"
Prefabs.BackgroundColor3 = Color3.new(1, 1, 1)
Prefabs.Size = UDim2.new(0, 100, 0, 100)
Prefabs.Visible = false
Prefabs.Parent = NewInstance

local Label = Instance.new("TextLabel")
Label.Name = "Label"
Label.BackgroundColor3 = Color3.new(1, 1, 1)
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(0, 200, 0, 20)
Label.Font = Enum.Font.GothamSemibold
Label.Text = "Hello, world 123"
Label.TextColor3 = Color3.new(1, 1, 1)
Label.TextSize = 14
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = Prefabs

local Window = Instance.new("ImageLabel")
Window.Name = "Window"
Window.Active = true
Window.BackgroundColor3 = Color3.new(1, 1, 1)
Window.BackgroundTransparency = 1
Window.ClipsDescendants = true
Window.Position = UDim2.new(0, 20, 0, 20)
Window.Selectable = true
Window.Size = UDim2.new(0, 200, 0, 200)
Window.Image = "rbxassetid://2851926732"
Window.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
Window.ScaleType = Enum.ScaleType.Slice
Window.SliceCenter = Rect.new(12, 12, 12, 12)
Window.Parent = Prefabs

local Resizer = Instance.new("Frame")
Resizer.Name = "Resizer"
Resizer.Active = true
Resizer.BackgroundColor3 = Color3.new(1, 1, 1)
Resizer.BackgroundTransparency = 1
Resizer.BorderSizePixel = 0
Resizer.Position = UDim2.new(1, -20, 1, -20)
Resizer.Size = UDim2.new(0, 20, 0, 20)
Resizer.Parent = Window

local Bar = Instance.new("Frame")
Bar.Name = "Bar"
Bar.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Bar.BorderSizePixel = 0
Bar.Position = UDim2.new(0, 0, 0, 5)
Bar.Size = UDim2.new(1, 0, 0, 15)
Bar.Parent = Window

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.BackgroundColor3 = Color3.new(1, 1, 1)
Toggle.BackgroundTransparency = 1
Toggle.Position = UDim2.new(0, 5, 0, -2)
Toggle.Rotation = 90
Toggle.Size = UDim2.new(0, 20, 0, 20)
Toggle.ZIndex = 2
Toggle.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
Toggle.Parent = Bar

local Base = Instance.new("ImageLabel")
Base.Name = "Base"
Base.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Base.BorderSizePixel = 0
Base.Position = UDim2.new(0, 0, 0.800000012, 0)
Base.Size = UDim2.new(1, 0, 0, 10)
Base.Image = "rbxassetid://2851926732"
Base.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Base.ScaleType = Enum.ScaleType.Slice
Base.SliceCenter = Rect.new(12, 12, 12, 12)
Base.Parent = Bar

local Top = Instance.new("ImageLabel")
Top.Name = "Top"
Top.BackgroundColor3 = Color3.new(1, 1, 1)
Top.BackgroundTransparency = 1
Top.Position = UDim2.new(0, 0, 0, -5)
Top.Size = UDim2.new(1, 0, 0, 10)
Top.Image = "rbxassetid://2851926732"
Top.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Top.ScaleType = Enum.ScaleType.Slice
Top.SliceCenter = Rect.new(12, 12, 12, 12)
Top.Parent = Bar

local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.BackgroundColor3 = Color3.new(1, 1, 1)
Tabs.BackgroundTransparency = 1
Tabs.Position = UDim2.new(0, 15, 0, 60)
Tabs.Size = UDim2.new(1, -30, 1, -60)
Tabs.Parent = Window

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 30, 0, 3)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Font = Enum.Font.GothamBold
Title.Text = "Gamer Time"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Window

local TabSelection = Instance.new("ImageLabel")
TabSelection.Name = "TabSelection"
TabSelection.BackgroundColor3 = Color3.new(1, 1, 1)
TabSelection.BackgroundTransparency = 1
TabSelection.Position = UDim2.new(0, 15, 0, 30)
TabSelection.Size = UDim2.new(1, -30, 0, 25)
TabSelection.Visible = false
TabSelection.Image = "rbxassetid://2851929490"
TabSelection.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
TabSelection.ScaleType = Enum.ScaleType.Slice
TabSelection.SliceCenter = Rect.new(4, 4, 4, 4)
TabSelection.Parent = Window

local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.BackgroundColor3 = Color3.new(1, 1, 1)
TabButtons.BackgroundTransparency = 1
TabButtons.Size = UDim2.new(1, 0, 1, 0)
TabButtons.Parent = TabSelection

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = TabButtons

local Frame = Instance.new("Frame")
Frame.BackgroundColor3 = Color3.new(0.12549, 0.227451, 0.372549)
Frame.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, 0)
Frame.Size = UDim2.new(1, 0, 0, 2)
Frame.Parent = TabSelection

local Tab = Instance.new("ScrollingFrame")
Tab.Name = "Tab"
Tab.BackgroundColor3 = Color3.new(1, 1, 1)
Tab.BackgroundTransparency = 1
Tab.Size = UDim2.new(1, 0, 1, 0)
Tab.Visible = false
Tab.ClipsDescendants = true
Tab.ScrollBarThickness = 0
Tab.Parent = Prefabs

local UIListLayout_2 = Instance.new("UIListLayout")
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 5)
UIListLayout_2.Parent = Tab

local TextBox = Instance.new("TextBox")
TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundTransparency = 1
TextBox.BorderSizePixel = 0
TextBox.Size = UDim2.new(1, 0, 0, 20)
TextBox.ClearTextOnFocus = false
TextBox.ZIndex = 2
TextBox.Font = Enum.Font.GothamSemibold
TextBox.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
TextBox.PlaceholderText = "Input Text"
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TextBox.TextSize = 14
TextBox.Parent = Prefabs

local TextBox_Roundify_4px = Instance.new("ImageLabel")
TextBox_Roundify_4px.Name = "TextBox_Roundify_4px"
TextBox_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox_Roundify_4px.BackgroundTransparency = 1
TextBox_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
TextBox_Roundify_4px.Image = "rbxassetid://2851929490"
TextBox_Roundify_4px.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextBox_Roundify_4px.ScaleType = Enum.ScaleType.Slice
TextBox_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)
TextBox_Roundify_4px.Parent = TextBox

local Slider = Instance.new("ImageLabel")
Slider.Name = "Slider"
Slider.BackgroundColor3 = Color3.new(1, 1, 1)
Slider.BackgroundTransparency = 1
Slider.Position = UDim2.new(0, 0, 0.178571433, 0)
Slider.Size = UDim2.new(1, 0, 0, 20)
Slider.Image = "rbxassetid://2851929490"
Slider.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
Slider.ScaleType = Enum.ScaleType.Slice
Slider.SliceCenter = Rect.new(4, 4, 4, 4)
Slider.Parent = Prefabs

local Title_2 = Instance.new("TextLabel")
Title_2.Name = "Title"
Title_2.BackgroundColor3 = Color3.new(1, 1, 1)
Title_2.BackgroundTransparency = 1
Title_2.Position = UDim2.new(0.5, 0, 0.5, -10)
Title_2.Size = UDim2.new(0, 0, 0, 20)
Title_2.ZIndex = 2
Title_2.Font = Enum.Font.GothamBold
Title_2.Text = "Slider"
Title_2.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_2.TextSize = 14
Title_2.Parent = Slider

local Indicator = Instance.new("ImageLabel")
Indicator.Name = "Indicator"
Indicator.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator.BackgroundTransparency = 1
Indicator.Size = UDim2.new(0, 0, 0, 20)
Indicator.Image = "rbxassetid://2851929490"
Indicator.ImageColor3 = Color3.new(0.254902, 0.262745, 0.278431)
Indicator.ScaleType = Enum.ScaleType.Slice
Indicator.SliceCenter = Rect.new(4, 4, 4, 4)
Indicator.Parent = Slider

local Value = Instance.new("TextLabel")
Value.Name = "Value"
Value.BackgroundColor3 = Color3.new(1, 1, 1)
Value.BackgroundTransparency = 1
Value.Position = UDim2.new(1, -55, 0.5, -10)
Value.Size = UDim2.new(0, 50, 0, 20)
Value.Font = Enum.Font.GothamBold
Value.Text = "0%"
Value.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Value.TextSize = 14
Value.Parent = Slider

local TextLabel = Instance.new("TextLabel")
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(1, -20, -0.75, 0)
TextLabel.Size = UDim2.new(0, 26, 0, 50)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "]"
TextLabel.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
TextLabel.TextSize = 14
TextLabel.Parent = Slider

local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(1, -65, -0.75, 0)
TextLabel_2.Size = UDim2.new(0, 26, 0, 50)
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.Text = "["
TextLabel_2.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
TextLabel_2.TextSize = 14
TextLabel_2.Parent = Slider

local Circle = Instance.new("ImageLabel")
Circle.Name = "Circle"
Circle.BackgroundColor3 = Color3.new(1, 1, 1)
Circle.BackgroundTransparency = 1
Circle.Image = "rbxassetid://266543268"
Circle.ImageTransparency = 0.5
Circle.Parent = Prefabs

local UIListLayout_3 = Instance.new("UIListLayout")
UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Padding = UDim.new(0, 20)
UIListLayout_3.Parent = Prefabs

local Dropdown = Instance.new("TextButton")
Dropdown.Name = "Dropdown"
Dropdown.BackgroundColor3 = Color3.new(1, 1, 1)
Dropdown.BackgroundTransparency = 1
Dropdown.BorderSizePixel = 0
Dropdown.Position = UDim2.new(-0.055555556, 0, 0.0833333284, 0)
Dropdown.Size = UDim2.new(0, 200, 0, 20)
Dropdown.ZIndex = 2
Dropdown.Font = Enum.Font.GothamBold
Dropdown.Text = "      Dropdown"
Dropdown.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Dropdown.TextSize = 14
Dropdown.TextXAlignment = Enum.TextXAlignment.Left
Dropdown.Parent = Prefabs

local Indicator_2 = Instance.new("ImageLabel")
Indicator_2.Name = "Indicator"
Indicator_2.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_2.BackgroundTransparency = 1
Indicator_2.Position = UDim2.new(0.899999976, -10, 0.100000001, 0)
Indicator_2.Rotation = -90
Indicator_2.Size = UDim2.new(0, 15, 0, 15)
Indicator_2.ZIndex = 2
Indicator_2.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"
Indicator_2.Parent = Dropdown

local Box = Instance.new("ImageButton")
Box.Name = "Box"
Box.BackgroundColor3 = Color3.new(1, 1, 1)
Box.BackgroundTransparency = 1
Box.Position = UDim2.new(0, 0, 0, 25)
Box.Size = UDim2.new(1, 0, 0, 150)
Box.ZIndex = 3
Box.Image = "rbxassetid://2851929490"
Box.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
Box.ScaleType = Enum.ScaleType.Slice
Box.SliceCenter = Rect.new(4, 4, 4, 4)
Box.Parent = Dropdown

local Objects = Instance.new("ScrollingFrame")
Objects.Name = "Objects"
Objects.BackgroundColor3 = Color3.new(1, 1, 1)
Objects.BackgroundTransparency = 1
Objects.BorderSizePixel = 0
Objects.Size = UDim2.new(1, 0, 1, 0)
Objects.ZIndex = 3
Objects.ScrollBarThickness = 4
Objects.ScrollBarImageColor3 = Color3.fromHex(Setting.MainColor)
Objects.ElasticBehavior = Enum.ElasticBehavior.Never
Objects.CanvasSize = UDim2.new(0, 0, 0, 0)
Objects.ScrollBarThickness = 8
Objects.Parent = Box

local UIListLayout_4 = Instance.new("UIListLayout")
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Parent = Objects

local TextButton_Roundify_4px = Instance.new("ImageLabel")
TextButton_Roundify_4px.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px.BackgroundTransparency = 1
TextButton_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextButton_Roundify_4px.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)
TextButton_Roundify_4px.Parent = Dropdown

local TabButton = Instance.new("TextButton")
TabButton.Name = "TabButton"
TabButton.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TabButton.BackgroundTransparency = 1
TabButton.BorderSizePixel = 0
TabButton.Position = UDim2.new(0.185185179, 0, 0, 0)
TabButton.Size = UDim2.new(0, 71, 0, 20)
TabButton.ZIndex = 2
TabButton.Font = Enum.Font.GothamSemibold
TabButton.Text = "Test tab"
TabButton.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TabButton.TextSize = 14
TabButton.Parent = Prefabs

local TextButton_Roundify_4px_2 = Instance.new("ImageLabel")
TextButton_Roundify_4px_2.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_2.BackgroundTransparency = 1
TextButton_Roundify_4px_2.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_2.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_2.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
TextButton_Roundify_4px_2.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_2.SliceCenter = Rect.new(4, 4, 4, 4)
TextButton_Roundify_4px_2.Parent = TabButton

local Folder = Instance.new("ImageLabel")
Folder.Name = "Folder"
Folder.BackgroundColor3 = Color3.new(1, 1, 1)
Folder.BackgroundTransparency = 1
Folder.Position = UDim2.new(0, 0, 0, 50)
Folder.Size = UDim2.new(1, 0, 0, 20)
Folder.Image = "rbxassetid://2851929490"
Folder.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
Folder.ScaleType = Enum.ScaleType.Slice
Folder.SliceCenter = Rect.new(4, 4, 4, 4)
Folder.Parent = Prefabs

local Button = Instance.new("TextButton")
Button.Name = "Button"
Button.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Button.BackgroundTransparency = 1
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 0, 20)
Button.ZIndex = 2
Button.Font = Enum.Font.GothamSemibold
Button.Text = "      Folder"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 14
Button.TextXAlignment = Enum.TextXAlignment.Left
Button.Parent = Folder

local TextButton_Roundify_4px_3 = Instance.new("ImageLabel")
TextButton_Roundify_4px_3.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_3.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_3.BackgroundTransparency = 1
TextButton_Roundify_4px_3.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_3.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_3.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_3.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_3.SliceCenter = Rect.new(4, 4, 4, 4)
TextButton_Roundify_4px_3.Parent = Button

local Toggle_2 = Instance.new("ImageLabel")
Toggle_2.Name = "Toggle"
Toggle_2.BackgroundColor3 = Color3.new(1, 1, 1)
Toggle_2.BackgroundTransparency = 1
Toggle_2.Position = UDim2.new(0, 5, 0, 0)
Toggle_2.Size = UDim2.new(0, 20, 0, 20)
Toggle_2.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
Toggle_2.Parent = Button

local Objects_2 = Instance.new("Frame")
Objects_2.Name = "Objects"
Objects_2.BackgroundColor3 = Color3.new(1, 1, 1)
Objects_2.BackgroundTransparency = 1
Objects_2.Position = UDim2.new(0, 10, 0, 25)
Objects_2.Size = UDim2.new(1, -10, 1, -25)
Objects_2.Visible = false
Objects_2.Parent = Folder

local UIListLayout_5 = Instance.new("UIListLayout")
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Padding = UDim.new(0, 5)
UIListLayout_5.Parent = Objects_2

local HorizontalAlignment = Instance.new("Frame")
HorizontalAlignment.Name = "HorizontalAlignment"
HorizontalAlignment.BackgroundColor3 = Color3.new(1, 1, 1)
HorizontalAlignment.BackgroundTransparency = 1
HorizontalAlignment.Size = UDim2.new(1, 0, 0, 20)
HorizontalAlignment.Parent = Prefabs

local UIListLayout_6 = Instance.new("UIListLayout")
UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_6.Padding = UDim.new(0, 5)
UIListLayout_6.Parent = HorizontalAlignment

local Console = Instance.new("ImageLabel")
Console.Name = "Console"
Console.BackgroundColor3 = Color3.new(1, 1, 1)
Console.BackgroundTransparency = 1
Console.Size = UDim2.new(1, 0, 0, 200)
Console.Image = "rbxassetid://2851928141"
Console.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
Console.ScaleType = Enum.ScaleType.Slice
Console.SliceCenter = Rect.new(8, 8, 8, 8)
Console.Parent = Prefabs

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Size = UDim2.new(1, 0, 1, 1)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Parent = Console

local Source = Instance.new("TextBox")
Source.Name = "Source"
Source.BackgroundColor3 = Color3.new(1, 1, 1)
Source.BackgroundTransparency = 1
Source.Position = UDim2.new(0, 40, 0, 0)
Source.Size = UDim2.new(1, -40, 0, 10000)
Source.ZIndex = 3
Source.ClearTextOnFocus = false
Source.Font = Enum.Font.Code
Source.MultiLine = true
Source.PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8)
Source.Text = ""
Source.TextColor3 = Color3.new(1, 1, 1)
Source.TextSize = 15
Source.TextStrokeColor3 = Color3.new(1, 1, 1)
Source.TextWrapped = true
Source.TextXAlignment = Enum.TextXAlignment.Left
Source.TextYAlignment = Enum.TextYAlignment.Top
Source.Parent = ScrollingFrame

local Comments = Instance.new("TextLabel")
Comments.Name = "Comments"
Comments.BackgroundColor3 = Color3.new(1, 1, 1)
Comments.BackgroundTransparency = 1
Comments.Size = UDim2.new(1, 0, 1, 0)
Comments.ZIndex = 5
Comments.Font = Enum.Font.Code
Comments.Text = ""
Comments.TextColor3 = Color3.new(0.231373, 0.784314, 0.231373)
Comments.TextSize = 15
Comments.TextXAlignment = Enum.TextXAlignment.Left
Comments.TextYAlignment = Enum.TextYAlignment.Top
Comments.Parent = Source

local Globals = Instance.new("TextLabel")
Globals.Name = "Globals"
Globals.BackgroundColor3 = Color3.new(1, 1, 1)
Globals.BackgroundTransparency = 1
Globals.Size = UDim2.new(1, 0, 1, 0)
Globals.ZIndex = 5
Globals.Font = Enum.Font.Code
Globals.Text = ""
Globals.TextColor3 = Color3.new(0.517647, 0.839216, 0.968628)
Globals.TextSize = 15
Globals.TextXAlignment = Enum.TextXAlignment.Left
Globals.TextYAlignment = Enum.TextYAlignment.Top
Globals.Parent = Source

local Keywords = Instance.new("TextLabel")
Keywords.Name = "Keywords"
Keywords.BackgroundColor3 = Color3.new(1, 1, 1)
Keywords.BackgroundTransparency = 1
Keywords.Size = UDim2.new(1, 0, 1, 0)
Keywords.ZIndex = 5
Keywords.Font = Enum.Font.Code
Keywords.Text = ""
Keywords.TextColor3 = Color3.new(0.972549, 0.427451, 0.486275)
Keywords.TextSize = 15
Keywords.TextXAlignment = Enum.TextXAlignment.Left
Keywords.TextYAlignment = Enum.TextYAlignment.Top
Keywords.Parent = Source

local RemoteHighlight = Instance.new("TextLabel")
RemoteHighlight.Name = "RemoteHighlight"
RemoteHighlight.BackgroundColor3 = Color3.new(1, 1, 1)
RemoteHighlight.BackgroundTransparency = 1
RemoteHighlight.Size = UDim2.new(1, 0, 1, 0)
RemoteHighlight.ZIndex = 5
RemoteHighlight.Font = Enum.Font.Code
RemoteHighlight.Text = ""
RemoteHighlight.TextColor3 = Color3.new(0, 0.568627, 1)
RemoteHighlight.TextSize = 15
RemoteHighlight.TextXAlignment = Enum.TextXAlignment.Left
RemoteHighlight.TextYAlignment = Enum.TextYAlignment.Top
RemoteHighlight.Parent = Source

local Strings = Instance.new("TextLabel")
Strings.Name = "Strings"
Strings.BackgroundColor3 = Color3.new(1, 1, 1)
Strings.BackgroundTransparency = 1
Strings.Size = UDim2.new(1, 0, 1, 0)
Strings.ZIndex = 5
Strings.Font = Enum.Font.Code
Strings.Text = ""
Strings.TextColor3 = Color3.new(0.678431, 0.945098, 0.584314)
Strings.TextSize = 15
Strings.TextXAlignment = Enum.TextXAlignment.Left
Strings.TextYAlignment = Enum.TextYAlignment.Top
Strings.Parent = Source

local Tokens = Instance.new("TextLabel")
Tokens.Name = "Tokens"
Tokens.BackgroundColor3 = Color3.new(1, 1, 1)
Tokens.BackgroundTransparency = 1
Tokens.Size = UDim2.new(1, 0, 1, 0)
Tokens.ZIndex = 5
Tokens.Font = Enum.Font.Code
Tokens.Text = ""
Tokens.TextColor3 = Color3.new(1, 1, 1)
Tokens.TextSize = 15
Tokens.TextXAlignment = Enum.TextXAlignment.Left
Tokens.TextYAlignment = Enum.TextYAlignment.Top
Tokens.Parent = Source

local Numbers = Instance.new("TextLabel")
Numbers.Name = "Numbers"
Numbers.BackgroundColor3 = Color3.new(1, 1, 1)
Numbers.BackgroundTransparency = 1
Numbers.Size = UDim2.new(1, 0, 1, 0)
Numbers.ZIndex = 4
Numbers.Font = Enum.Font.Code
Numbers.Text = ""
Numbers.TextColor3 = Color3.new(1, 0.776471, 0)
Numbers.TextSize = 15
Numbers.TextXAlignment = Enum.TextXAlignment.Left
Numbers.TextYAlignment = Enum.TextYAlignment.Top
Numbers.Parent = Source

local Info = Instance.new("TextLabel")
Info.Name = "Info"
Info.BackgroundColor3 = Color3.new(1, 1, 1)
Info.BackgroundTransparency = 1
Info.Size = UDim2.new(1, 0, 1, 0)
Info.ZIndex = 5
Info.Font = Enum.Font.Code
Info.Text = ""
Info.TextColor3 = Color3.new(0, 0.635294, 1)
Info.TextSize = 15
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = Source

local Lines = Instance.new("TextLabel")
Lines.Name = "Lines"
Lines.BackgroundColor3 = Color3.new(1, 1, 1)
Lines.BackgroundTransparency = 1
Lines.BorderSizePixel = 0
Lines.Size = UDim2.new(0, 40, 0, 10000)
Lines.ZIndex = 4
Lines.Font = Enum.Font.Code
Lines.Text = "1\n"
Lines.TextColor3 = Color3.new(1, 1, 1)
Lines.TextSize = 15
Lines.TextWrapped = true
Lines.TextYAlignment = Enum.TextYAlignment.Top
Lines.Parent = ScrollingFrame

local ColorPicker = Instance.new("ImageLabel")
ColorPicker.Name = "ColorPicker"
ColorPicker.BackgroundColor3 = Color3.new(1, 1, 1)
ColorPicker.BackgroundTransparency = 1
ColorPicker.Size = UDim2.new(0, 180, 0, 110)
ColorPicker.Image = "rbxassetid://2851929490"
ColorPicker.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
ColorPicker.ScaleType = Enum.ScaleType.Slice
ColorPicker.SliceCenter = Rect.new(4, 4, 4, 4)
ColorPicker.Parent = Prefabs

local Palette = Instance.new("ImageLabel")
Palette.Name = "Palette"
Palette.BackgroundColor3 = Color3.new(1, 1, 1)
Palette.BackgroundTransparency = 1
Palette.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
Palette.Size = UDim2.new(0, 100, 0, 100)
Palette.Image = "rbxassetid://698052001"
Palette.ScaleType = Enum.ScaleType.Slice
Palette.SliceCenter = Rect.new(4, 4, 4, 4)
Palette.Parent = ColorPicker

local Indicator_3 = Instance.new("ImageLabel")
Indicator_3.Name = "Indicator"
Indicator_3.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_3.BackgroundTransparency = 1
Indicator_3.Size = UDim2.new(0, 5, 0, 5)
Indicator_3.ZIndex = 2
Indicator_3.Image = "rbxassetid://2851926732"
Indicator_3.ImageColor3 = Color3.new(0, 0, 0)
Indicator_3.ScaleType = Enum.ScaleType.Slice
Indicator_3.SliceCenter = Rect.new(12, 12, 12, 12)
Indicator_3.Parent = Palette

local Sample = Instance.new("ImageLabel")
Sample.Name = "Sample"
Sample.BackgroundColor3 = Color3.new(1, 1, 1)
Sample.BackgroundTransparency = 1
Sample.Position = UDim2.new(0.800000012, 0, 0.0500000007, 0)
Sample.Size = UDim2.new(0, 25, 0, 25)
Sample.Image = "rbxassetid://2851929490"
Sample.ScaleType = Enum.ScaleType.Slice
Sample.SliceCenter = Rect.new(4, 4, 4, 4)
Sample.Parent = ColorPicker

local Saturation = Instance.new("ImageLabel")
Saturation.Name = "Saturation"
Saturation.BackgroundColor3 = Color3.new(1, 1, 1)
Saturation.Position = UDim2.new(0.649999976, 0, 0.0500000007, 0)
Saturation.Size = UDim2.new(0, 15, 0, 100)
Saturation.Image = "rbxassetid://3641079629"
Saturation.Parent = ColorPicker

local Indicator_4 = Instance.new("Frame")
Indicator_4.Name = "Indicator"
Indicator_4.BackgroundColor3 = Color3.new(1, 1, 1)
Indicator_4.BorderSizePixel = 0
Indicator_4.Size = UDim2.new(0, 20, 0, 2)
Indicator_4.ZIndex = 2
Indicator_4.Parent = Saturation

local Switch = Instance.new("TextButton")
Switch.Name = "Switch"
Switch.BackgroundColor3 = Color3.new(1, 1, 1)
Switch.BackgroundTransparency = 1
Switch.BorderSizePixel = 0
Switch.Position = UDim2.new(0.229411766, 0, 0.20714286, 0)
Switch.Size = UDim2.new(0, 20, 0, 20)
Switch.ZIndex = 2
Switch.Font = Enum.Font.SourceSans
Switch.Text = ""
Switch.TextColor3 = Color3.new(1, 1, 1)
Switch.TextSize = 18
Switch.Parent = Prefabs

local TextButton_Roundify_4px_4 = Instance.new("ImageLabel")
TextButton_Roundify_4px_4.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_4.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_4.BackgroundTransparency = 1
TextButton_Roundify_4px_4.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_4.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_4.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_4.ImageTransparency = 0.5
TextButton_Roundify_4px_4.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_4.SliceCenter = Rect.new(4, 4, 4, 4)
TextButton_Roundify_4px_4.Parent = Switch

local Title_3 = Instance.new("TextLabel")
Title_3.Name = "Title"
Title_3.BackgroundColor3 = Color3.new(1, 1, 1)
Title_3.BackgroundTransparency = 1
Title_3.Position = UDim2.new(1.20000005, 0, 0, 0)
Title_3.Size = UDim2.new(0, 20, 0, 20)
Title_3.Font = Enum.Font.GothamSemibold
Title_3.Text = "Switch"
Title_3.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_3.TextSize = 14
Title_3.TextXAlignment = Enum.TextXAlignment.Left
Title_3.Parent = Switch

local Button_2 = Instance.new("TextButton")
Button_2.Name = "Button"
Button_2.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
Button_2.BackgroundTransparency = 1
Button_2.BorderSizePixel = 0
Button_2.Size = UDim2.new(0, 91, 0, 20)
Button_2.ZIndex = 2
Button_2.Font = Enum.Font.GothamSemibold
Button_2.TextColor3 = Color3.new(1, 1, 1)
Button_2.TextSize = 14
Button_2.Parent = Prefabs

local TextButton_Roundify_4px_5 = Instance.new("ImageLabel")
TextButton_Roundify_4px_5.Name = "TextButton_Roundify_4px"
TextButton_Roundify_4px_5.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton_Roundify_4px_5.BackgroundTransparency = 1
TextButton_Roundify_4px_5.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_4px_5.Image = "rbxassetid://2851929490"
TextButton_Roundify_4px_5.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
TextButton_Roundify_4px_5.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_4px_5.SliceCenter = Rect.new(4, 4, 4, 4)
TextButton_Roundify_4px_5.Parent = Button_2

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.BackgroundColor3 = Color3.new(0.129412, 0.133333, 0.141176)
DropdownButton.BorderSizePixel = 0
DropdownButton.Size = UDim2.new(1, 0, 0, 20)
DropdownButton.ZIndex = 3
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Text = "      Button"
DropdownButton.TextColor3 = Color3.new(0.784313, 0.784313, 0.784313)
DropdownButton.TextSize = 14
DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
DropdownButton.Parent = Prefabs

local Keybind = Instance.new("ImageLabel")
Keybind.Name = "Keybind"
Keybind.BackgroundColor3 = Color3.new(1, 1, 1)
Keybind.BackgroundTransparency = 1
Keybind.Size = UDim2.new(0, 200, 0, 20)
Keybind.Image = "rbxassetid://2851929490"
Keybind.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
Keybind.ScaleType = Enum.ScaleType.Slice
Keybind.SliceCenter = Rect.new(4, 4, 4, 4)
Keybind.Parent = Prefabs

local Title_4 = Instance.new("TextLabel")
Title_4.Name = "Title"
Title_4.BackgroundColor3 = Color3.new(1, 1, 1)
Title_4.BackgroundTransparency = 1
Title_4.Size = UDim2.new(0, 0, 1, 0)
Title_4.Font = Enum.Font.GothamBold
Title_4.Text = "Keybind"
Title_4.AutomaticSize = Enum.AutomaticSize.X
Title_4.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Title_4.TextSize = 14
Title_4.TextXAlignment = Enum.TextXAlignment.Left
Title_4.Parent = Keybind

local Input = Instance.new("TextButton")
Input.Name = "Input"
Input.BackgroundColor3 = Color3.new(1, 1, 1)
Input.BackgroundTransparency = 1
Input.BorderSizePixel = 0
Input.Position = UDim2.new(1, -85, 0, 2)
Input.Size = UDim2.new(0, 80, 1, -4)
Input.ZIndex = 2
Input.Font = Enum.Font.GothamSemibold
Input.Text = "RShift"
Input.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Input.TextSize = 12
Input.TextWrapped = true
Input.Parent = Keybind

local Input_Roundify_4px = Instance.new("ImageLabel")
Input_Roundify_4px.Name = "Input_Roundify_4px"
Input_Roundify_4px.BackgroundColor3 = Color3.new(1, 1, 1)
Input_Roundify_4px.BackgroundTransparency = 1
Input_Roundify_4px.Size = UDim2.new(1, 0, 1, 0)
Input_Roundify_4px.Image = "rbxassetid://2851929490"
Input_Roundify_4px.ImageColor3 = Color3.new(0.290196, 0.294118, 0.313726)
Input_Roundify_4px.ScaleType = Enum.ScaleType.Slice
Input_Roundify_4px.SliceCenter = Rect.new(4, 4, 4, 4)
Input_Roundify_4px.Parent = Input

local Windows = Instance.new("Frame")
Windows.Name = "Windows"
Windows.BackgroundColor3 = Color3.new(1, 1, 1)
Windows.BackgroundTransparency = 1
Windows.Position = UDim2.new(0, 20, 0, 20)
Windows.Size = UDim2.new(1, 20, 1, -20)
Windows.Parent = NewInstance

local Checks = {
	["Binding"] = false,
}

local function IsKeyCode(Key)
	local success, Keycode = pcall(function()
		return Enum.KeyCode[Key]
	end)

	if success then
		return Keycode
	end

	return false
end

local function CheckType(Object, Type, _Default)
	if typeof(Object) == Type then
		if Type == "EnumItem" then
			for _, v in pairs(Enum[tostring(Object):split(".")[2]]:GetEnumItems()) do
				if v.Name == Object.Name then
					return v
				end
			end
		else
			return Object
		end
	end

	return typeof(_Default) == Type and _Default or nil
end

local function Resize(Part, New, _Delay)
	_Delay = _Delay or 0.5

	local TweenInfo = TweenInfo.new(_Delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(Part, TweenInfo, New):Play()
end

local function RGBToHSV(R, G, B)
	R, G, B = R / 255, G / 255, B / 255
	local Max, Min = math.max(R, G, B), math.min(R, G, B)
	local H, S, V
	V = Max

	local D = Max - Min

	if Max == 0 then
		S = 0
	else
		S = D / Max
	end

	if Max == Min then
		H = 0
	else
		if Max == R then
			H = (G - B) / D

			if G < B then
				H = H + 6
			end
		elseif Max == G then
			H = (B - R) / D + 2
		elseif Max == B then
			H = (R - G) / D + 4
		end

		H = H / 6
	end

	return H, S, V
end

-- Notification
local Notification_Container

if not NewInstance:FindFirstChild("Notification_Container") then
	Notification_Container = Instance.new("Frame")
	Notification_Container.Name = "Notification_Container"
	Notification_Container.Size = UDim2.new(0, 300, 0.627, 0)
	Notification_Container.ClipsDescendants = true
	Notification_Container.AnchorPoint = Vector2.new(0, 0.5)
	Notification_Container.Position = UDim2.new(0, 0, 0.471, 0)
	Notification_Container.BackgroundTransparency = 1
	Notification_Container.Parent = NewInstance

	local Notification_List = Instance.new("UIListLayout")
	Notification_List.Padding = UDim.new(0, 5)
	Notification_List.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Notification_List.SortOrder = Enum.SortOrder.LayoutOrder
	Notification_List.VerticalAlignment = Enum.VerticalAlignment.Bottom
	Notification_List.Parent = Notification_Container
else
	Notification_Container = NewInstance["Notifiction_Container"]
end

local function Notification(Notification_Opt, Color)
	Notification_Opt = CheckType(Notification_Opt, "table", {})
	Notification_Opt.Title = CheckType(Notification_Opt.Title, "string", "")
	Notification_Opt.Description = CheckType(Notification_Opt.Description, "string", "")
	Notification_Opt.Duration = CheckType(Notification_Opt.Duration, "number", 5)

	task.spawn(function()
		local Notification_Frame = Instance.new("Frame")
		local Notification_Main = Instance.new("Frame")
		local Notification_Description = Instance.new("TextLabel")
		local Container_Corner = Instance.new("UICorner")
		local Notification_Bar = Instance.new("Frame")
		local Notification_Title = Instance.new("TextLabel")
		local Bar_Corner = Instance.new("UICorner")

		Notification_Frame.Name = "Notification_Frame"
		Notification_Frame.BackgroundColor3 = Color3.fromRGB(19, 21, 22)
		Notification_Frame.BackgroundTransparency = 1
		Notification_Frame.Size = UDim2.new(0, 260, 0, 90)
		Notification_Frame.Parent = Notification_Container

		Notification_Main.Name = "Notification_Main"
		Notification_Main.BackgroundColor3 = Color3.fromRGB(19, 21, 22)
		Notification_Main.Position = UDim2.new(0, 1, 0, 1)
		Notification_Main.Parent = Notification_Frame

		if Notification_Opt.Title ~= "" then
			Notification_Bar.Name = "Notification_Bar"
			Notification_Bar.BackgroundColor3 = Color
			Notification_Bar.BorderSizePixel = 0
			Notification_Bar.Size = UDim2.new(0, 261, 0, 22)
			Notification_Bar.Parent = Notification_Main

			Notification_Title.Name = "Notification_Title"
			Notification_Title.BackgroundColor3 = Color
			Notification_Title.BackgroundTransparency = 1
			Notification_Title.BorderColor3 = Color
			Notification_Title.BorderSizePixel = 0
			Notification_Title.Position = UDim2.new(0, 8, 0, 3)
			Notification_Title.Size = UDim2.new(0, 252, 0, 19)
			Notification_Title.Font = Enum.Font.GothamMedium
			Notification_Title.Text = Notification_Opt.Title
			Notification_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Notification_Title.TextSize = 14
			Notification_Title.TextXAlignment = Enum.TextXAlignment.Left
			Notification_Title.Parent = Notification_Bar

			Bar_Corner.CornerRadius = UDim.new(0, 5)
			Bar_Corner.Name = "Bar_Corner"
			Bar_Corner.Parent = Notification_Bar
		end

		Notification_Description.Name = "Notification_Description"
		Notification_Description.Parent = Notification_Main
		Notification_Description.BackgroundTransparency = 1
		Notification_Description.BorderSizePixel = 0
		Notification_Description.Size = UDim2.new(0, 252, 0, 64)
		Notification_Description.Font = Enum.Font.GothamMedium
		Notification_Description.Text = Notification_Opt.Description
		Notification_Description.TextColor3 = Color3.fromRGB(255, 255, 255)
		Notification_Description.TextSize = 14
		Notification_Description.TextWrapped = true
		Notification_Description.TextXAlignment = Enum.TextXAlignment.Left
		Notification_Description.TextYAlignment = Enum.TextYAlignment.Top

		Container_Corner.Name = "Container_Corner"
		Container_Corner.Parent = Notification_Main

		if Notification_Opt.Title ~= "" then
			local Height = math.min(Notification_Title.TextBounds.Y + Notification_Description.TextBounds.Y + 10, 90)

			Notification_Description.Position = UDim2.new(0, 8, 0, 26)
			Notification_Main.Size = UDim2.new(0, 261, 0, Height + 7)
			Notification_Frame.Size = UDim2.new(0, 261, 0, Height + 7)
		else
			local Height = math.min(Notification_Description.TextBounds.Y + 15, 90)
			Notification_Description.Position = UDim2.new(0, 8, 0, 7)
			Notification_Main.Size = UDim2.new(0, 261, 0, Height + 5)
			Notification_Frame.Size = UDim2.new(0, 261, 0, Height + 5)
		end

		Notification_Frame.Position = UDim2.new(0, -261 - 10, 0.5, -45)
		Notification_Main.Position = UDim2.new(0, -261 - 10, 0.5, -45)
		TweenService:Create(Notification_Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0.5, -45)}):Play()
		task.wait(Notification_Opt.Duration)
		TweenService:Create(Notification_Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0, -261 - 10, 0.5, -45)}):Play()
		task.wait(0.5)
		Notification_Frame:Destroy()
	end)
end

local function HasProp(Object, Prop)
	local a, b = pcall(function()
		return Object[tostring(Prop)]
	end)

	if a then
		return b
	end
end

local function GetNameLen(Object)
	return Object.TextBounds.X + 15
end

local function GetMouse()
	return Vector2.new(UserInputService:GetMouseLocation().X + 1, UserInputService:GetMouseLocation().Y - 35)
end

local function Ripple(_Button, X, Y)
	task.spawn(function()
		_Button.ClipsDescendants = true

		local _Circle = Prefabs:FindFirstChild("Circle"):Clone()
		_Circle.ZIndex = 1000
		_Circle.Parent = _Button

		local New_X = X - _Circle.AbsolutePosition.X
		local New_Y = Y - _Circle.AbsolutePosition.Y
		_Circle.Position = UDim2.new(0, New_X, 0, New_Y)

		local Size = 0

		if _Button.AbsoluteSize.X > _Button.AbsoluteSize.Y then
			Size = _Button.AbsoluteSize.X * 1.5
		elseif _Button.AbsoluteSize.X < _Button.AbsoluteSize.Y then
			Size = _Button.AbsoluteSize.Y * 1.5
		elseif _Button.AbsoluteSize.X == _Button.AbsoluteSize.Y then
			Size = _Button.AbsoluteSize.X * 1.5
		end

		TweenService:Create(
			_Circle,
			TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, Size, 0, Size), Position = UDim2.new(0.5, -Size / 2, 0.5, -Size / 2) }
		):Play()
		Resize(_Circle, { ImageTransparency = 1 }, 0.5)

		task.wait(0.5)
		_Circle:Destroy()
	end)
end

local _Windows = 0
local Library = {}

-- Format Window
local _UIListLayout = Prefabs:FindFirstChild("UIListLayout"):Clone()
_UIListLayout.Parent = Windows

local Data = {}

for _, v in next, Windows:GetChildren() do
	if not v:IsA("UIListLayout") then
		Data[v] = v.AbsolutePosition
	end
end

_UIListLayout:Destroy()

for i, v in next, Data do
	i.Position = UDim2.new(0, v.X, 0, v.Y)
end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == CheckType(IsKeyCode(Setting.ToggleKey), "EnumItem", IsKeyCode(Default.ToggleKey)) then
		if not Checks.Binding then
			NewInstance.Enabled = not NewInstance.Enabled
		end
	end
end)

-- UI Elements
function Library:AddWindow(title, Options)
	_Windows = _Windows + 1

	local Dropdown_Open = false

	title = CheckType(title, "string", "Window")
	Options = CheckType(Options, "table", {})

	Options.MainColor = CheckType(Options.MainColor, "Color3", Color3.fromHex(Setting.MainColor))
	Options.CanResize = CheckType(Options.CanResize, "boolean", Setting.CanResize)
	Options.MinSize = CheckType(Options.MinSize, "Vector2", Vector2.new(Setting.MinSize.X, Setting.MinSize.Y))
	Options.TweenTime = 0.1

	local NewWindow = Prefabs:FindFirstChild("Window"):Clone()

	NewWindow.Parent = Windows
	NewWindow:FindFirstChild("Title").Text = title
	NewWindow.Size = UDim2.new(0, Options.MinSize.X, 0, 0)
	NewWindow.ZIndex = NewWindow.ZIndex + (_Windows * 10)

	Resize(NewWindow, {Size = UDim2.new(0, Options.MinSize.X, 0, Options.MinSize.Y)}, 1)

	local _Bar = NewWindow:FindFirstChild("Bar")
	local _Base = _Bar:FindFirstChild("Base")
	local _Top = _Bar:FindFirstChild("Top")
	local _SplitFrame = NewWindow:FindFirstChild("TabSelection"):FindFirstChild("Frame")

	_Bar.BackgroundColor3 = Options.MainColor
	_Base.BackgroundColor3 = Options.MainColor
	_Base.ImageColor3 = Options.MainColor
	_Top.ImageColor3 = Options.MainColor
	_SplitFrame.BackgroundColor3 = Options.MainColor

	Colors[#Colors + 1] = _Bar
	Colors[#Colors + 1] = _Base
	Colors[#Colors + 1] = _Base
	Colors[#Colors + 1] = _Top
	Colors[#Colors + 1] = _SplitFrame

	local _Resizer = NewWindow:WaitForChild("Resizer")

	local Window_Data = {}
	NewWindow.Draggable = true

	-- Resize Windows
	local OldIcon = Mouse.Icon
	local Entered = false

	_Resizer.MouseEnter:Connect(function()
		NewWindow.Draggable = false

		if Options.CanResize then
			OldIcon = Mouse.Icon
		end

		Entered = true
	end)

	_Resizer.MouseLeave:Connect(function()
		Entered = false

		if Options.CanResize then
			Mouse.Icon = OldIcon
		end

		NewWindow.Draggable = true
	end)

	local Held = false

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Held = true

			task.spawn(function()
				if Entered and _Resizer.Active and Options.CanResize then
					while Held and _Resizer.Active do
						local Mouse_Location = GetMouse()
						local X = Mouse_Location.X - NewWindow.AbsolutePosition.X
						local Y = Mouse_Location.Y - NewWindow.AbsolutePosition.Y

						if X >= Options.MinSize.X and Y >= Options.MinSize.Y then
							Resize(NewWindow, { Size = UDim2.new(0, X, 0, Y) }, Options.TweenTime)
						elseif X >= Options.MinSize.X then
							Resize(NewWindow, { Size = UDim2.new(0, X, 0, Options.MinSize.Y) }, Options.TweenTime)
						elseif Y >= Options.MinSize.Y then
							Resize(NewWindow, { Size = UDim2.new(0, Options.MinSize.X, 0, Y) }, Options.TweenTime)
						else
							Resize(NewWindow, { Size = UDim2.new(0, Options.MinSize.X, 0, Options.MinSize.Y)}, Options.TweenTime)
						end

						task.wait()
					end
				end
			end)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Held = false
		end
	end)

	-- [Open / Close] Window
	local Open_Close = NewWindow:FindFirstChild("Bar"):FindFirstChild("Toggle")
	local Open = true
	local CanOpen = true

	local OldWindowData = {}
	local OldY = NewWindow.AbsoluteSize.Y

	Open_Close.MouseButton1Click:Connect(function()
		if CanOpen then
			CanOpen = false

			if Open then
				OldWindowData = {}

				for _, v in next, NewWindow:FindFirstChild("Tabs"):GetChildren() do
					OldWindowData[v] = v.Visible
					v.Visible = false
				end

				Resizer.Active = false

				OldY = NewWindow.AbsoluteSize.Y
				Resize(Open_Close, { Rotation = 0 }, Options.TweenTime)
				Resize(NewWindow, { Size = UDim2.new(0, NewWindow.AbsoluteSize.X, 0, 26) }, Options.TweenTime)
				Open_Close.Parent:FindFirstChild("Base").Transparency = 1
			else
				for i, v in next, OldWindowData do
					i.Visible = v
				end

				Resizer.Active = true

				Resize(Open_Close, { Rotation = 90 }, Options.TweenTime)
				Resize(NewWindow, { Size = UDim2.new(0, NewWindow.AbsoluteSize.X, 0, OldY) }, Options.TweenTime)
				Open_Close.Parent:FindFirstChild("Base").Transparency = 0
			end

			Open = not Open
			task.wait(Options.TweenTime)
			CanOpen = true
		end
	end)

	local NewTabs = NewWindow:FindFirstChild("Tabs")
	local Tab_Selection = NewWindow:FindFirstChild("TabSelection")
	local Tab_Buttons = Tab_Selection:FindFirstChild("TabButtons")

	function Window_Data:AddTab(Tab_Text, Tab_Opt)
		Tab_Text = CheckType(Tab_Text, "string", "Tab")
		Tab_Selection.Visible = true

		Tab_Opt = CheckType(Tab_Opt, "table", {})
		Tab_Opt.TextColor = CheckType(Tab_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
		Tab_Opt.Visible = CheckType(Tab_Opt.Visible, "boolean", true)
		Tab_Opt.ReadOnly = CheckType(Tab_Opt.ReadOnly, "boolean", false)

		local Tab_Data = {}

		local NewButton = Prefabs:FindFirstChild("TabButton"):Clone()

		NewButton.Parent = Tab_Buttons
		NewButton.Text = Tab_Text
		NewButton.Name = Tab_Text
		NewButton.Size = UDim2.new(0, GetNameLen(NewButton), 0, 20)
		NewButton.ZIndex = NewButton.ZIndex + (_Windows * 10)

		NewButton:GetChildren()[1].ZIndex = NewButton:GetChildren()[1].ZIndex + (_Windows * 10)

		local NewTab = Prefabs:FindFirstChild("Tab"):Clone()
		local TabListLayout = NewTab:FindFirstChild("UIListLayout")

		NewTab.Parent = NewTabs
		NewTab.Visible = Tab_Opt.Visible
		NewTab.ZIndex = NewTab.ZIndex + (_Windows * 10)

		TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			NewTab.CanvasSize = UDim2.fromOffset(0, TabListLayout.AbsoluteContentSize.Y + 10)
		end)

		local function Show()
			if Dropdown_Open then
				return
			end

			for _, v in next, Tab_Buttons:GetChildren() do
				if not v:IsA("UIListLayout") then
					v:GetChildren()[1].ImageColor3 = Color3.fromRGB(52, 53, 56)
					Resize(v, { Size = UDim2.new(0, v.AbsoluteSize.X, 0, 20) }, Options.TweenTime)
				end
			end

			for _, v in next, NewTabs:GetChildren() do
				v.Visible = false
			end

			Resize(NewButton, { Size = UDim2.new(0, NewButton.AbsoluteSize.X, 0, 25) }, Options.TweenTime)
			NewButton:GetChildren()[1].ImageColor3 = Color3.fromRGB(73, 75, 79)
			NewTab.Visible = true
		end

		NewButton.MouseButton1Click:Connect(function()
			if not Tab_Opt.ReadOnly then
				Show()
			end
		end)

		function Tab_Data:Show()
			Show()
		end

		function Tab_Data:AddSeparator(Visible)
			Visible = CheckType(Visible, "boolean", true)

			local Separator_Data = {}

			local Separator = Tab_Selection:FindFirstChild("Frame"):Clone()

			Separator.Parent = NewTab
			Separator.Visible = Visible

			if Separator then
				Separator.BackgroundColor3 = Options.MainColor
				Colors[#Colors + 1] = Separator
			end

			return setmetatable(Separator_Data, {
				__newindex = function(t, k, v)
					if k == "Visible" then
						Separator.Visible = CheckType(v, "boolean", Separator.Visible)
					end
				end,
				__index = function(t, k, v)
					if k == "Visible" then
						return Separator.Visible
					end
				end,
			}),
				Separator
		end

		function Tab_Data:AddLabel(Label_Text, Label_Opt)
            Label_Text = CheckType(Label_Text, "string", "Label")

			Label_Opt = CheckType(Label_Opt, "table", {})
            Label_Opt.Visible = CheckType(Label_Opt.Visible, "boolean", true)
            Label_Opt.TextColor = CheckType(Label_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            Label_Opt.MouseEnter = CheckType(Label_Opt.MouseEnter, "function", function() end)
            Label_Opt.MouseLeave = CheckType(Label_Opt.MouseLeave, "function", function() end)

			local Label_Data = {}

			local NewLabel = Prefabs:FindFirstChild("Label"):Clone()

			NewLabel.Parent = NewTab
			NewLabel.Text = Label_Text
			NewLabel.TextColor3 = Label_Opt.TextColor
            NewLabel.Visible = Label_Opt.Visible
			NewLabel.Size = UDim2.new(0, GetNameLen(NewLabel), 0, 20)
			NewLabel.ZIndex = NewLabel.ZIndex + (_Windows * 10)

            NewLabel.MouseEnter:Connect(function()
                Label_Opt.MouseEnter(Label_Data)
            end)

            NewLabel.MouseLeave:Connect(function()
                Label_Opt.MouseLeave(Label_Data)
            end)

			return setmetatable(Label_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						NewLabel.Text = v
						NewLabel.Size = UDim2.new(0, GetNameLen(NewLabel), 0, 20)
					elseif k == "TextColor" then
						NewLabel.TextColor3 = CheckType(v, "Color3", NewLabel.TextColor3) 
					elseif k == "Visible" then
						NewLabel.Visible = CheckType(v, "boolean", NewLabel.Visible) 
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return NewLabel.Text
					elseif k == "TextColor" then
						return NewLabel.TextColor3
					elseif k == "Visible" then
						return NewLabel.Visible
					end
				end,
			}), NewLabel
		end

		function Tab_Data:AddButton(Button_Text, Callback, Button_Opt)
			Button_Text = CheckType(Button_Text, "string", "Button")
			Callback = CheckType(Callback, "function", function() end)

            Button_Opt = CheckType(Button_Opt, "table", {})
            Button_Opt.Visible = CheckType(Button_Opt.Visible, "boolean", true)
            Button_Opt.TextColor = CheckType(Button_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            Button_Opt.ReadOnly = CheckType(Button_Opt.ReadOnly, "boolean", false)

			local Button_Data = {}

			local _NewButton = Prefabs:FindFirstChild("Button"):Clone()

			_NewButton.Parent = NewTab
			_NewButton.Text = Button_Text
            _NewButton.Visible = Button_Opt.Visible
            _NewButton.TextColor3 = Button_Opt.TextColor
			_NewButton.Size = UDim2.new(0, GetNameLen(_NewButton), 0, 20)
			_NewButton.ZIndex = _NewButton.ZIndex + (_Windows * 10)

			_NewButton:GetChildren()[1].ZIndex = _NewButton:GetChildren()[1].ZIndex + (_Windows * 10)

			if _NewButton and _NewButton:GetChildren()[1] then
				_NewButton:GetChildren()[1].ImageColor3 = Options.MainColor
				Colors[#Colors + 1] = _NewButton:GetChildren()[1]
			end

			_NewButton.MouseButton1Click:Connect(function()
                if not Button_Opt.ReadOnly then
                    Ripple(_NewButton, Mouse.X, Mouse.Y)
                    Callback(Button_Data)
                end
			end)

			return setmetatable(Button_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						_NewButton.Text = v
						_NewButton.Size = UDim2.new(0, GetNameLen(_NewButton), 0, 20)
					elseif k == "Visible" then
						_NewButton.Visible = v
                    elseif k == "TextColor" then
                        _NewButton.TextColor3 = CheckType(v, "Color3", _NewButton.TextColor3)
					elseif k == "ReadOnly" then
						Button_Opt.ReadOnly = CheckType(v, "boolean", Button_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return _NewButton.Text
					elseif k == "Visible" then
						return _NewButton.Visible
                    elseif k == "TextColor" then
                        return _NewButton.TextColor3
					elseif k == "ReadOnly" then
						return Button_Opt.ReadOnly
					end
				end
			}), _NewButton
		end

		function Tab_Data:AddSwitch(Switch_Text, Callback, Switch_Opt)
			Switch_Text = CheckType(Switch_Text, "string", "Switch")
			Callback = CheckType(Callback, "function", function() end)

            Switch_Opt = CheckType(Switch_Opt, "table", {})
			Switch_Opt.Enabled = CheckType(Switch_Opt.Enabled, "boolean", false)
            Switch_Opt.TextColor = CheckType(Switch_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            Switch_Opt.Visible = CheckType(Switch_Opt.Visible, "boolean", true)
            Switch_Opt.ReadOnly = CheckType(Switch_Opt.ReadOnly, "boolean", false)

            local Switch_Data = {}

			local NewSwitch = Prefabs:FindFirstChild("Switch"):Clone()

			NewSwitch.Parent = NewTab
            NewSwitch.Visible = Switch_Opt.Visible

            NewSwitch:FindFirstChild("Title").TextColor3 = Switch_Opt.TextColor
			NewSwitch:FindFirstChild("Title").Text = Switch_Text

			NewSwitch:FindFirstChild("Title").ZIndex = NewSwitch:FindFirstChild("Title").ZIndex + (_Windows * 10)
			NewSwitch.ZIndex = NewSwitch.ZIndex + (_Windows * 10)
			NewSwitch:GetChildren()[1].ZIndex = NewSwitch:GetChildren()[1].ZIndex + (_Windows * 10)

			if NewSwitch and NewSwitch:GetChildren()[1] then
				NewSwitch:GetChildren()[1].ImageColor3 = Options.MainColor
				Colors[#Colors + 1] = NewSwitch:GetChildren()[1]
			end

            if Switch_Opt.Enabled and not Switch_Opt.ReadOnly then
                NewSwitch.Text = Switch_Opt.Enabled and utf8.char(10003) or ""
				Callback(Switch_Opt.Enabled, Switch_Data)
            end

			NewSwitch.MouseButton1Click:Connect(function()
                if not Switch_Opt.ReadOnly then
                    Switch_Opt.Enabled = not Switch_Opt.Enabled

                    NewSwitch.Text = Switch_Opt.Enabled and utf8.char(10003) or ""
                    Callback(Switch_Opt.Enabled, Switch_Data)
                end
			end)

			local Connection
			Connection = NewInstance:GetPropertyChangedSignal("Parent"):Connect(function()
				if not NewInstance.Parent then
					if Switch_Opt.Enabled then
						Switch_Opt.Enabled = false
						Callback(Switch_Opt.Enabled, Switch_Data)

						Connection:Disconnect()
					else
						Connection:Disconnect()
					end
				end
			end)

			return setmetatable(Switch_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						NewSwitch:FindFirstChild("Title").Text = tostring(v)
					elseif k == "State" then
                        if not Switch_Opt.ReadOnly then
                            Switch_Opt.Enabled = CheckType(v, "boolean", Switch_Opt.Enabled)

                            NewSwitch.Text = Switch_Opt.Enabled and utf8.char(10003) or ""
                            Callback(Switch_Opt.Enabled, Switch_Data)
                        end
                    elseif k == "TextColor" then
                        NewSwitch:FindFirstChild("Title").TextColor3 = CheckType(v, "Color3", NewSwitch:FindFirstChild("Title").TextColor3)
                    elseif k == "Visible" then
                        NewSwitch.Visible = CheckType(v, "boolean", NewSwitch.Visible)
                    elseif k == "ReadOnly" then
                        Switch_Opt.ReadOnly = CheckType(v, "boolean", Switch_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return NewSwitch:FindFirstChild("Title").Text
					elseif k == "State" then
						return Switch_Opt.Enabled
                    elseif k == "TextColor" then
                        return NewSwitch:FindFirstChild("Title").TextColor3
                    elseif k == "Visible" then
                        return NewSwitch.Visible
                    elseif k == "ReadOnly" then
                        return Switch_Opt.ReadOnly
					end
				end,
			}), NewSwitch
		end

		function Tab_Data:AddTextBox(TextBox_Text, Callback, TextBox_Opt)
			TextBox_Text = CheckType(TextBox_Text, "string", "TextBox")
			Callback = CheckType(Callback, "function", function() end)

			TextBox_Opt = CheckType(TextBox_Opt, "table", {})
            TextBox_Opt.TextColor = CheckType(TextBox_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            TextBox_Opt.Visible = CheckType(TextBox_Opt.Visible, "boolean", true)
            TextBox_Opt.ReadOnly = CheckType(TextBox_Opt.ReadOnly, "boolean", false)
			TextBox_Opt.Clear = CheckType(TextBox_Opt.Clear, "boolean", true)
			TextBox_Opt.Default = CheckType(TextBox_Opt.Default, "string", "")
			TextBox_Opt.Type = CheckType(TextBox_Opt.Type, "string", "string")

			local TextBox_Data = {}
			local Backup = ""

			local NewTextBox = Prefabs:FindFirstChild("TextBox"):Clone()

			NewTextBox.Parent = NewTab
			NewTextBox.PlaceholderText = TextBox_Text
			NewTextBox.TextEditable = not TextBox_Opt.ReadOnly
			NewTextBox.Text = TextBox_Opt.Default
            NewTextBox.TextColor3 = TextBox_Opt.TextColor
            NewTextBox.Visible = TextBox_Opt.Visible
			NewTextBox.ZIndex = NewTextBox.ZIndex + (_Windows * 10)
			NewTextBox:GetChildren()[1].ZIndex = NewTextBox:GetChildren()[1].ZIndex + (_Windows * 10)

			NewTextBox:GetPropertyChangedSignal("Text"):Connect(function()
				if TextBox_Opt.Type == "number" and not tonumber(NewTextBox.Text) and NewTextBox.Text:sub(1, #NewTextBox.Text) ~= "-" then
					NewTextBox.Text = ""
				end
			end)

			NewTextBox.FocusLost:Connect(function(EnterPressed)
				if EnterPressed then
					if #NewTextBox.Text > 0 then
						if TextBox_Opt.Type == "string" then
							Callback(tostring(NewTextBox.Text), TextBox_Data)
						elseif TextBox_Opt.Type == "number" then
							Callback(tonumber(NewTextBox.Text), TextBox_Data)
						end

						if TextBox_Opt.Clear then
							Backup = NewTextBox.Text
							NewTextBox.Text = ""
						end
					end
				end
			end)

			return setmetatable(TextBox_Data, {
				__newindex = function(t, k, v)
					if k == "Title" then
						if #v > 0 then
							NewTextBox.PlaceholderText = CheckType(v, "string", NewTextBox.PlaceholderText)
						end
					elseif k == "Text" then
						if #v > 0 and not TextBox_Opt.ReadOnly then
							if TextBox_Opt.Type == "string" then
								Callback(tostring(v), TextBox_Data)
							elseif TextBox_Opt.Type == "number" then
								if tonumber(v) then
									NewTextBox.Text = ""
									Callback(tonumber(v), TextBox_Data)
								end
							end

							NewTextBox.Text = CheckType(v, TextBox_Opt.Type, NewTextBox.Text)

							if TextBox_Opt.Clear then
								Backup = NewTextBox.Text
								NewTextBox.Text = ""
							end
						end
					elseif k == "Type" then
						if v == "string" then
							TextBox_Opt.Type = CheckType("string", "string", TextBox_Opt.Type)
						elseif v == "number" then
							TextBox_Opt.Type = CheckType("number", "string", TextBox_Opt.Type)
						end
					elseif k == "Clear" then
						TextBox_Opt.Clear = CheckType(v, "boolean", TextBox_Opt.Clear)
                    elseif k == "TextColor" then
                        NewTextBox.TextColor3 = CheckType(v, "Color3", NewTextBox.TextColor3)
                    elseif k == "Visible" then
                        NewTextBox.Visible = CheckType(v, "boolean", NewTextBox.Visible)
					elseif k == "ReadOnly" then
						TextBox_Opt.ReadOnly = CheckType(v, "boolean", TextBox_Opt.ReadOnly)
						NewTextBox.TextEditable = TextBox_Opt.ReadOnly
					end
				end,
				__index = function(t, k)
					if k == "Title" then
						return NewTextBox.PlaceholderText
					elseif k == "Text" then
						return TextBox_Opt.Clear and Backup or NewTextBox.Text
					elseif k == "Type" then
						return TextBox_Opt.Type
					elseif k == "Clear" then
						return TextBox_Opt.Clear
                    elseif k == "TextColor" then
                        return NewTextBox.TextColor3
                    elseif k == "Visible" then
                        return NewTextBox.Visible
					elseif k == "ReadOnly" then
						return TextBox_Opt.ReadOnly
					end
				end,
			}), NewTextBox
		end

		function Tab_Data:AddSlider(Slider_Text, Callback, Slider_Opt)
			Slider_Text = CheckType(Slider_Text, "string", "Slider")
			Callback = CheckType(Callback, "function", function() end)

			Slider_Opt = CheckType(Slider_Opt, "table", {})
            Slider_Opt.TextColor = CheckType(Slider_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            Slider_Opt.Visible = CheckType(Slider_Opt.Visible, "boolean", true)
			Slider_Opt.Min = CheckType(Slider_Opt.Min, "number", 0)
			Slider_Opt.Max = CheckType(Slider_Opt.Max, "number", 100)
			Slider_Opt.Default = CheckType(Slider_Opt.Default, "number", 50)
			Slider_Opt.ReadOnly = CheckType(Slider_Opt.ReadOnly, "boolean", false)

			local Slider_Data = {}

			local NewSlider = Prefabs:FindFirstChild("Slider"):Clone()

			NewSlider.Parent = NewTab
            NewSlider.Visible = Slider_Opt.Visible
			NewSlider.ZIndex = NewSlider.ZIndex + (_Windows * 10)

			local Slider_Title = NewSlider:FindFirstChild("Title")
			local Slider_Indicator = NewSlider:FindFirstChild("Indicator")
			local Slider_Value = NewSlider:FindFirstChild("Value")

			Slider_Title.ZIndex = Slider_Title.ZIndex + (_Windows * 10)
			Slider_Indicator.ZIndex = Slider_Indicator.ZIndex + (_Windows * 10)
			Slider_Value.ZIndex = Slider_Value.ZIndex + (_Windows * 10)

			Slider_Title.Text = Slider_Text
            Slider_Title.TextColor3 = Slider_Opt.TextColor

			local Slider_Entered = false

			NewSlider.MouseEnter:Connect(function()
				Slider_Entered = true
				NewWindow.Draggable = false
			end)

			NewSlider.MouseLeave:Connect(function()
				Slider_Entered = false
				NewWindow.Draggable = true
			end)

			local Slider_Held = false

			if Slider_Opt.Default > Slider_Opt.Max then
				Slider_Opt.Default = Slider_Opt.Max
			elseif Slider_Opt.Default < Slider_Opt.Min then
				Slider_Opt.Default = Slider_Opt.Min
			end

			Slider_Value.Text = tostring(Slider_Opt.Default)
			Resize(Slider_Indicator, {Size = UDim2.new((((Slider_Opt.Default >= 0 and Slider_Opt.Default <= 100) and Slider_Opt.Default) / 100) or 0, 0, 0, 20),}, Options.TweenTime)

			UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Slider_Held = true

					task.spawn(function()
						if Slider_Entered and not Slider_Opt.ReadOnly then
							while Slider_Held and not Dropdown_Open do
								local Mouse_Location = GetMouse()
								local X = (
									NewSlider.AbsoluteSize.X
									- (NewSlider.AbsoluteSize.X - (Mouse_Location.X - NewSlider.AbsolutePosition.X) + 1)
								) / NewSlider.AbsoluteSize.X

								local Min = 0
								local Max = 1

								local Size = Min

								if X >= Min and X <= Max then
									Size = X
								elseif X < Min then
									Size = Min
								elseif X > Max then
									Size = Max
								end

								Resize(Slider_Indicator, { Size = UDim2.new(Size or Min, 0, 0, 20) }, Options.TweenTime)
								local P = math.floor((Size or Min) * 100)

								local MaxV = Slider_Opt.Max
								local MinV = Slider_Opt.Min
								local Diff = MaxV - MinV

								local Sel_Value = math.floor(((Diff / 100) * P) + MinV)
								Slider_Value.Text = tostring(Sel_Value)
								Callback(Sel_Value, Slider_Data)

								task.wait()
							end
						end
					end)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Slider_Held = false
				end
			end)

			return setmetatable(Slider_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						Slider_Title.Text = CheckType(v, "string", Slider_Title.Text)
					elseif k == "Value" then
						v = CheckType(v, "number", 0)
						v = (((v >= 0 and v <= 100) and v) / 100)

						Resize(Slider_Indicator, { Size = UDim2.new(v or 0, 0, 0, 20) }, Options.TweenTime)
						local P = math.floor((v or 0) * 100)

						local MaxV = Slider_Opt.max
						local MinV = Slider_Opt.min
						local Diff = MaxV - MinV

						local Sel_Value = math.floor(((Diff / 100) * P) + MinV)
						Slider_Value.Text = tostring(Sel_Value)
						Callback(Sel_Value, Slider_Data)
					elseif k == "TextColor" then
						Slider_Title.TextColor3 = CheckType(v, "Color3", Slider_Title.TextColor3)				
					elseif k == "Visible" then
						NewSlider.Visible = CheckType(v, "boolean", NewSlider.Visible)
					elseif k == "ReadOnly" then
						Slider_Opt.ReadOnly = CheckType(v, "boolean", Slider_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return Slider_Title.Text
					elseif k == "Value" then
						return tonumber(Slider_Value.Text)
					elseif k == "TextColor" then
						return Slider_Title.TextColor3
					elseif k == "Visible" then
						return NewSlider.Visible
					elseif k == "ReadOnly" then
						return Slider_Opt.ReadOnly
					end
				end,
			}), NewSlider
		end

		function Tab_Data:AddKeybind(Keybind_Text, Callback, Keybind_Opt)
			Keybind_Text = CheckType(Keybind_Text, "string", "Keybind")
			Callback = CheckType(Callback, "function", function() end)

			Keybind_Opt = CheckType(Keybind_Opt, "table", {})
			Keybind_Opt.TextColor = CheckType(Keybind_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
			Keybind_Opt.Default = CheckType(Keybind_Opt.Default, "EnumItem", Enum.KeyCode.RightShift)
			Keybind_Opt.Enabled = CheckType(Keybind_Opt.Enabled, "boolean", false)
			Keybind_Opt.Visible = CheckType(Keybind_Opt.Visible, "boolean", true)
            Keybind_Opt.ReadOnly = CheckType(Keybind_Opt.ReadOnly, "boolean", false)
			Keybind_Opt.Notify = CheckType(Keybind_Opt.Notify, "boolean", false)

			local KeyBind_Data = {}
			local Shortkeys = {
				RightControl = "RightCtrl",
				LeftControl = "LeftCtrl",
				LeftShift = "LShift",
				RightShift = "RShift",
				MouseButton1 = "Mouse1",
				MouseButton2 = "Mouse2",
			}

			local Blacklisted = {
				Enum.KeyCode.A,
				Enum.KeyCode.W,
				Enum.KeyCode.D,
				Enum.KeyCode.S,
				Enum.KeyCode.Space,
				Enum.KeyCode.Escape,
				Enum.KeyCode.F9,
				Enum.KeyCode.Backquote,
				Enum.KeyCode.Tab,
				Enum.KeyCode.Backspace,
				Enum.KeyCode.CapsLock,
				Enum.KeyCode.Insert,
				Enum.KeyCode.Up,
				Enum.KeyCode.Down,
				Enum.KeyCode.Left,
				Enum.KeyCode.Right,
				Enum.KeyCode.F12,
				Enum.KeyCode.Print,
			}

			local keybind = Keybind_Opt.Default.Name

			local NewKeybind = Prefabs:FindFirstChild("Keybind"):Clone()
			local Keybind_Input = NewKeybind:FindFirstChild("Input")
			local Keybind_Title = NewKeybind:FindFirstChild("Title")

			NewKeybind.ZIndex = NewKeybind.ZIndex + (_Windows * 10)
			Keybind_Input.ZIndex = Keybind_Input.ZIndex + (_Windows * 10)
			Keybind_Input:GetChildren()[1].ZIndex = Keybind_Input:GetChildren()[1].ZIndex + (_Windows * 10)
			Keybind_Title.ZIndex = Keybind_Title.ZIndex + (_Windows * 10)

			NewKeybind.Parent = NewTab
			NewKeybind.Visible = Keybind_Opt.Visible

			Keybind_Title.Text = ("  %s"):format(Keybind_Text)
			Keybind_Title.TextColor3 = Keybind_Opt.TextColor
			Keybind_Input.Text = Shortkeys[keybind] or keybind

			NewKeybind.Size = UDim2.new(0, GetNameLen(Keybind_Title) + 80, 0, 20)

			local Keybind_Connection
			Keybind_Connection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if NewInstance.Parent then
                    if not Keybind_Opt.ReadOnly then
                        if Checks.Binding then
                            task.spawn(function()
                                task.wait()
                                Checks.Binding = false
                            end)
                        end

                        if input.KeyCode.Name == keybind and not gameProcessedEvent then
                            Keybind_Opt.Enabled = not Keybind_Opt.Enabled

							if Keybind_Opt.Notify then
								Notification({
									Description = ("%s: [ %s ]"):format(Keybind_Title.Text, Keybind_Opt.Enabled and "Enabled" or "Disabled"),
									Duration = 0.70
								})
							end

                            Callback(Keybind_Opt.Enabled, KeyBind_Data)
                        end
                    end
				else
					Keybind_Connection:Disconnect()
				end
			end)

			Keybind_Input.MouseButton1Click:Connect(function()
                if not Keybind_Opt.ReadOnly then
                    if Checks.Binding then
                        return
                    end

                    Keybind_Input.Text = "..."
                    Checks.Binding = true

                    local input = UserInputService.InputBegan:Wait()

                    if input.KeyCode.Name == "Unknown" then
                        keybind = nil
                        Keybind_Input.Text = "None"
                    elseif table.find(Blacklisted, input.KeyCode) then
                        keybind = Keybind_Opt.Default.Name
                        Keybind_Input.Text = Keybind_Opt.Default.Name
						Notification({
							Title = Keybind_Title.Text,
							Description = ("[%s] is a blacklisted key, please use another one."):format(input.KeyCode.Name),
							Duration = 2
						})
                    else
                        local Key = Shortkeys[input.KeyCode.Name] or input.KeyCode.Name
                        Keybind_Input.Text = Key
                        keybind = input.KeyCode.Name
                    end
                end
			end)

			return setmetatable(KeyBind_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						Keybind_Title.Text = ("  %s"):format(CheckType(v, "string", Keybind_Title.Text))
						NewKeybind.Size = UDim2.new(0, GetNameLen(Keybind_Title) + 30, 0, 20)
					elseif k == "Bind" then
						v = CheckType(v, "EnumItem", keybind)

						local Key = Shortkeys[v.Name] or v.Name
						Keybind_Input.Text = Key
						keybind = v
					elseif k == "State" then
						Keybind_Opt.Enabled = CheckType(v, "boolean", Keybind_Opt.Enabled)

						if Keybind_Opt.Notify then
							Notification({
								Description = ("%s: [ %s ]"):format(Keybind_Title.Text, Keybind_Opt.Enabled and "Enabled" or "Disabled"),
								Duration = 3
							})
						end

						Callback(Keybind_Opt.Enabled, KeyBind_Data)
					elseif k == "TextColor" then
						Keybind_Title.TextColor3 = CheckType(v, "Color3", Keybind_Title.TextColor3)
					elseif k == "Visible" then
						NewKeybind.Visible = CheckType(v, "boolean", NewKeybind.Visible)
					elseif k == "ReadOnly" then
						Keybind_Opt.ReadOnly = CheckType(v, "boolean", Keybind_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return Keybind_Title.Text
					elseif k == "Bind" then
						return keybind
					elseif k == "State" then
						return Keybind_Opt.Enabled
					elseif k == "TextColor" then
						return Keybind_Title.TextColor3
					elseif k == "Visible" then
						return NewKeybind.Visible
					elseif k == "ReadOnly" then
						return Keybind_Opt.ReadOnly
					end
				end,
			}), NewKeybind
		end

		function Tab_Data:AddDropdown(Dropdown_Text, Callback, Dropdown_Opt)
			Dropdown_Text = CheckType(Dropdown_Text, "string", "Dropdown")
			Callback = CheckType(Callback, "function", function() end)

            Dropdown_Opt = CheckType(Dropdown_Opt, "table", {})
            Dropdown_Opt.Menu = CheckType(Dropdown_Opt.Menu, "table", {})
            Dropdown_Opt.ReadOnly = CheckType(Dropdown_Opt.ReadOnly, "boolean", false)
            Dropdown_Opt.TextColor = CheckType(Dropdown_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
            Dropdown_Opt.Visible = CheckType(Dropdown_Opt.Visible, "boolean", true)

			local Dropdown_Data = {}

			local NewDropdown = Prefabs:FindFirstChild("Dropdown"):Clone()
			local Dropdown_Box = NewDropdown:FindFirstChild("Box")
			local Dropdown_Objects = Dropdown_Box:FindFirstChild("Objects")
			local Dropdown_List = Dropdown_Objects:FindFirstChildOfClass("UIListLayout")
			local Dropdown_Indicator = NewDropdown:FindFirstChild("Indicator")

			NewDropdown.ZIndex = NewDropdown.ZIndex + (_Windows * 10)
			Dropdown_Box.ZIndex = Dropdown_Box.ZIndex + (_Windows * 10)
			Dropdown_Indicator.ZIndex = Dropdown_Indicator.ZIndex + (_Windows * 10)

			NewDropdown:GetChildren()[3].ZIndex = NewDropdown:GetChildren()[3].ZIndex + (_Windows * 10)

			NewDropdown.Parent = NewTab
            NewDropdown.Visible = Dropdown_Opt.Visible
			NewDropdown.Text = ("  %s"):format(Dropdown_Text)
			NewDropdown.TextColor3 = Dropdown_Opt.TextColor

            NewDropdown.Size = UDim2.new(0, GetNameLen(NewDropdown) + 20, 0, 20)
			Dropdown_Box.Size = UDim2.new(1, 0, 0, 0)

			local IsOpen = false

			Dropdown_List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if IsOpen then
					Dropdown_Box.Size = UDim2.new(1, 0, 0, Dropdown_List.AbsoluteContentSize.Y)
					Dropdown_Objects.Size = UDim2.new(1, 0, 0, Dropdown_List.AbsoluteContentSize.Y)
				end
			end)

			NewDropdown.MouseButton1Click:Connect(function()
                if not Dropdown_Opt.ReadOnly then
                    IsOpen = not IsOpen

                    local Len = (#Dropdown_Objects:GetChildren() - 1) * 20

                    if #Dropdown_Objects:GetChildren() - 1 >= 10 then
                        Len = 10 * 20
                        Dropdown_Objects.CanvasSize = UDim2.new(0, 0, (#Dropdown_Objects:GetChildren() - 1) * 0.1, 0)
                    end

                    if IsOpen then
                        if Dropdown_Open then
                            return
                        end

                        Dropdown_Open = true

                        Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, Len)}, Options.TweenTime)
                        Resize(Dropdown_Indicator, { Rotation = 90 }, Options.TweenTime)
                    else
                        Dropdown_Open = false

                        Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, 0)}, Options.TweenTime)
                        Resize(Dropdown_Indicator, { Rotation = -90 }, Options.TweenTime)
                    end
                end
			end)

			for _, v in pairs(Dropdown_Opt.Menu) do
				local Object = Prefabs:FindFirstChild("DropdownButton"):Clone()

				Object.Parent = Dropdown_Objects
				Object.Text = v
				Object.ZIndex = Object.ZIndex + (_Windows * 10)

				Dropdown_Objects.MouseEnter:Connect(function()
					Object.BackgroundColor3 = Options.MainColor
				end)

				Colors[#Colors + 1] = Object

				Dropdown_Objects.MouseLeave:Connect(function()
					Object.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
				end)

				if IsOpen then
					local Len = (#Dropdown_Objects:GetChildren() - 1) * 20

					if #Dropdown_Objects:GetChildren() - 1 >= 10 then
						Len = 10 * 20
						Dropdown_Objects.CanvasSize = UDim2.new(0, 0, (#Dropdown_Objects:GetChildren() - 1) * 0.1, 0)
					end

					Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, Len) }, Options.TweenTime)
				end

				Object.MouseButton1Click:Connect(function()
					if Dropdown_Open then
						NewDropdown.Text = ("  %s  [ %s ]"):format(Dropdown_Text, v)
						Dropdown_Open = false
						IsOpen = false
						NewDropdown.Size = UDim2.new(0, GetNameLen(NewDropdown) + 20, 0, 20)
						Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, 0) }, Options.TweenTime)
						Resize(Dropdown_Indicator, { Rotation = -90 }, Options.TweenTime)
						Callback(v, Dropdown_Data)
					end
				end)
			end

			return setmetatable(Dropdown_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						v = CheckType(v, "string", NewDropdown.Text:match("^(.-):"))

                        if #v > 0 then
                            NewDropdown.Text = NewDropdown.Text:gsub(NewDropdown.Text:match("^(.-):"), v)
                            NewDropdown.Size = UDim2.new(0, GetNameLen(NewDropdown) + 20, 0, 20)
                        end
					elseif k == "Option" then
						v = CheckType(v, "string", NewDropdown.Text:match("%[ (.-) %]"))

						if table.find(Dropdown_Opt.Menu, v) or v == "" then
							NewDropdown.Text = NewDropdown.Text:gsub(NewDropdown:match("%[ (.-) %]"), v)
							NewDropdown.Size = UDim2.new(0, GetNameLen(NewDropdown) + 20, 0, 20)

							if v ~= "" then
								Callback(v, Dropdown_Data)
							end
						end
                    elseif k == "Menu" then
                        if not Dropdown_Opt.ReadOnly then
                            Dropdown_Opt.Menu = CheckType(v, "table", Dropdown_Opt.Menu)

                            for _,x in pairs(Dropdown_Objects:GetChildren()) do
								if not x:IsA("UIListLayout") then
									x:Destroy()
								end
							end

                            for _,x in pairs(Dropdown_Opt.Menu) do
                                local Object = Prefabs:FindFirstChild("DropdownButton"):Clone()

                                Object.Parent = Dropdown_Objects
                                Object.Text = x

                                Object.ZIndex = Object.ZIndex + (_Windows * 10)

                                Dropdown_Objects.MouseEnter:Connect(function()
                                    Object.BackgroundColor3 = Options.MainColor
                                end)

                                Colors[#Colors + 1] = Object

                                Dropdown_Objects.MouseLeave:Connect(function()
                                    Object.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
                                end)

                                if IsOpen then
                                    local Len = (#Dropdown_Objects:GetChildren() - 1) * 20

                                    if #Dropdown_Objects:GetChildren() - 1 >= 10 then
                                        Len = 10 * 20
                                        Dropdown_Objects.CanvasSize = UDim2.new(0, 0, (#Dropdown_Objects:GetChildren() - 1) * 0.1, 0)
                                    end

                                    Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, Len)}, Options.TweenTime)
                                end

                                Object.MouseButton1Click:Connect(function()
                                    if Dropdown_Open then
                                        NewDropdown.Text = ("  %s  [ %s ]"):format(Dropdown_Text, x)
                                        Dropdown_Open = false
                                        IsOpen = false
										NewDropdown.Size = UDim2.new(0, GetNameLen(NewDropdown) + 20, 0, 20)
                                        Resize(Dropdown_Box, {Size = UDim2.new(1, 0, 0, 0) }, Options.TweenTime)
                                        Resize(Dropdown_Indicator, {Rotation = -90 }, Options.TweenTime)
                                        Callback(v, Dropdown_Data)
                                    end
                                end)
                            end
                        end
					elseif k == "Visible" then
						NewDropdown.Visible = CheckType(v, "boolean", NewDropdown.Visible)
					elseif k == "TextColor" then
						NewDropdown.TextColor3 = CheckType(v, "Color3", NewDropdown.TextColor3)
					elseif k == "ReadOnly" then
						Dropdown_Opt.ReadOnly = CheckType(v, "boolean", Dropdown_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return NewDropdown.Text:match("^(.-):")
                    elseif  k == "Menu" then
                        return Dropdown_Opt.Menu
					elseif k == "Option" then
                        return NewDropdown.Text:match("%[ (.-) %]")
					elseif k == "Visible" then
						return NewDropdown.Visible
					elseif k == "TextColor" then
						return NewDropdown.TextColor3
					elseif k == "ReadOnly" then
						return Dropdown_Opt.ReadOnly
					end
				end,
			}), NewDropdown
		end

		function Tab_Data:AddColorPicker(Callback, ColorPicker_Opt)
			Callback = CheckType(Callback, "function", function() end)

			ColorPicker_Opt = CheckType(ColorPicker_Opt, "table", {})
			ColorPicker_Opt.Default = CheckType(ColorPicker_Opt.Default, "Color3", Color3.fromRGB(255, 255, 255))
			ColorPicker_Opt.Indicator = CheckType(ColorPicker_Opt.Indicator, "boolean", false)
			ColorPicker_Opt.Text = CheckType(ColorPicker_Opt.Text, "string", "")
			ColorPicker_Opt.Visible = CheckType(ColorPicker_Opt.Visible, "boolean", true)
			ColorPicker_Opt.ReadOnly = CheckType(ColorPicker_Opt.ReadOnly, "boolean", false)

			local Text
			local ColorPicker_Data = {}

			if ColorPicker_Opt.Text ~= "" then
				ColorPicker_Opt.TextColor = CheckType(ColorPicker_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))

				Text = Tab_Data:AddLabel(ColorPicker_Opt.Text, {
					TextColor = ColorPicker_Opt.TextColor
				})
			end

			local NewColorPicker = Prefabs:FindFirstChild("ColorPicker"):Clone()

			NewColorPicker.Parent = NewTab
			NewColorPicker.Visible = ColorPicker_Opt.Visible
			NewColorPicker.ZIndex = NewColorPicker.ZIndex + (_Windows * 10)

			local Picker_Palette = NewColorPicker:FindFirstChild("Palette")
			local Picker_Sample = NewColorPicker:FindFirstChild("Sample")
			local Picker_Saturation = NewColorPicker:FindFirstChild("Saturation")

			Picker_Palette.ZIndex = Picker_Palette.ZIndex + (_Windows * 10)
			Picker_Sample.ZIndex = Picker_Sample.ZIndex + (_Windows * 10)
			Picker_Saturation.ZIndex = Picker_Saturation.ZIndex + (_Windows * 10)

			-- ColorPicker Math
			local H, S, V = Color3.toHSV(ColorPicker_Opt.Default)

			local function Update()
				if not ColorPicker_Opt.ReadOnly then
					local Color = Color3.fromHSV(H, S, V)
					Picker_Sample.ImageColor3 = Color
					Picker_Saturation.ImageColor3 = Color3.fromHSV(H, 1, 1)

					Callback(Color, ColorPicker_Data)
				end
			end

			local Color = Color3.fromHSV(H, S, V)
			Picker_Sample.ImageColor3 = Color
			Picker_Saturation.ImageColor3 = Color3.fromHSV(H, 1, 1)

			local Picker_Entered1, Picker_Entered2 = false, false

			Picker_Palette.MouseEnter:Connect(function()
				NewWindow.Draggable = false
				Picker_Entered1 = true
			end)

			Picker_Palette.MouseLeave:Connect(function()
				NewWindow.Draggable = true
				Picker_Entered1 = false
			end)

			Picker_Saturation.MouseEnter:Connect(function()
				NewWindow.Draggable = false
				Picker_Entered2 = true
			end)

			Picker_Saturation.MouseLeave:Connect(function()
				NewWindow.Draggable = true
				Picker_Entered2 = false
			end)

			local Palette_Indicator = Picker_Palette:FindFirstChild("Indicator")
			local Saturation_Indicator = Picker_Saturation:FindFirstChild("Indicator")

			Palette_Indicator.ZIndex = Palette_Indicator.ZIndex + (_Windows * 10)
			Saturation_Indicator.ZIndex = Saturation_Indicator.ZIndex + (_Windows * 10)

			Palette_Indicator.Visible = ColorPicker_Opt.Indicator

			local Picker_Held = false

			UserInputService.InputBegan:Connect(function(input)
				if not ColorPicker_Opt.ReadOnly then
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Picker_Held = true

						task.spawn(function()
							while Picker_Held and Picker_Entered1 and not Dropdown_Open do
								local Mouse_Location = GetMouse()

								local X = ((Picker_Palette.AbsoluteSize.X - (Mouse_Location.X - Picker_Palette.AbsolutePosition.X)) + 1)
								local Y = ((Picker_Palette.AbsoluteSize.Y - (Mouse_Location.Y - Picker_Palette.AbsolutePosition.Y)) + 1.5)

								H = X / 100
								S = Y / 100

								Resize(Palette_Indicator, {Position = UDim2.new(0, math.abs(X - 100) - (Palette_Indicator.AbsoluteSize.X / 2), 0, math.abs(Y - 100) - (Palette_Indicator.AbsoluteSize.Y / 2)), }, Options.TweenTime)
								Update()

								task.wait()
							end

							while Picker_Held and Picker_Entered2 and not Dropdown_Open do
								local Mouse_Location = GetMouse()
								local Y = (
									(Picker_Palette.AbsoluteSize.Y - (Mouse_Location.Y - Picker_Palette.AbsolutePosition.Y))
									+ 1.5
								)
								V = Y / 100

								Resize(
									Saturation_Indicator,
									{ Position = UDim2.new(0, 0, 0, math.abs(Y - 100)) },
									Options.TweenTime
								)

								Update()
								task.wait()
							end
						end)
					end
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Picker_Held = false
				end
			end)

			return setmetatable(ColorPicker_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						Text.Text = CheckType(v, "string", Text.Text)
					elseif k == "TextColor" then
						Text.TextColor = CheckType(v, "Color3", Text.TextColor)
					elseif k == "Color" then
						if not ColorPicker_Opt.ReadOnly then
							v = CheckType(v, "Color3", Picker_Sample.ImageColor3)

							local H2, S2, V2 = RGBToHSV(v.R * 255, v.G * 255, v.B * 255)
							Picker_Sample.ImageColor3 = v
							Picker_Saturation.ImageColor3 = Color3.fromHSV(H2, 1, 1)
							Callback(v, ColorPicker_Data)
						end
					elseif k == "Indicator" then
						Palette_Indicator.Visible = CheckType(v, "boolean", Palette_Indicator.Visible)
					elseif k == "Visible" then
						NewColorPicker.Visible = CheckType(v, "boolean", NewColorPicker.Visible)
					elseif k == "ReadOnly" then
						ColorPicker_Opt.ReadOnly = CheckType(v, "boolean", ColorPicker_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return Text.Text
					elseif k == "TextColor" then
						return Text.TextColor
					elseif k == "Color" then
						return Picker_Sample.ImageColor3
					elseif k == "Indicator" then
						return Palette_Indicator.Visible
					elseif k == "Visible" then
						return NewColorPicker.Visible
					elseif k == "ReadOnly" then
						return ColorPicker_Opt.ReadOnly
					end
				end
			}), NewColorPicker
		end

		function Tab_Data:AddConsole(Console_Opt)
			Console_Opt = CheckType(Console_Opt, "table", {})

			Console_Opt.Source = CheckType(Console_Opt.Source, "string", "Logs")
			Console_Opt.Full = CheckType(Console_Opt.Full, "boolean", false)
			Console_Opt.ReadOnly = CheckType(Console_Opt.ReadOnly, "boolean", true)
			Console_Opt.Y = CheckType(Console_Opt.Y, "number", 200)
			Console_Opt.Visible = CheckType(Console_Opt.Visible, "boolean", true)

			local Console_Data = {}

			local NewConsole = Prefabs:FindFirstChild("Console"):Clone()

			NewConsole.Parent = NewTab
			NewConsole.Visible = Console_Opt.Visible
			NewConsole.ZIndex = NewConsole.ZIndex + (_Windows * 10)
			NewConsole.Size = UDim2.new(1, 0, Console_Opt.Full and 1 or 0, Console_Opt.Y)

			local Sf = NewConsole:GetChildren()[1]
			local Console_Source = Sf:FindFirstChild("Source")
			local Console_Lines = Sf:FindFirstChild("Lines")

			Console_Source.ZIndex = Console_Source.ZIndex + (_Windows * 10)
			Console_Lines.ZIndex = Console_Lines.ZIndex + (_Windows * 10)

			Console_Source.TextEditable = not Console_Opt.ReadOnly

			-- Syntax ZIndex
			for _, v in pairs(Console_Source:GetChildren()) do
				v.ZIndex = v.ZIndex + (_Windows * 10)
			end

			Console_Source.Comments.ZIndex = Console_Source.Comments.ZIndex + 1

			-- Highlighting
			local Lua_Keywords = {
				"and",
				"break",
				"do",
				"else",
				"elseif",
				"end",
				"false",
				"for",
				"function",
				"goto",
				"if",
				"in",
				"local",
				"nil",
				"not",
				"or",
				"repeat",
				"return",
				"then",
				"true",
				"until",
				"while",
			}
			local Global_Env = {
				"getrawmetatable",
				"newcclosure",
				"islclosure",
				"setclipboard",
				"game",
				"workspace",
				"script",
				"math",
				"string",
				"table",
				"print",
				"wait",
				"BrickColor",
				"Color3",
				"next",
				"pairs",
				"ipairs",
				"select",
				"unpack",
				"Instance",
				"Vector2",
				"Vector3",
				"CFrame",
				"Ray",
				"UDim2",
				"Enum",
				"assert",
				"error",
				"warn",
				"tick",
				"loadstring",
				"_G",
				"shared",
				"getfenv",
				"setfenv",
				"newproxy",
				"setmetatable",
				"getmetatable",
				"os",
				"debug",
				"pcall",
				"ypcall",
				"xpcall",
				"rawequal",
				"rawset",
				"rawget",
				"tonumber",
				"tostring",
				"type",
				"typeof",
				"_VERSION",
				"coroutine",
				"delay",
				"require",
				"spawn",
				"LoadLibrary",
				"settings",
				"stats",
				"time",
				"UserSettings",
				"version",
				"Axes",
				"ColorSequence",
				"Faces",
				"ColorSequenceKeypoint",
				"NumberRange",
				"NumberSequence",
				"NumberSequenceKeypoint",
				"gcinfo",
				"elapsedTime",
				"collectgarbage",
				"PhysicalProperties",
				"Rect",
				"Region3",
				"Region3int16",
				"UDim",
				"Vector2int16",
				"Vector3int16",
				"load",
				"fire",
				"Fire",
			}

			local Highlight = function(string, keywords)
				local K = {}
				local S = string

				local Token = {
					["="] = true,
					["."] = true,
					[","] = true,
					["("] = true,
					[")"] = true,
					["["] = true,
					["]"] = true,
					["{"] = true,
					["}"] = true,
					[":"] = true,
					["*"] = true,
					["/"] = true,
					["+"] = true,
					["-"] = true,
					["%"] = true,
					[";"] = true,
					["~"] = true,
				}

				for _, v in pairs(keywords) do
					K[v] = true
				end

				S = S:gsub(".", function(c)
					if Token[c] ~= nil then
						return "\32"
					else
						return c
					end
				end)

				S = S:gsub("%S+", function(c)
					if K[c] ~= nil then
						return c
					else
						return (" "):rep(#c)
					end
				end)

				return S
			end

			local HTokens = function(string)
				local Token = {
					["="] = true,
					["."] = true,
					[","] = true,
					["("] = true,
					[")"] = true,
					["["] = true,
					["]"] = true,
					["{"] = true,
					["}"] = true,
					[":"] = true,
					["*"] = true,
					["/"] = true,
					["+"] = true,
					["-"] = true,
					["%"] = true,
					[";"] = true,
					["~"] = true,
				}

				local A = ""

				string:gsub(".", function(c)
					if Token[c] ~= nil then
						A = A .. c
					elseif c == "\n" then
						A = A .. "\n"
					elseif c == "\t" then
						A = A .. "\t"
					else
						A = A .. "\32"
					end
				end)

				return A
			end

			local strings = function(string)
				local Highlight = ""
				local Quote = false

				string:gsub(".", function(c)
					if Quote == false and c == "\34" then
						Quote = true
					elseif Quote == true and c == "\34" then
						Quote = false
					end

					if Quote == false and c == "\34" then
						Highlight = Highlight .. "\34"
					elseif c == "\n" then
						Highlight = Highlight .. "\n"
					elseif c == "\t" then
						Highlight = Highlight .. "\t"
					elseif Quote == true then
						Highlight = Highlight .. c
					elseif Quote == false then
						Highlight = Highlight .. "\32"
					end
				end)

				return Highlight
			end

			local info = function(string)
				local highlight = ""
				local Quote = false

				string:gsub(".", function(c)
					if Quote == false and c == "[" then
						Quote = true
					elseif Quote == true and c == "]" then
						Quote = false
					end

					if Quote == false and c == "]" then
						highlight = highlight .. "]"
					elseif c == "\n" then
						highlight = highlight .. "\n"
					elseif c == "\t" then
						highlight = highlight .. "\t"
					elseif Quote == true then
						highlight = highlight .. c
					elseif Quote == false then
						highlight = highlight .. "\32"
					end
				end)

				return highlight
			end

			local comments = function(string)
				local Ret = ""

				string:gsub("[^\r\n]+", function(c)
					local comm = false
					local i = 0

					c:gsub(".", function(n)
						i = i + 1

						if c:sub(i, i + 1) == "--" then
							comm = true
						end

						if comm == true then
							Ret = Ret .. n
						else
							Ret = Ret .. "\32"
						end
					end)

					Ret = Ret
				end)

				return Ret
			end

			local numbers = function(string)
				local A = ""

				string:gsub(".", function(c)
					if tonumber(c) ~= nil then
						A = A .. c
					elseif c == "\n" then
						A = A .. "\n"
					elseif c == "\t" then
						A = A .. "\t"
					else
						A = A .. "\32"
					end
				end)

				return A
			end

			local Highlight_Lua = function(Type)
				if Type == "Text" then
					Console_Source.Text = Console_Source.Text:gsub("\13", "")
					Console_Source.Text = Console_Source.Text:gsub("\t", "      ")

					local s = Console_Source.Text
					Console_Source.Keywords.Text = Highlight(s, Lua_Keywords)
					Console_Source.Globals.Text = Highlight(s, Global_Env)
					Console_Source.RemoteHighlight.Text = Highlight(s, { "FireServer", "fireServer", "InvokeServer", "invokeServer" })
					Console_Source.Tokens.Text = HTokens(s)
					Console_Source.Numbers.Text = numbers(s)
					Console_Source.Strings.Text = strings(s)
					Console_Source.Comments.Text = comments(s)

					local _Lines = 1
					s:gsub("\n", function()
						_Lines = _Lines + 1
					end)

					Console_Lines.Text = ""

					for i = 1, _Lines do
						Console_Lines.Text = Console_Lines.Text .. i .. "\n"
					end

					Sf.CanvasSize = UDim2.new(0, 0, _Lines * 0.153846154, 0)
				end
			end

			local Highlight_Logs = function(Type)
				if Type == "Text" then
					Console_Source.Text = Console_Source.Text:gsub("\13", "")
					Console_Source.Text = Console_Source.Text:gsub("\t", "      ")
					local s = Console_Source.Text

					Console_Source.Info.Text = info(s)

					local _Lines = 1

					s:gsub("\n", function()
						_Lines = _Lines + 1
					end)

					Sf.CanvasSize = UDim2.new(0, 0, _Lines * 0.153846154, 0)
				end
			end

			if Console_Opt.Source == "Lua" then
				Highlight_Lua("Text")
				Console_Source.Changed:Connect(Highlight_Lua)
			elseif Console_Opt.Source == "Logs" then
				Console_Lines.Visible = false

				Highlight_Logs("Text")
				Console_Source.Changed:Connect(Highlight_Logs)
			end

			return setmetatable(Console_Data, {
				__newindex = function(t, k, v)
					if k == "Code" then
						Console_Source.Text = tostring(v)
					elseif k == "Log" then
						Console_Source.Text = Console_Source.Text .. "[*] " .. tostring(v) .. "\n"
					elseif k == "Visible" then
						NewConsole.Visible = CheckType(v, "boolean", NewConsole.Visible)
					end
				end,
				__index = function(t, k)
					if k == "Code" then
						return Console_Source.Text
					elseif k == "Visible" then
						return NewConsole.Visible
					end
				end,
			}), NewConsole
		end

		function Tab_Data:AddHorizontalAlignment()
			local HA_Data = {}
			local Blacklisted = {
				"AddConsole",
				"AddColorPicker",
				"AddSlider",
				"AddSettings",
				"AddTextBox",
				"AddHorizontalAlignment",
				"AddSeparator",
				"AddFolder",
			}
			-- AddLabel
			-- AddButton
			-- AddSwitch


			local NewHa = Prefabs:FindFirstChild("HorizontalAlignment"):Clone()
			NewHa.Parent = NewTab

			for i, v in pairs(Tab_Data) do
				if not table.find(Blacklisted, i) then
					HA_Data[i] = function(...)
						local _Data, Object
						local Ret = { v(...) }

						if typeof(Ret[1]) == "table" then
							_Data = Ret[1]
							Object = Ret[2]
							Object.Parent = NewHa
							return _Data, Object
						else
							Object = Ret[1]
							Object.Parent = NewHa
							return Object
						end
					end
				end
			end

			return HA_Data, NewHa
		end

		function Tab_Data:AddFolder(Folder_Text, Folder_Opt)
			Folder_Text = CheckType(Folder_Text, "string", "Folder")

			Folder_Opt = CheckType(Folder_Opt, "table", {})
			Folder_Opt.Visible = CheckType(Folder_Opt.Visible, "boolean", true)
			Folder_Opt.TextColor = CheckType(Folder_Opt.TextColor, "Color3", Color3.fromRGB(255, 255, 255))
			Folder_Opt.ReadOnly = CheckType(Folder_Opt.ReadOnly, "boolean", false)

			local Folder_Data = {}

			local NewFolder = Prefabs:FindFirstChild("Folder"):Clone()
			local Folder_Button = NewFolder:FindFirstChild("Button")
			local Folder_Objects = NewFolder:FindFirstChild("Objects")
			local Folder_Toggle = Folder_Button:FindFirstChild("Toggle")

			NewFolder.ZIndex = NewFolder.ZIndex + (_Windows * 10)
			Folder_Button.ZIndex = Folder_Button.ZIndex + (_Windows * 10)
			Folder_Objects.ZIndex = Folder_Objects.ZIndex + (_Windows * 10)
			Folder_Toggle.ZIndex = Folder_Toggle.ZIndex + (_Windows * 10)
			Folder_Button:GetChildren()[1].ZIndex = Folder_Button:GetChildren()[1].ZIndex + (_Windows * 10)

			NewFolder.Parent = NewTab
									NewFolder.Visible = Folder_Opt.Visible
			Folder_Button.TextColor3 = Folder_Opt.TextColor
			Folder_Button.Text = ("      %s"):format(Folder_Text)

			if Folder_Button and Folder_Button:GetChildren()[1] then
				Folder_Button:GetChildren()[1].ImageColor3 = Options.MainColor
				Colors[#Colors + 1] = Folder_Button:GetChildren()[1]
			end

			local function GetFolderLen()
				local n = 25

				for _, v in pairs(Folder_Objects:GetChildren()) do
					if not v:IsA("UIListLayout") then
						n = n + v.AbsoluteSize.Y + 5
					end
				end

				return n
			end

			local Folder_Open = false

			Folder_Button.MouseButton1Click:Connect(function()
				if not Folder_Opt.ReadOnly then
					if Folder_Open then
						Resize(Folder_Toggle, { Rotation = 0 }, Options.TweenTime)
						Folder_Objects.Visible = false
					else
						Resize(Folder_Toggle, { Rotation = 90 }, Options.TweenTime)
						Folder_Objects.Visible = true
					end

					Folder_Open = not Folder_Open
				end
			end)

			task.spawn(function()
				while NewInstance.Parent do
					Resize(NewFolder,{Size = UDim2.new(1, 0, 0, (Folder_Open and GetFolderLen() or 20)) },Options.TweenTime)
					task.wait()
				end
			end)

			for i, v in pairs(Tab_Data) do
				Folder_Data[i] = function(...)
					local _Data, Object
					local Ret = {v(...)}

					if typeof(Ret[1]) == "table" then
						_Data = Ret[1]
						Object = Ret[2]
						Object.Parent = Folder_Objects
						return _Data, Object
					else
						Object = Ret[1]
						Object.Parent = Folder_Objects
						return Object
					end
				end
			end

			return setmetatable(Folder_Data, {
				__newindex = function(t, k, v)
					if k == "Text" then
						v = CheckType(v, "string", Folder_Button.Text:match("%w"))
						Folder_Button.Text = ("      %s"):format(v)
					elseif k == "TextColor" then
						Folder_Button.TextColor3 = CheckType(v, "Color3", Folder_Button.TextColor3)
					elseif k == "Visible" then
						NewFolder.Visible = CheckType(v, "boolean", NewFolder.Visible)
					elseif k == "ReadOnly" then
						Folder_Opt.ReadOnly = CheckType(v, "boolean", Folder_Opt.ReadOnly)
					end
				end,
				__index = function(t, k)
					if k == "Text" then
						return Folder_Button.Text:match("%w")
					elseif k == "TextColor" then
						return Folder_Button.TextColor3
					elseif k == "Visible" then
						return NewFolder.Visible
					elseif k == "ReadOnly" then
						return Folder_Opt.ReadOnly
					end
				end,
			}), NewFolder
		end

		task.spawn(function()
			while NewInstance.Parent and Tab_Buttons:FindFirstChild("Settings") do
				for _, v in pairs(Colors) do
					if v.BackgroundColor3 and v.BackgroundColor3 ~= Color3.fromHex(Setting.MainColor) then
						v.BackgroundColor3 = Color3.fromHex(Setting.MainColor)
					end

					if v:IsA("ImageButton") or v:IsA("ImageLabel") and v.ImageColor3 ~= Color3.fromHex(Setting.MainColor) then
						v.ImageColor3 = Color3.fromHex(Setting.MainColor)
					end
				end

				task.wait(0.005)
			end
		end)

		return setmetatable(Tab_Data, {
			__newindex = function(t, k, v)
				if k == "Text" then
					NewButton.Text = CheckType(v, "string", NewButton.Text)
				elseif k == "TextColor" then
					NewButton.TextColor3 = CheckType(v, "Color3", NewButton.TextColor3)
				elseif k == "Visible" then
					NewButton.Visible = CheckType(v, "boolean", NewButton.Visible)
				elseif k == "ReadOnly" then
					Tab_Opt.ReadOnly = CheckType(v, "boolean", Tab_Opt.ReadOnly)
				end
			end,
			__index = function(t, k)
				if k == "Text" then
					return NewButton.Text
				elseif k == "TextColor" then
					return NewButton.TextColor3
				elseif k == "Visible" then
					return NewButton.Visible
				elseif k == "ReadOnly" then
					return Tab_Opt.ReadOnly
				end
			end
		}), NewTab
	end

	function Window_Data:AddSettings(Setting_Opt)
		Setting_Opt = CheckType(Setting_Opt, "table", {})

		Setting_Opt.Rejoin = CheckType(Setting_Opt.Rejoin, "boolean", false)
		Setting_Opt.MainColor = CheckType(Setting_Opt.MainColor, "boolean", false)

		local Settings = Window_Data:AddTab("Settings")

		Settings:AddKeybind("Toggle UI", function(State, Func)
			NewInstance.Enabled = not State

			Setting.ToggleKey = Func.Bind
			writefile("EleriumSettings", HttpService:JSONEncode(Setting))
		end, {
			Default = IsKeyCode(Setting.ToggleKey) or IsKeyCode(Default.ToggleKey),
			Enabled = NewInstance.Enabled,
		})

		Settings:AddButton("Destroy UI", function()
			Resize(NewWindow, {Size = UDim2.new(0, Options.MinSize.X, 0, 0)}, 1)
			task.wait(1)
			NewInstance:Destroy()
		end)

		if Setting_Opt.Rejoin then
			Settings:AddButton("Rejoin", function()
				if RobloxReplicatedStorage.GetServerType:InvokeServer() == "StandardServer" then
					if #Players:GetPlayers() <= 1 then
						Players.LocalPlayer:Kick("\nRejoining...")
						TeleportService:Teleport(game.PlaceId)
					else
						TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
					end
				else
					Notification({
						Description = ("Can't rejoin, your current server type is %s"):format(RobloxReplicatedStorage.GetServerType:InvokeServer()),
						Duration = 5
					})
				end
			end)
		end

		if Setting_Opt.MainColor then
			Settings:AddSeparator()
			Settings:AddLabel("Main Color")

			Settings:AddColorPicker(function(Color)
				Setting.MainColor = Color:ToHex()

				writefile("EleriumSettings.json", HttpService:JSONEncode(Setting))
			end)
		end
	end

	function Window_Data:AddNotification(Notification_Opt)
		Notification(Notification_Opt, Options.MainColor)
	end

	for _, v in pairs(NewWindow:GetDescendants()) do
		if HasProp(v, "ZIndex") then
			v.ZIndex = v.ZIndex + (_Windows * 10)
		end
	end

	return setmetatable(Window_Data, {
		__newindex = function(t, k, v)
			if k == "Title" then
				NewWindow:FindFirstChild("Title").Text = CheckType(v, "string", NewWindow:FindFirstChild("Title").Text)
			end
		end,
		__index = function(t, k)
			if k == "Title" then
				return NewWindow:FindFirstChild("Title").Text
			end
		end
	}), NewWindow
end

return Library
