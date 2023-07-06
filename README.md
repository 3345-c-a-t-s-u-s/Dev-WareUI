# Dev-WareUI
![Thread](https://cdn.discordapp.com/attachments/968821397956722718/1126476680706408453/Screenshot_2023-07-06_043026.png)
Dev Ware UI Library
## Make Your Onwer Script Hub!

## Useing Library
```lua
local DevWareUI = loadstring(game:HttpGet(('https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Dev-WareUI/main/Source.lua')))();
```

## Create Window
```lua
local Window = DevWareUI:CreateWindow("Window - Dev Ware")
```

## Create Tab
```lua
local Tab = Window:NewTab("Tab")
```

## Create Section
```lua
local Section = Tab:NewSection("Section")
```

## Create Button
```lua
Section:NewButton("-Button-",function()
	
end)

-- or --

local Button = Section:NewButton("-Button-",function()
	
end)

Button.Set("-Button2-")
Button.Fire()
```

## Create Toggle
```lua
Section:NewToggle("-Toggle-",false,function(boolen)
	
end)

-- or --

local Toggle = Section:NewToggle("-Toggle2-",false,function()
	
end)

Toggle.Set(true)
```

## Create Label
```lua
Section:NewLabel("Label")

-- or --
local Label = Section:NewLabel("Label")

Label.Set("- Label -")
```

## Create Slider
```lua
Section:NewSlider("-Slider-",1,100,1,function(number)
	
end)

-- or --

local Slider = Section:NewSlider("-Slider2-",1,100,1,function(number)

end)

Slider.Set(50)
```

## Create Keybinds
```lua
Section:NewKeybind("Key Binds",Enum.KeyCode.E,function(EnumKey)
	
end)

-- or --

local KeyBinds = Section:NewKeybind("Key Binds",Enum.KeyCode.E,function(EnumKey)

end)

KeyBinds.Set(Enum.KeyCode.J)
```

## Create ColorPicker
```lua
Section:NewColorPicker("Color",Color3.fromHSV(0, 0, 1),function(HSV)
	
end)

-- or --

local ColorPicker = Section:NewColorPicker("Color",Color3.fromHSV(0, 0, 1),function(HSV)

end)

ColorPicker.Set(Color3.fromHSV(0.997389, 1, 1))
```

# Key System

## To Useing Key System
```lua
_G.KeyPass = false
DevWareUI:KeySystem("Description",function(Key)
	if Key == tostring("Pass") then
		_G.KeyPass = true
		return true -- Remove Key UI
	end
end)

repeat wait() until _G.KeyPass


-- or --

_G.KeyPass = false
local Key = DevWareUI:KeySystem("Description",function(Key)
	if Key == tostring("Pass") then
		_G.KeyPass = true
	end
end)

repeat wait() until _G.KeyPass

Key() -- Remove Key UI
```
