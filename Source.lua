--[[
()(((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))
	Fuck
	- lua
	- Roblox Script
	- UI Library
	- Url : https://github.com/3345-c-a-t-s-u-s/Dev-WareUI/blob/main/README.md#dev-wareui
()(((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))
]]

export type Devware = {
	CreateWindow : func & {
		NewTab:func & {
			NewSection : func & {
				Destroy : func,
				NewButton : func,
				NewColorPicker : func,
				NewKeybind : func,
				NewLabel : func,
				NewSlider : func,
				NewToggle : func,
			}
		},
		SetToggle : func,
		Destroy : func,
	},
	KeySystem : func & {
		func
	},
}

local CoreUI = game:FindFirstChild('CoreGui') or game:GetService('Players').LocalPlayer.PlayerGui
local UserInputService = game:GetService('UserInputService')
local Mouse = game:GetService('Players').LocalPlayer:GetMouse()
local TweenService = game:GetService('TweenService')
local IconAPI = [[https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json]]
local KEY = nil

local Devware = {}

local function CalculateDistance(pointA, pointB)
	return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
end

local function OnInputClick(frame:GuiObject,back:func,onoff)
	frame.InputBegan:Connect(function(Input)
		if Input then
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				back(true)
			end
		end
	end)
	
	if onoff then
		frame.InputEnded:Connect(function(Input)
			if Input then
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					back(false)
				end
			end
		end)
	end
end

local function Find(pp:Instance,ta:string)
	for i,v in ipairs(pp:GetDescendants()) do
		if v.Name==tostring(ta) then
			return v
		end
	end
end

function Create_Ripple(Parent : Frame)
	Parent.ClipsDescendants = true

	local ripple = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new('UIStroke',ripple)

	ripple.Name = "ripple"
	ripple.Parent = Parent
	ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ripple.ZIndex = 5
	ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	ripple.Size = UDim2.new(0,0,0,0)
	ripple.SizeConstraint = Enum.SizeConstraint.RelativeYY

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.fromRGB(255,255,255)
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 14
	UIStroke.Transparency = 0.3
	
	UICorner.Name = "CORNER_EFFECT"
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = ripple

	local buttonAbsoluteSize = Parent.AbsoluteSize
	local buttonAbsolutePosition = Parent.AbsolutePosition

	local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
	local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)

	ripple.BackgroundTransparency = 0.84
	ripple.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
	ripple.Parent = Parent

	local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
	local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
	local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
	local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))

	local Size_UP = UDim2.new(20,0,10,0)
	TweenService:Create(ripple,TweenInfo.new(2,Enum.EasingStyle.Back),{Size = Size_UP,BackgroundTransparency = 1}):Play()
	game:GetService('Debris'):AddItem(ripple,2.2)
end

