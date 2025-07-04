local Configs_HUB = {
  Cor_Hub = Color3.fromRGB(15, 15, 15),
  Cor_Options = Color3.fromRGB(15, 15, 15),
  Cor_Stroke = Color3.fromRGB(132, 3, 252),
  Cor_Text = Color3.fromRGB(240, 240, 240),
  Cor_DarkText = Color3.fromRGB(140, 140, 140),
  Corner_Radius = UDim.new(0, 4),
  VERDE = Color3.fromRGB(21, 235, 32),
  Text_Font = Enum.Font.FredokaOne
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function Create(instance, parent, props)
  local new = Instance.new(instance, parent)
  if props then
    table.foreach(props, function(prop, value)
      new[prop] = value
    end)
  end
  return new
end

local function SetProps(instance, props)
  if instance and props then
    table.foreach(props, function(prop, value)
      instance[prop] = value
    end)
  end
  return instance
end

local function Corner(parent, props)
  local new = Create("UICorner", parent)
  new.CornerRadius = Configs_HUB.Corner_Radius
  if props then
    SetProps(new, props)
  end
  return new
end

local function Stroke(parent, props)
  local new = Create("UIStroke", parent)
  new.Color = Configs_HUB.Cor_Stroke
  new.ApplyStrokeMode = "Border"
  if props then
    SetProps(new, props)
  end
  return new
end

local function CreateTween(instance, prop, value, time, tweenWait)
  local tween = TweenService:Create(instance,
  TweenInfo.new(time, Enum.EasingStyle.Linear),
  {[prop] = value})
  tween:Play()
  if tweenWait then
    tween.Completed:Wait()
  end
end

local function TextSetColor(instance)
  instance.MouseEnter:Connect(function()
    CreateTween(instance, "TextColor3", Color3.fromRGB(30, 140, 200), 0.4, true)
  end)
  instance.MouseLeave:Connect(function()
    CreateTween(instance, "TextColor3", Configs_HUB.Cor_Text, 0.4, false)
  end)
end

local ScreenGui = Create("ScreenGui", CoreGui, {
  Name = "REDz HUB library"
})

ScreenFind = CoreGui:FindFirstChild(ScreenGui.Name)
if ScreenFind and ScreenFind ~= ScreenGui then
  ScreenFind:Destroy()
end

function DestroyScript()
  ScreenGui:Destroy()
end

local Menu_Notifi = Create("Frame", ScreenGui, {
  Size = UDim2.new(0, 300, 1, 0),
  Position = UDim2.new(1, 0, 0, 0),
  AnchorPoint = Vector2.new(1, 0),
  BackgroundTransparency = 1
})

local Padding = Create("UIPadding", Menu_Notifi, {
  PaddingLeft = UDim.new(0, 25),
  PaddingTop = UDim.new(0, 25),
  PaddingBottom = UDim.new(0, 50)
})

local ListLayout = Create("UIListLayout", Menu_Notifi, {
  Padding = UDim.new(0, 15),
  VerticalAlignment = "Bottom"
})

function MakeNotifi(Configs)
  local Title = Configs.Title or "REDz HUB"
  local text = Configs.Text or "Notificação"
  local timewait = Configs.Time or 5
  
  local Frame1 = Create("Frame", Menu_Notifi, {
    Size = UDim2.new(2, 0, 0, 0),
    BackgroundTransparency = 1,
    AutomaticSize = "Y",
    Name = "Title"
  })
  
  local Frame2 = Create("Frame", Frame1, {
    Size = UDim2.new(0, Menu_Notifi.Size.X.Offset - 50, 0, 0),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),
    AutomaticSize = "Y"
  })
  Corner(Frame2)
  
  local TextLabel = Create("TextLabel", Frame2, {
    Size = UDim2.new(1, 0, 0, 25),
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    Text = Title,
    TextSize = 20,
    Position = UDim2.new(0, 20, 0, 5),
    TextXAlignment = "Left",
    TextColor3 = Configs_HUB.Cor_Text
  })
  
  local TextButton = Create("TextButton", Frame2, {
    Text = "X",
    Font = Configs_HUB.Text_Font,
    TextSize = 20,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Position = UDim2.new(1, -5, 0, 5),
    AnchorPoint = Vector2.new(1, 0),
    Size = UDim2.new(0, 25, 0, 25)
  })
  
  local TextLabel = Create("TextLabel", Frame2, {
    Size = UDim2.new(1, -30, 0, 0),
    Position = UDim2.new(0, 20, 0, TextButton.Size.Y.Offset + 10),
    TextSize = 15,
    TextColor3 = Configs_HUB.Cor_DarkText,
    TextXAlignment = "Left",
    TextYAlignment = "Top",
    AutomaticSize = "Y",
    Text = text,
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.Y,
    TextWrapped = true
  })
  
  local FrameSize = Create("Frame", Frame2, {
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = Configs_HUB.Cor_Stroke,
    Position = UDim2.new(0, 2, 0, 30),
    BorderSizePixel = 0
  })
  Corner(FrameSize)
  Create("Frame", Frame2, {
    Size = UDim2.new(0, 0, 0, 5),
    Position = UDim2.new(0, 0, 1, 5),
    BackgroundTransparency = 1
  })
  
  task.spawn(function()
    CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0, 2), timewait, true)
  end)
  
  TextButton.MouseButton1Click:Connect(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
    CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
    Frame1:Destroy()
  end)
  
  task.spawn(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true)
    CreateTween(Frame2, "Position", UDim2.new(), 0.1, true)
    task.wait(timewait)
    if Frame2 then
      CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
      CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
      Frame1:Destroy()
    end
  end)