function Devware:CreateWindow(TitleStr : string)
	local CanMove = true
	local dragToggle = nil
	local dragSpeed = 0.05
	local dragStart = nil
	local startPos = nil
	
	local ToggleKey = Enum.KeyCode.X
	local WindowAccess = {}
	local Tabs = {}
	local Sections = {}
	
	local DevwareUIScreen = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Shadow = Instance.new("ImageLabel")
	local Header = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local HeaderTitle = Instance.new("TextLabel")
	local Close = Instance.new("TextButton")
	local UICorner_3 = Instance.new("UICorner")
	local TabCollects = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Shadow_2 = Instance.new("ImageLabel")
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		wait(0.1)
		TweenService:Create(ScrollingFrame,TweenInfo.new(0.2),{CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)}):Play()
	end)
	
	DevwareUIScreen.Name = "Window"
	DevwareUIScreen.Parent = CoreUI
	DevwareUIScreen.ZIndexBehavior = Enum.ZIndexBehavior.Global
	DevwareUIScreen.IgnoreGuiInset = true
	DevwareUIScreen.ResetOnSpawn = false

	Frame.Parent = DevwareUIScreen
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.new(0.35, 0, 0.35, 0)

	UICorner.Parent = Frame

	Shadow.Name = "Shadow"
	Shadow.Parent = Frame
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Rotation = 0.000
	Shadow.Size = UDim2.new(1.14999998, 0, 1.14999998, 0)
	Shadow.ZIndex = -10
	Shadow.Image = "rbxassetid://7912134082"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.770
	Shadow.SliceCenter = Rect.new(95, 95, 205, 205)

	Header.Name = "Header"
	Header.Parent = Frame
	Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(0.99999994, 0, 0.0788463801, 0)
	Header.ZIndex = 2

	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = Header

	HeaderTitle.Name = "HeaderTitle"
	HeaderTitle.Parent = Header
	HeaderTitle.AnchorPoint = Vector2.new(0, 0.5)
	HeaderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeaderTitle.BackgroundTransparency = 1.000
	HeaderTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeaderTitle.BorderSizePixel = 0
	HeaderTitle.Position = UDim2.new(0.0201775618, 0, 0.5, 0)
	HeaderTitle.Size = UDim2.new(0.779822409, 0, 0.949999988, 0)
	HeaderTitle.ZIndex = 15
	HeaderTitle.Font = Enum.Font.GothamMedium
	HeaderTitle.Text = tostring(TitleStr)
	HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	HeaderTitle.TextScaled = true
	HeaderTitle.TextSize = 14.000
	HeaderTitle.TextWrapped = true
	HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

	Close.Name = "Close"
	Close.Parent = Header
	Close.AnchorPoint = Vector2.new(0.5, 0.5)
	Close.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0.964999974, 0, 0.5, 0)
	Close.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
	Close.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Close.ZIndex = 5
	Close.Font = Enum.Font.FredokaOne
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(255, 144, 47)
	Close.TextScaled = true
	Close.TextSize = 14.000
	Close.TextTransparency = 0.200
	Close.TextWrapped = true

	UICorner_3.CornerRadius = UDim.new(0, 5)
	UICorner_3.Parent = Close

	TabCollects.Name = "TabCollects"
	TabCollects.Parent = Frame
	TabCollects.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TabCollects.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabCollects.BorderSizePixel = 0
	TabCollects.Position = UDim2.new(0.0201775618, 0, 0.0976563096, 0)
	TabCollects.Size = UDim2.new(0.305932194, 0, 0.870278478, 0)
	TabCollects.ZIndex = 3

	UICorner_4.CornerRadius = UDim.new(0, 4)
	UICorner_4.Parent = TabCollects

	ScrollingFrame.Parent = TabCollects
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ScrollingFrame.Size = UDim2.new(0.980000019, 0, 0.980000019, 0)
	ScrollingFrame.ZIndex = 4
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ScrollBarThickness = 1

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Shadow_2.Name = "Shadow"
	Shadow_2.Parent = TabCollects
	Shadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_2.BackgroundTransparency = 1.000
	Shadow_2.Position = UDim2.new(0.624609351, 0, 0.501626194, 0)
	Shadow_2.Rotation = 0.000
	Shadow_2.Size = UDim2.new(0.900781333, 0, 1.12072694, 0)
	Shadow_2.ZIndex = 2
	Shadow_2.Image = "rbxassetid://7912134082"
	Shadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_2.ImageTransparency = 0.490
	Shadow_2.SliceCenter = Rect.new(95, 95, 205, 205)
	
	function WindowAccess:NewTab(TabNameStr : string)
		local TabAccess = {}
		local CurentTime = 0.1
		local TabButton = Instance.new("Frame")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		local UICorner = Instance.new("UICorner")
		local Slider = Instance.new("Frame")
		local SliderMouse = Instance.new("UIGradient")
		local Title = Instance.new("TextLabel")
		local UIGradient = Instance.new("UIGradient")

		TabButton.Name = "TabButton"
		TabButton.Parent = ScrollingFrame
		TabButton.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
		TabButton.BackgroundTransparency = 0.500
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, 0, 0.899999976, 0)
		TabButton.ZIndex = 4

		UIAspectRatioConstraint.Parent = TabButton
		UIAspectRatioConstraint.AspectRatio = 4.000

		UICorner.CornerRadius = UDim.new(0, 2)
		UICorner.Parent = TabButton

		Slider.Name = "Slider"
		Slider.Parent = TabButton
		Slider.AnchorPoint = Vector2.new(0, 1)
		Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Slider.BackgroundTransparency = 0.500
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Position = UDim2.new(0, 0, 1, 0)
		Slider.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)
		Slider.ZIndex = 7

		SliderMouse.Offset = Vector2.new(-0.5, 0)
		SliderMouse.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		SliderMouse.Name = "SliderMouse"
		SliderMouse.Parent = Slider

		Title.Name = "Title"
		Title.Parent = TabButton
		Title.AnchorPoint = Vector2.new(0, 0.5)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.0500000007, 0, 0.5, 0)
		Title.Size = UDim2.new(0.899999976, 0, 0.5, 0)
		Title.ZIndex = 7
		Title.Font = Enum.Font.GothamMedium
		Title.Text = TabNameStr or "Tab"
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.51), NumberSequenceKeypoint.new(1.00, 0.69)}
		UIGradient.Parent = TabButton
		
		local Tab = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			wait(0.1)
			TweenService:Create(ScrollingFrame,TweenInfo.new(0.2),{CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)}):Play()
		end)
		
		Tab.Name = TabNameStr or "Tab"
		Tab.Parent = Frame
		Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Position = UDim2.new(0.350584894, 0, 0.106148034, 0)
		Tab.Size = UDim2.new(0.633149326, 0, 0.861786604, 0)

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Tab

		ScrollingFrame.Parent = Tab
		ScrollingFrame.Active = true
		ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		ScrollingFrame.Size = UDim2.new(0.980000019, 0, 0.980000019, 0)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
		ScrollingFrame.ScrollBarThickness = 1

		UIListLayout.Parent = ScrollingFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)
		
		table.insert(Tabs,{Tab,TabButton})
		
		if #Tabs <= 1 then
			TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(0,0)}):Play()
			Tab.Visible = true
		else
			TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(-0.5,0)}):Play()
			Tab.Visible = false
		end
		
		function TabAccess:NewSection(SectionNameStr : string)
			local SectionAccess = {}
			
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UIListLayout = Instance.new("UIListLayout")
			local Start = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIScale = Instance.new("UIScale")
			local SectionName = Instance.new("TextLabel")
			local UIGradient = Instance.new("UIGradient")
			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")

			Section.Name = "Section"
			Section.Parent = ScrollingFrame
			Section.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(0.0836764425, 0, 5.11417042e-08, 0)
			Section.Size = UDim2.new(1.5, 0, 1, 0)

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Section

			UIStroke.Thickness = 0.500
			UIStroke.Transparency = 0.850
			UIStroke.Color = Color3.fromRGB(255, 255, 255)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Section

			UIListLayout.Parent = Section
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 7)

			Start.Name = "Start"
			Start.Parent = Section
			Start.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Start.BackgroundTransparency = 1.000
			Start.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Start.BorderSizePixel = 0
			Start.Size = UDim2.new(0.899999976, 0, 1, 0)

			UIAspectRatioConstraint.Parent = Start
			UIAspectRatioConstraint.AspectRatio = 15.000

			UIScale.Parent = Start
			UIScale.Scale = 1.040

			SectionName.Name = "SectionName"
			SectionName.Parent = Start
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1.000
			SectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionName.BorderSizePixel = 0
			SectionName.Size = UDim2.new(1, 0, 0.999998331, 0)
			SectionName.Font = Enum.Font.GothamBold
			SectionName.Text = SectionNameStr or "Section Name"
			SectionName.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.TextScaled = true
			SectionName.TextSize = 14.000
			SectionName.TextTransparency = 0.210
			SectionName.TextWrapped = true
			SectionName.TextXAlignment = Enum.TextXAlignment.Left

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 0.90)}
			UIGradient.Parent = SectionName

			UIAspectRatioConstraint_2.Parent = Section
			UIAspectRatioConstraint_2.AspectRatio = 5.500
			UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize
			UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Height
			
			local function UpdateSectionSize()
				local Constraint = UIAspectRatioConstraint_2
				local Children = Section:GetChildren()
				local UsedFrame = 0
				local totalSize = Vector2.new(0, 0)

				for _, child in ipairs(Children) do
					if child:isA('Frame') then
						UsedFrame += 1
						totalSize = totalSize + Vector2.new(child.Size.X.Scale,child.Size.Y.Scale)
					end
				end

				local Mide = UsedFrame / 100
				local averageSize = totalSize / UsedFrame

				local verage = ((averageSize.Y / ((UsedFrame * 5)) * 10) * 3) - Mide

				local aspectRatio = math.clamp(verage,1 / 100000,7.5)
				
				if UserInputService.TouchEnabled then
					aspectRatio = aspectRatio - 0.1
				end
				
				TweenService:Create(Constraint,TweenInfo.new(0.1,Enum.EasingStyle.Sine),{AspectRatio = aspectRatio}):Play()
			end
			
			function SectionAccess:NewButton(ButtonStr:string,callback)
				callback = callback or function() end
				
				local Button = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local ClickedButton = Instance.new("TextButton")
				local UIStroke = Instance.new("UIStroke")

				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				Button.BackgroundTransparency = 0.250
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.ClipsDescendants = true
				Button.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = Button
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Button

				Title.Name = "Title"
				Title.Parent = Button
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.481653035, 0, 0.500000596, 0)
				Title.Size = UDim2.new(0.923305988, 0, 0.5, 0)
				Title.Font = Enum.Font.GothamMedium
				Title.Text = ButtonStr or "Dir/Button"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextTransparency = 0.200
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ClickedButton.Name = "ClickedButton"
				ClickedButton.Parent = Button
				ClickedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickedButton.BackgroundTransparency = 1.000
				ClickedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.BorderSizePixel = 0
				ClickedButton.Size = UDim2.new(1, 0, 1, 0)
				ClickedButton.ZIndex = 5
				ClickedButton.Font = Enum.Font.SourceSans
				ClickedButton.Text = ""
				ClickedButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.TextSize = 14.000
				ClickedButton.TextTransparency = 1.000

				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.750
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = Button
				
				ClickedButton.MouseButton1Click:Connect(function()
					Create_Ripple(Button)
					callback()
				end)
				
				UpdateSectionSize()
				
				return {
					Set = function(NewLabel)
						Title.Text = NewLabel or Title.Text
					end,
					Fire = function(dsa)
						callback(dsa)
					end,
				}
			end
			
			function SectionAccess:NewColorPicker(ColorPickerName:string,Default:Color3,callback)
				callback = callback or function() end
				local ColorPicker = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local ClickedButton = Instance.new("TextButton")
				local Pick = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")
				local UICorner_2 = Instance.new("UICorner")
				local ColorPickerMain = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local RGB = Instance.new("ImageLabel")
				local Marker = Instance.new("Frame")
				local Value = Instance.new("ImageLabel")
				local Marker_2 = Instance.new("Frame")
				local Submit = Instance.new("TextButton")
				local UICorner_4 = Instance.new("UICorner")
				local UIStroke_2 = Instance.new("UIStroke")

				ColorPicker.Name = "ColorPicker"
				ColorPicker.Parent = Section
				ColorPicker.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				ColorPicker.BackgroundTransparency = 0.250
				ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorPicker.BorderSizePixel = 0
				ColorPicker.ClipsDescendants = true
				ColorPicker.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = ColorPicker
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ColorPicker

				Title.Name = "Title"
				Title.Parent = ColorPicker
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.361377269, 0, 0.500000596, 0)
				Title.Size = UDim2.new(0.682754457, 0, 0.5, 0)
				Title.Font = Enum.Font.GothamMedium
				Title.Text = ColorPickerName or "Dir/ColorPicker"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextTransparency = 0.200
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ClickedButton.Name = "ClickedButton"
				ClickedButton.Parent = ColorPicker
				ClickedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickedButton.BackgroundTransparency = 1.000
				ClickedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.BorderSizePixel = 0
				ClickedButton.Size = UDim2.new(1, 0, 1, 0)
				ClickedButton.ZIndex = 5
				ClickedButton.Font = Enum.Font.SourceSans
				ClickedButton.Text = ""
				ClickedButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.TextSize = 14.000
				ClickedButton.TextTransparency = 1.000

				Pick.Name = "Pick"
				Pick.Parent = ColorPicker
				Pick.AnchorPoint = Vector2.new(0, 0.5)
				Pick.BackgroundColor3 = Color3.fromRGB(218, 218, 218)
				Pick.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Pick.BorderSizePixel = 0
				Pick.Position = UDim2.new(0.742486894, 0, 0.5, 0)
				Pick.Size = UDim2.new(1.20000005, 0, 0.5, 0)
				Pick.SizeConstraint = Enum.SizeConstraint.RelativeYY
				Pick.Font = Enum.Font.GothamMedium
				Pick.Text = ""
				Pick.TextColor3 = Color3.fromRGB(255, 255, 255)
				Pick.TextScaled = true
				Pick.TextSize = 14.000
				Pick.TextTransparency = 1.000
				Pick.TextWrapped = true
				Pick.ZIndex = 20
				
				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.700
				UIStroke.Color = Color3.fromRGB(106, 106, 106)
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = Pick

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = Pick

				ColorPickerMain.Name = "ColorPickerMain"
				ColorPickerMain.Parent = ColorPicker
				ColorPickerMain.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				ColorPickerMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ColorPickerMain.BorderSizePixel = 0
				ColorPickerMain.Position = UDim2.new(0.240551591, 0, -2.19326425, 0)
				ColorPickerMain.Rotation = 0.010
				ColorPickerMain.Size = UDim2.new(0.5, 0, 0.5, 0)
				ColorPickerMain.SizeConstraint = Enum.SizeConstraint.RelativeXX
				ColorPickerMain.Visible = false
				ColorPickerMain.ZIndex = 10

				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = ColorPickerMain

				RGB.Name = "RGB"
				RGB.Parent = ColorPickerMain
				RGB.AnchorPoint = Vector2.new(0.5, 0)
				RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RGB.BorderColor3 = Color3.fromRGB(40, 40, 40)
				RGB.BorderSizePixel = 2
				RGB.Position = UDim2.new(0.422174513, 0, 0.0221744999, 0)
				RGB.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
				RGB.SizeConstraint = Enum.SizeConstraint.RelativeYY
				RGB.ZIndex = 25
				RGB.Image = "rbxassetid://1433361550"
				RGB.SliceCenter = Rect.new(10, 10, 90, 90)

				Marker.Name = "Marker"
				Marker.Parent = RGB
				Marker.AnchorPoint = Vector2.new(0.5, 0.5)
				Marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Marker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Marker.BorderSizePixel = 2
				Marker.Position = UDim2.new(0.5, 0, 1, 0)
				Marker.Size = UDim2.new(0, 4, 0, 4)
				Marker.ZIndex = 225
				Marker.ClipsDescendants = true

				Value.Name = "Value"
				Value.Parent = ColorPickerMain
				Value.AnchorPoint = Vector2.new(0.5, 0)
				Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderColor3 = Color3.fromRGB(40, 40, 40)
				Value.BorderSizePixel = 2
				Value.Position = UDim2.new(0.880999982, 0, 0.0719999969, 0)
				Value.Size = UDim2.new(0.100000001, 0, 0.600000024, 0)
				Value.ZIndex = 25
				Value.Image = "rbxassetid://359311684"
				Value.SliceCenter = Rect.new(10, 10, 90, 90)

				Marker_2.Name = "Marker"
				Marker_2.Parent = Value
				Marker_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Marker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Marker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Marker_2.BorderSizePixel = 2
				Marker_2.Position = UDim2.new(0.5, 0, 0, 0)
				Marker_2.Size = UDim2.new(1, 4, 0, 2)
				Marker_2.ZIndex = 30
				Marker_2.ClipsDescendants = true

				Submit.Name = "Submit"
				Submit.Parent = ColorPickerMain
				Submit.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
				Submit.BackgroundTransparency = 0.750
				Submit.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Submit.BorderSizePixel = 0
				Submit.Position = UDim2.new(0.120275781, 0, 0.764104962, 0)
				Submit.Size = UDim2.new(0.800000012, 0, 0.200000003, 0)
				Submit.ZIndex = 25
				Submit.Font = Enum.Font.SourceSansSemibold
				Submit.Text = "Submit"
				Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
				Submit.TextScaled = true
				Submit.TextSize = 14.000
				Submit.TextWrapped = true

				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = Submit

				UIStroke_2.Thickness = 3.100
				UIStroke_2.Transparency = 0.750
				UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke_2.Parent = ColorPicker
				
				Pick.BackgroundColor3 = Default or Color3.fromRGB(255,255,255) Color3.new(1, 0, 0.0156863)
				
				local function ConvertHSVToRGB(h, s, v)
					local rgb = Color3.fromHSV(h, s, v)
					local r, g, b = rgb.r, rgb.g, rgb.b
					return Color3.fromRGB(math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
				end
				
				local mouse1Down = false
				local rgb = RGB
				local value = Value

				local selectedColor = Default or Color3.fromHSV(1,1,1)
				local colorData = {1,1,1}

				local mouse1down = false

				local function setColor(hue,sat,val)
					colorData = {hue or colorData[1],sat or colorData[2],val or colorData[3]}
					selectedColor = Color3.fromHSV(colorData[1],colorData[2],colorData[3])
					Pick.BackgroundColor3 = selectedColor
					value.ImageColor3 = Color3.fromHSV(colorData[1],colorData[2],1)
					callback(selectedColor)
				end

				local function inBounds(frame)
					local x,y = Mouse.X - frame.AbsolutePosition.X,Mouse.Y - frame.AbsolutePosition.Y
					local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
					if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
						return x/maxX,y/maxY
					end
				end

				local function updateRGB()
					if not ColorPickerMain.Visible then
						return
					end
					if mouse1Down then
						local x,y = inBounds(rgb)
						if x and y then
							rgb:WaitForChild("Marker").Position = UDim2.new(x,0,y,0)
							setColor(1 - x,1 - y)
						end

						local x,y = inBounds(value)
						if x and y then
							value:WaitForChild("Marker").Position = UDim2.new(0.5,0,y,0)
							setColor(nil,nil,1 - y)
						end
					end
				end
				
				ColorPickerMain.Active = true
				ColorPickerMain.ZIndex = 15
				
				ColorPickerMain.MouseEnter:Connect(function()
					if ColorPickerMain.Visible then
						CanMove = false
					end
				end)
				
				ColorPickerMain.MouseLeave:Connect(function()
					if ColorPickerMain.Visible then
						CanMove = true
					end
				end)
				
				UserInputService.InputChanged:Connect(updateRGB)
				
				local function OffUI()
					TweenService:Create(ColorPickerMain,TweenInfo.new(0.1),{Size = UDim2.new(0, 0, 0, 0)}):Play()
					wait(0.11)
					if ColorPickerMain.Size == UDim2.new(0,0,0,0) then
						ColorPickerMain.Visible = false
					end
				end
				
				OnInputClick(ColorPickerMain,function(value)
					mouse1Down = value
				end,true)
				
				OnInputClick(Pick,function()
					Create_Ripple(ColorPicker)
					if ColorPickerMain.Visible then
						OffUI()
					else
						TweenService:Create(ColorPickerMain,TweenInfo.new(0.1),{Size = UDim2.new(0.5, 0, 0.5, 0)}):Play()
						ColorPickerMain.Visible = true
					end
				end)
				
				Submit.MouseButton1Click:Connect(function()
					CanMove = true
					OffUI()
				end)
				
				UpdateSectionSize()
				
				return {
					Set = function(Color)
						Pick.BackgroundColor3 = Color
						selectedColor = Color
						callback(Color)
					end,
				}
			end
			
			function SectionAccess:NewKeybind(TitleStr:string,Default:Enum.KeyCode,callback:func)
				callback = callback or function() end
				Default = Default or Enum.KeyCode.T
				
				UpdateSectionSize()
				
				local function GetKeyText(Target:Enum.KeyCode)
					if Target ~= Enum.KeyCode.Unknown then
						local Text = tostring(UserInputService:GetStringForKeyCode(Target))
						if (tonumber(#Text) <= 0) then
							Text = Target.Name
						end
						return tostring(Text)
					else
						return tostring(Target.Name)
					end
				end
				
				local Keybind = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local ClickedButton = Instance.new("TextButton")
				local KeyToggle = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")
				local UICorner_2 = Instance.new("UICorner")
				local UIStroke_2 = Instance.new("UIStroke")

				Keybind.Name = "Keybind"
				Keybind.Parent = Section
				Keybind.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				Keybind.BackgroundTransparency = 0.250
				Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Keybind.BorderSizePixel = 0
				Keybind.ClipsDescendants = true
				Keybind.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = Keybind
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Keybind

				Title.Name = "Title"
				Title.Parent = Keybind
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.41090259, 0, 0.500000596, 0)
				Title.Size = UDim2.new(0.781805098, 0, 0.5, 0)
				Title.Font = Enum.Font.GothamMedium
				Title.Text = TitleStr or "Dir/Keybind"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextTransparency = 0.200
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ClickedButton.Name = "ClickedButton"
				ClickedButton.Parent = Keybind
				ClickedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickedButton.BackgroundTransparency = 1.000
				ClickedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.BorderSizePixel = 0
				ClickedButton.Size = UDim2.new(1, 0, 1, 0)
				ClickedButton.ZIndex = 5
				ClickedButton.Font = Enum.Font.SourceSans
				ClickedButton.Text = ""
				ClickedButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.TextSize = 14.000
				ClickedButton.TextTransparency = 1.000

				KeyToggle.Name = "KeyToggle"
				KeyToggle.Parent = Keybind
				KeyToggle.AnchorPoint = Vector2.new(0, 0.5)
				KeyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				KeyToggle.BackgroundTransparency = 0.200
				KeyToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeyToggle.BorderSizePixel = 0
				KeyToggle.Position = UDim2.new(0.742486894, 0, 0.5, 0)
				KeyToggle.Size = UDim2.new(1.20000005, 0, 0.5, 0)
				KeyToggle.SizeConstraint = Enum.SizeConstraint.RelativeYY
				KeyToggle.Font = Enum.Font.GothamMedium
				KeyToggle.Text = GetKeyText(Default) or "E"
				KeyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
				KeyToggle.TextScaled = true
				KeyToggle.TextSize = 14.000
				KeyToggle.TextTransparency = 0.100
				KeyToggle.TextWrapped = true

				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.250
				UIStroke.Color = Color3.fromRGB(106, 106, 106)
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = KeyToggle

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = KeyToggle

				UIStroke_2.Thickness = 3.100
				UIStroke_2.Transparency = 0.750
				UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke_2.Parent = Keybind
				
				UpdateSectionSize()
				
				local Binding = false
				ClickedButton.MouseButton1Click:Connect(function()
					if Binding then
						return
					end
					
					Binding = true
					Create_Ripple(Keybind)
					local TargetKey = nil
					local CallbackFuncions = {}
					table.insert(CallbackFuncions,UserInputService.InputBegan:Connect(function(Key)
						if Key.KeyCode ~= Enum.KeyCode.Unknown then
							TargetKey = Key.KeyCode
						end
					end))
					
					repeat wait() KeyToggle.Text="..." until TargetKey
					Binding = false
					for i,v in ipairs(CallbackFuncions) do
						if v then
							v:Disconnect()
						end
					end
					
					if TargetKey then
						KeyToggle.Text = GetKeyText(TargetKey)
						Default = TargetKey
						callback(TargetKey)
					end
				end)
				return {
					Set = function(NewKKey)
						KeyToggle.Text = GetKeyText(NewKKey)
						Default = NewKKey
						callback(NewKKey)
					end,
				}
			end
			
			function SectionAccess:NewLabel(LabelStr:string):{func}?
				UpdateSectionSize()
				local Label = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")
				local Move = Instance.new("Frame")
				local FF = Instance.new("UIGradient")
				local UIStroke = Instance.new("UIStroke")

				Label.Name = "Label"
				Label.Parent = Section
				Label.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
				Label.BackgroundTransparency = 0.250
				Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label.BorderSizePixel = 0
				Label.ClipsDescendants = true
				Label.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = Label
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Label

				TextLabel.Parent = Label
				TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.5, 0, 0.400000006, 0)
				TextLabel.Size = UDim2.new(0.959999979, 0, 0.5, 0)
				TextLabel.Font = Enum.Font.GothamMedium
				TextLabel.Text = LabelStr or "Dir/s"
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14.000
				TextLabel.TextTransparency = 0.200
				TextLabel.TextWrapped = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				Move.Name = "Move"
				Move.Parent = Label
				Move.AnchorPoint = Vector2.new(0.5, 1)
				Move.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Move.BackgroundTransparency = 0.500
				Move.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Move.BorderSizePixel = 0
				Move.Position = UDim2.new(0.5, 0, 0.949999988, 0)
				Move.Size = UDim2.new(0.949999988, 0, 0.100000001, 0)
				Move.ZIndex = 7

				FF.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.40), NumberSequenceKeypoint.new(1.00, 1.00)}
				FF.Name = "FF"
				FF.Parent = Move

				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.750
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = Label
				return {
					Set = function(Newlabel)
						TextLabel.Text = Newlabel
					end,
				}
			end
			
			function SectionAccess:NewSlider(TitleStr:string,Min:number,Max:number,Increment:number,callback:func):{func}?
				Min = Min or 1
				Max = Max or 100
				Increment = Increment or 1
				callback = callback or function() end
				
				local date = Min
				local Slider = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frount = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Moveed = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Value = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")

				Slider.Name = "Slider"
				Slider.Parent = Section
				Slider.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				Slider.BackgroundTransparency = 0.250
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.ClipsDescendants = true
				Slider.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = Slider
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Slider

				Title.Name = "Title"
				Title.Parent = Slider
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.381243438, 0, 0.270061582, 0)
				Title.Size = UDim2.new(0.722486794, 0, 0.323123842, 0)
				Title.Font = Enum.Font.GothamMedium
				Title.Text = TitleStr or "Dir/Slider"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextTransparency = 0.200
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frount.Name = "Frount"
				Frount.Parent = Slider
				Frount.AnchorPoint = Vector2.new(0.5, 0)
				Frount.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				Frount.BackgroundTransparency = 0.300
				Frount.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frount.BorderSizePixel = 0
				Frount.ClipsDescendants = true
				Frount.Position = UDim2.new(0.5, 0, 0.654999971, 0)
				Frount.Size = UDim2.new(0.899999976, 0, 0.150000006, 0)
				Frount.ZIndex = 10

				UICorner_2.CornerRadius = UDim.new(0, 3)
				UICorner_2.Parent = Frount

				Moveed.Name = "Moveed"
				Moveed.Parent = Frount
				Moveed.AnchorPoint = Vector2.new(0, 0.5)
				Moveed.BackgroundColor3 = Color3.fromRGB(127, 127, 127)
				Moveed.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Moveed.BorderSizePixel = 0
				Moveed.Position = UDim2.new(0, 0, 0.5, 0)
				Moveed.Size = UDim2.new(0.100000001, 0, 0.949999988, 0)
				Moveed.ZIndex = 11

				UICorner_3.CornerRadius = UDim.new(0, 3)
				UICorner_3.Parent = Moveed

				Value.Name = "Value"
				Value.Parent = Slider
				Value.AnchorPoint = Vector2.new(0.5, 0.5)
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1.000
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Position = UDim2.new(0.857456326, 0, 0.270061582, 0)
				Value.Size = UDim2.new(0.229938984, 0, 0.323123842, 0)
				Value.Font = Enum.Font.GothamMedium
				Value.Text = tostring(Min) or "100"
				Value.TextColor3 = Color3.fromRGB(255, 255, 255)
				Value.TextScaled = true
				Value.TextSize = 14.000
				Value.TextTransparency = 0.100
				Value.TextWrapped = true

				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.750
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = Slider
				
				local IS_DOWN = false
				Frount.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						IS_DOWN = true
						CanMove = false
					end
				end)
				Frount.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						IS_DOWN = false
						CanMove = true
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if IS_DOWN  and input.UserInputType == Enum.UserInputType.MouseMovement then 
						local SizeScale = math.clamp(((input.Position.X - Frount.AbsolutePosition.X) / Frount.AbsoluteSize.X), 0, 1)
						local ValueEnum = math.floor(((Max - Min) * SizeScale) + Min)
						local Size = UDim2.fromScale(SizeScale, 1)
						Value.Text = ValueEnum
						TweenService:Create(Moveed,TweenInfo.new(0.1),{Size = Size}):Play()
						callback(ValueEnum)
					end
				end)
				
				return {
					Set = function(Value)
						local SizeScale = math.clamp((Value / Max),0,1)
						local Size =UDim2.fromScale(SizeScale, 1)
						Value.Text = tostring(Value)
						TweenService:Create(Moveed,TweenInfo.new(0.1),{Size = Size}):Play()
						callback(Value)
					end,
				}
			end
			
			function SectionAccess:NewToggle(TitleStr:string,Default:boolean,callback:func):{func}?
				callback = callback or function()
					
				end
				Default = Default or false
				
				local IMGS = {
					TOGGLE_ON = "rbxassetid://3944680095",
					TOOGGLE_OFF = "rbxassetid://10002398990"
				}
				
				local UIStrokegg = Instance.new('UIStroke')
				local Toggle = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local ClickedButton = Instance.new("TextButton")
				local ToggleImage = Instance.new("ImageLabel")
				local UIGradient = Instance.new("UIGradient")
				local UIStroke = Instance.new("UIStroke")

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				Toggle.BackgroundTransparency = 0.250
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.ClipsDescendants = true
				Toggle.Size = UDim2.new(0.920000017, 0, 0.899999976, 0)

				UIAspectRatioConstraint.Parent = Toggle
				UIAspectRatioConstraint.AspectRatio = 5.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Toggle

				Title.Name = "Title"
				Title.Parent = Toggle
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.41090259, 0, 0.500000596, 0)
				Title.Size = UDim2.new(0.781805098, 0, 0.5, 0)
				Title.Font = Enum.Font.GothamMedium
				Title.Text = TitleStr or "Dir/Toggle"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextScaled = true
				Title.TextSize = 14.000
				Title.TextTransparency = 0.200
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ClickedButton.Name = "ClickedButton"
				ClickedButton.Parent = Toggle
				ClickedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickedButton.BackgroundTransparency = 1.000
				ClickedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.BorderSizePixel = 0
				ClickedButton.Size = UDim2.new(1, 0, 1, 0)
				ClickedButton.ZIndex = 5
				ClickedButton.Font = Enum.Font.SourceSans
				ClickedButton.Text = ""
				ClickedButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ClickedButton.TextSize = 14.000
				ClickedButton.TextTransparency = 1.000

				ToggleImage.Name = "ToggleImage"
				ToggleImage.Parent = Toggle
				ToggleImage.AnchorPoint = Vector2.new(0, 0.5)
				ToggleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleImage.BackgroundTransparency = 1.000
				ToggleImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleImage.BorderSizePixel = 0
				ToggleImage.Position = UDim2.new(0.838, 0, 0.5, 0)
				ToggleImage.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
				ToggleImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
				ToggleImage.ZIndex = 5
				ToggleImage.Image = "rbxassetid://10002398990"
				ToggleImage.ImageTransparency = 0.200

				UIGradient.Offset = Vector2.new(-1, 0)
				UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(1.00, 0.00)}
				UIGradient.Parent = ToggleImage

				UIStroke.Thickness = 3.100
				UIStroke.Transparency = 0.750
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Parent = Toggle
				
				UIStrokegg.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
				UIStrokegg.Color = Color3.fromRGB(255, 255, 255)
				UIStrokegg.Thickness = 2
				UIStrokegg.Transparency = 0.75
				UIStrokegg.Parent = ToggleImage
				
				Instance.new('UICorner',ToggleImage).CornerRadius = UDim.new(0,6)
				local function ToggleTo(Value)
					if Value then
						ToggleImage.Image = IMGS.TOGGLE_ON
					else
						ToggleImage.Image = IMGS.TOOGGLE_OFF
					end
					ToggleImage.ImageTransparency = 0.9
					ToggleImage.Size = UDim2.new(0.4,0,0.4,0)
					TweenService:Create(ToggleImage,TweenInfo.new(0.4,Enum.EasingStyle.Back),{ImageTransparency = 0.2,Size = UDim2.new(0.7,0,0.7,0)}):Play()
				end
				
				ToggleTo(Default)
				
				ClickedButton.MouseButton1Click:Connect(function()
					Create_Ripple(Toggle)
					if Default then
						Default = false
					else
						Default = true
					end
					ToggleTo(Default)
					callback(Default)
				end)
				
				return {
					Set = function(NewValue)
						Default = NewValue
						ToggleTo(NewValue)
						callback(NewValue)
					end,
				}
			end
			
			function SectionAccess:Destroy()
				Section:Destroy()
			end
			
			UpdateSectionSize()
			
			Section.Changed:Connect(function()
				UpdateSectionSize()
			end)
			
			return SectionAccess;
		end
		
		TabButton.MouseEnter:Connect(function()
			TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(0,0)}):Play()
		end)
		
		TabButton.MouseLeave:Connect(function()
			if not Tab.Visible then
				TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(-0.5,0)}):Play()
			end
		end)
		
		OnInputClick(TabButton,function()
			Create_Ripple(TabButton)
			TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(0,0)}):Play()
			for i,v in ipairs(Tabs) do
				if v[1] == Tab then
					v[1].Visible = true
				else
					local SliderMouse = Find(v[2],"SliderMouse")
					v[1].Visible = false
					if SliderMouse then
						TweenService:Create(SliderMouse,TweenInfo.new(CurentTime),{Offset = Vector2.new(-0.5,0)}):Play()
					end
				end
			end
		end)
		
		return TabAccess;
	end
	
	function WindowAccess:SetToggle(EnumKey)
		ToggleKey = EnumKey or ToggleKey
	end
	
	function WindowAccess:Destroy()
		return DevwareUIScreen:Destroy()
	end

	local function updateInput(input)
		if not CanMove then
			return
		end
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(Frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end

	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and CanMove then 
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle and CanMove then
				updateInput(input)
			end
		end
	end)
	
	UserInputService.InputBegan:Connect(function(Input)
		if Input.KeyCode==ToggleKey then
			if Frame.Visible then
				Frame.Visible = false
			else
				Frame.Visible = true
			end
		end
	end)
	
	Close.MouseButton1Click:Connect(function()
		if Frame.Visible then
			Frame.Visible = false
		else
			Frame.Visible = true
		end
	end)
	
	return WindowAccess;
end

function Devware:KeySystem(DescriptionStr:string,callback:func)
	
	local dragToggle = nil
	local dragStart = nil
	local startPos = nil
	
	local KeySystem = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Shadow = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local Description = Instance.new("TextLabel")
	local Submit = Instance.new("TextButton")
	local UICorner_2 = Instance.new("UICorner")
	local PasteKey = Instance.new("TextBox")
	local Shadow_2 = Instance.new("ImageLabel")

	KeySystem.Name = "KeySystem"
	KeySystem.Parent = CoreUI
	KeySystem.ResetOnSpawn = false

	Main.Name = "Main"
	Main.Parent = KeySystem
	Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.39626804, 0, 0.298913062, 0)
	Main.Size = UDim2.new(0.349999994, 0, 0.400000006, 0)
	Main.SizeConstraint = Enum.SizeConstraint.RelativeYY

	Shadow.Name = "Shadow"
	Shadow.Parent = Main
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Rotation = 0.000
	Shadow.Size = UDim2.new(1.14999998, 0, 1.14999998, 0)
	Shadow.ZIndex = -10
	Shadow.Image = "rbxassetid://7912134082"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.770
	Shadow.SliceCenter = Rect.new(95, 95, 205, 205)

	UICorner.Parent = Main

	TextLabel.Parent = Main
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.0485248491, 0, 0.025475543, 0)
	TextLabel.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "Key System"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextTransparency = 0.100
	TextLabel.TextWrapped = true

	Description.Name = "Description"
	Description.Parent = Main
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.BackgroundTransparency = 1.000
	Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Description.BorderSizePixel = 0
	Description.Position = UDim2.new(0.194099396, 0, 0.161345109, 0)
	Description.Size = UDim2.new(0.600000024, 0, 0.0490489192, 0)
	Description.Font = Enum.Font.GothamBold
	Description.Text = DescriptionStr or "Description"
	Description.TextColor3 = Color3.fromRGB(255, 255, 255)
	Description.TextScaled = true
	Description.TextSize = 14.000
	Description.TextTransparency = 0.500
	Description.TextWrapped = true

	Submit.Name = "Submit"
	Submit.Parent = Main
	Submit.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	Submit.BackgroundTransparency = 0.600
	Submit.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Submit.BorderSizePixel = 0
	Submit.Position = UDim2.new(0.228066787, 0, 0.844938815, 0)
	Submit.Size = UDim2.new(0.457142889, 0, 0.123573378, 0)
	Submit.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Submit.ZIndex = 5
	Submit.Font = Enum.Font.GothamBold
	Submit.Text = "Submit"
	Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
	Submit.TextScaled = true
	Submit.TextSize = 14.000
	Submit.TextWrapped = true

	UICorner_2.Parent = Submit

	PasteKey.Name = "PasteKey"
	PasteKey.Parent = Main
	PasteKey.AnchorPoint = Vector2.new(0.5, 0)
	PasteKey.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	PasteKey.BackgroundTransparency = 0.200
	PasteKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PasteKey.BorderSizePixel = 0
	PasteKey.Position = UDim2.new(0.5, 0, 0.653999984, 0)
	PasteKey.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)
	PasteKey.ZIndex = 5
	PasteKey.ClearTextOnFocus = false
	PasteKey.Font = Enum.Font.GothamMedium
	PasteKey.MultiLine = true
	PasteKey.PlaceholderColor3 = Color3.fromRGB(225, 225, 225)
	PasteKey.PlaceholderText = "Paste"
	PasteKey.Text = ""
	PasteKey.TextColor3 = Color3.fromRGB(255, 255, 255)
	PasteKey.TextScaled = true
	PasteKey.TextSize = 14.000
	PasteKey.TextTransparency = 0.100
	PasteKey.TextWrapped = true

	Shadow_2.Name = "Shadow"
	Shadow_2.Parent = PasteKey
	Shadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_2.BackgroundTransparency = 1.000
	Shadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow_2.Rotation = 0.000
	Shadow_2.Size = UDim2.new(1.14999998, 0, 1.35000002, 0)
	Shadow_2.ZIndex = 3
	Shadow_2.Image = "rbxassetid://7912134082"
	Shadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow_2.ImageTransparency = 0.770
	Shadow_2.SliceCenter = Rect.new(95, 95, 205, 205)
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(Main, TweenInfo.new(0.05), {Position = position}):Play()
	end

	Main.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input);
			end
		end
	end)
	
	Submit.MouseButton1Click:Connect(function()
		Create_Ripple(Submit);
		wait(0.1);
		local value = callback(PasteKey.Text);
		if value then
			KEY = tostring(PasteKey.Text)
			KeySystem:Destroy();
		end
	end)
	
	return function()
		KeySystem:Destroy();
	end
end

return Devware;