end

function MakeWindow(Configs)
  local title = Configs.Hub.Title or "REDz HUB"
  local Anim_Title = Configs.Hub.Animation or "by : redz9999"
  
  local KeySystem = Configs.Key.KeySystem or false
  local KeyTitle = Configs.Key.Title or "Key System"
  local KeyDescription = Configs.Key.Description or ".-."
  local KeyKey = Configs.Key.Keys or {"123", "321"}
  local KeyLink = Configs.Key.KeyLink or ""
  local KeyNotifications = Configs.Key.Notifi.Notifications or true
  local KeyNotSuccess = Configs.Key.Notifi.Incorrectkey or "The key is incorrect"
  local KeySuccess = Configs.Key.Notifi.CorrectKey or "Running the Script..."
  local KeyCopyKeyLink = Configs.Key.Notifi.CopyKeyLink or "Copied to Clipboard"
  
  if KeySystem then
    local KeyMenu = Create("Frame", ScreenGui, {
      Size = UDim2.new(0, 400, 0, 220),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      AnchorPoint = Vector2.new(0.5, 0.5),
      Active = true,
      Draggable = true
    })
    Corner(KeyMenu)
    
    local CloseButton = Create("TextButton", KeyMenu, {
      Size = UDim2.new(0, 30, 0, 30),
      Position = UDim2.new(1, -10, 0, 5),
      AnchorPoint = Vector2.new(1, 0),
      Text = "X",
      Font = Enum.Font.FredokaOne,
      TextScaled = true,
      TextColor3 = Color3.fromRGB(240, 0, 0),
      BackgroundTransparency = 1,
    })
    Corner(CloseButton)
    
    local Title = Create("TextLabel", KeyMenu, {
      Size = UDim2.new(1, -80, 0, 20),
      Position = UDim2.new(0, 20, 0, 5),
      Text = KeyTitle,
      Font = Configs_HUB.Text_Font,
      TextScaled = true,
      TextColor3 = Configs_HUB.Cor_Text,
      TextXAlignment = "Left",
      BackgroundTransparency = 1
    })
    
    local Description = Create("TextLabel", KeyMenu, {
      Size = UDim2.new(1, -80, 0, 0),
      Text = KeyDescription,
      TextSize = 17,
      TextColor3 = Configs_HUB.Cor_DarkText,
      Font = Configs_HUB.Text_Font,
      Position = UDim2.new(0, 20, 0, 25),
      TextXAlignment = "Left",
      AutomaticSize = "Y",
      TextYAlignment = "Top",
      BackgroundTransparency = 1
    })
    
    local ConfirmButton = Create("TextButton", KeyMenu, {
      Text = "Confirm",
      Font = Configs_HUB.Text_Font,
      TextSize = 20,
      TextColor3 = Configs_HUB.Cor_Text,
      Size = UDim2.new(0, 150, 0, 40),
      AnchorPoint = Vector2.new(1, 0),
      Position = UDim2.new(1, -35, 0, 140),
      BackgroundColor3 = Configs_HUB.Cor_Options
    })
    Corner(ConfirmButton)
    
    local GetKeyLink = Create("TextButton", KeyMenu, {
      Text = "Get Key Link",
      Font = Configs_HUB.Text_Font,
      TextSize = 20,
      TextColor3 = Configs_HUB.Cor_Text,
      Size = UDim2.new(0, 150, 0, 40),
      Position = UDim2.new(0, 35, 0, 140),
      BackgroundColor3 = Configs_HUB.Cor_Options
    })
    Corner(GetKeyLink)
    
    local TextBox = Create("TextBox", KeyMenu, {
      Size = UDim2.new(1, -70, 0, 40),
      Position = UDim2.new(0, 35, 0, 90),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      PlaceholderText = "Put the Key here",
      Text = "",
      TextColor3 = Configs_HUB.Cor_Text,
      Font = Configs_HUB.Text_Font,
      TextSize = 25
    })
    Corner(TextBox)
    
    local KeyVerify = false
    CloseButton.MouseButton1Click:Connect(function()
      local UIScale = Create("UIScale", ScreenGui)
      CreateTween(UIScale, "Scale", 0, 0.20, true)
      ScreenGui:Destroy()
    end)
    
    ConfirmButton.MouseButton1Click:Connect(function()
      for _,v in pairs(KeyKey) do
        if TextBox.Text == v then
          KeyVerify = true
        end
      end
      if KeyNotifications and not KeyVerify then
        MakeNotifi({
          Title = KeyTitle,
          Text = KeyNotSuccess,
          Time = 5
        })
      elseif KeyNotifications then
        MakeNotifi({
          Title = KeyTitle,
          Text = KeySuccess,
          Time = 5
        })
      end
    end)
    
    GetKeyLink.MouseButton1Click:Connect(function()
      if KeyNotifications then
        setclipboard(KeyLink)
        MakeNotifi({
          Title = KeyTitle,
          Text = KeyCopyKeyLink,
          Time = 5
        })
      end
    end)
    
    repeat task.wait()
    until KeyVerify
    local UIScale = Create("UIScale", KeyMenu)
    CreateTween(UIScale, "Scale", 0, 0.40, true)
    KeyMenu:Destroy()
  end
  
  local Menu = Create("Frame", ScreenGui, {
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0.5, -500/2, 0.5, -270/2),
    Active = true,
    Draggable = true
  })
  Corner(Menu)
  
  local TopBar = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 25),
    Visible = false
  })
  
  local ButtonsFrame = Create("Frame", TopBar, {
    Size = UDim2.new(0, 40, 1, -5),
    Position = UDim2.new(1, -10, 0, 2.5),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1
  })
  
  local Title = Create("TextLabel", TopBar, {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 20, 0, 0),
    TextColor3 = Configs_HUB.Cor_Text,
    Font = Configs_HUB.Text_Font,
    TextXAlignment = "Left",
    Text = title,
    TextSize = 20,
    BackgroundTransparency = 1
  })
  
  local Minimize_BTN = Create("TextButton", ButtonsFrame, {
    Text = "",
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextYAlignment = "Bottom",
    TextSize = 25
  })
  
  IsMinimized = false
  Minimize_BTN.MouseButton1Click:Connect(function()
    Minimize_BTN.Text = not IsMinimized and "" or ""
    if IsMinimized then
      IsMinimized = false
      CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 270), 0.15, false)
    else
      IsMinimized = true
      CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 25), 0.15, true)
    end
  end)
  
  local Close_Button = Create("TextButton", ButtonsFrame, {
    Text = "×",
    TextYAlignment = "Bottom",
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextSize = 25
  })
  
  local function CreateClose()
    IsMinimized = false
    CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 270), 0.3, false)
    local CloseGui = Create("TextButton", Menu, {
      BackgroundTransparency = 0.5,
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Size = UDim2.new(1, 0, 1, 0),
      AutoButtonColor = false,
      Text = "",
      BackgroundTransparency = 0.5,
      Visible = false
    })
    Corner(CloseGui)
    
    local CloseMenu = Create("Frame", CloseGui, {
      Size = UDim2.new(),
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Transparency = 1,
      BackgroundColor3 = Configs_HUB.Cor_Hub
    })
    Corner(CloseMenu)
    Stroke(CloseMenu)
    
    local Mensage = Create("TextLabel", CloseMenu, {
      Size = UDim2.new(0.8, 0, 0.25, 0),
      Text = "Deseja Realmente Fechar o Script?",
      Position = UDim2.new(0.1, 0, 0.2),
      TextColor3 = Configs_HUB.Cor_Text,
      Font = Configs_HUB.Text_Font,
      TextScaled = true,
      BackgroundTransparency = 1
    })
    
    local Confirm = Create("TextButton", CloseMenu, {
      Size = UDim2.new(0.35, 0, 0.3, 0),
      Position = UDim2.new(0.1, 0, 0.5, 0),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Text = "Fechar",
      Font = Configs_HUB.Text_Font,
      TextColor3 = Color3.fromRGB(240, 0, 0),
      TextSize = 20
    })
    Corner(Confirm)
    Stroke(Confirm)
    
    local Cancel = Create("TextButton", CloseMenu, {
      Size = UDim2.new(0.35, 0, 0.3, 0),
      Position = UDim2.new(0.9, 0, 0.5, 0),
      AnchorPoint = Vector2.new(1, 0),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Text = "Cancelar",
      Font = Configs_HUB.Text_Font,
      TextColor3 = Color3.fromRGB(0, 240, 0),
      TextSize = 20
    })
    Corner(Cancel)
    Stroke(Cancel)
    
    local function SetVisible()
      if Menu.Size.Y.Offset > 100 then
        CloseGui.Visible = true
      else
        CloseGui.Visible = false
      end
    end
    
    SetVisible()
    Menu:GetPropertyChangedSignal("Size"):Connect(SetVisible)
    
    CreateTween(CloseMenu, "Transparency", 0, 0.2, false)
    CreateTween(CloseMenu, "Size", UDim2.new(0.7, 0, 0.7, 0), 0.2, false)
    
    Cancel.MouseButton1Click:Connect(function()
      CreateTween(CloseMenu, "Transparency", 1, 0.3, false)
      CreateTween(CloseMenu, "Size", UDim2.new(), 0.2, true)
      CloseGui:Destroy()
    end)
    
    Confirm.MouseButton1Click:Connect(function()
      CloseGui:Destroy()
      CreateTween(Menu, "Size", UDim2.new(), 0.3, true)
      DestroyScript()
    end)
    
    CloseGui.MouseButton1Click:Connect(function()
      CreateTween(CloseMenu, "Transparency", 1, 0.3, false)
      CreateTween(CloseMenu, "Size", UDim2.new(), 0.2, true)
      CloseGui:Destroy()
    end)
  end
  
  Close_Button.MouseButton1Click:Connect(CreateClose)
  
  local AnimMenu = Create("Frame", ScreenGui, {
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Configs_HUB.Cor_Hub
  })
  Corner(AnimMenu, {CornerRadius = UDim.new(0, 6)})
  
  local Anim_Credits = Create("TextLabel", AnimMenu, {
    Text = Anim_Title,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Visible = false,
    Font = Configs_HUB.Text_Font,
    TextTransparency = 1,
    TextColor3 = Configs_HUB.Cor_Text,
    Position = UDim2.new(0, 50, 0, 0),
    TextXAlignment = "Left",
    TextSize = 15
  })
  
  CreateTween(AnimMenu, "Size", UDim2.new(0, 0, 0, 35), 0.5, true)
  CreateTween(AnimMenu, "Size", UDim2.new(0, 150, 0, 35), 0.5, true)
  Anim_Credits.Visible = true
  task.wait(0.5)
  for i = 1, 0, -0.1 do task.wait()
    Anim_Credits.TextTransparency = i
  end
  task.wait(1)
  for i = 0, 1, 0.1 do task.wait()
    Anim_Credits.TextTransparency = i
  end
  Anim_Credits:Destroy()
  AnimMenu:Destroy()
  CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 35), 0.5, true)
  TopBar.Visible = true
  CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 270), 0.3, true)
  Menu.Draggable = true
  
  local line_Containers = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0)
  })
  
  function MinimizeButton(Configs)
    local image = Configs.Image or ""
    local size = Configs.Size or {30, 30}
    local color = Configs.Color or Configs_HUB.Cor_Hub
    local corner = Configs.Corner or true
    local stroke = Configs.Stroke or false
    local strokecolor = Configs.StrokeColor or Configs_HUB.Cor_Stroke
    
    local Button = Create("ImageButton", ScreenGui, {
      Size = UDim2.new(0, size[1], 0, size[2]),
      Position = UDim2.new(0.15, 0, 0.15, 0),
      BackgroundColor3 = color,
      Image = image,
      Active = true,
      Draggable = true
    })
    if corner then Corner(Button) end
    if stroke then Stroke(Button, {Color = strokecolor}) end
    
    local minimize = false
    Button.MouseButton1Click:Connect(function()
      if minimize then
        minimize = false
        Menu.Visible = true
        if not IsMinimized then
          CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 270), 0.3, false)
        else
          CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 25), 0.3, false)
        end
      else
        minimize = true
        CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 0), 0.3, true)
        Menu.Visible = false
      end
    end)
  end
  
  local ScrollBar = Create("ScrollingFrame", Menu, {
    Size = UDim2.new(0, 140, 1, -tonumber(TopBar.Size.Y.Offset + 2)),
    Position = UDim2.new(0, 0, 1, 0),
    AnchorPoint = Vector2.new(0, 1),
    CanvasSize = UDim2.new(),
    ScrollingDirection = "Y",
    AutomaticCanvasSize = "Y",
    BackgroundTransparency = 1,
    ScrollBarThickness = 2
  })
  Create("UIPadding", ScrollBar, {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
  })
  Create("UIListLayout", ScrollBar, {
    Padding = UDim.new(0, 5)
  })
  
  local Containers = Create("Frame", Menu, {
    Size = UDim2.new(1, -tonumber(ScrollBar.Size.X.Offset + 2), 1, -tonumber(TopBar.Size.Y.Offset + 2)),
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1
  })
  Corner(Containers)
  
  local function Add_Line(props)
    local line = Create("Frame", line_Containers, props)
    line.BackgroundColor3 = Configs_HUB.Cor_Stroke
    line.BorderSizePixel = 0
  end
  
  Add_Line({Size = UDim2.new(1, 0, 0, 1),Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)})
  Add_Line({Size = UDim2.new(0, 1, 1, -tonumber(TopBar.Size.Y.Offset + 1)),
  Position = UDim2.new(0, ScrollBar.Size.X.Offset, 0, TopBar.Size.Y.Offset)})
  
  local firstVisible = true
  local FirstTab = true
  local textsize = 15
  local textcolor = Configs_HUB.Cor_Text
  
  Menu:GetPropertyChangedSignal("Size"):Connect(function()
    if Menu.Size.Y.Offset > 70 then
      ScrollBar.Visible = true
      Containers.Visible = true
      line_Containers.Visible = true
    else
      ScrollBar.Visible = false
      Containers.Visible = false
      line_Containers.Visible = false
    end
  end)
  
  function MakeTab(Configs)
    local TabName = Configs.Name or "Tab"
    local TabTitle = Configs.TabTitle or false
    
    local Frame = Create("Frame", ScrollBar, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundTransparency = 1
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextButton = Create("TextButton", Frame, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Text = ""
    })
    
    local TextLabel = Create("TextLabel", Frame, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Font = Configs_HUB.Text_Font,
      TextColor3 = textcolor,
      TextSize = textsize,
      Text = TabName
    })
    
    local Container = Create("ScrollingFrame", Containers, {
      Size = UDim2.new(1, 0, 1, 0),
      ScrollingDirection = "Y",
      AutomaticCanvasSize = "Y",
      CanvasSize = UDim2.new(),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      Visible = firstVisible
    })
    Create("UIPadding", Container, {
      PaddingLeft = UDim.new(0, 10),
      PaddingRight = UDim.new(0, 10),
      PaddingTop = UDim.new(0, 10),
      PaddingBottom = UDim.new(0, 10)
    })
    Create("UIListLayout", Container, {
      Padding = UDim.new(0, 5)
    })
    
    if TabTitle then
      Create("TextLabel",Container,{BackgroundTransparency=1,Text="#"..string.gsub(TabName," ","-"),TextSize=25,Font=Configs_HUB.Text_Font,TextXAlignment="Left",TextColor3=Configs_HUB.Cor_Text,Size=UDim2.new(1, 0, 0, 30),Position=UDim2.new(0, 30, 0, 0),Name="Frame"})
    end
    
    TextButton.MouseButton1Click:Connect(function()
      for _,container in pairs(Containers:GetChildren()) do
        if container:IsA("ScrollingFrame") then
          container.Visible = false
        end
      end
      for _,frame in pairs(ScrollBar:GetChildren()) do
        if frame:IsA("Frame") and frame:FindFirstChild("TextLabel") and frame.TextLabel ~= TextLabel then
          CreateTween(frame.TextLabel, "TextColor3", Configs_HUB.Cor_DarkText, 0.3, false)
          frame.TextLabel.TextSize = 14
        end
      end
      Container.Visible = true
      CreateTween(TextLabel, "TextColor3", Configs_HUB.Cor_Text, 0.3, false)
      TextLabel.TextSize = 15
    end)
    
    firstVisible = false
    FirstTab = false
    textsize = 14
    textcolor = Configs_HUB.Cor_DarkText
    return Container
  end --PPP
  
  function AddButton(parent, Configs)
    local ButtonName = Configs.Name or "Button!!"
    local Callback = Configs.Callback or function() end
    
    local TextButton = Create("TextButton", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame",
      Text = "",
      AutoButtonColor = false
    })
    Corner(TextButton)
    Stroke(TextButton)
    
    local TextLabel = Create("TextLabel", TextButton, {
      TextSize = 12,
      TextColor3 = Configs_HUB.Cor_DarkText,
      Text = ButtonName,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 35, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      Font = Configs_HUB.Text_Font
    })
    
    local ImageLabel = Create("ImageLabel", TextButton, {
      Image = "rbxassetid://10734898355",
      Size = UDim2.new(0, 20, 0, 20),
      Position = UDim2.new(0, 5, 0, 2.5),
      BackgroundTransparency = 1,
      ImageColor3 = Configs_HUB.Cor_Stroke
    })
    
    TextButton.MouseButton1Click:Connect(function()
      Callback("Click!!")
      CreateTween(ImageLabel, "ImageColor3", Color3.fromRGB(30, 140, 200), 0.2, true)
      CreateTween(ImageLabel, "ImageColor3", Configs_HUB.Cor_Stroke, 0.2, false)
    end)
    
    TextSetColor(TextLabel)
  end
  
  function AddToggle(parent, Configs)
    local ToggleName = Configs.Name or "Toggle!!"
    local Default = Configs.Default or false
    local Callback = Configs.Callback or function() end
    
    local TextButton = Create("TextButton", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame",
      Text = "",
      AutoButtonColor = false
    })
    Corner(TextButton)
    Stroke(TextButton)
    
    local TextLabel = Create("TextLabel", TextButton, {
      TextSize = 12,
      TextColor3 = Configs_HUB.Cor_Text,
      Text = ToggleName,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 35, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      Font = Configs_HUB.Text_Font
    })
    
    local Frame1 = Create("Frame", TextButton, {
      Size = UDim2.new(0, 25, 0, 15),
      Position = UDim2.new(0, 5, 0, 5),
      BackgroundTransparency = 1,
    })
    Corner(Frame1, {CornerRadius = UDim.new(1, 0)})
    local Stroke = Stroke(Frame1, {Thickness = 2})
    
    local Frame2 = Create("Frame", Frame1, {
      Size = UDim2.new(0, 13, 0, 13),
      Position = UDim2.new(0, 2, 0.5, 0),
      AnchorPoint = Vector2.new(0, 0.5),
      BackgroundColor3 = Configs_HUB.Cor_Stroke
    })
    Corner(Frame2, {CornerRadius = UDim.new(1, 0)})
    
    local OnOff = false
    if Default then
      OnOff = true
      CreateTween(Frame2, "Position", UDim2.new(0, 10, 0.5, 0), 0.2, false)
      CreateTween(Frame2, "BackgroundColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
      CreateTween(Stroke, "Color", Color3.fromRGB(30, 140, 200), 0.2, false)
      CreateTween(TextLabel, "TextColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
    end
    Callback(OnOff)
    TextButton.MouseButton1Click:Connect(function()
      if Frame2.Position.X.Offset < 5 then
        OnOff = true
        CreateTween(Frame2, "Position", UDim2.new(0, 10, 0.5, 0), 0.2, false)
        CreateTween(Frame2, "BackgroundColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
        CreateTween(Stroke, "Color", Color3.fromRGB(30, 140, 200), 0.2, false)
        CreateTween(TextLabel, "TextColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
        Callback(true)
      else
        OnOff = false
        CreateTween(Frame2, "Position", UDim2.new(0, 2, 0.5, 0), 0.2, false)
        CreateTween(Frame2, "BackgroundColor3", Configs_HUB.Cor_Stroke, 0.2, false)
        CreateTween(Stroke, "Color", Configs_HUB.Cor_Stroke, 0.2, false)
        CreateTween(TextLabel, "TextColor3", Configs_HUB.Cor_Text, 0.2, false)
        Callback(false)
      end
    end)
    return {Frame2, Stroke, OnOff, Callback}
  end
  
  function AddMobileToggle(Configs)
    local name = Configs.Name or "Atalho"
    local Callback = Configs.Callback or function() end
    local visible = Configs.Visible or false
    
    local Toggle_Atalho = Create("Frame", ScreenGui, {
      Size = UDim2.new(0, 100, 0, 60),
      Position = UDim2.new(0.8, 0, 0.8, 0),
      AnchorPoint = Vector2.new(0.5, 0.5),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Draggable = true,
      Active = true,
      Visible = visible
    })
    Corner(Toggle_Atalho)
    
    local TextLabel = Create("TextLabel", Toggle_Atalho, {
      Size = UDim2.new(1, 0, 0, 20),
      TextSize = 20,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_Text,
      Text = name,
      BackgroundTransparency = 1
    })
    
    local Button = Create("TextButton", Toggle_Atalho, {
      Size = UDim2.new(1, 0, 0, 40),
      Position = UDim2.new(0, 0, 0, 20),
      BackgroundTransparency = 1,
      Text = ""
    })
    
    local Frame = Create("Frame", Button, {
      Position = UDim2.new(0.5, 0, 0.5, 0),
      AnchorPoint = Vector2.new(0.5, 0.5),
      Size = UDim2.new(1, -40, 1, -15),
      BackgroundTransparency = 1
    })
    Corner(Frame, {CornerRadius = UDim.new(2, 0)})
    
    local Frame2 = Create("Frame", Frame, {
      Position = UDim2.new(0, 5, 0.5, 0),
      AnchorPoint = Vector2.new(0, 0.5),
      Size = UDim2.new(0, 17, 0, 17),
      BackgroundTransparency = 1
    })
    Corner(Frame2, {CornerRadius = UDim.new(5, 0)})
    
    local stroke = Stroke(Frame, {
      Color = Color3.fromRGB(100, 100, 100),
      Thickness = 3
    })
    
    local stroke = Stroke(Frame2, {
      Color = Color3.fromRGB(100, 100, 100),
      Thickness = 3
    })
    
    local OnOff = false
    Callback(OnOff)
    Button.MouseButton1Click:Connect(function()
      if OnOff == false then
        CreateTween(Frame2, "Position", UDim2.new(1, -22, 0.5, 0), 0.2, false)
      else
        CreateTween(Frame2, "Position", UDim2.new(0, 5, 0.5, 0), 0.2, false)
      end
      OnOff = not OnOff
      Callback(OnOff)
    end)
    return Toggle_Atalho
  end
  
  function UpdateToggle(toggle, value)
    local Frame2 = toggle[1]
    local Stroke = toggle[2]
    local OnOff = value
    local Callback = toggle[4]
    if OnOff then
      Callback(true)
      CreateTween(Frame2, "Position", UDim2.new(0, 10, 0.5, 0), 0.2, false)
      CreateTween(Frame2, "BackgroundColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
      CreateTween(Stroke, "Color", Color3.fromRGB(30, 140, 200), 0.2, false)
      CreateTween(TextLabel, "TextColor3", Color3.fromRGB(30, 140, 200), 0.2, false)
    else
      Callback(false)
      CreateTween(Frame2, "Position", UDim2.new(0, 2, 0.5, 0), 0.2, false)
      CreateTween(Frame2, "BackgroundColor3", Configs_HUB.Cor_Stroke, 0.2, false)
      CreateTween(Stroke, "Color", Configs_HUB.Cor_Stroke, 0.2, false)
      CreateTween(TextLabel, "TextColor3", Configs_HUB.Cor_Text, 0.2, false)
    end
  end
  
  function AddSlider(parent, Configs)
    local SliderName = Configs.Name or "Slider!!"
    local Increase = Configs.Increase or 1
    local MinValue = Configs.MinValue / Increase or 10 / Increase
    local MaxValue = Configs.MaxValue / Increase or 100 / Increase
    local Default = Configs.Default or 25
    local Callback = Configs.Callback or function() end
    local Frame = Create("TextButton", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame",
      Text = 0
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextLabel = Create("TextButton", Frame, {
      TextSize = 12,
      TextColor3 = Configs_HUB.Cor_Text,
      Text = SliderName,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 150, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      Font = Configs_HUB.Text_Font
    })
    TextSetColor(TextLabel)
    
    local TextLabelNumber = Create("TextLabel", Frame, {
      Font = Configs_HUB.Text_Font,
      Size = UDim2.new(0, 20, 0, 20),
      Text = "...",
      Position = UDim2.new(0, 5, 0, 2.5),
      TextScaled = true,
      TextColor3 = Configs_HUB.Cor_Text,
      BackgroundTransparency = 1
    })
    
    local SliderBar1 = Create("TextLabel", Frame, {
      Size = UDim2.new(0, 100, 0, 7.5),
      Position = UDim2.new(0, 35, 0.5, 0),
      AnchorPoint = Vector2.new(0, 0.5),
      BackgroundColor3 = Configs_HUB.Cor_Stroke,
      Text = ""
    })
    Corner(SliderBar1)
    
    local SavePos = Create("Frame", SliderBar1, {
      Size = UDim2.new(0, 1, 0, 0),
      Visible = false
    })
    
    local Slider = Create("Frame", SliderBar1, {
      BackgroundColor3 = Configs_HUB.Cor_Text,
      Size = UDim2.new(0, 7.5, 0, 15),
      Position = UDim2.new(0, 0, 0.5, 0),
      AnchorPoint = Vector2.new(0, 0.5),
      Active = true,
      Draggable = true
    })
    Corner(Slider)
    
    local SliderBar2 = Create("Frame", SliderBar1, {
      BackgroundColor3 = Color3.fromRGB(30, 140, 200),
      Size = UDim2.new(0, Slider.Position.X.Offset, 1, 0)
    })
    Corner(SliderBar2)
    
    local function UpdCounter(Value)
      local String = tostring(Value * Increase)
      if string.find(String, ".") then
        String = String:sub(1, 5)
      end
      TextLabelNumber.Text = String
      Callback(Value * Increase)
    end
    
    local MouseEnterOrLeave = false
    Frame.MouseButton1Down:Connect(function()
      MouseEnterOrLeave = true
      while MouseEnterOrLeave do
        task.wait()
        local MousePos = UserInputService:GetMouseLocation().X - SavePos.AbsolutePosition.X
        Slider.Position = UDim2.new(0, MousePos, 0.5, 0)
      end
    end)
    
    Frame.MouseLeave:Connect(function()
      MouseEnterOrLeave = false
    end)
    
    local function SliderSet(NewValue)
      local max, min = MaxValue * Increase, MinValue * Increase
      local SliderPos = (NewValue - min) / (max - min)
      local X_Offset = SliderPos * 100
      local SliderPosition = UDim2.new(0, X_Offset + 1, 0, 0)
      CreateTween(Slider, "Position", SliderPosition, 0.5, false)
    end
    SliderSet(Default)
    
    Slider.Changed:Connect(function(prop)
      if prop == "Position" then
        Slider.Position = UDim2.new(0, math.clamp(Slider.Position.X.Offset, 0, 100), 0.5, 0)
        SliderBar2.Size = UDim2.new(0, Slider.Position.X.Offset, 1, 0)
        local SliderPos = Slider.Position.X.Offset / 100
        local A_1 = math.floor(((SliderPos * MaxValue) / MaxValue) * (MaxValue - MinValue) + MinValue)
        UpdCounter(A_1)
      end
    end)
    return {Slider, Increase, MaxValue, MinValue}
  end
  
  function UpdateSlider(Slider, NewValue)
    local Frame = Slider[1]
    local Increase = Slider[2]
    local Max = Slider[3] * Increase
    local Min = Slider[4] * Increase
    local SliderPos = (NewValue - Min) / (Max - Min)
    local X_Offset = SliderPos * 100
    local SliderPosition = UDim2.new(0, X_Offset + 1, 0, 0)
    CreateTween(Frame, "Position", SliderPosition, 0.5, false)
  end
  
  function AddKeybind(parent, Configs)
    local KeybindName = Configs.Name or "Slider!!"
    local KeyCode = Configs.KeyCode or "E"
    local Default = Configs.Default or false
    local Callback = Configs.Callback or function() end
    local Frame = Create("Frame", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame"
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextLabel = Create("TextButton", Frame, {
      TextSize = 12,
      TextColor3 = Configs_HUB.Cor_Text,
      Text = KeybindName,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 35, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      Font = Configs_HUB.Text_Font
    })
    
    local Keybind = Create("TextLabel", Frame, {
      Font = Configs_HUB.Text_Font,
      Size = UDim2.new(0, 18, 0, 18),
      Text = KeyCode,
      Position = UDim2.new(0, 5, 0, 2.5),
      TextScaled = true,
      TextColor3 = Configs_HUB.Cor_Text,
      BackgroundTransparency = 1
    })
    
    local Clicked = false
    TextButton.MouseButton1Click:Connect(function()
      if not Clicked then
        Clicked = true
        Keybind.Text = "..."
        local Input = UserInputService.InputBegan:Connect(function(Key)
          if Key.UserInputType == Enum.UserInputType.Keyboard then
            KeyCode = Key.KeyCode.Name
            Keybind.Text = KeyCode
            Callback(KeyCode)
            Input:Disconnect()
            Clicked = false
          end
        end)
      end
    end)
    TextSetColor(TextLabel)
  end
  
  function AddDropdown(parent, Configs)
    local Name = Configs.Name or "Dropdown"
    local Options = Configs.Options or {"Opção 1", "Opção 2", "Opção 3"}
    local Default = Configs.Default or Options[1]
    local Callback = Configs.Callback or function() end
    
    local Frame = Create("Frame", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame"
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextLabel = Create("TextLabel", Frame, {
      Size = UDim2.new(1, -25, 1, 0),
      Position = UDim2.new(0, 5, 0, 0),
      BackgroundTransparency = 1,
      Text = Name,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_DarkText,
      TextSize = 12,
      TextXAlignment = "Left"
    })
    TextSetColor(TextLabel)
    
    local Button = Create("TextButton", Frame, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Text = ""
    })
    
    local Value = Create("TextLabel", Frame, {
      Size = UDim2.new(0, 100, 1, 0),
      Position = UDim2.new(1, -110, 0, 0),
      AnchorPoint = Vector2.new(1, 0),
      BackgroundTransparency = 1,
      Text = Default,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_Text,
      TextSize = 12,
      TextXAlignment = "Right"
    })
    
    local Arrow = Create("ImageLabel", Frame, {
      Size = UDim2.new(0, 15, 0, 15),
      Position = UDim2.new(1, -20, 0.5, 0),
      AnchorPoint = Vector2.new(1, 0.5),
      Image = "rbxassetid://16447834785",
      BackgroundTransparency = 1,
      ImageColor3 = Configs_HUB.Cor_Text
    })
    
    local Open = false
    local OptionsFrame = Create("Frame", Frame, {
      Size = UDim2.new(1, 0, 0, 0),
      Position = UDim2.new(0, 0, 1, 0),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Visible = false
    })
    Corner(OptionsFrame)
    Stroke(OptionsFrame)
    
    local UIList = Create("UIListLayout", OptionsFrame, {
      Padding = UDim.new(0, 5)
    })
    Create("UIPadding", OptionsFrame, {
      PaddingLeft = UDim.new(0, 5),
      PaddingRight = UDim.new(0, 5),
      PaddingTop = UDim.new(0, 5),
      PaddingBottom = UDim.new(0, 5)
    })
    
    local function CreateOption(text)
      local OptionButton = Create("TextButton", OptionsFrame, {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Configs_HUB.Cor_Hub,
        Text = text,
        Font = Configs_HUB.Text_Font,
        TextColor3 = Configs_HUB.Cor_Text,
        TextSize = 12
      })
      Corner(OptionButton)
      Stroke(OptionButton)
      
      OptionButton.MouseButton1Click:Connect(function()
        Value.Text = text
        Callback(text)
        CreateTween(OptionsFrame, "Size", UDim2.new(1, 0, 0, 0), 0.2, true)
        OptionsFrame.Visible = false
        Open = false
      end)
    end
    
    for _,option in pairs(Options) do
      CreateOption(option)
    end
    
    Button.MouseButton1Click:Connect(function()
      if not Open then
        Open = true
        OptionsFrame.Visible = true
        local totalHeight = #Options * (20 + UIList.Padding.Offset) + (UIList.Padding.Offset * 2)
        CreateTween(OptionsFrame, "Size", UDim2.new(1, 0, 0, totalHeight), 0.2, false)
      else
        Open = false
        CreateTween(OptionsFrame, "Size", UDim2.new(1, 0, 0, 0), 0.2, true)
        OptionsFrame.Visible = false
      end
    end)
    
    --[[
    Para pegar o valor:
    Dropdown[3]
    ]]
    
    --[[
    Para mudar o valor:
    UpdateDropdown(Dropdown, "Novo Valor")
    ]]
    
    return {Frame, OptionsFrame, Value, Callback, Options}
  end
  
  function UpdateDropdown(dropdown, newValue)
    local frame = dropdown[1]
    local optionsFrame = dropdown[2]
    local valueLabel = dropdown[3]
    local callback = dropdown[4]
    local options = dropdown[5]
    
    for _, option in pairs(options) do
      if option == newValue then
        valueLabel.Text = newValue
        callback(newValue)
        return
      end
    end
    warn("New value not found in dropdown options!")
  end
  
  function AddParagraph(parent, Configs)
    local Name = Configs[1] or "Paragraph"
    local Text = Configs[2] or "Text"
    
    local Frame = Create("Frame", parent, {
      Size = UDim2.new(1, 0, 0, 0),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      AutomaticSize = "Y"
    })
    Corner(Frame)
    Stroke(Frame)
    
    local Title = Create("TextLabel", Frame, {
      Size = UDim2.new(1, -20, 0, 20),
      Position = UDim2.new(0, 10, 0, 5),
      BackgroundTransparency = 1,
      Text = Name,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_Text,
      TextSize = 15,
      TextXAlignment = "Left"
    })
    
    local Content = Create("TextLabel", Frame, {
      Size = UDim2.new(1, -20, 0, 0),
      Position = UDim2.new(0, 10, 0, Title.Size.Y.Offset + 10),
      BackgroundTransparency = 1,
      Text = Text,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_DarkText,
      TextSize = 12,
      TextXAlignment = "Left",
      TextYAlignment = "Top",
      TextWrapped = true,
      AutomaticSize = "Y"
    })
    
    local Padding = Create("UIPadding", Frame, {
      PaddingBottom = UDim.new(0, 10)
    })
  end
  
    function AddSection(parent, Configs)
    local SectionName = Configs[1] or Configs.Name or "Section!!"
    
    local Frame = Create("Frame", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Name = "Frame",
      Transparency = 1
    })Corner(Frame)
    
    local TextButton = Create("TextButton", Frame, {
      TextSize = 12,
      TextColor3 = Configs_HUB.VERDE,
      Text = SectionName,
      Size = UDim2.new(1, 0, 0, 25),
      Position = UDim2.new(0, 145, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      Font = Configs_HUB.Text_Font
    })
    return TextButton
  end
  
  function SetSection(Section, NewName)
    Section.Text = NewName
  end
  
  
  function AddTextLabel(parent, text)
    local TextLabel = Create("TextLabel", parent, {
      Size = UDim2.new(1, 0, 0, 20),
      BackgroundTransparency = 1,
      Text = text,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_DarkText,
      TextSize = 12,
      TextXAlignment = "Left"
    })
  end
  
  function AddImageLabel(parent, Configs)
    local Name = Configs.Name or "Image"
    local Image = Configs.Image or "rbxassetid://"
    
    local Frame = Create("Frame", parent, {
      Size = UDim2.new(1, 0, 0, 0),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      AutomaticSize = "Y"
    })
    Corner(Frame)
    Stroke(Frame)
    
    local Title = Create("TextLabel", Frame, {
      Size = UDim2.new(1, -20, 0, 20),
      Position = UDim2.new(0, 10, 0, 5),
      BackgroundTransparency = 1,
      Text = Name,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_Text,
      TextSize = 15,
      TextXAlignment = "Left"
    })
    
    local ImageLabel = Create("ImageLabel", Frame, {
      Size = UDim2.new(1, -20, 0, 150),
      Position = UDim2.new(0, 10, 0, Title.Size.Y.Offset + 10),
      BackgroundTransparency = 1,
      Image = Image,
      ScaleType = Enum.ScaleType.Fit
    })
    
    local Padding = Create("UIPadding", Frame, {
      PaddingBottom = UDim.new(0, 10)
    })
  end
  
