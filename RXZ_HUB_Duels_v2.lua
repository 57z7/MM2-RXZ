Players = game:GetService("Players")
    UserInputService = game:GetService("UserInputService")
    TweenService = game:GetService("TweenService")
    RunService = game:GetService("RunService")
    HttpService = game:GetService("HttpService")
    Lighting = game:GetService("Lighting")
    Workspace = game:GetService("Workspace")
    Stats = game:GetService("Stats")
    MaterialService = game:GetService("MaterialService")
    ReplicatedStorage = game:GetService("ReplicatedStorage")
    SoundService = game:GetService("SoundService")
    StarterGui = game:GetService("StarterGui")
    CoreGui = game:GetService("CoreGui")


    _syn = rawget((getgenv and getgenv()) or _G, "syn") or rawget(_G, "syn")

    if type(protectgui) ~= "function" and _syn and type(_syn.protect_gui) == "function" then
        protectgui = _syn.protect_gui
    end

    if type(getcustomasset) ~= "function" then
        if type(getexecutorasset) == "function" then
            getcustomasset = getexecutorasset
        elseif type(getsynasset) == "function" then
            getcustomasset = getsynasset
        elseif _syn and type(_syn.getcustomasset) == "function" then
            getcustomasset = _syn.getcustomasset
        elseif _syn and type(_syn.getsynasset) == "function" then
            getcustomasset = _syn.getsynasset
        end
    end


    if type(isfile) ~= "function" and _syn and type(_syn.isfile) == "function" then isfile = _syn.isfile end
    if type(readfile) ~= "function" and _syn and type(_syn.readfile) == "function" then readfile = _syn.readfile end
    if type(writefile) ~= "function" and _syn and type(_syn.writefile) == "function" then writefile = _syn.writefile end
    if type(delfile) ~= "function" and _syn and type(_syn.delfile) == "function" then delfile = _syn.delfile end


    if type(getconnections) ~= "function" then
        if type(get_signal_cons) == "function" then
            getconnections = get_signal_cons
        elseif type(getconnects) == "function" then
            getconnections = getconnects
        elseif _syn and type(_syn.get_signal_cons) == "function" then
            getconnections = _syn.get_signal_cons
        end
    end


    function _xluCompatGuiParent()
        if type(gethui) == "function" then
            local ok, parent = pcall(gethui)
            if ok and parent then return parent end
        end
        local okCore, core = pcall(function() return CoreGui end)
        if okCore and core then return core end
        return nil
    end

    LP = Players.LocalPlayer
    PlayerGui = LP:WaitForChild("PlayerGui")

    function getUndetectedGuiParent()
        
        if type(gethui) == "function" then
            local ok, parent = pcall(gethui)
            if ok and parent then return parent end
        end
        
        if protectgui then
            return game:GetService("CoreGui")
        end
        
        local cg = game:GetService("CoreGui")
        if cg then return cg end
        
        return PlayerGui
    end

    function safeParentGui(gui)
        pcall(function()
            if type(gethui) == "function" then
                local ok, parent = pcall(gethui)
                if ok and parent then
                    gui.Parent = parent
                    return
                end
            end
            if protectgui then
                gui.Parent = game:GetService("CoreGui")
                pcall(function() protectgui(gui) end)
                return
            end
            gui.Parent = game:GetService("CoreGui")
        end)
        
        if not gui.Parent then
            pcall(function() gui.Parent = PlayerGui end)
        end
    end



    RyzenAutoMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    _G.RyzenIsMobile = RyzenAutoMobile
    _G.RyzenDeviceMode = RyzenAutoMobile and "MOBILE" or "PC"

    for _, name in ipairs({"RyzenDuelsRyzenReconstruct", "RyzenHubPolished", "RyzenHub"}) do
    old = PlayerGui:FindFirstChild(name)
    if old then old:Destroy() end
    end
    NS = 60
    CS = 30
    LAGGER_SPEED = 29
    LAGGER_CARRY_SPEED = 15
    currentSpeedMode = "Normal"
    speedBoosterEnabled = true
    _G.RyzenModesGuiEnabled = (_G.RyzenModesGuiEnabled == nil) and true or (_G.RyzenModesGuiEnabled == true)
    -- on-screen action notifications (Visual tab -> Notifications)
    if _G.RyzenNotificationsEnabled == nil then _G.RyzenNotificationsEnabled = true end
    autoCarrySpeedEnabled = false
    setAutoCarrySpeedVisual = nil
    _G.RyzenAutoCarryWasCarrying = false
    _G.RyzenAutoCarrySavedMode = nil
    autoCarryEnemyBaseEnabled = false
    autoCarryEnemyBaseRange = 35
    setAutoCarryEnemyBaseVisual = nil
    autoCarryEnemyBaseRangeBox = nil
    autoStealEnabled = false
    selectedStealMode = "Auto Steal"
    autoStealRadius = 63
    _G.RyzenStealRadii = _G.RyzenStealRadii or {["Auto Steal"] = 63, Semi = 9}
    _G.RyzenStealRadii["Auto Steal"] = tonumber(_G.RyzenStealRadii["Auto Steal"] or _G.RyzenStealRadii["Auto Steal"] or _G.RyzenStealRadii["Auto Steal"] or _G.RyzenStealRadii.Normal) or 63
    autoStealRadiusBox = nil
    selectedAimbotMode = "Normal"
    AIMBOT_SPEED = 58
    LAGGER_AIMBOT_SPEED = 40
    _G.RyzenAntiBypassAimbotSpeed = _G.RyzenAntiBypassAimbotSpeed or 58
    if _G.RyzenAntiBypassLaggerAimbotSpeed == nil or tonumber(_G.RyzenAntiBypassLaggerAimbotSpeed) == 58 then _G.RyzenAntiBypassLaggerAimbotSpeed = 40 end
    autoSwingEnabled = false
    mirrorTPDownEnabled = false
    _G.RyzenNormalAimbotOn = _G.RyzenNormalAimbotOn or false
    _G.RyzenAntiBypassAimbotOn = _G.RyzenAntiBypassAimbotOn or false
    antiDesyncAutoSwingEnabled = false
    batCounterEnabled = false
    medCounterEnabled = false
    hardHitEnabled = false
    hardHitRadius = 10
    perfectHitEnabled = false
    perfectHitRange = 175
    _G.RyzenPerfectHitEnabled = false
    _G.RyzenHardHitEnabled = false
    _G.RyzenHardHitRadius = 10
    antiKickEnabled = false
    setSafeModeVisual = nil
    autoResetOnMedEnabled = false
    -- ANTI DROP (404 velocity-spoof donor, integrated into Movement; no keybind / controller bind / mobile button)
    _G.RyzenAntiDropEnabled = true
    espEnabled = false
    showTracerEnabled = false
    ragdollCountdownEnabled = true
    fpsBoostEnabled = false
    antiLagVisualEnabled = false
    antiLagV2Enabled = false
    nukeOptimiserEnabled = false
    fovEnabled = false
    fovValue = 70
    shinyGraphicsEnabled = false
    noCamCollisionEnabled = false
    _G.RyzenNoPlayerCollisionEnabled = _G.RyzenNoPlayerCollisionEnabled or false
    customFontVisualEnabled = false
    _G.RyzenCustomFontSelected = _G.RyzenCustomFontSelected or "None"
    skyTheme = "Off"
    setPlayerESPVisual = nil
    setTracerESPVisual = nil
    setRagdollCountdownVisual = nil
    setFPSBoostVisual = nil
    setAntiLagVisual = nil
    setAntiLagV2Visual = nil
    setNukeOptimiserVisual = nil
    setFOVVisual = nil
    setNoCamCollisionVisual = nil
    _G.RyzenSetNoPlayerCollisionVisual = _G.RyzenSetNoPlayerCollisionVisual or nil
    setCustomFontVisual = nil
    skyValueLabel = nil
    autoLeftEnabled = false
    autoRightEnabled = false
    DEFAULT_SPEED_KEYBINDS = {
    SpeedToggle = Enum.KeyCode.Q,
    LaggerToggle = Enum.KeyCode.R,
    DropBrainrot = Enum.KeyCode.X,
    Aimbot = Enum.KeyCode.E,
    TPBat = Enum.KeyCode.T,
    AutoLeft = Enum.KeyCode.Z,
    AutoRight = Enum.KeyCode.C,
    ToggleUI = Enum.KeyCode.LeftControl,
    }
    DEFAULT_TP_DOWN_KEYBIND = Enum.KeyCode.F
    speedKeybinds = {
    SpeedToggle = DEFAULT_SPEED_KEYBINDS.SpeedToggle,
    LaggerToggle = DEFAULT_SPEED_KEYBINDS.LaggerToggle,
    DropBrainrot = DEFAULT_SPEED_KEYBINDS.DropBrainrot,
    Aimbot = DEFAULT_SPEED_KEYBINDS.Aimbot,
    TPBat = DEFAULT_SPEED_KEYBINDS.TPBat,
    AutoLeft = DEFAULT_SPEED_KEYBINDS.AutoLeft,
    AutoRight = DEFAULT_SPEED_KEYBINDS.AutoRight,
    ToggleUI = DEFAULT_SPEED_KEYBINDS.ToggleUI,
    }
    speedKeybindButtons = {}
    listeningForSpeedKey = nil
    autoTPEnabled = false
    autoTPHeight = 20
    autoTPConn = nil
    autoTPLastRun = 0
    autoTPClickDebounce = false
    tpDownKeybind = Enum.KeyCode.F
    tpDownKeybindButton = nil
    listeningForTPDownKey = false
    keybindListenStartedAt = 0
    -- Controller (gamepad) keybind state: dedicated slots so controller and
    -- keyboard bindings can coexist. Dispatched by the per-frame gamepad poller.
    controllerKeybinds = {
    SpeedToggle = nil,
    LaggerToggle = nil,
    DropBrainrot = nil,
    Aimbot = nil,
    TPBat = nil,
    AutoLeft = nil,
    AutoRight = nil,
    InstaReset = nil,
    ToggleUI = nil,
    }
    controllerTPDownKeybind = nil
    listeningForControllerKey = nil
    controllerKeybindButtons = {}
    -- FIX: the table above is written with every slot = nil, which in Lua means
    -- it is EMPTY. The old loader guarded with `if controllerKeybinds[slot] ~= nil`
    -- so it could never match a slot and controller binds never restored.
    -- This whitelist is what the loader validates against now.
    CONTROLLER_KEYBIND_SLOTS = {
    SpeedToggle = true,
    LaggerToggle = true,
    DropBrainrot = true,
    Aimbot = true,
    TPBat = true,
    AutoLeft = true,
    AutoRight = true,
    InstaReset = true,
    ToggleUI = true,
    }
    setAutoTPVisual = nil
    function doAutoTPDown(force)
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if not hum2 then return end
        if not force then
            if hum2.FloorMaterial ~= Enum.Material.Air then return end
            if not (hrp.Position.Y >= (tonumber(autoTPHeight) or 20)) then return end
        end
        local yaw = select(2, hrp.CFrame:ToEulerAnglesYXZ())
        _skipRagdollFromTP = tick() + 0.6 -- Ryzenx: don't pop the ragdoll timer from a TP
        hrp.CFrame = CFrame.new(hrp.Position.X, -7.00, hrp.Position.Z) * CFrame.Angles(0, yaw, 0)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        pcall(function() hrp.Velocity = Vector3.zero end)
        pcall(function() hrp.RotVelocity = Vector3.zero end)
    end
    local function _clearAutoTPConnection()
    if autoTPConn then
    pcall(function() autoTPConn:Disconnect() end)
    pcall(function() task.cancel(autoTPConn) end)
    autoTPConn = nil
    end
    end
    local function startAutoTP()
    autoTPEnabled = true
    _clearAutoTPConnection()
    autoTPLastRun = 0
    autoTPConn = RunService.Heartbeat:Connect(function()
    if not autoTPEnabled then
    _clearAutoTPConnection()
    return
    end
    local now = tick()
    if now - autoTPLastRun < 0.1 then return end
    autoTPLastRun = now
    pcall(function() doAutoTPDown(false) end)
    end)
    if setAutoTPVisual then setAutoTPVisual(true) end
    end
    local function stopAutoTP()
    autoTPEnabled = false
    _clearAutoTPConnection()
    if setAutoTPVisual then setAutoTPVisual(false) end
    end
    local function runTPFloor()
    pcall(function() doAutoTPDown(true) end)
    end
    local function toggleAutoTP(on)
    if on then
    startAutoTP()
    else
    stopAutoTP()
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    function _G.RyzenStopAutoTPForAction()
    if autoTPEnabled then
    stopAutoTP()
    pcall(function() if setAutoTPVisual then setAutoTPVisual(false) end end)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    end
    local dropBrainrotActive = false
    local _ryzenDropConns = {}

    _G.RyzenDropMode = (_G.RyzenDropMode == "Jump Drop") and "Jump Drop" or "Stand Drop"

    local _xDropLastInvoke = 0
    local _xDropConn = nil
    local function stopDropBrainrot()
        dropBrainrotActive = false
        if _xDropConn then
            pcall(function() _xDropConn:Disconnect() end)
            _xDropConn = nil
        end
        for _, t in ipairs(_ryzenDropConns) do
            if type(t) == "thread" then pcall(task.cancel, t)
            elseif typeof(t) == "RBXScriptConnection" then pcall(function() t:Disconnect() end) end
        end
        _ryzenDropConns = {}
        local c = LP.Character
        if c then
            local root = c:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end

    local function runStandDrop()
        if dropBrainrotActive then return end
        local now = tick()
        if now - _xDropLastInvoke < 0.2 then return end
        _xDropLastInvoke = now
        if _G.RyzenStopAutoTPForAction then _G.RyzenStopAutoTPForAction() end
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        dropBrainrotActive = true
        local startTime = tick()
        _xDropConn = RunService.Heartbeat:Connect(function()
            local currentChar = LP.Character
            local currentRoot = currentChar and currentChar:FindFirstChild("HumanoidRootPart")
            if not currentChar or not currentRoot then
                stopDropBrainrot()
                return
            end
            if tick() - startTime >= (_G.RyzenDropAscendDuration or 0.2) then
                if _xDropConn then pcall(function() _xDropConn:Disconnect() end); _xDropConn = nil end
                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {currentChar}
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                local rayResult = workspace:Raycast(currentRoot.Position, Vector3.new(0, -2000, 0), rayParams)
                if rayResult then
                    local hum = currentChar:FindFirstChildOfClass("Humanoid")
                    local offset = (hum and hum.HipHeight or 2) + (currentRoot.Size.Y / 2)
                    currentRoot.CFrame = CFrame.new(currentRoot.Position.X, rayResult.Position.Y + offset, currentRoot.Position.Z)
                        * CFrame.Angles(0, select(2, currentRoot.CFrame:ToEulerAnglesYXZ()), 0)
                    currentRoot.AssemblyLinearVelocity = Vector3.zero
                    currentRoot.AssemblyAngularVelocity = Vector3.zero
                end
                dropBrainrotActive = false
                return
            end
            local v = currentRoot.AssemblyLinearVelocity
            local up = tonumber(_G.RyzenDropAscendSpeed) or 150
            pcall(function()
                currentRoot.AssemblyLinearVelocity = Vector3.new(v.X, up, v.Z)
            end)
        end)
        task.delay(1.0, function()
            if dropBrainrotActive then stopDropBrainrot() end
        end)
    end

    _G.RyzenJumpDropActive = false
    _G.RyzenJumpDropAscendDuration = 0.2
    _G.RyzenJumpDropAscendSpeed = 150
    _G.RyzenDropAscendDuration = _G.RyzenDropAscendDuration or 0.2
    _G.RyzenDropAscendSpeed    = _G.RyzenDropAscendSpeed    or 150

    function _G.RyzenRunJumpDrop()
    if _G.RyzenJumpDropActive then return end
    if _G.RyzenStopAutoTPForAction then pcall(_G.RyzenStopAutoTPForAction) end

    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then return end

    _G.RyzenJumpDropActive = true
    local startTime = tick()

    _G.RyzenJumpDropConn = RunService.Heartbeat:Connect(function()
    local currentChar = LP.Character
    local currentRoot = currentChar and currentChar:FindFirstChild("HumanoidRootPart")

    if not currentChar or not currentRoot then
    if _G.RyzenJumpDropConn then
    pcall(function() _G.RyzenJumpDropConn:Disconnect() end)
    _G.RyzenJumpDropConn = nil
    end
    _G.RyzenJumpDropActive = false
    return
    end

    if tick() - startTime >= _G.RyzenJumpDropAscendDuration then
    if _G.RyzenJumpDropConn then
    pcall(function() _G.RyzenJumpDropConn:Disconnect() end)
    _G.RyzenJumpDropConn = nil
    end

    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {currentChar}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    local rayResult = workspace:Raycast(currentRoot.Position, Vector3.new(0, -2000, 0), rayParams)
    if rayResult then
    local hum = currentChar:FindFirstChildOfClass("Humanoid")
    local offset = (hum and hum.HipHeight or 2) + (currentRoot.Size.Y / 2)
    currentRoot.CFrame = CFrame.new(currentRoot.Position.X, rayResult.Position.Y + offset, currentRoot.Position.Z)
    currentRoot.AssemblyLinearVelocity = Vector3.zero
    currentRoot.AssemblyAngularVelocity = Vector3.zero
    end

    _G.RyzenJumpDropActive = false
    return
    end

    local _jdCur = currentRoot.AssemblyLinearVelocity
    currentRoot.AssemblyLinearVelocity = Vector3.new(
    _jdCur.X,
    _G.RyzenJumpDropAscendSpeed,
    _jdCur.Z
    )
    end)
    end

    function runDrop()
    if _G.RyzenDropMode == "Jump Drop" then
    _G.RyzenRunJumpDrop()
    else
    runStandDrop()
    end
    end

    function runDropBrainrot()
    runDrop()
    end

    local infJumpEnabled = false
    local antiRagdollEnabled = false
    local antiRagdollConn = nil
    _G.RyzenAntiRagdollMode = "No Splatter"

    _G.RyzenAntiVoidEnabled = _G.RyzenAntiVoidEnabled == true
    _G.RyzenAntiVoidConnection = _G.RyzenAntiVoidConnection or nil
    _G.RyzenAntiVoidSafeCFrame = _G.RyzenAntiVoidSafeCFrame or nil

    function _G.RyzenAntiVoidSaveSafe()
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not hum or not root or hum.Health <= 0 then return end
        if hum.FloorMaterial ~= Enum.Material.Air then
            _G.RyzenAntiVoidSafeCFrame = root.CFrame
        end
    end

    function _G.RyzenAntiVoidStop()
        if _G.RyzenAntiVoidConnection then
            pcall(function() _G.RyzenAntiVoidConnection:Disconnect() end)
            _G.RyzenAntiVoidConnection = nil
        end
    end

    function _G.RyzenAntiVoidSet(on)
        _G.RyzenAntiVoidEnabled = on == true
        _G.RyzenAntiVoidStop()
        if not _G.RyzenAntiVoidEnabled then return end

        _G.RyzenAntiVoidSaveSafe()

        _G.RyzenAntiVoidConnection = RunService.Heartbeat:Connect(function()
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not _G.RyzenAntiVoidEnabled or not hum or not root or hum.Health <= 0 then return end

            local voidY = Workspace.FallenPartsDestroyHeight + 30
            if hum.FloorMaterial ~= Enum.Material.Air and root.Position.Y > voidY + 12 then
                _G.RyzenAntiVoidSafeCFrame = root.CFrame
            elseif root.Position.Y <= voidY and _G.RyzenAntiVoidSafeCFrame then
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = _G.RyzenAntiVoidSafeCFrame + Vector3.new(0, 4, 0)
                hum.PlatformStand = false
                hum.Sit = false
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
            end
        end)
    end
    local unwalkEnabled = false
    local unwalkSavedAnimate = nil
    local hitHarderAnimEnabled = false
    local hitHarderOriginalAnims = {}
    local selectedAnimationPack = "OFF"

    local AnimationPacks = {
    ["Adidas Sports"] = {
    idle = {{"rbxassetid://18537376492", 1}, {"rbxassetid://18537371272", 1}},
    walk = "rbxassetid://18537392113",
    run = "rbxassetid://18537384940",
    jump = "rbxassetid://18537380791",
    fall = "rbxassetid://18537367238",
    climb = "rbxassetid://18537363391",
    swim = "rbxassetid://18537389531",
    swimidle = "rbxassetid://18537387180",
    },
    ["Adidas Community"] = {
    idle = {{"rbxassetid://122257458498464", 1}, {"rbxassetid://102357151005774", 1}},
    walk = "rbxassetid://122150855457006",
    run = "rbxassetid://82598234841035",
    jump = "rbxassetid://75290611992385",
    fall = "rbxassetid://98600215928904",
    climb = "rbxassetid://88763136693023",
    swim = "rbxassetid://133308483266208",
    swimidle = "rbxassetid://109346520324160",
    },
    ["Adidas Aura"] = {
    idle = {{"rbxassetid://110211186840347", 1}, {"rbxassetid://114191137265065", 1}},
    walk = "rbxassetid://83842218823011",
    run = "rbxassetid://118320322718866",
    jump = "rbxassetid://109996626521204",
    fall = "rbxassetid://95603166884636",
    climb = "rbxassetid://97824616490448",
    swim = "rbxassetid://134530128383903",
    swimidle = "rbxassetid://94922130551805",
    },
    ["Wicked Popular"] = {
    idle = {{"rbxassetid://118832222982049", 1}, {"rbxassetid://76049494037641", 1}},
    walk = "rbxassetid://92072849924640",
    run = "rbxassetid://72301599441680",
    jump = "rbxassetid://104325245285198",
    fall = "rbxassetid://121152442762481",
    climb = "rbxassetid://131326830509784",
    swim = "rbxassetid://99384245425157",
    swimidle = "rbxassetid://113199415118199",
    },
    ["Elder"] = {
    idle = {{"rbxassetid://10921101664", 1}, {"rbxassetid://10921102574", 1}},
    walk = "rbxassetid://10921111375",
    run = "rbxassetid://10921104374",
    jump = "rbxassetid://10921107367",
    fall = "rbxassetid://10921105765",
    climb = "rbxassetid://10921100400",
    swim = "rbxassetid://10921108971",
    swimidle = "rbxassetid://10921110146",
    },
    ["Zombie"] = {
    idle = {{"rbxassetid://10921344533", 1}, {"rbxassetid://10921345304", 1}},
    walk = "rbxassetid://10921355261",
    run = "rbxassetid://616163682",
    jump = "rbxassetid://10921351278",
    fall = "rbxassetid://10921350320",
    climb = "rbxassetid://10921343576",
    swim = "rbxassetid://10921352344",
    swimidle = "rbxassetid://10921353442",
    },
    ["Mage"] = {
    idle = {{"rbxassetid://10921144709", 1}, {"rbxassetid://10921145797", 1}},
    walk = "rbxassetid://10921152678",
    run = "rbxassetid://10921148209",
    jump = "rbxassetid://10921149743",
    fall = "rbxassetid://10921148939",
    climb = "rbxassetid://10921143404",
    swim = "rbxassetid://10921150788",
    swimidle = "rbxassetid://10921151661",
    },
    ["Catwalk Glam"] = {
    idle = {{"rbxassetid://133806214992291", 1}, {"rbxassetid://94970088341563", 1}},
    walk = "rbxassetid://109168724482748",
    run = "rbxassetid://81024476153754",
    jump = "rbxassetid://116936326516985",
    fall = "rbxassetid://92294537340807",
    climb = "rbxassetid://119377220967554",
    swim = "rbxassetid://134591743181628",
    swimidle = "rbxassetid://98854111361360",
    },
    ["Astronaut"] = {
    idle = {{"rbxassetid://10921034824", 1}, {"rbxassetid://10921036806", 1}},
    walk = "rbxassetid://10921046031",
    run = "rbxassetid://10921039308",
    jump = "rbxassetid://10921042494",
    fall = "rbxassetid://10921040576",
    climb = "rbxassetid://10921032124",
    swim = "rbxassetid://10921044000",
    swimidle = "rbxassetid://10921045006",
    },
    ['Wicked "Dancing Through Life"'] = {
    idle = {{"rbxassetid://92849173543269", 1}, {"rbxassetid://132238900951109", 1}},
    walk = "rbxassetid://73718308412641",
    run = "rbxassetid://135515454877967",
    jump = "rbxassetid://78508480717326",
    fall = "rbxassetid://78147885297412",
    climb = "rbxassetid://129447497744818",
    swim = "rbxassetid://110657013921774",
    swimidle = "rbxassetid://129183123083281",
    },
    ["Werewolf"] = {
    idle = {{"rbxassetid://10921330408", 1}, {"rbxassetid://10921333667", 1}},
    walk = "rbxassetid://10921342074",
    run = "rbxassetid://10921336997",
    fall = "rbxassetid://10921337907",
    climb = "rbxassetid://10921329322",
    swim = "rbxassetid://10921340419",
    swimidle = "rbxassetid://10921341319",
    },
    ["Superhero"] = {
    idle = {{"rbxassetid://10921288909", 1}, {"rbxassetid://10921290167", 1}},
    walk = "rbxassetid://10921298616",
    run = "rbxassetid://10921291831",
    jump = "rbxassetid://10921294559",
    fall = "rbxassetid://10921293373",
    climb = "rbxassetid://10921286911",
    swim = "rbxassetid://10921295495",
    swimidle = "rbxassetid://10921297391",
    },
    ["Toy"] = {
    idle = {{"rbxassetid://10921301576", 1}, {"rbxassetid://10921301576", 1}},
    walk = "rbxassetid://10921312010",
    run = "rbxassetid://10921306285",
    jump = "rbxassetid://10921308158",
    fall = "rbxassetid://10921307241",
    climb = "rbxassetid://10921300839",
    swim = "rbxassetid://10921309319",
    swimidle = "rbxassetid://10921310341",
    },
    ["No Boundaries"] = {
    idle = {{"rbxassetid://18747067405", 1}, {"rbxassetid://18747063918", 1}},
    walk = "rbxassetid://18747074203",
    run = "rbxassetid://18747070484",
    jump = "rbxassetid://18747069148",
    fall = "rbxassetid://18747062535",
    climb = "rbxassetid://18747060903",
    swim = "rbxassetid://18747073181",
    swimidle = "rbxassetid://18747071682",
    },
    ["NFL"] = {
    idle = {{"rbxassetid://92080889861410", 1}, {"rbxassetid://74451233229259", 1}},
    walk = "rbxassetid://110358958299415",
    run = "rbxassetid://117333533048078",
    jump = "rbxassetid://119846112151352",
    fall = "rbxassetid://129773241321032",
    climb = "rbxassetid://134630013742019",
    swim = "rbxassetid://132697394189921",
    swimidle = "rbxassetid://79090109939093",
    },
    ["Amazon Unboxed"] = {
    idle = {{"rbxassetid://98281136301627", 1}, {"rbxassetid://98281136301627", 1}},
    walk = "rbxassetid://90478085024465",
    run = "rbxassetid://134824450619865",
    jump = "rbxassetid://121454505477205",
    fall = "rbxassetid://94788218468396",
    climb = "rbxassetid://121145883950231",
    swim = "rbxassetid://105962919001086",
    swimidle = "rbxassetid://129126268464847",
    },
    ["Vampire"] = {
    idle = {{"rbxassetid://10921315373", 1}, {"rbxassetid://10921315373", 1}},
    walk = "rbxassetid://10921326949",
    run = "rbxassetid://10921320299",
    jump = "rbxassetid://10921322186",
    fall = "rbxassetid://10921321317",
    climb = "rbxassetid://10921314188",
    swim = "rbxassetid://10921324408",
    swimidle = "rbxassetid://10921325443",
    },
    ["Ninja"] = {
    idle = {{"rbxassetid://656117400", 1}, {"rbxassetid://656118341", 1}},
    walk = "rbxassetid://656121766",
    run = "rbxassetid://656118852",
    jump = "rbxassetid://656117878",
    fall = "rbxassetid://656115606",
    climb = "rbxassetid://656114359",
    swim = "rbxassetid://656119721",
    swimidle = "rbxassetid://656121397",
    },
    ["Robot"] = {
    idle = {{"rbxassetid://616088211", 1}, {"rbxassetid://616089559", 1}},
    walk = "rbxassetid://616095330",
    run = "rbxassetid://616091570",
    jump = "rbxassetid://616090535",
    fall = "rbxassetid://616087089",
    climb = "rbxassetid://616086039",
    swim = "rbxassetid://616092998",
    swimidle = "rbxassetid://616094091",
    },
    ["Levitation"] = {
    idle = {{"rbxassetid://616006778", 1}, {"rbxassetid://616008087", 1}},
    walk = "rbxassetid://616013216",
    run = "rbxassetid://616010382",
    jump = "rbxassetid://616008936",
    fall = "rbxassetid://616005863",
    climb = "rbxassetid://616003713",
    swim = "rbxassetid://616011509",
    swimidle = "rbxassetid://616012453",
    },
    ["Stylish"] = {
    idle = {{"rbxassetid://616136790", 1}, {"rbxassetid://616138447", 1}},
    walk = "rbxassetid://616146177",
    run = "rbxassetid://616140816",
    jump = "rbxassetid://616139451",
    fall = "rbxassetid://616134815",
    climb = "rbxassetid://616133594",
    swim = "rbxassetid://616143378",
    swimidle = "rbxassetid://616144772",
    },
    ["Bubbly"] = {
    idle = {{"rbxassetid://910004836", 1}, {"rbxassetid://910009958", 1}},
    walk = "rbxassetid://910034870",
    run = "rbxassetid://910025107",
    jump = "rbxassetid://910016857",
    fall = "rbxassetid://910001910",
    climb = "rbxassetid://909997997",
    swim = "rbxassetid://910028158",
    swimidle = "rbxassetid://910030921",
    },
    ["Cartoon"] = {
    idle = {{"rbxassetid://742637544", 1}, {"rbxassetid://742638445", 1}},
    walk = "rbxassetid://742640026",
    run = "rbxassetid://742638842",
    jump = "rbxassetid://742637942",
    fall = "rbxassetid://742637151",
    climb = "rbxassetid://742636889",
    swim = "rbxassetid://742639220",
    swimidle = "rbxassetid://742639812",
    },
    }

    local AnimationPackList = {"OFF","Adidas Sports","Adidas Community","Adidas Aura","Wicked Popular","Elder","Zombie","Mage","Catwalk Glam","Astronaut",'Wicked "Dancing Through Life"',"Werewolf","Superhero","Toy","No Boundaries","NFL","Amazon Unboxed","Vampire","Ninja","Robot","Levitation","Stylish","Bubbly","Cartoon"}
    local AnimationPackIndex = 1
    local OriginalAnims = {}
    local animationPackValueLabel = nil
    local refreshAnimationPackRow = nil

    _G.RyzenAnimationSystem = _G.RyzenAnimationSystem or {
        conn = nil,
        original = nil,
        activePack = "OFF",
    }

    function _G.RyzenAnimGetAnimate(char)
        char = char or LP.Character
        return char and char:FindFirstChild("Animate") or nil
    end

    function _G.RyzenAnimReadOriginal(char)
        if _G.RyzenAnimationSystem.original then return end
        local animate = _G.RyzenAnimGetAnimate(char)
        if not animate then return end

        local function g(obj)
            return obj and obj.AnimationId or nil
        end

        _G.RyzenAnimationSystem.original = {
            idle1 = g(animate.idle and animate.idle:FindFirstChild("Animation1")),
            idle2 = g(animate.idle and animate.idle:FindFirstChild("Animation2")),
            walk = g(animate.walk and animate.walk:FindFirstChild("WalkAnim")),
            run = g(animate.run and animate.run:FindFirstChild("RunAnim")),
            jump = g(animate.jump and animate.jump:FindFirstChild("JumpAnim")),
            fall = g(animate.fall and animate.fall:FindFirstChild("FallAnim")),
            climb = g(animate.climb and animate.climb:FindFirstChild("ClimbAnim")),
            swim = g(animate.swim and animate.swim:FindFirstChild("Swim")),
            swimidle = g(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle")),
        }
    end

    function _G.RyzenAnimGetPack(packName)
        return AnimationPacks[packName]
    end

    function _G.RyzenAnimApplyPack(char, packName)
        local animate = _G.RyzenAnimGetAnimate(char)
        local pack = _G.RyzenAnimGetPack(packName)
        if not animate or not pack then return false end

        local function s(obj, id)
            if obj and id then
                obj.AnimationId = tostring(id)
            end
        end

        s(animate.idle and animate.idle:FindFirstChild("Animation1"), pack.idle and pack.idle[1] and pack.idle[1][1])
        s(animate.idle and animate.idle:FindFirstChild("Animation2"), pack.idle and pack.idle[2] and pack.idle[2][1])
        s(animate.walk and animate.walk:FindFirstChild("WalkAnim"), pack.walk)
        s(animate.run and animate.run:FindFirstChild("RunAnim"), pack.run)
        s(animate.jump and animate.jump:FindFirstChild("JumpAnim"), pack.jump)
        s(animate.fall and animate.fall:FindFirstChild("FallAnim"), pack.fall)
        s(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), pack.climb)
        s(animate.swim and animate.swim:FindFirstChild("Swim"), pack.swim)
        s(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle"), pack.swimidle)

        return true
    end

    function _G.RyzenAnimRestore(char)
        local animate = _G.RyzenAnimGetAnimate(char)
        local o = _G.RyzenAnimationSystem.original
        if not animate or not o then return end

        local function s(obj,id)
            if obj and id then obj.AnimationId = id end
        end

        s(animate.idle and animate.idle:FindFirstChild("Animation1"), o.idle1)
        s(animate.idle and animate.idle:FindFirstChild("Animation2"), o.idle2)
        s(animate.walk and animate.walk:FindFirstChild("WalkAnim"), o.walk)
        s(animate.run and animate.run:FindFirstChild("RunAnim"), o.run)
        s(animate.jump and animate.jump:FindFirstChild("JumpAnim"), o.jump)
        s(animate.fall and animate.fall:FindFirstChild("FallAnim"), o.fall)
        s(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), o.climb)
        s(animate.swim and animate.swim:FindFirstChild("Swim"), o.swim)
        s(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle"), o.swimidle)
    end

    function _G.RyzenAnimStop()
        if _G.RyzenAnimationSystem.conn then
            pcall(function() _G.RyzenAnimationSystem.conn:Disconnect() end)
            _G.RyzenAnimationSystem.conn = nil
        end

        _G.RyzenAnimRestore(LP.Character)
        _G.RyzenAnimationSystem.activePack = "OFF"
    end

    function _G.RyzenAnimStart(packName)
        if packName == "OFF" then
            _G.RyzenAnimStop()
            return
        end

        if _G.RyzenAnimationSystem.conn then
            pcall(function() _G.RyzenAnimationSystem.conn:Disconnect() end)
            _G.RyzenAnimationSystem.conn = nil
        end

        local char = LP.Character
        if not char then return end

        local pack = _G.RyzenAnimGetPack(packName)
        if not pack then return end

        _G.RyzenAnimReadOriginal(char)
        _G.RyzenAnimationSystem.activePack = packName

        
        task.spawn(function()
            local list = {}
            for _, v in pairs(pack) do
                if type(v) == "string" then
                    table.insert(list, v)
                elseif type(v) == "table" then
                    for _, a in ipairs(v) do
                        if type(a) == "table" and a[1] then
                            table.insert(list, tostring(a[1]))
                        end
                    end
                end
            end
            pcall(function()
                game:GetService("ContentProvider"):PreloadAsync(list)
            end)
        end)

        _G.RyzenAnimApplyPack(char, packName)

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                pcall(function() track:Stop(0) end)
            end
            pcall(function()
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end)
        end

        
        _G.RyzenAnimationSystem.conn = RunService.Heartbeat:Connect(function()
            if selectedAnimationPack == "OFF" then return end
            local c = LP.Character
            if c then
                _G.RyzenAnimApplyPack(c, selectedAnimationPack)
            end
        end)
    end

    function syncAnimationPackIndex()
        local found = 1
        for i, name in ipairs(AnimationPackList) do
            if name == selectedAnimationPack then
                found = i
                break
            end
        end
        AnimationPackIndex = found
    end

    function applyAnimationPack(packName)
        selectedAnimationPack = packName or "OFF"
        syncAnimationPackIndex()

        if selectedAnimationPack == "OFF" then
            _G.RyzenAnimStop()
        else
            _G.RyzenAnimStart(selectedAnimationPack)
        end

        if refreshAnimationPackRow then
            pcall(refreshAnimationPackRow)
        end
    end


    enableUnwalk = function()
        selectedAnimationPack = "OFF"
        _G.RyzenAnimStop()
    end

    disableUnwalk = function()
    end

    enableHitHarderAnim = function()
        applyAnimationPack("Zombie")
    end

    disableHitHarderAnim = function()
        applyAnimationPack("OFF")
    end

    resetAnimations = function()
        applyAnimationPack("OFF")
    end

    stopCurrentAnimations = function(char)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
            pcall(function() track:Stop(0) end)
        end
    end

    getAnimate = function(char)
        return _G.RyzenAnimGetAnimate(char)
    end

    setAnimId = function(obj,id)
        if obj and id then obj.AnimationId = tostring(id) end
    end

    reloadAnimate = function(animate)
        if not animate then return end
        pcall(function()
            animate.Disabled = true
            task.wait()
            animate.Disabled = false
        end)
    end

    backupAnimations = function(char)
        _G.RyzenAnimReadOriginal(char)
    end

    LP.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        _G.RyzenAnimationSystem.original = nil
        if selectedAnimationPack and selectedAnimationPack ~= "OFF" then
            _G.RyzenAnimStart(selectedAnimationPack)
        end
    end)


    local antiRagdollResetCooldown = 0

    local function forceAntiRagdollReset()
        local char = LP.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root or hum.Health <= 0 then return end

        pcall(function()
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero

            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Motor6D") then obj.Enabled = true end
                if obj:IsA("Constraint") then obj.Enabled = true end
            end

            if workspace.CurrentCamera then
                workspace.CurrentCamera.CameraSubject = hum
            end

            local playerScripts = LP:FindFirstChild("PlayerScripts")
            local playerModule = playerScripts and playerScripts:FindFirstChild("PlayerModule")
            if playerModule then
                local controlModuleObj = playerModule:FindFirstChild("ControlModule")
                if controlModuleObj then
                    local ok, controls = pcall(require, controlModuleObj)
                    if ok and controls and controls.Enable then
                        pcall(function() controls:Enable() end)
                    end
                end
            end

            hum.AutoRotate = true
            hum.PlatformStand = false
            hum.Sit = false
        end)
    end

    local function startAntiRagdoll()
        if antiRagdollConn then return end
        antiRagdollEnabled = true
        antiRagdollConn = RunService.Heartbeat:Connect(function()
            if not antiRagdollEnabled then return end
            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum or not root or hum.Health <= 0 then return end
            local state = hum:GetState()
            local ragdolled = (state == Enum.HumanoidStateType.Physics
                or state == Enum.HumanoidStateType.Ragdoll
                or state == Enum.HumanoidStateType.FallingDown)
            -- NO SPLATTER (user's Pepsi logic): clean reset - BallSocket
            -- constraints are KEPT (no blood/splat mess), motors re-enabled,
            -- instant get-up via forceAntiRagdollReset with a 0.15s cooldown
            if ragdolled then
                local now = tick()
                if now - (antiRagdollResetCooldown or 0) > 0.15 then
                    antiRagdollResetCooldown = now
                    forceAntiRagdollReset()
                end
            end
        end)
    end

    local function stopAntiRagdoll()
        antiRagdollEnabled = false
        if antiRagdollConn then
            antiRagdollConn:Disconnect()
            antiRagdollConn = nil
        end
    end

    local function setAntiRagdoll(on)
        if on then
            startAntiRagdoll()
        else
            stopAntiRagdoll()
        end
    end

    _G.RyzenInfJumpMode = (_G.RyzenInfJumpMode == "Hold") and "Hold" or "Tap"

    -- ============================================================
    -- INFINITE JUMP (Ryzen engine)
    -- ============================================================
    local _xJumpHeld      = false
    local _xIJBoosting    = false
    local _xIJLastBoost   = 0
    local _xIJForce       = 25
    local _xIJFrames      = 2
    local _xIJCooldown    = 0.12
    local _xManualIJConn  = nil
    local _xHoldIJConn    = nil

    local function _xApplyInfJumpBoost(root)
        if not root or _xIJBoosting then return end
        local now = tick()
        if now - _xIJLastBoost < _xIJCooldown then return end
        _xIJLastBoost  = now
        _xIJBoosting   = true

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.P        = 1250
        bv.Velocity = Vector3.new(root.AssemblyLinearVelocity.X, _xIJForce, root.AssemblyLinearVelocity.Z)
        bv.Parent   = root

        local frames = 0
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if frames < _xIJFrames then
                frames = frames + 1
                if bv and bv.Parent then
                    bv.Velocity = bv.Velocity + Vector3.new(0, 0.01, 0)
                end
            else
                if bv then pcall(function() bv:Destroy() end) end
                if conn then conn:Disconnect() end
                _xIJBoosting = false
            end
        end)
    end

    task.spawn(function()
        local pg = LP:WaitForChild("PlayerGui", 10)
        if not pg then return end
        local function hookBtn(btn)
            if btn:IsA("GuiButton") and btn.Name == "JumpButton" and not btn:GetAttribute("RyzenIJHooked") then
                btn:SetAttribute("RyzenIJHooked", true)
                btn.MouseButton1Down:Connect(function() if infJumpEnabled then _xJumpHeld = true end end)
                btn.MouseButton1Up:Connect(function()  _xJumpHeld = false end)
                btn.MouseLeave:Connect(function()      _xJumpHeld = false end)
            end
        end
        for _, d in ipairs(pg:GetDescendants()) do hookBtn(d) end
        pg.DescendantAdded:Connect(hookBtn)
    end)

    UserInputService.JumpRequest:Connect(function()
        -- FIX: JumpRequest fires for every spacebar press, INCLUDING while
        -- typing in a textbox / chat - which made you jump mid-sentence.
        if UserInputService:GetFocusedTextBox() then return end
        if infJumpEnabled and _G.RyzenInfJumpMode == "Tap" then
            _xJumpHeld = true
            task.delay(0.08, function() _xJumpHeld = false end)
        end
    end)

    UserInputService.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        -- FIX: gameProcessed alone is unreliable for executor textboxes, so
        -- also bail out whenever a textbox has focus (typing must not jump).
        if UserInputService:GetFocusedTextBox() then return end
        if infJumpEnabled and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.Space then
            _xJumpHeld = true
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.Space then
            _xJumpHeld = false
        end
    end)

    local function _xStartManualIJLoop()
        if _xManualIJConn then _xManualIJConn:Disconnect() end
        _xManualIJConn = RunService.Heartbeat:Connect(function()
            if not infJumpEnabled or _G.RyzenInfJumpMode ~= "Tap" then return end
            if not _xJumpHeld then return end
            local char = LP.Character
            if not char then return end
            local hum  = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum or not root or hum.Health <= 0 then return end
            _xApplyInfJumpBoost(root)
        end)
    end

    local function _xStopManualIJLoop()
        if _xManualIJConn then
            _xManualIJConn:Disconnect()
            _xManualIJConn = nil
        end
        _xJumpHeld   = false
        _xIJBoosting = false
    end

    local function _xStartHoldIJLoop()
        if _xHoldIJConn then _xHoldIJConn:Disconnect() end
        _xHoldIJConn = RunService.Heartbeat:Connect(function()
            if not infJumpEnabled or _G.RyzenInfJumpMode ~= "Hold" then return end
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum  = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end

            -- FIX: IsKeyDown polls fire even while typing (every space in a
            -- textbox boosted you into the air). Ignore the key while a
            -- textbox has focus; hum.Jump stays valid for real jumps.
            local typing = UserInputService:GetFocusedTextBox() ~= nil
            local held = (not typing and (_xJumpHeld or UserInputService:IsKeyDown(Enum.KeyCode.Space))) or (hum.Jump == true)
            local vel  = root.AssemblyLinearVelocity
            if held and vel.Y < 35 then
                root.AssemblyLinearVelocity = Vector3.new(vel.X, 55, vel.Z)
            end

            vel = root.AssemblyLinearVelocity
            if vel.Y < -120 then
                root.AssemblyLinearVelocity = Vector3.new(vel.X, -120, vel.Z)
            end
        end)
    end

    local function _xStopHoldIJLoop()
        if _xHoldIJConn then
            _xHoldIJConn:Disconnect()
            _xHoldIJConn = nil
        end
    end

    _G.RyzenStopNormalInfJumpHoldState = _xStopHoldIJLoop

    function _G.RyzenRestartInfJump()
        _xStopManualIJLoop()
        _xStopHoldIJLoop()
        if not infJumpEnabled then return end
        if _G.RyzenInfJumpMode == "Hold" then
            _xStartHoldIJLoop()
        else
            _xStartManualIJLoop()
        end
    end

    setInfJumpInternal = function(on)
        infJumpEnabled = on and true or false
        if not infJumpEnabled then
            _xJumpHeld   = false
            _xIJBoosting = false
        end
        _G.RyzenRestartInfJump()
    end

    _G.RyzenRestartInfJump()

    _G.RyzenAntiResetEnabled = _G.RyzenAntiResetEnabled == true

    -- ============================================================
    -- ANTI DIE (full god-mode from Green Duels V3)
    -- SetStateEnabled Dead false + heal on HealthChanged + death
    -- revival via Died event + BreakJoints=false hook
    -- ============================================================
    _G.RyzenAntiDie = { enabled = false, conns = {} }

    function _G.RyzenApplyAntiReset()
        pcall(function()
            StarterGui:SetCore("ResetButtonCallback", false)
        end)
    end

    function _G.RyzenRestoreReset()
        pcall(function()
            StarterGui:SetCore("ResetButtonCallback", true)
        end)
    end

    local function ryzenApplyGodMode(character)
        if not character or not character.Parent then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
        if not humanoid then return end

        pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)

        local healConn
        healConn = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if not _G.RyzenAntiDie.enabled then return end
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
        table.insert(_G.RyzenAntiDie.conns, healConn)

        local deathConn
        deathConn = humanoid.Died:Connect(function()
            if not _G.RyzenAntiDie.enabled then return end
            deathConn:Disconnect()
            task.wait(0.05)
            if humanoid and humanoid.Parent then
                humanoid.Health = humanoid.MaxHealth
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                deathConn = humanoid.Died:Connect(function()
                    if not _G.RyzenAntiDie.enabled then return end
                    task.wait(0.05)
                    if humanoid and humanoid.Parent then
                        humanoid.Health = humanoid.MaxHealth
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                    end
                end)
            end
        end)
        table.insert(_G.RyzenAntiDie.conns, deathConn)

        local breakConn
        pcall(function()
            breakConn = character:GetPropertyChangedSignal("BreakJoints"):Connect(function()
                if not _G.RyzenAntiDie.enabled then return end
                if character.BreakJoints then character.BreakJoints = false end
            end)
        end)
        if breakConn then table.insert(_G.RyzenAntiDie.conns, breakConn) end
    end

    function _G.RyzenHookAntiDieCharacter(char)
        if not _G.RyzenAntiDie.enabled then return end
        ryzenApplyGodMode(char)
    end

    function _G.RyzenSetAntiReset(on)
        _G.RyzenAntiResetEnabled = on == true
        _G.RyzenAntiDie.enabled = on == true

        if _G.RyzenAntiResetEnabled then
            
            task.spawn(function()
                for _ = 1, 12 do
                    if not _G.RyzenAntiResetEnabled then return end
                    _G.RyzenApplyAntiReset()
                    task.wait(0.25)
                end
            end)

            for _, c in ipairs(_G.RyzenAntiDie.conns) do
                pcall(function() c:Disconnect() end)
            end
            _G.RyzenAntiDie.conns = {}

            if LP.Character then
                task.spawn(function()
                    task.wait(0.1)
                    ryzenApplyGodMode(LP.Character)
                end)
            end
        else
            for _, c in ipairs(_G.RyzenAntiDie.conns) do
                pcall(function() c:Disconnect() end)
            end
            _G.RyzenAntiDie.conns = {}
            _G.RyzenRestoreReset()
        end
    end


    if _G.RyzenAntiDieCharConn then
        pcall(function() _G.RyzenAntiDieCharConn:Disconnect() end)
    end
    _G.RyzenAntiDieCharConn = LP.CharacterAdded:Connect(function(char)
        task.wait(0.3)
        if _G.RyzenAntiDie.enabled then
            ryzenApplyGodMode(char)
        end

        if _G.RyzenRestoreAntiDieAfterReset then
            _G.RyzenRestoreAntiDieAfterReset = false
            task.wait(0.35)
            _G.RyzenSetAntiReset(true)
            if _G.RyzenAntiResetVisual then
                pcall(function() _G.RyzenAntiResetVisual(true) end)
            end
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end
    end)

    if LP.Character and _G.RyzenAntiResetEnabled then
        task.defer(function()
            _G.RyzenAntiDie.enabled = true
            ryzenApplyGodMode(LP.Character)
        end)
    end


    _G.RyzenHeadlessEnabled = _G.RyzenHeadlessEnabled == true
    _G.RyzenKorbloxEnabled = _G.RyzenKorbloxEnabled == true
    _G.RyzenHeadlessMeshId = "rbxassetid://1095708"
    _G.RyzenKorbloxMeshId = "rbxassetid://101851696"
    _G.RyzenKorbloxTextureId = "rbxassetid://101851254"

    function _G.RyzenApplyHeadless(char, enabled)
        if not char then return end
        local head = char:FindFirstChild("Head")
        if not head then return end

        local function removeFace()
            local face = head:FindFirstChild("face")
            if face then face:Destroy() end
        end

        if enabled then
            head.Transparency = 1
            head.CanCollide = false
            removeFace()
            -- Pepsi logic: wipe any previous headless mesh (matched by MeshId)
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("SpecialMesh") and child.MeshId == _G.RyzenHeadlessMeshId then
                    child:Destroy()
                end
            end
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = _G.RyzenHeadlessMeshId
            mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
            mesh.Name = "HeadlessMesh"
            mesh.Parent = head
            -- Pepsi logic: locks so the game can't revert the effect
            head:GetPropertyChangedSignal("Transparency"):Connect(function()
                if head.Transparency ~= 1 then head.Transparency = 1 end
            end)
            head.ChildAdded:Connect(function(child)
                if child.Name == "face" and child:IsA("Decal") then child:Destroy() end
            end)
        else
            head.Transparency = 0
            head.CanCollide = true
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("SpecialMesh") and child.Name == "HeadlessMesh" then
                    child:Destroy()
                end
            end
            removeFace()
        end
    end

    function _G.RyzenApplyKorblox(char, enabled)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if hum.RigType == Enum.HumanoidRigType.R6 then
            local rightLeg = char:FindFirstChild("Right Leg")
            if not rightLeg then return end
            if enabled then
                -- Pepsi logic: clear every mesh on the leg, not just ours
                for _, child in ipairs(rightLeg:GetChildren()) do
                    if child:IsA("SpecialMesh") or child:IsA("CharacterMesh") then child:Destroy() end
                end
                rightLeg.Color = Color3.fromRGB(64, 64, 64)
                -- Pepsi logic: lock the color so the game can't revert it
                rightLeg:GetPropertyChangedSignal("Color"):Connect(function()
                    if rightLeg.Color ~= Color3.fromRGB(64, 64, 64) then rightLeg.Color = Color3.fromRGB(64, 64, 64) end
                end)
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = _G.RyzenKorbloxMeshId
                mesh.TextureId = _G.RyzenKorbloxTextureId
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Name = "KorbloxMesh"
                mesh.Parent = rightLeg
            else
                for _, child in ipairs(rightLeg:GetChildren()) do
                    if child:IsA("SpecialMesh") and child.Name == "KorbloxMesh" then child:Destroy() end
                end
                rightLeg.Color = Color3.fromRGB(255, 255, 255)
            end
        elseif hum.RigType == Enum.HumanoidRigType.R15 then
            local rightUpperLeg = char:FindFirstChild("RightUpperLeg")
            if not rightUpperLeg then return end
            if enabled then
                rightUpperLeg.Transparency = 1
                local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
                local rightFoot = char:FindFirstChild("RightFoot")
                if rightLowerLeg then rightLowerLeg.Transparency = 1 end
                if rightFoot then rightFoot.Transparency = 1 end
                local oldKorblox = char:FindFirstChild("KorbloxLeg")
                if oldKorblox then oldKorblox:Destroy() end
                local korbloxLeg = Instance.new("Part")
                korbloxLeg.Name = "KorbloxLeg"
                korbloxLeg.Size = Vector3.new(1, 2, 1)
                korbloxLeg.Anchored = false
                korbloxLeg.CanCollide = false
                korbloxLeg.Massless = true
                korbloxLeg.Color = Color3.fromRGB(64, 64, 64)
                korbloxLeg.Parent = char
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = _G.RyzenKorbloxMeshId
                mesh.TextureId = _G.RyzenKorbloxTextureId
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Name = "KorbloxMesh"
                mesh.Parent = korbloxLeg
                local weld = Instance.new("Weld")
                weld.Part0 = rightUpperLeg
                weld.Part1 = korbloxLeg
                weld.C0 = CFrame.new(0, -0.8, 0)
                weld.Name = "KorbloxWeld"
                weld.Parent = korbloxLeg
            else
                rightUpperLeg.Transparency = 0
                local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
                local rightFoot = char:FindFirstChild("RightFoot")
                if rightLowerLeg then rightLowerLeg.Transparency = 0 end
                if rightFoot then rightFoot.Transparency = 0 end
                local korbloxLeg = char:FindFirstChild("KorbloxLeg")
                if korbloxLeg then korbloxLeg:Destroy() end
            end
        end
    end

    function _G.RyzenApplyCharacterVisuals(char)
        char = char or LP.Character
        if not char then return end
        pcall(function() _G.RyzenApplyHeadless(char, _G.RyzenHeadlessEnabled) end)
        pcall(function() _G.RyzenApplyKorblox(char, _G.RyzenKorbloxEnabled) end)
    end




    _G.RyzenBodyLockEnabled = _G.RyzenBodyLockEnabled == true
    _G.RyzenBodyLockRadius = tonumber(_G.RyzenBodyLockRadius) or 60
    _G.RyzenBodyLockConn = _G.RyzenBodyLockConn or nil

    function _G.RyzenGetNearestBodyLockTarget()
    local character = LP.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local nearest = nil
    local shortest = math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local tr = plr.Character:FindFirstChild("HumanoidRootPart")
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if tr and hum and hum.Health > 0 then
    local d = (tr.Position - root.Position).Magnitude
    if d <= (_G.RyzenBodyLockRadius or 60) and d < shortest then
    shortest = d
    nearest = plr
    end
    end
    end
    end

    return nearest
    end

    function _G.RyzenStartBodyLock()
    if _G.RyzenBodyLockConn then return end
    _G.RyzenBodyLockEnabled = true

    _G.RyzenBodyLockConn = RunService.Heartbeat:Connect(function()
    if not _G.RyzenBodyLockEnabled then return end

    local character = LP.Character
    local myRoot = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not myRoot or not humanoid or humanoid.Health <= 0 then return end

    local target = _G.RyzenGetNearestBodyLockTarget()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
    local targetPos = target.Character.HumanoidRootPart.Position
    local myPos = myRoot.Position
    local offset = Vector3.new(targetPos.X, myPos.Y, targetPos.Z) - myPos

    if offset.Magnitude > 0.1 then
    humanoid.AutoRotate = false
    local lookDir = offset.Unit
    local currentDir = myRoot.CFrame.LookVector
    local cross = currentDir:Cross(lookDir)
    local currentVel = myRoot.AssemblyAngularVelocity
    myRoot.AssemblyAngularVelocity = Vector3.new(currentVel.X, cross.Y * 40, currentVel.Z)
    end
    else
    humanoid.AutoRotate = true
    end
    end)
    end

    function _G.RyzenStopBodyLock()
    _G.RyzenBodyLockEnabled = false

    if _G.RyzenBodyLockConn then
    pcall(function() _G.RyzenBodyLockConn:Disconnect() end)
    _G.RyzenBodyLockConn = nil
    end

    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then
    hum.AutoRotate = true
    end
    end

    function _G.RyzenSetBodyLock(on)
    _G.RyzenBodyLockEnabled = on == true
    if _G.RyzenBodyLockEnabled then
    _G.RyzenStartBodyLock()
    else
    _G.RyzenStopBodyLock()
    end

    if _G.RyzenBodyLockVisual then
    pcall(function() _G.RyzenBodyLockVisual(_G.RyzenBodyLockEnabled) end)
    end
    end

    LP.CharacterAdded:Connect(function()
    if _G.RyzenBodyLockEnabled then
    task.wait(0.3)
    _G.RyzenStopBodyLock()
    _G.RyzenStartBodyLock()
    end
    end)

    local currentBackground = 0
    local aceGuiScaleValue = RyzenAutoMobile and 0.67 or 1.00
    local aceProgressBarScaleValue = RyzenAutoMobile and 0.83 or 1.00
    CONFIG_FILE = "RyzenDuels_MainGUI_Config_DefaultsV2.json"
    KEYBINDS_CONFIG_FILE = "RyzenDuels_Keybinds_DefaultsV2.json"
    _ace_isfile = isfile or (syn and syn.isfile) or function(path)
    local ok, result = pcall(function() return readfile(path) end)
    return ok and result ~= nil
    end
    _ace_readfile = readfile or (syn and syn.readfile)
    _ace_writefile = writefile or (syn and syn.writefile)
    canSaveConfig = true
    _ace_writefile = writefile or (syn and syn.writefile)
    canSaveConfig = (type(_ace_readfile) == "function" and type(_ace_writefile) == "function")

    selectedIntroMusic = selectedIntroMusic or 1
    _introEnabled = (_introEnabled ~= false)
    setIntroVisual = nil
    setIntroSongVisual = nil
    INTRO_MUSIC_OPTIONS = INTRO_MUSIC_OPTIONS or {
    {name="Song 1", url="https://files.catbox.moe/mzvrir.mp3", file="RyzenDuelsIntroSong_1.mp3"},
    {name="Song 2", url="https://files.catbox.moe/2a7jyx.mp3", file="RyzenDuelsIntroSong_2.mp3"},
    {name="Song 3", url="https://files.catbox.moe/rcgr9f.mp3", file="RyzenDuelsIntroSong_3.mp3"},
    {name="Song 4", url="https://files.catbox.moe/iknfuh.mp3", file="RyzenDuelsIntroSong_4.mp3"},
    {name="Song 5", url="https://files.catbox.moe/6eigoh.mp3", file="RyzenDuelsIntroSong_5.mp3"},
    {name="Song 6", url="https://files.catbox.moe/dvjtjk.mp3", file="RyzenDuelsIntroSong_6.mp3"},
    {name="Song 7", url="https://files.catbox.moe/iyw1cb.mp3", file="RyzenDuelsIntroSong_7.mp3"},
    }
    function getIntroSongName()
    local opt = INTRO_MUSIC_OPTIONS[selectedIntroMusic]
    return opt and opt.name or "No Songs Added"
    end
    introPreviewSound = nil
    introPlaybackSound = nil
    introPreviewToken = 0
    introPlaybackToken = 0
    introSongCache = introSongCache or {}
    introSongDownloading = introSongDownloading or {}
    function stopIntroPreview()
    introPreviewToken = introPreviewToken + 1
    if introPreviewSound then
    pcall(function() introPreviewSound:Stop() end)
    pcall(function() introPreviewSound:Destroy() end)
    introPreviewSound = nil
    end
    end
    function stopIntroPlayback()
    introPlaybackToken = introPlaybackToken + 1
    if introPlaybackSound then
    pcall(function() introPlaybackSound:Stop() end)
    pcall(function() introPlaybackSound:Destroy() end)
    introPlaybackSound = nil
    end
    end
    function _safeNotify(msg)
    if showActionNotification then pcall(function() showActionNotification(msg) end) end
    end
    function cacheIntroSong(option, allowDownload)
    if not option or not option.url or option.url == "" then return nil end
    if not (writefile and getcustomasset) then return nil end
    local fileName = option.file or ("RyzenDuelsIntroSong_" .. tostring(option.name or "song") .. ".mp3")
    local function loadExisting()
    if introSongCache[fileName] then return introSongCache[fileName] end
    local hasFile = false
    pcall(function() hasFile = isfile and isfile(fileName) end)
    if hasFile then
    local ok = pcall(function() introSongCache[fileName] = getcustomasset(fileName) end)
    if ok and introSongCache[fileName] then return introSongCache[fileName] end
    end
    return nil
    end
    local cached = loadExisting()
    if cached then return cached end
    if allowDownload == false then return nil end
    if introSongDownloading[fileName] then
    local waitStart = tick()
    while introSongDownloading[fileName] and tick() - waitStart < 12 do task.wait(0.05) end
    cached = loadExisting()
    if cached then return cached end
    end
    introSongDownloading[fileName] = true
    local ok = pcall(function()
    local data = game:HttpGet(option.url)
    if data and #data > 0 then
    writefile(fileName, data)
    introSongCache[fileName] = getcustomasset(fileName)
    end
    end)
    introSongDownloading[fileName] = nil
    if ok and introSongCache[fileName] then return introSongCache[fileName] end
    return loadExisting()
    end
    function preloadIntroSongs()



    RYZEN_INTRO_MUSIC_OPTIONS = {
        {name="Song 1", file="RyzenIntroMusic_18dpz9.mp3", url="https://files.catbox.moe/18dpz9.mp3"},
        {name="Song 2", file="RyzenIntroMusic_gm9wuu.mp3"},
        {name="Song 3", file="RyzenIntroMusic_s2epvz.mp3"},
        {name="Song 4", file="RyzenIntroMusic_w8vxqg.mp3"},
        {name="Song 5", file="RyzenIntroMusic_y02ovb.mp3"},
        {name="Harun be ging", file="Harun_be_ging.mp3"},
    }

    if not RYZEN_INTRO_MUSIC_OPTIONS[selectedIntroMusic] then
        selectedIntroMusic = 1
    end

    local function getRyzenIntroAssetLoader()
        if type(getcustomasset) == "function" then return getcustomasset end
        if type(getexecutorasset) == "function" then return getexecutorasset end
        if type(getsynasset) == "function" then return getsynasset end
        if syn and type(syn.getcustomasset) == "function" then return syn.getcustomasset end
        if syn and type(syn.getsynasset) == "function" then return syn.getsynasset end
        return nil
    end

    local function resolveRyzenIntroSong(index)
        local option = RYZEN_INTRO_MUSIC_OPTIONS[index]
        if not option then return nil end

        local loader = getRyzenIntroAssetLoader()
        if not loader then return nil end

        -- Download support: if the local file is missing but the option has a
        -- url (Song 1 = catbox link), fetch it once and cache it on disk.
        do
            local missing = false
            if type(isfile) == "function" then
                local okExists, exists = pcall(isfile, option.file)
                if okExists and not exists then missing = true end
            end
            if missing and type(option.url) == "string" and option.url ~= ""
                and type(writefile) == "function" then
                pcall(function()
                    local data = game:HttpGet(option.url)
                    if data and #data > 0 then
                        writefile(option.file, data)
                    end
                end)
            end
        end

        if type(isfile) == "function" then
            local okExists, exists = pcall(isfile, option.file)
            if okExists and not exists then return nil end
        end

        local ok, asset = pcall(loader, option.file)
        if ok and asset and tostring(asset) ~= "" then
            return asset
        end
        return nil
    end

    function getIntroSongName()
        local opt = RYZEN_INTRO_MUSIC_OPTIONS[selectedIntroMusic]
        return opt and opt.name or "Song 1"
    end


    function stopIntroPreview()
        introPreviewToken = (introPreviewToken or 0) + 1
        if introPreviewSound then
            pcall(function() introPreviewSound:Stop() end)
            pcall(function() introPreviewSound:Destroy() end)
            introPreviewSound = nil
        end
    end

    function stopIntroPlayback()
        introPlaybackToken = (introPlaybackToken or 0) + 1
        if introPlaybackSound then
            pcall(function() introPlaybackSound:Stop() end)
            pcall(function() introPlaybackSound:Destroy() end)
            introPlaybackSound = nil
        end
    end

    function previewIntroMusic(index)
        stopIntroPreview()
        stopIntroPlayback()

        index = tonumber(index) or selectedIntroMusic or 1
        if not RYZEN_INTRO_MUSIC_OPTIONS[index] then index = 1 end

        local token = introPreviewToken
        task.spawn(function()
            local soundId = resolveRyzenIntroSong(index)
            if token ~= introPreviewToken then return end

            if not soundId then
                if showActionNotification then
                    pcall(function() showActionNotification("INTRO MUSIC FILE NOT FOUND") end)
                end
                return
            end

            local sound = Instance.new("Sound")
            sound.Name = "RyzenIntroPreview_" .. tostring(index)
            sound.SoundId = soundId
            sound.Volume = 0.65
            sound.Looped = false
            sound.Parent = SoundService
            introPreviewSound = sound

            sound.TimePosition = 0
            pcall(function() sound:Play() end)

            task.delay(10, function()
                if token == introPreviewToken then
                    stopIntroPreview()
                end
            end)
        end)
    end

    function playIntroMusic()
        stopIntroPreview()
        stopIntroPlayback()
        if not _introEnabled then return end

        local index = tonumber(selectedIntroMusic) or 1
        if not RYZEN_INTRO_MUSIC_OPTIONS[index] then index = 1 end

        local token = introPlaybackToken
        task.spawn(function()
            local soundId = resolveRyzenIntroSong(index)
            if token ~= introPlaybackToken or not _introEnabled then return end

            if not soundId then
                if showActionNotification then
                    pcall(function() showActionNotification("INTRO MUSIC FILE NOT FOUND") end)
                end
                return
            end

            local sound = Instance.new("Sound")
            sound.Name = "RyzenIntroMusic_" .. tostring(index)
            sound.SoundId = soundId
            sound.Volume = 0.65
            sound.Looped = false
            sound.Parent = SoundService
            introPlaybackSound = sound

            sound.TimePosition = 0
            pcall(function() sound:Play() end)
        end)
    end

    task.spawn(function()
    cacheIntroSong(INTRO_MUSIC_OPTIONS[selectedIntroMusic], true)
    for _, option in ipairs(INTRO_MUSIC_OPTIONS) do
    if option ~= INTRO_MUSIC_OPTIONS[selectedIntroMusic] then
    cacheIntroSong(option, true)
    task.wait(0.05)
    end
    end
    end)
    end
    function makeIntroSoundFromId(soundId, name, parent)
    if not soundId then return nil end
    local sound = Instance.new("Sound")
    sound.Name = name or "RyzenDuelsIntroMusic"
    sound.Volume = 0.65
    sound.Looped = false
    sound.SoundId = soundId
    sound.Parent = parent or SoundService
    return sound
    end
    function createIntroSound(option, fileName, parent, allowDownload)
    if not option then return nil end
    local soundId = cacheIntroSong(option, allowDownload)
    if not soundId then return nil end
    return makeIntroSoundFromId(soundId, fileName, parent)
    end
    function previewIntroMusic(index)
    stopIntroPreview()
    stopIntroPlayback()
    if not INTRO_MUSIC_OPTIONS[index] then _safeNotify("ADD SONG LINKS"); return end
    local token = introPreviewToken
    task.spawn(function()
    local option = INTRO_MUSIC_OPTIONS[index]
    local sound = createIntroSound(option, "RyzenDuelsIntroPreview_" .. tostring(token), SoundService, true)
    if token ~= introPreviewToken then if sound then sound:Destroy() end; return end
    introPreviewSound = sound
    if not sound then _safeNotify("SONG LOADING..."); return end
    sound.TimePosition = 0
    pcall(function() sound:Play() end)
    task.delay(15, function() if token == introPreviewToken then stopIntroPreview() end end)
    end)
    end
    function playIntroMusic()
    stopIntroPreview()
    stopIntroPlayback()
    if not _introEnabled then return end
    local option = INTRO_MUSIC_OPTIONS[selectedIntroMusic]
    if not option then return end
    local token = introPlaybackToken
    task.spawn(function()
    local sound = createIntroSound(option, "RyzenDuelsIntroMusic_" .. tostring(token), SoundService, true)
    if token ~= introPlaybackToken or not _introEnabled then if sound then pcall(function() sound:Destroy() end) end; return end
    introPlaybackSound = sound
    if not sound then _safeNotify("SONG FAILED"); return end
    sound.TimePosition = 0
    local loadStart = tick()
    while sound and not sound.IsLoaded and tick() - loadStart < 10 do task.wait(0.05) end
    pcall(function() sound:Play() end)
    task.delay(15, function() if token == introPlaybackToken then stopIntroPlayback() end end)
    end)
    end
    preloadIntroSongs()

    savedConfig = {}
    _G.RyzenGuiLocked = _G.RyzenGuiLocked == true
    if _G.RyzenHideMobileButtons == nil then
    _G.RyzenHideMobileButtons = not RyzenAutoMobile
    else
    _G.RyzenHideMobileButtons = _G.RyzenHideMobileButtons == true
    _G.RyzenMobileButtonScale = tonumber(_G.RyzenMobileButtonScale) or 0.75
    end
    _G.RyzenMobileButtonScale = tonumber(_G.RyzenMobileButtonScale) or (RyzenAutoMobile and 0.90 or 1.00)
    _G.RyzenMobileButtonPositions = _G.RyzenMobileButtonPositions or {}
    _G.RyzenMobileButtonImage = _G.RyzenMobileButtonImage or ""
    _G.RyzenMobileButtonShape = _G.RyzenMobileButtonShape or "ROUNDED"
    _G.RyzenStealUIImage = _G.RyzenStealUIImage or ""
    savedMainPositionTable = nil
    savedMiniPositionTable = nil
    savedStealBarPositionTable = nil
    function udim2ToTable(u)
    return {xs = u.X.Scale, xo = u.X.Offset, ys = u.Y.Scale, yo = u.Y.Offset}
    end
    function tableToUDim2(t, fallback)
    if type(t) == "table" then
    return UDim2.new(tonumber(t.xs) or 0, tonumber(t.xo) or 0, tonumber(t.ys) or 0, tonumber(t.yo) or 0)
    end
    return fallback
    end
    function collectRyzenMobileButtonPositions()
    local out = {}
    for key, entry in pairs(_G.RyzenMobileButtonRefs or {}) do
    local holder = entry and entry.holder
    if holder then out[key] = udim2ToTable(holder.Position) end
    end
    if next(out) == nil and type(_G.RyzenMobileButtonPositions) == "table" then
    return _G.RyzenMobileButtonPositions
    end
    -- Keep saved positions when buttons are reconstructed during a rerun.
    for key, position in pairs(_G.RyzenMobileButtonPositions or {}) do
        if out[key] == nil then out[key] = position end
    end
    out.instaReset = nil
    _G.RyzenMobileButtonPositions = out
    return out
    end
    function getSavedMobileButtonPosition(key, fallback)
    if type(_G.RyzenMobileButtonPositions) == "table" then
    local t = _G.RyzenMobileButtonPositions[key]
    if type(t) == "table" then
    return tableToUDim2(t, fallback)
    end
    end
    return fallback
    end
    function saveMobileButtonPosition(key, pos)
    if not key then return end
    _G.RyzenMobileButtonPositions = _G.RyzenMobileButtonPositions or {}
    _G.RyzenMobileButtonPositions[key] = udim2ToTable(pos)
    if type(saveRyzenConfig) == "function" then
    pcall(saveRyzenConfig)
    end
    end
    function keyToString(key)
    if not key then return "None" end
    return tostring(key):gsub("Enum.KeyCode.", "")
    end
    function stringToKeyCode(value)
    if type(value) ~= "string" or value == "" or value == "None" then return nil end
    return Enum.KeyCode[value]
    end
    function keybindsToTable()
    local out = {}
    for keyId in pairs(DEFAULT_SPEED_KEYBINDS) do
    out[keyId] = keyToString(speedKeybinds[keyId])
    end
    for keyId, key in pairs(speedKeybinds) do
    out[keyId] = keyToString(key)
    end
    return out
    end
    function collectRyzenKeybindConfig()
    local ctrlOut = {}
    -- write EVERY slot, including unbound ones as "None", so clearing a
    -- controller bind persists instead of silently keeping the old value
    for slot in pairs(CONTROLLER_KEYBIND_SLOTS) do
    ctrlOut[slot] = keyToString(controllerKeybinds[slot])
    end
    for slot, k in pairs(controllerKeybinds) do
    ctrlOut[slot] = keyToString(k)
    end
    return {
    keybinds = keybindsToTable(),
    tpDownKeybind = keyToString(tpDownKeybind),
    controllerKeybinds = ctrlOut,
    controllerTPDownKeybind = keyToString(controllerTPDownKeybind),
    }
    end
    function applySavedKeybinds(t)
    if type(t) ~= "table" then return end
    for keyId in pairs(speedKeybinds) do
    if t[keyId] ~= nil then
    speedKeybinds[keyId] = stringToKeyCode(t[keyId])
    end
    end
    end
    function applyDefaultRyzenKeybinds()
    for keyId, key in pairs(DEFAULT_SPEED_KEYBINDS) do
    speedKeybinds[keyId] = key
    end
    tpDownKeybind = DEFAULT_TP_DOWN_KEYBIND
    end
    function collectRyzenConfig()
    return {
    lastActiveTab = _G.RyzenLastActiveTab or "MOVEMENT",
    mainPosition = savedMainPositionTable,
    miniPosition = savedMiniPositionTable,
    stealBarPosition = savedStealBarPositionTable,
    keybinds = keybindsToTable(),
    tpDownKeybind = keyToString(tpDownKeybind),
    NS = NS,
    CS = CS,
    LAGGER_SPEED = LAGGER_SPEED,
    LAGGER_CARRY_SPEED = LAGGER_CARRY_SPEED,
    currentSpeedMode = currentSpeedMode,
    notificationsEnabled = _G.RyzenNotificationsEnabled ~= false,
    modesGuiEnabled = _G.RyzenModesGuiEnabled == true,
    dropMode = _G.RyzenDropMode,
    autoCarrySpeedEnabled = autoCarrySpeedEnabled == true,
    autoCarryEnemyBaseEnabled = autoCarryEnemyBaseEnabled == true,
    autoCarryEnemyBaseRange = tonumber(autoCarryEnemyBaseRange) or 35,
    autoTPEnabled = autoTPEnabled,
    autoTPHeight = autoTPHeight,
    infJumpEnabled = infJumpEnabled,
    infJumpMode = _G.RyzenInfJumpMode,
    antiRagdollEnabled = antiRagdollEnabled,
    antiRagdollMode = _G.RyzenAntiRagdollMode,
    antiVoidEnabled = _G.RyzenAntiVoidEnabled == true,
    antiResetEnabled = _G.RyzenAntiResetEnabled == true,
    selectedAnimationPack = selectedAnimationPack,
    selectedMoreAnimationBundle = _G.RyzenSelectedMoreAnimationBundle,
    selectedStealMode = selectedStealMode,
    autoStealEnabled = autoStealEnabled,
    autoStealPauseEnabled = _G.RyzenAutoStealPause == true,
    autoStealPausePercent = tonumber(_G.RyzenAutoStealPausePercent) or 75,
    autoStealRadius = autoStealRadius,
    aceStealRadii = _G.RyzenStealRadii,
    selectedAimbotMode = selectedAimbotMode,
    AIMBOT_SPEED = AIMBOT_SPEED,
    LAGGER_AIMBOT_SPEED = LAGGER_AIMBOT_SPEED,
    ANTI_BYPASS_AIMBOT_SPEED = _G.RyzenAntiBypassAimbotSpeed,
    ANTI_BYPASS_LAGGER_AIMBOT_SPEED = _G.RyzenAntiBypassLaggerAimbotSpeed,
    autoSwingEnabled = autoSwingEnabled,
    mirrorTPDownEnabled = mirrorTPDownEnabled,
    normalAimbotEnabled = _G.RyzenNormalAimbotOn == true,
    antiBypassAimbotEnabled = _G.RyzenAntiBypassAimbotOn == true,
    antiDesyncAutoSwingEnabled = antiDesyncAutoSwingEnabled,
    tpBatEnabled = _G.RyzenTPBatEnabled == true,
    tpBatMode = _G.RyzenTPBatMode,
    antiDropEnabled = _G.RyzenAntiDropEnabled == true,
    batCounterEnabled = batCounterEnabled,
    medCounterEnabled = medCounterEnabled,
    hardHitEnabled = hardHitEnabled == true,
    hardHitRadius = tonumber(hardHitRadius) or 10,
    perfectHitEnabled = perfectHitEnabled == true,
    perfectHitRange = tonumber(perfectHitRange) or 175,
    safeMode = antiKickEnabled == true,
    autoResetOnMedEnabled = autoResetOnMedEnabled,
    espEnabled = espEnabled,
    showTracerEnabled = showTracerEnabled,
    ragdollCountdownEnabled = ragdollCountdownEnabled,
    fpsBoostEnabled = fpsBoostEnabled,
    antiLagVisualEnabled = antiLagVisualEnabled,
    antiLagV2Enabled = antiLagV2Enabled,
    nukeOptimiserEnabled = nukeOptimiserEnabled,
    fovEnabled = fovEnabled,
    fovValue = fovValue,
    shinyGraphicsEnabled = shinyGraphicsEnabled == true,
    noCamCollisionEnabled = noCamCollisionEnabled,
    noPlayerCollisionEnabled = _G.RyzenNoPlayerCollisionEnabled,
    customFontVisualEnabled = (_G.RyzenCustomFontSelected or "None") ~= "None",
    customFontSelected = _G.RyzenCustomFontSelected or "None",
    skyTheme = skyTheme,
    autoLeftEnabled = autoLeftEnabled,
    autoRightEnabled = autoRightEnabled,
    currentBackground = currentBackground,
    bodyLockEnabled = _G.RyzenBodyLockEnabled == true,
    bodyLockRadius = tonumber(_G.RyzenBodyLockRadius) or 60,
    mobileButtonScale = tonumber(_G.RyzenMobileButtonScale) or 0.75,
    guiScaleValue = tonumber(_G.RyzenGuiScaleValue) or tonumber(ryzenGuiScaleValue) or tonumber(aceGuiScaleValue) or 0.52,
    stealUiScaleValue = tonumber(_G.RyzenProgressBarScaleValue) or tonumber(ryzenProgressBarScaleValue) or tonumber(aceProgressBarScaleValue) or 0.83,
    headlessEnabled = _G.RyzenHeadlessEnabled == true,
    korbloxEnabled = _G.RyzenKorbloxEnabled == true,
    currentThemeName = _G.RyzenThemeName,
    aceGuiScaleValue = aceGuiScaleValue,
    aceProgressBarScaleValue = aceProgressBarScaleValue,
    introEnabled = _introEnabled == true,
    selectedIntroMusic = selectedIntroMusic,
    guiLocked = _G.RyzenGuiLocked == true,
    hideMobileButtons = _G.RyzenHideMobileButtons == true,
    aceMobileButtonScale = _G.RyzenMobileButtonScale,
    mobileButtonPositions = collectRyzenMobileButtonPositions(),
    mobileButtonImage = _G.RyzenMobileButtonImage or "",
    mobileButtonShape = _G.RyzenMobileButtonShape or "ROUNDED",
    stealUIImage = _G.RyzenStealUIImage or "",
    autoStealV2Radius = tonumber((_G.RyzenStealRadii and _G.RyzenStealRadii["Auto Steal"]) or autoStealRadius) or 63,
    autoStealV3Radius = tonumber((_G.RyzenStealRadii and _G.RyzenStealRadii["Auto Steal"]) or 63) or 63,
    aceStealRadii = {
        ["Auto Steal"] = tonumber((_G.RyzenStealRadii and _G.RyzenStealRadii["Auto Steal"]) or autoStealRadius) or 63,
        ["Auto Steal"] = tonumber((_G.RyzenStealRadii and _G.RyzenStealRadii["Auto Steal"]) or 63) or 63,
        Semi = tonumber((_G.RyzenStealRadii and _G.RyzenStealRadii.Semi) or 9) or 9,
    },
    duelMode = _G.RyzenDuelMode or "half",
    autoMoveSpeed = tonumber(_G.RyzenAutoMoveSpeed) or 60,
    autoMoveCarrySpeed = tonumber(_G.RyzenAutoMoveCarrySpeed) or 30,
    stretchValue = tonumber(_G.RyzenStretchValue) or 0.7,
    stretchPreset = _G.RyzenStretchPreset or "Medium",
    avatarChangerUserId = (_G.RyzenAvatarChangerCleared and 0) or ((_G.RyzenAvatarChangerState and _G.RyzenAvatarChangerState.lastUserId) or 0),
    avatarChangerUsername = (_G.RyzenAvatarChangerCleared and "") or ((_G.RyzenAvatarChangerState and _G.RyzenAvatarChangerState.lastUsername) or ""),
    }
    end
    function saveRyzenConfig()
    if not canSaveConfig then return end
    pcall(function()
    _ace_writefile(CONFIG_FILE, HttpService:JSONEncode(collectRyzenConfig()))
    _ace_writefile(KEYBINDS_CONFIG_FILE, HttpService:JSONEncode(collectRyzenKeybindConfig()))
    end)
    end
    function loadRyzenConfig()
    _G.RyzenManualSaveConfig = saveRyzenConfig
    if _G.RyzenGuiScaleValue then
    pcall(function()
    if ryzenGuiScaleValue ~= nil then ryzenGuiScaleValue = tonumber(_G.RyzenGuiScaleValue) or ryzenGuiScaleValue end
    if aceGuiScaleValue ~= nil then aceGuiScaleValue = tonumber(_G.RyzenGuiScaleValue) or aceGuiScaleValue end
    end)
    end
    if _G.RyzenProgressBarScaleValue then
    pcall(function()
    if ryzenProgressBarScaleValue ~= nil then ryzenProgressBarScaleValue = tonumber(_G.RyzenProgressBarScaleValue) or ryzenProgressBarScaleValue end
    if aceProgressBarScaleValue ~= nil then aceProgressBarScaleValue = tonumber(_G.RyzenProgressBarScaleValue) or aceProgressBarScaleValue end
    end)
    end
    if not canSaveConfig or not _ace_isfile(CONFIG_FILE) then return end
    local ok, data = pcall(function()
    return HttpService:JSONDecode(_ace_readfile(CONFIG_FILE))
    end)
    if not ok or type(data) ~= "table" then return end
    savedConfig = data
    local keybindData = data
    pcall(function()
    if _ace_isfile(KEYBINDS_CONFIG_FILE) then
    local kb = HttpService:JSONDecode(_ace_readfile(KEYBINDS_CONFIG_FILE))
    if type(kb) == "table" then keybindData = kb end
    end
    end)
    savedMainPositionTable = data.mainPosition
    savedMiniPositionTable = data.miniPosition
    savedStealBarPositionTable = data.stealBarPosition
    _G.RyzenGuiLocked = data.guiLocked == true
    if data.hideMobileButtons ~= nil then
    _G.RyzenHideMobileButtons = data.hideMobileButtons == true
    elseif _G.RyzenHideMobileButtons == nil then
    _G.RyzenHideMobileButtons = not RyzenAutoMobile
    end
    _G.RyzenMobileButtonScale = tonumber(data.mobileButtonScale) or (RyzenAutoMobile and 0.90 or 1.00)
    _G.RyzenMobileButtonPositions = {}
    if type(data.mobileButtonPositions) == "table" then
        for k, v in pairs(data.mobileButtonPositions) do
            if type(v) == "table" then
                _G.RyzenMobileButtonPositions[tostring(k)] = v
            end
        end
    end
    _G.RyzenMobileButtonImage = tostring(data.mobileButtonImage or "")
    -- Circle button feature removed: force ROUNDED so a previously saved
    -- CIRCLE / SQUARE shape doesn't stick with no UI to change it back.
    _G.RyzenMobileButtonShape = "ROUNDED"
    _G.RyzenStealUIImage = tostring(data.stealUIImage or "")
    _G.RyzenStealRadii = _G.RyzenStealRadii or {}
    -- Backward compatibility: old configs stored the (now-V2) radius under autoStealV3Radius.
    -- New configs store V2 radius under autoStealV2Radius and the new V3 radius under autoStealV3Radius.
    if data.autoStealV2Radius ~= nil then
        _G.RyzenStealRadii["Auto Steal"] = tonumber(data.autoStealV2Radius) or 63
    end
    if data.autoStealV3Radius ~= nil then
        _G.RyzenStealRadii["Auto Steal"] = tonumber(data.autoStealV3Radius) or 63
        if selectedStealMode == "Auto Steal" then
            autoStealRadius = _G.RyzenStealRadii["Auto Steal"]
            if autoStealRadiusBox then
                autoStealRadiusBox.Text = tostring(autoStealRadius)
            end
        end
    end

    _G.RyzenDuelMode = (tostring(data.duelMode or "half") == "full") and "full" or "half"
    _G.RyzenAutoMoveSpeed = tonumber(data.autoMoveSpeed) or _G.RyzenAutoMoveSpeed or 60
    _G.RyzenAutoMoveCarrySpeed = tonumber(data.autoMoveCarrySpeed) or _G.RyzenAutoMoveCarrySpeed or 30
    _G.RyzenStretchValue = tonumber(data.stretchValue) or _G.RyzenStretchValue or 0.7
    _G.RyzenStretchPreset = tostring(data.stretchPreset or _G.RyzenStretchPreset or "Medium")
    _G.RyzenSavedAvatarChangerUserId = tonumber(data.avatarChangerUserId)
    if _G.RyzenSavedAvatarChangerUserId == 0 then _G.RyzenSavedAvatarChangerUserId = nil; _G.RyzenAvatarChangerCleared = true else _G.RyzenAvatarChangerCleared = false end
    _G.RyzenSavedAvatarChangerUsername = tostring(data.avatarChangerUsername or "")
    applySavedKeybinds(keybindData.keybinds)
    if keybindData.tpDownKeybind ~= nil then
    if tostring(keybindData.tpDownKeybind) == "None" then
    tpDownKeybind = nil
    else
    tpDownKeybind = stringToKeyCode(keybindData.tpDownKeybind) or DEFAULT_TP_DOWN_KEYBIND
    end
    end
    if type(keybindData.controllerKeybinds) == "table" then
    for slot, v in pairs(keybindData.controllerKeybinds) do
    -- was: `if controllerKeybinds[slot] ~= nil` - always false on a fresh
    -- launch because every slot starts nil, so nothing ever loaded
    if CONTROLLER_KEYBIND_SLOTS[slot] then
    if tostring(v) == "None" then
    controllerKeybinds[slot] = nil
    else
    controllerKeybinds[slot] = stringToKeyCode(v)
    end
    end
    end
    end
    if keybindData.controllerTPDownKeybind ~= nil then
    if tostring(keybindData.controllerTPDownKeybind) == "None" then
    controllerTPDownKeybind = nil
    else
    controllerTPDownKeybind = stringToKeyCode(keybindData.controllerTPDownKeybind)
    end
    end
    for keyId, defaultKey in pairs(DEFAULT_SPEED_KEYBINDS) do
    local savedKeys = keybindData and keybindData.keybinds
    if (not savedKeys or savedKeys[keyId] == nil) and speedKeybinds[keyId] == nil then
    speedKeybinds[keyId] = defaultKey
    end
    end
    NS = tonumber(data.NS) or NS
    CS = tonumber(data.CS) or CS
    LAGGER_SPEED = tonumber(data.LAGGER_SPEED) or LAGGER_SPEED
    LAGGER_CARRY_SPEED = tonumber(data.LAGGER_CARRY_SPEED) or LAGGER_CARRY_SPEED
    currentSpeedMode = data.currentSpeedMode or currentSpeedMode
    -- Auto Steal Pause: force-enabled at load. Configs saved before the
    -- feature was wired up stored false (the old dead default), so honouring
    -- that would keep it off forever. The Combat toggle can still turn it
    -- off for the current session.
    _G.RyzenAutoStealPause = data.autoStealPauseEnabled ~= false
    _G.RyzenAutoStealPausePercent = tonumber(data.autoStealPausePercent) or 75
    if data.notificationsEnabled ~= nil then
    _G.RyzenNotificationsEnabled = data.notificationsEnabled == true
    end
    if data.modesGuiEnabled ~= nil then
    _G.RyzenModesGuiEnabled = data.modesGuiEnabled == true
    end
    _G.RyzenDropMode = (data.dropMode == "Jump Drop") and "Jump Drop" or "Stand Drop"
    if currentSpeedMode ~= "Normal" and currentSpeedMode ~= "Carry" and currentSpeedMode ~= "Lagger" and currentSpeedMode ~= "Lagger Carry" then currentSpeedMode = "Normal" end
    autoCarrySpeedEnabled = data.autoCarrySpeedEnabled == true
    autoCarryEnemyBaseEnabled = data.autoCarryEnemyBaseEnabled == true
    if type(data.autoCarryEnemyBaseRange) == "number" then autoCarryEnemyBaseRange = math.clamp(math.floor(data.autoCarryEnemyBaseRange), 5, 150) end
    autoTPEnabled = data.autoTPEnabled == true
    autoTPHeight = tonumber(data.autoTPHeight) or autoTPHeight
    infJumpEnabled = data.infJumpEnabled == true
    _G.RyzenInfJumpMode = (data.infJumpMode == "Hold") and "Hold" or "Tap"
    antiRagdollEnabled = data.antiRagdollEnabled == true
    _G.RyzenAntiRagdollMode = "No Splatter"
    _G.RyzenAntiVoidEnabled = data.antiVoidEnabled == true
    _G.RyzenAntiResetEnabled = data.antiResetEnabled == true
    selectedAnimationPack = data.selectedAnimationPack or selectedAnimationPack
    _G.RyzenSelectedMoreAnimationBundle = data.selectedMoreAnimationBundle
    -- FIX: "anim bugging into unwalk state". If an Unwalk-style bundle from the
    -- More Animations gallery was ever selected, it was saved to the config and
    -- silently re-applied on EVERY respawn (walk animations removed -> the
    -- character glides). Drop it at load so walking comes back for good.
    do
    local _bundle = _G.RyzenSelectedMoreAnimationBundle
    if type(_bundle) == "table" then
    local _bn = tostring(_bundle.name or ""):lower()
    if _bn:find("unwalk", 1, true) or _bn:find("no walk", 1, true) or _bn:find("glide", 1, true) then
    _G.RyzenSelectedMoreAnimationBundle = nil
    end
    elseif _bundle ~= nil then
    _G.RyzenSelectedMoreAnimationBundle = nil
    end
    end
    selectedStealMode = data.selectedStealMode or selectedStealMode
    if selectedStealMode == "Auto Steal" then
        selectedStealMode = "Auto Steal"
    elseif selectedStealMode == "Semi" then
        selectedStealMode = "Semi"
    else
        selectedStealMode = "Auto Steal"
    end
    autoStealEnabled = data.autoStealEnabled == true
    if type(data.aceStealRadii) == "table" then
    _G.RyzenStealRadii["Auto Steal"] = tonumber(
        data.aceStealRadii["Auto Steal"]
        or data.aceStealRadii.Normal
        or data.autoStealV2Radius
    ) or _G.RyzenStealRadii["Auto Steal"] or 63
    _G.RyzenStealRadii["Auto Steal"] = tonumber(
        data.aceStealRadii["Auto Steal"]
        or 63
    ) or _G.RyzenStealRadii["Auto Steal"] or 63
    _G.RyzenStealRadii.Semi = tonumber(data.aceStealRadii.Semi) or _G.RyzenStealRadii.Semi or 9
    end
    autoStealRadius = tonumber(data.autoStealRadius) or autoStealRadius
    _G.RyzenStealRadii = _G.RyzenStealRadii or {["Auto Steal"] = 63, ["Auto Steal"] = 63, Semi = 9}
    _G.RyzenStealRadii["Auto Steal"] = tonumber(_G.RyzenStealRadii["Auto Steal"]) or 63

    if selectedStealMode == "__REMOVED_V2__" then
        autoStealRadius = tonumber(
            data.autoStealV2Radius
            or _G.RyzenStealRadii["Auto Steal"]
            or autoStealRadius
            or 63
        ) or 63
        _G.RyzenStealRadii["Auto Steal"] = autoStealRadius
    elseif selectedStealMode == "Auto Steal" then
        autoStealRadius = tonumber(
            data.autoStealV3Radius
            or _G.RyzenStealRadii["Auto Steal"]
            or 63
        ) or 63
        _G.RyzenStealRadii["Auto Steal"] = autoStealRadius
    else
        autoStealRadius = tonumber(_G.RyzenStealRadii.Semi) or 9
    end
    selectedAimbotMode = data.selectedAimbotMode or selectedAimbotMode
    if selectedAimbotMode ~= "Anti Bypass" then selectedAimbotMode = "Normal" end
    AIMBOT_SPEED = tonumber(data.AIMBOT_SPEED) or AIMBOT_SPEED
    LAGGER_AIMBOT_SPEED = tonumber(data.LAGGER_AIMBOT_SPEED) or LAGGER_AIMBOT_SPEED
    _G.RyzenAntiBypassAimbotSpeed = tonumber(data.ANTI_BYPASS_AIMBOT_SPEED) or _G.RyzenAntiBypassAimbotSpeed or 58
    if data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED == nil or tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) == 58 then
    _G.RyzenAntiBypassLaggerAimbotSpeed = 40
    else
    _G.RyzenAntiBypassLaggerAimbotSpeed = tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) or 40
    end
    autoSwingEnabled = data.autoSwingEnabled == true
    mirrorTPDownEnabled = data.mirrorTPDownEnabled == true
    _G.RyzenNormalAimbotOn = data.normalAimbotEnabled == true
    _G.RyzenAntiBypassAimbotOn = data.antiBypassAimbotEnabled == true
    antiDesyncAutoSwingEnabled = data.antiDesyncAutoSwingEnabled == true
    -- last active tab (validated at boot against the real tab list)
    if data.lastActiveTab then _G.RyzenLastActiveTab = tostring(data.lastActiveTab) end
    -- RYZEN ANTI DROP config restore (state only; runtime applied after UI boot)
    _G.RyzenTPBatEnabled = data.tpBatEnabled == true
    _G.RyzenTPBatMode = data.tpBatMode == "V2" and "V2" or "Classic"
    _G.RyzenAntiDropEnabled = data.antiDropEnabled == true
    batCounterEnabled = data.batCounterEnabled == true
    medCounterEnabled = data.medCounterEnabled == true
    hardHitEnabled = data.hardHitEnabled == true
    hardHitRadius = tonumber(data.hardHitRadius) or 10
    _G.RyzenHardHitRadius = hardHitRadius
    if _G.RyzenHardHitState then _G.RyzenHardHitState.radius = hardHitRadius end
    perfectHitEnabled = data.perfectHitEnabled == true
    perfectHitRange = tonumber(data.perfectHitRange) or 175
    if _G.RyzenPerfectHitState then _G.RyzenPerfectHitState.range = perfectHitRange end
    antiKickEnabled = data.safeMode == true
    autoResetOnMedEnabled = data.autoResetOnMedEnabled == true
    espEnabled = data.espEnabled == true
    showTracerEnabled = false
    ragdollCountdownEnabled = true
    fpsBoostEnabled = data.fpsBoostEnabled == true
    antiLagVisualEnabled = false
    antiLagV2Enabled = false
    nukeOptimiserEnabled = false
    fovEnabled = data.fovEnabled == true
    fovValue = tonumber(data.fovValue) or fovValue
    shinyGraphicsEnabled = data.shinyGraphicsEnabled == true
    noCamCollisionEnabled = data.noCamCollisionEnabled == true
    _G.RyzenNoPlayerCollisionEnabled = data.noPlayerCollisionEnabled == true
    _G.RyzenCustomFontSelected = (type(data.customFontSelected) == "string" and data.customFontSelected) or "None"
    customFontVisualEnabled = _G.RyzenCustomFontSelected ~= "None"
    skyTheme = data.skyTheme or "Off"
    autoLeftEnabled = data.autoLeftEnabled == true
    autoRightEnabled = data.autoRightEnabled == true
    if data.introEnabled ~= nil then _introEnabled = data.introEnabled == true end
    if data.selectedIntroMusic and RYZEN_INTRO_MUSIC_OPTIONS[data.selectedIntroMusic] then
    selectedIntroMusic = data.selectedIntroMusic
    else
    selectedIntroMusic = 1
    end
    if autoLeftEnabled and autoRightEnabled then autoRightEnabled = false end
    end
    loadRyzenConfig()
    local function syncAnimationPackIndex()
    for i, name in ipairs(AnimationPackList) do
    if name == selectedAnimationPack then
    AnimationPackIndex = i
    return
    end
    end
    selectedAnimationPack = "OFF"
    AnimationPackIndex = 1
    end
    local function applySavedAnimationPackToCharacter(char)
    syncAnimationPackIndex()
    if refreshAnimationPackRow then pcall(refreshAnimationPackRow) end
    if not char then char = LP.Character end
    if not char then return end
    local animate = char:FindFirstChild("Animate") or char:WaitForChild("Animate", 6)
    if not animate then return end
    task.wait(0.2)
    OriginalAnims = {}
    unwalkSavedAnimate = nil
    if selectedAnimationPack and selectedAnimationPack ~= "OFF" then
        pcall(function() applyAnimationPack(selectedAnimationPack) end)
    elseif _G.RyzenSelectedMoreAnimationBundle and applyFullAnimationBundle then
        -- FIX: never auto re-apply an Unwalk-style bundle on respawn - that is
        -- what kept putting the character into the unwalk state "randomly"
        -- (every death / respawn). Manual gallery clicks still work.
        local _savedBundle = _G.RyzenSelectedMoreAnimationBundle
        local _savedName = tostring((type(_savedBundle) == "table" and _savedBundle.name) or ""):lower()
        local _isUnwalkBundle = _savedName:find("unwalk", 1, true) or _savedName:find("no walk", 1, true) or _savedName:find("glide", 1, true)
        if not _isUnwalkBundle then
            task.wait(0.15)
            pcall(function()
                applyFullAnimationBundle(_savedBundle)
            end)
        end
    else
        pcall(function() resetAnimations() end)
    end
    end
    syncAnimationPackIndex()
    task.defer(function()
    applySavedAnimationPackToCharacter(LP.Character)
    end)
    LP.CharacterAdded:Connect(function(char)
    task.wait(0.65)
    task.defer(function()
    task.wait(0.2)
    _G.RyzenApplyCharacterVisuals(char)
    end)
    if _G.RyzenAntiVoidEnabled then pcall(_G.RyzenAntiVoidSaveSafe) end
    applySavedAnimationPackToCharacter(char)


    if _G.RyzenSelectedMoreAnimationBundle then
        task.delay(1.25, function()
            if char == LP.Character and char.Parent and applyFullAnimationBundle then
                pcall(function()
                    applyFullAnimationBundle(_G.RyzenSelectedMoreAnimationBundle)
                end)
            end
        end)
    end
    end)
    _G.RyzenAutoResetOnMed = _G.RyzenAutoResetOnMed or {}
    _G.RyzenAutoResetOnMed.conns = _G.RyzenAutoResetOnMed.conns or {}
    _G.RyzenAutoResetOnMed.enabled = autoResetOnMedEnabled == true
    _G.RyzenAutoResetOnMed.medTriggered = false
    _G.RyzenAutoResetOnMed.lastFire = _G.RyzenAutoResetOnMed.lastFire or 0
    _G.RyzenAutoResetOnMed.cooldown = 2.25
    _G.RyzenAutoResetOnMed.charAddedConn = _G.RyzenAutoResetOnMed.charAddedConn

    function _G.RyzenAutoResetShouldFire(part)
    local state = _G.RyzenAutoResetOnMed
    if not state or not state.enabled then return false end
    if state.medTriggered then return false end
    if tick() - (state.lastFire or 0) < (state.cooldown or 2.25) then return false end
    if not part or not part.Parent then return false end
    if part:FindFirstAncestorOfClass("Tool") or part:FindFirstAncestorOfClass("Accessory") then
    return false
    end
    return part.Anchored and part.Transparency == 1
    end
    function _G.RyzenAutoResetFireOnce(part)
    if not _G.RyzenAutoResetShouldFire(part) then return end
    local state = _G.RyzenAutoResetOnMed
    state.medTriggered = true
    state.lastFire = tick()
    task.delay(2.3, function()
    if state.enabled then
    end
    end)
    end
    function _G.RyzenAutoResetOnAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
    _G.RyzenAutoResetFireOnce(part)
    end)
    end
    function _G.RyzenStopAutoResetOnMed()
    local state = _G.RyzenAutoResetOnMed
    if not state then return end
    for _, conn in ipairs(state.conns or {}) do
    pcall(function()
    conn:Disconnect()
    end)
    end
    state.conns = {}
    state.medTriggered = false
    end
    function _G.RyzenStartAutoResetOnMed(char)
    local state = _G.RyzenAutoResetOnMed
    if not state then return end
    _G.RyzenStopAutoResetOnMed()
    state.medTriggered = false
    char = char or LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
    if part:IsA("BasePart") then
    table.insert(state.conns, _G.RyzenAutoResetOnAnchorChanged(part))
    _G.RyzenAutoResetFireOnce(part)
    end
    end
    table.insert(state.conns, char.DescendantAdded:Connect(function(part)
    if part:IsA("BasePart") then
    table.insert(state.conns, _G.RyzenAutoResetOnAnchorChanged(part))
    _G.RyzenAutoResetFireOnce(part)
    end
    end))
    table.insert(state.conns, char.AncestryChanged:Connect(function(_, parent)
    if not parent then
    state.medTriggered = false
    end
    end))
    end
    function _G.RyzenEnableAutoResetOnMed()
    autoResetOnMedEnabled = true
    _G.RyzenAutoResetOnMed.enabled = true
    _G.RyzenStartAutoResetOnMed(LP.Character)
    end
    function _G.RyzenDisableAutoResetOnMed()
    autoResetOnMedEnabled = false
    _G.RyzenAutoResetOnMed.enabled = false
    _G.RyzenStopAutoResetOnMed()
    end
    function _G.RyzenSetAutoResetOnMed(state, noSave)
    autoResetOnMedEnabled = state == true
    if autoResetOnMedEnabled then
    _G.RyzenEnableAutoResetOnMed()
    else
    _G.RyzenDisableAutoResetOnMed()
    end
    if setAutoResetOnMedVisual then
    setAutoResetOnMedVisual(autoResetOnMedEnabled)
    end
    if not noSave and saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    function enableAutoResetOnMed()
    _G.RyzenSetAutoResetOnMed(true)
    end
    function disableAutoResetOnMed()
    _G.RyzenSetAutoResetOnMed(false)
    end
    function toggleAutoResetOnMed(on)
    _G.RyzenSetAutoResetOnMed(on == true)
    end
    if not _G.RyzenAutoResetOnMed.charAddedConn then
    _G.RyzenAutoResetOnMed.charAddedConn = LP.CharacterAdded:Connect(function(char)
    if _G.RyzenAutoResetOnMed and _G.RyzenAutoResetOnMed.enabled then
    task.wait(0.25)
    _G.RyzenStartAutoResetOnMed(char)
    end
    end)
    end
    _G.RyzenCounterState = _G.RyzenCounterState or {}
    _G.RyzenCounterState.batConn = nil
    _G.RyzenCounterState.batDebounce = false
    _G.RyzenCounterState.medConns = _G.RyzenCounterState.medConns or {}
    _G.RyzenCounterState.medDebounce = false
    _G.RyzenCounterState.medLastUsed = _G.RyzenCounterState.medLastUsed or 0
    _G.RyzenMedusaCooldown = 25
    function _G.RyzenFindMedusa()
    local c = LP.Character
    if not c then return nil end
    for _, t in ipairs(c:GetChildren()) do
    if t:IsA("Tool") then
    local n = t.Name:lower()
    if n:find("medusa") or n:find("head") or n:find("stone") then return t end
    end
    end
    local bp = LP:FindFirstChild("Backpack") or LP:FindFirstChildOfClass("Backpack")
    if bp then
    for _, t in ipairs(bp:GetChildren()) do
    if t:IsA("Tool") then
    local n = t.Name:lower()
    if n:find("medusa") or n:find("head") or n:find("stone") then return t end
    end
    end
    end
    return nil
    end
    function _G.RyzenUseMedusaCounter()
    if not medCounterEnabled then return end
    if _G.RyzenCounterState.medDebounce then return end
    if tick() - (_G.RyzenCounterState.medLastUsed or 0) < _G.RyzenMedusaCooldown then return end
    local c = LP.Character
    if not c then return end
    _G.RyzenCounterState.medDebounce = true
    local med = _G.RyzenFindMedusa()
    if not med then
    _G.RyzenCounterState.medDebounce = false
    return
    end
    if med.Parent ~= c then
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum:EquipTool(med) end) end
    task.wait(0.05)
    end
    pcall(function() med:Activate() end)
    _G.RyzenCounterState.medLastUsed = tick()
    _G.RyzenCounterState.medDebounce = false
    end
    function _G.RyzenOnMedusaAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
    if medCounterEnabled and part.Anchored and part.Transparency == 1 then
    _G.RyzenUseMedusaCounter()
    end
    end)
    end
    function _G.RyzenStartMedCounter(char)
    _G.RyzenStopMedCounter()
    char = char or LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
    if part:IsA("BasePart") then
    table.insert(_G.RyzenCounterState.medConns, _G.RyzenOnMedusaAnchorChanged(part))
    end
    end
    table.insert(_G.RyzenCounterState.medConns, char.DescendantAdded:Connect(function(part)
    if part:IsA("BasePart") then
    table.insert(_G.RyzenCounterState.medConns, _G.RyzenOnMedusaAnchorChanged(part))
    end
    end))
    end
    function _G.RyzenStopMedCounter()
    for _, c in pairs(_G.RyzenCounterState.medConns or {}) do
    pcall(function() c:Disconnect() end)
    end
    _G.RyzenCounterState.medConns = {}
    _G.RyzenCounterState.medDebounce = false
    end
    _G.RyzenBatCounterSlapList = {"Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap", "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap", "Nuclear Slap", "Galaxy Slap", "Glitched Slap"}
    function _G.RyzenFindBatForCounter()
    local c = LP.Character
    if not c then return nil end
    local bp = LP:FindFirstChildOfClass("Backpack") or LP:FindFirstChild("Backpack")
    for _, name in ipairs(_G.RyzenBatCounterSlapList) do
    local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name))
    if t then return t end
    end
    for _, ch in ipairs(c:GetChildren()) do
    if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
    end
    if bp then
    for _, ch in ipairs(bp:GetChildren()) do
    if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
    end
    end
    return nil
    end
    function _G.RyzenSwingBatForCounter(bat, char)
    if not bat or not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if bat.Parent ~= char then
    if hum then pcall(function() hum:EquipTool(bat) end) end
    task.wait(0.05)
    end
    local remote = bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
    if remote and remote:IsA("RemoteEvent") then
    pcall(function() remote:FireServer() end)
    task.wait(0.15)
    pcall(function() remote:FireServer() end)
    else
    pcall(function() bat:Activate() end)
    task.wait(0.15)
    pcall(function() bat:Activate() end)
    end
    end
    function _G.RyzenCounterIsRagdoll(hum)
    if not hum then return false end
    local st = hum:GetState()
    return st == Enum.HumanoidStateType.Physics
    or st == Enum.HumanoidStateType.Ragdoll
    or st == Enum.HumanoidStateType.FallingDown
    or hum.PlatformStand == true
    end
    function _G.RyzenStartBatCounter()
    if _G.RyzenCounterState.batConn then return end
    _G.RyzenCounterState.batDebounce = false
    _G.RyzenCounterState.batConn = RunService.Heartbeat:Connect(function()
    if not batCounterEnabled then return end
    if _G.RyzenCounterState.batDebounce then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if _G.RyzenCounterIsRagdoll(hum) then
    _G.RyzenCounterState.batDebounce = true
    task.spawn(function()
    local bat = _G.RyzenFindBatForCounter()
    if bat then _G.RyzenSwingBatForCounter(bat, char) end
    task.wait(0.5)
    _G.RyzenCounterState.batDebounce = false
    end)
    end
    end)
    end
    function _G.RyzenStopBatCounter()
    if _G.RyzenCounterState.batConn then
    _G.RyzenCounterState.batConn:Disconnect()
    _G.RyzenCounterState.batConn = nil
    end
    _G.RyzenCounterState.batDebounce = false
    end
    startBatCounter = _G.RyzenStartBatCounter
    stopBatCounter = _G.RyzenStopBatCounter
    setupMedusaCounter = _G.RyzenStartMedCounter
    stopMedusaCounter = _G.RyzenStopMedCounter

    _G.RyzenHardHitState = _G.RyzenHardHitState or {
    ring = nil,
    conn = nil,
    enabled = false,
    radius = 10,
    }
    local HH = _G.RyzenHardHitState
    function _G.RyzenHideHardHitRing()
    if HH.ring then
    pcall(function() HH.ring:Destroy() end)
    HH.ring = nil
    end
    end
    function _G.RyzenShowHardHitRing()
        -- Ring removed per user request
    end
    function _G.RyzenStartHardHit()
    HH.enabled = true
    hardHitEnabled = true
    _G.RyzenHardHitEnabled = true
    if HH.conn then return end
    HH.conn = RunService.Heartbeat:Connect(function()
    if not HH.enabled then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if not HH.ring or not HH.ring.Parent then
    _G.RyzenShowHardHitRing()
    end
    if HH.ring then
    local r = tonumber(HH.radius) or 10
    HH.ring.Radius = r
    HH.ring.InnerRadius = math.max(0.1, r - 0.35)
    if HH.ring.Adornee ~= root then
    HH.ring.Adornee = root
    HH.ring.Parent = root
    end
    end
    end)
    _G.RyzenShowHardHitRing()
    end
    function _G.RyzenStopHardHit()
    HH.enabled = false
    hardHitEnabled = false
    _G.RyzenHardHitEnabled = false
    if HH.conn then
    pcall(function() HH.conn:Disconnect() end)
    HH.conn = nil
    end
    _G.RyzenHideHardHitRing()
    end
    function _G.RyzenSetHardHitRadius(v)
    local n = tonumber(v)
    if not n then return end
    HH.radius = math.clamp(n, 1, 100)
    hardHitRadius = HH.radius
    _G.RyzenHardHitRadius = HH.radius
    if HH.ring then
    HH.ring.Radius = HH.radius
    HH.ring.InnerRadius = math.max(0.1, HH.radius - 0.35)
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end

    _G.RyzenPerfectHitState = _G.RyzenPerfectHitState or {
    enabled = false,
    conn = nil,
    cd = false,
    range = 175,
    }
    local PH = _G.RyzenPerfectHitState
    function _G.RyzenPerfectHitTryHit()
    if not PH.enabled then return end
    if PH.cd then return end
    PH.cd = true
    local char = LP.Character
    if char then
    local bat = _G.RyzenFindBatForCounter and _G.RyzenFindBatForCounter() or nil
    if bat then
    _G.RyzenSwingBatForCounter(bat, char)
    end
    end
    task.delay(0.045, function() PH.cd = false end)
    end
    function _G.RyzenPerfectHitGetTarget()
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local nearest = nil
    local shortest = math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local tr = plr.Character:FindFirstChild("HumanoidRootPart")
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if tr and hum and hum.Health > 0 then
    local d = (tr.Position - root.Position).Magnitude
    if d <= (tonumber(PH.range) or 175) and d < shortest then
    shortest = d
    nearest = tr
    end
    end
    end
    end
    return nearest
    end
    function _G.RyzenStartPerfectHit()
    PH.enabled = true
    perfectHitEnabled = true
    _G.RyzenPerfectHitEnabled = true
    if PH.conn then return end
    PH.conn = RunService.Heartbeat:Connect(function()
    if not PH.enabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if _G.RyzenCounterIsRagdoll then
    if _G.RyzenCounterIsRagdoll(hum) then return end
    end
    local target = _G.RyzenPerfectHitGetTarget()
    if target then
    _G.RyzenPerfectHitTryHit()
    end
    end)
    end
    function _G.RyzenStopPerfectHit()
    PH.enabled = false
    perfectHitEnabled = false
    _G.RyzenPerfectHitEnabled = false
    if PH.conn then
    pcall(function() PH.conn:Disconnect() end)
    PH.conn = nil
    end
    PH.cd = false
    end
    function _G.RyzenSetPerfectHitRange(v)
    local n = tonumber(v)
    if not n then return end
    PH.range = math.clamp(n, 10, 500)
    perfectHitRange = PH.range
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end

    _G.RyzenNoPlayerCollisionState = _G.RyzenNoPlayerCollisionState or {connections = {}}
    function _G.RyzenSetOtherPlayerCollision(state)
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    for _, part in ipairs(plr.Character:GetDescendants()) do
    if part:IsA("BasePart") then
    pcall(function() part.CanCollide = state end)
    end
    end
    end
    end
    end
    function enableNoPlayerCollision()
    if _G.RyzenNoPlayerCollisionState.running then return end
    _G.RyzenNoPlayerCollisionEnabled = true
    _G.RyzenNoPlayerCollisionState.running = true
    for _, conn in ipairs(_G.RyzenNoPlayerCollisionState.connections or {}) do
    pcall(function() conn:Disconnect() end)
    end
    _G.RyzenNoPlayerCollisionState.connections = {}
    _G.RyzenSetOtherPlayerCollision(false)
    table.insert(_G.RyzenNoPlayerCollisionState.connections, LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if _G.RyzenNoPlayerCollisionEnabled then _G.RyzenSetOtherPlayerCollision(false) end
    end))
    table.insert(_G.RyzenNoPlayerCollisionState.connections, Players.PlayerAdded:Connect(function(plr)
    local c = plr.CharacterAdded:Connect(function()
    task.wait(0.5)
    if _G.RyzenNoPlayerCollisionEnabled then _G.RyzenSetOtherPlayerCollision(false) end
    end)
    table.insert(_G.RyzenNoPlayerCollisionState.connections, c)
    end))
    local collisionScanElapsed = 0
    table.insert(_G.RyzenNoPlayerCollisionState.connections, RunService.Heartbeat:Connect(function(dt)
    if not _G.RyzenNoPlayerCollisionEnabled then return end
    collisionScanElapsed = collisionScanElapsed + (dt or 0)
    if collisionScanElapsed < 0.25 then return end
    collisionScanElapsed = 0
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    for _, part in ipairs(plr.Character:GetDescendants()) do
    if part:IsA("BasePart") and part.CanCollide == true then
    pcall(function() part.CanCollide = false end)
    end
    end
    end
    end
    end))
    end
    function disableNoPlayerCollision()
    if not _G.RyzenNoPlayerCollisionState.running then
    _G.RyzenNoPlayerCollisionEnabled = false
    return
    end
    _G.RyzenNoPlayerCollisionEnabled = false
    _G.RyzenNoPlayerCollisionState.running = false
    for _, conn in ipairs(_G.RyzenNoPlayerCollisionState.connections or {}) do
    pcall(function() conn:Disconnect() end)
    end
    _G.RyzenNoPlayerCollisionState.connections = {}
    _G.RyzenSetOtherPlayerCollision(true)
    end
    function _G.RyzenSafeModeGetCountdownLabel()
    local ok, label = pcall(function()
    return LP.PlayerGui
    and LP.PlayerGui:FindFirstChild("DuelsMachineTopFrame")
    and LP.PlayerGui.DuelsMachineTopFrame:FindFirstChild("DuelsMachineTopFrame")
    and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame:FindFirstChild("Timer")
    and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame.Timer:FindFirstChild("Label")
    end)
    return (ok and label) or nil
    end
    function _G.RyzenSafeModeCountdownNumber(text)
    local t = tostring(text or ""):upper():gsub("^%s+", ""):gsub("%s+$", "")
    if t == "GO" or t == "START" or t == "READY" then return true end
    local n = tonumber(t)
    return n ~= nil and n >= 0 and n <= 10
    end
    function _G.RyzenSafeModeInDuelCountdown()
    local label = _G.RyzenSafeModeGetCountdownLabel()
    return label and _G.RyzenSafeModeCountdownNumber(label.Text) or false
    end
    _G.RyzenSafeModeBlockedTools = {
    bat=true, slap=true, sword=true, gun=true, pistol=true, rifle=true,
    medusa=true, hammer=true, axe=true, knife=true, katana=true, blade=true, fist=true,
    }
    function _G.RyzenSafeModeIsCarryableTool(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local name = tool.Name:lower()
    for word in pairs(_G.RyzenSafeModeBlockedTools) do
    if name:find(word, 1, true) then return false end
    end
    return true
    end
    function _G.RyzenSafeModeHoldingBrainrot()
    local ok, val = pcall(function() return LP:GetAttribute("Stealing") end)
    if ok and val == true then return true end
    local ok2, val2 = pcall(function() return LP:GetAttribute("AntiKick") end)
    if ok2 and val2 == true then return true end
    local char = LP.Character
    if not char then return false end
    local ok3, val3 = pcall(function() return char:GetAttribute("Stealing") end)
    if ok3 and val3 == true then return true end
    if _G.AutoCarrySpeed and type(_G.AutoCarrySpeed.IsCarryingBrainrot) == "function" then
    local okCarry, carrying = pcall(function() return _G.AutoCarrySpeed.IsCarryingBrainrot(char) end)
    if okCarry and carrying then return true end
    end
    for _, name in ipairs({"Carrying", "IsCarrying", "Grabbed", "Holding", "StealHold", "HasGrab"}) do
    local v = char:FindFirstChild(name, true)
    if v then
    if v:IsA("BoolValue") and v.Value then return true end
    if v:IsA("ObjectValue") and v.Value then return true end
    if v:IsA("StringValue") and v.Value ~= "" then return true end
    end
    end
    for _, child in ipairs(char:GetChildren()) do
    if child:IsA("Model") and child:FindFirstChildWhichIsA("BasePart", true) then
    local n = child.Name:lower()
    if n:find("brainrot") or n:find("animal") or n:find("carry") or n:find("grab") or n:find("steal") or n:find("hold") then
    return true
    end
    end
    end
    return false
    end
    function _G.RyzenSafeModeIsLocked()
    if not antiKickEnabled then return false end
    return _G.RyzenSafeModeInDuelCountdown() or _G.RyzenSafeModeHoldingBrainrot()
    end
    function _G.RyzenSafeModeForceStop(reason)
    local stopped = false
    if _G.RyzenNormalAimbotOn and _G.RyzenStopNormalAimbot then _G.RyzenStopNormalAimbot(); stopped = true end
    if _G.RyzenAntiBypassAimbotOn and _G.RyzenStopAntiBypassAimbot then _G.RyzenStopAntiBypassAimbot(false); stopped = true end
    if _G.RyzenAntiDropEnabled and _G.RyzenStopAntiDrop then
        _G.RyzenStopAntiDrop()
        if _G.RyzenAntiDropSetVisual then _G.RyzenAntiDropSetVisual(false) end
        stopped = true
    end
    if autoLeftEnabled then
    autoLeftEnabled = false
    if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(false) end
    if _G.RyzenStopAutoLeft then _G.RyzenStopAutoLeft() end
    stopped = true
    end
    if autoRightEnabled then
    autoRightEnabled = false
    if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(false) end
    if _G.RyzenStopAutoRight then _G.RyzenStopAutoRight() end
    stopped = true
    end
    if stopped and showActionNotification then pcall(function() showActionNotification(reason or "SAFE MODE LOCK") end) end
    end
    function _G.RyzenSafeModeTryStart()
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    _G.RyzenSafeModeForceStop("SAFE MODE LOCK")
    return false
    end
    return true
    end
    _G.RyzenSafeModeMonitorStarted = _G.RyzenSafeModeMonitorStarted or false
    if not _G.RyzenSafeModeMonitorStarted then
    _G.RyzenSafeModeMonitorStarted = true
    RunService.Heartbeat:Connect(function()
    if antiKickEnabled and _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    _G.RyzenSafeModeForceStop("SAFE MODE LOCK")
    end
    end)
    end
    LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if medCounterEnabled then _G.RyzenStartMedCounter(char) end
    if batCounterEnabled then _G.RyzenStartBatCounter() end
    if hardHitEnabled then _G.RyzenStartHardHit() end
    if perfectHitEnabled then _G.RyzenStartPerfectHit() end
    end)
    _G.RyzenNormalAimbot = _G.RyzenNormalAimbot or {conn = nil, target = nil, swingCooldown = false}
    function _G.RyzenFindAimbotBat()
    local char = LP.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
    if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
    return tool
    end
    end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
    for _, tool in ipairs(bp:GetChildren()) do
    if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
    return tool
    end
    end
    end
    return nil
    end
    function _G.RyzenGetClosestAimbotTarget()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if tRoot and hum and hum.Health > 0 then
    local dist = (tRoot.Position - root.Position).Magnitude
    if dist < minDist then
    minDist = dist
    closest = tRoot
    end
    end
    end
    end
    return closest
    end
    function _G.RyzenGetNormalAimbotSpeed()
    if currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry" then
    return tonumber(LAGGER_AIMBOT_SPEED) or 40
    end
    return tonumber(AIMBOT_SPEED) or 58
    end
    function _G.RyzenGetAntiBypassAimbotSpeed()
    if currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry" then
    return tonumber(_G.RyzenAntiBypassLaggerAimbotSpeed) or 40
    end
    return tonumber(_G.RyzenAntiBypassAimbotSpeed) or 58
    end
    function _G.RyzenGetSelectedAimbotSpeedValues()
    if selectedAimbotMode == "Anti Bypass" then
    return tonumber(_G.RyzenAntiBypassAimbotSpeed) or 58, tonumber(_G.RyzenAntiBypassLaggerAimbotSpeed) or 40
    end
    return tonumber(AIMBOT_SPEED) or 58, tonumber(LAGGER_AIMBOT_SPEED) or 40
    end
    function _G.RyzenSetSelectedAimbotSpeedValues(normalValue, laggerValue)
    if selectedAimbotMode == "Anti Bypass" then
    if normalValue then _G.RyzenAntiBypassAimbotSpeed = normalValue end
    if laggerValue then _G.RyzenAntiBypassLaggerAimbotSpeed = laggerValue end
    else
    if normalValue then AIMBOT_SPEED = normalValue end
    if laggerValue then LAGGER_AIMBOT_SPEED = laggerValue end
    end
    end
    function _G.RyzenRefreshAimbotSpeedBoxes()
    local n, l = _G.RyzenGetSelectedAimbotSpeedValues()
    if _G.RyzenAimbotSpeedBox then _G.RyzenAimbotSpeedBox.Text = tostring(n) end
    if _G.RyzenLaggerAimbotSpeedBox then _G.RyzenLaggerAimbotSpeedBox.Text = tostring(l) end
    end

    _G.RyzenNormalAimbot = _G.RyzenNormalAimbot or {
        conn = nil,
        target = nil,
        lastScan = 0,
        attachment = nil,
        linearVelocity = nil,
        stickyUntil = 0,
        stickyTarget = nil,
        charConn = nil,
    }

    -- Ryzen-style sticky target: hold same enemy ~1.25s
    local RYZEN_AIMBOT_STICKY_TIME = 1.25
    local RYZEN_AIMBOT_STICKY_MAX_DIST = 85

    local function _ryzenAimbotStickyValid(root, tRoot)
        if not tRoot or not tRoot.Parent then return false end
        local hum = tRoot.Parent:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if not root then return false end
        if (tRoot.Position - root.Position).Magnitude > RYZEN_AIMBOT_STICKY_MAX_DIST then return false end
        return true
    end

    local function _ryzenGetAimbotTarget()
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local S = _G.RyzenNormalAimbot
        local now = tick()
        local sticky = S.stickyTarget
        if sticky and now < (S.stickyUntil or 0) and _ryzenAimbotStickyValid(root, sticky) then
            S.target = sticky
            return sticky
        end
        if now - (S.lastScan or 0) <= 0.08 and S.target and _ryzenAimbotStickyValid(root, S.target) then
            return S.target
        end
        S.lastScan = now
        local closest = _G.RyzenGetClosestAimbotTarget and _G.RyzenGetClosestAimbotTarget() or nil
        S.target = closest
        S.stickyTarget = closest
        S.stickyUntil = now + RYZEN_AIMBOT_STICKY_TIME
        return closest
    end

    local function _RyzenAimbotEnsureLinearVelocity(root)
        local S = _G.RyzenNormalAimbot

        if S.linearVelocity
            and S.linearVelocity.Parent
            and S.attachment
            and S.attachment.Parent == root then
            S.linearVelocity.Enabled = true
            return S.linearVelocity
        end

        if S.linearVelocity then
            pcall(function() S.linearVelocity:Destroy() end)
        end
        if S.attachment then
            pcall(function() S.attachment:Destroy() end)
        end

        local att = Instance.new("Attachment")
        att.Name = "RyzenAimbotAttachment"
        att.Parent = root

        local lv = Instance.new("LinearVelocity")
        lv.Name = "RyzenAimbotLinearVelocity"
        lv.Attachment0 = att
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.ForceLimitMode = Enum.ForceLimitMode.Magnitude
        lv.MaxForce = math.huge
        lv.VectorVelocity = Vector3.zero
        lv.Enabled = true
        lv.Parent = att

        S.attachment = att
        S.linearVelocity = lv
        return lv
    end

    local function _RyzenAimbotReleaseLinearVelocity()
        local S = _G.RyzenNormalAimbot
        if S.linearVelocity and S.linearVelocity.Parent then
            S.linearVelocity.VectorVelocity = Vector3.zero
            S.linearVelocity.Enabled = false
        end
    end

    function _G.RyzenStartNormalAimbot()
        if _G.RyzenSafeModeTryStart and not _G.RyzenSafeModeTryStart() then
            return false
        end

        if _G.RyzenStopAntiBypassAimbot then
            _G.RyzenStopAntiBypassAimbot(false)
        end
        _G.RyzenAntiBypassAimbotOn = false

        if _G.RyzenNormalAimbot.conn then
            pcall(function() _G.RyzenNormalAimbot.conn:Disconnect() end)
            _G.RyzenNormalAimbot.conn = nil
        end

        _G.RyzenNormalAimbotAutoTPWasEnabled = false
        if autoTPEnabled then
            _G.RyzenNormalAimbotAutoTPWasEnabled = true
            stopAutoTP()
            if setAutoTPVisual then setAutoTPVisual(false) end
        end

        _G.RyzenNormalAimbotOn = true
        _G.RyzenNormalAimbot.target = nil
        _G.RyzenNormalAimbot.stickyTarget = nil
        _G.RyzenNormalAimbot.stickyUntil = 0
        _G.RyzenNormalAimbot.lastScan = 0

        -- Ryzen SCYTHE VS aimbot: Heartbeat + prediction + sticky + CFrame rotation + fling recovery
        _G.RyzenNormalAimbot.conn = RunService.Heartbeat:Connect(function()
            if not _G.RyzenNormalAimbotOn or selectedAimbotMode ~= "Normal" then
                return
            end

            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not char or not hum or not root then return end
            if hum.Health <= 0 then return end

            -- Ryzen: PlatformStand recovery
            if hum.PlatformStand then
                pcall(function() hum.PlatformStand = false end)
            end

            -- Ryzen fling recovery: damp insane velocity from hit/death (prevents die+fling loop)
            pcall(function()
                local lv = root.AssemblyLinearVelocity
                local av = root.AssemblyAngularVelocity
                if lv.Magnitude > 220 then
                    root.AssemblyLinearVelocity = lv.Unit * 60
                end
                if av.Magnitude > 25 then
                    root.AssemblyAngularVelocity = Vector3.zero
                end
            end)

            -- equip bat if needed
            if not char:FindFirstChildOfClass("Tool") then
                local bat = _G.RyzenFindAimbotBat()
                if bat then pcall(function() hum:EquipTool(bat) end) end
            end

            local target = _ryzenGetAimbotTarget()
            if not target then
                hum.AutoRotate = true
                root.AssemblyAngularVelocity = Vector3.zero
                return
            end
            _G.RyzenNormalAimbot.target = target
            hum.AutoRotate = false

            local targetVel = target.AssemblyLinearVelocity or Vector3.zero
            local myPos = root.Position
            local targetPos = target.Position
            local predictPos = targetPos + targetVel * 0.14 + target.CFrame.LookVector * 0.3
            local direction = predictPos - myPos
            local flatDir = Vector3.new(direction.X, 0, direction.Z)
            if flatDir.Magnitude > 0.01 then flatDir = flatDir.Unit else flatDir = Vector3.new(0, 0, 1) end

            local chaseSpeed = _G.RyzenGetNormalAimbotSpeed()
            local desiredHeight = targetPos.Y + 3.7
            local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8
            if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
            yVel = math.clamp(yVel, -50, 80)
            local desiredVel = Vector3.new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.65)

            -- Ryzen rotation with CFrame (no crazy angular velocity = no self-fling)
            local predictedPos = targetPos + targetVel * math.clamp(targetVel.Magnitude / 150, 0.05, 0.2)
            if (predictedPos - myPos).Magnitude > 0.1 then
                local look = Vector3.new(predictedPos.X, myPos.Y, predictedPos.Z)
                root.CFrame = CFrame.new(myPos, look)
                root.AssemblyAngularVelocity = Vector3.zero
            end

            -- auto swing
            if autoSwingEnabled then
                local bat = char:FindFirstChildOfClass("Tool") or _G.RyzenFindAimbotBat()
                if bat and bat:IsA("Tool") then pcall(function() bat:Activate() end) end
            end
        end)

        -- Ryzen: keep aimbot ON after death/respawn (CharacterAdded reconnect)
        if _G.RyzenNormalAimbot.charConn then pcall(function() _G.RyzenNormalAimbot.charConn:Disconnect() end) end
        _G.RyzenNormalAimbot.charConn = LP.CharacterAdded:Connect(function(char)
            if not _G.RyzenNormalAimbotOn then return end
            task.wait(0.25)
            local root = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 3)
            local hum = char:FindFirstChildOfClass("Humanoid")
            pcall(function()
                if root then
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end
                if hum then
                    hum.PlatformStand = false
                    hum.AutoRotate = false
                    local bat = _G.RyzenFindAimbotBat and _G.RyzenFindAimbotBat() or nil
                    if bat then hum:EquipTool(bat) end
                end
            end)
        end)

        if _G.RyzenRefreshAimbotVisual then
            _G.RyzenRefreshAimbotVisual()
        end

        return true
    end

    function _G.RyzenStopNormalAimbot()
        _G.RyzenNormalAimbotOn = false

        if _G.RyzenNormalAimbot and _G.RyzenNormalAimbot.conn then
            pcall(function() _G.RyzenNormalAimbot.conn:Disconnect() end)
            _G.RyzenNormalAimbot.conn = nil
        end

        -- Ryzen: disconnect CharacterAdded reconnect
        if _G.RyzenNormalAimbot and _G.RyzenNormalAimbot.charConn then
            pcall(function() _G.RyzenNormalAimbot.charConn:Disconnect() end)
            _G.RyzenNormalAimbot.charConn = nil
        end

        if _G.RyzenNormalAimbot then
            _G.RyzenNormalAimbot.target = nil
            _G.RyzenNormalAimbot.stickyTarget = nil
            _G.RyzenNormalAimbot.stickyUntil = 0
        end

        _RyzenAimbotReleaseLinearVelocity()

        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if root then
            root.AssemblyLinearVelocity  = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end

        if hum then
            hum.AutoRotate = true
        end

        if _G.RyzenNormalAimbotAutoTPWasEnabled then
            _G.RyzenNormalAimbotAutoTPWasEnabled = false
            autoTPEnabled = true
            if setAutoTPVisual then setAutoTPVisual(true) end
            startAutoTP()
        end

        if _G.RyzenRefreshAimbotVisual then
            _G.RyzenRefreshAimbotVisual()
        end
    end
    _G.RyzenAntiBypassAimbot = _G.RyzenAntiBypassAimbot or {conn = nil, swingCooldown = false, prevAutoRotate = nil}
    _G.RyzenAntiBypassSettings = {
    SPEED = 63,
    VERT_SPEED = 52,
    DISTANCE = -2.8,
    HEIGHT = 4.75,
    V_OFFSET = 1,
    TURN_SPEED = 285,
    MAX_TURN_RATE = 28,
    AUTO_SWING = true,
    }
    _G.RyzenAntiBypassSlapList = _G.RyzenAntiBypassSlapList or {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
    function _G.RyzenAntiBypassFindBat()
    local char = LP.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
    if tool:IsA("Tool") then
    local name = tool.Name:lower()
    if name:find("bat") or name:find("slap") then return tool end
    end
    end
    local bp = LP:FindFirstChildOfClass("Backpack")
    if bp then
    for _, tool in ipairs(bp:GetChildren()) do
    if tool:IsA("Tool") then
    local name = tool.Name:lower()
    if name:find("bat") or name:find("slap") then return tool end
    end
    end
    end
    return nil
    end
    function _G.RyzenAntiBypassEnsureBat()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hum then return nil end
    local equipped = char:FindFirstChildOfClass("Tool")
    if equipped then return equipped end
    local bat = _G.RyzenAntiBypassFindBat()
    if bat then pcall(function() hum:EquipTool(bat) end) end
    return bat
    end
    function _G.RyzenAntiBypassTrySwing()
    if _G.RyzenAntiBypassAimbot.swingCooldown then return end
    _G.RyzenAntiBypassAimbot.swingCooldown = true
    pcall(function()
    local bat = _G.RyzenAntiBypassEnsureBat()
    if bat and bat:IsA("Tool") then bat:Activate() end
    end)
    task.delay(0.3, function()
    if _G.RyzenAntiBypassAimbot then _G.RyzenAntiBypassAimbot.swingCooldown = false end
    end)
    end
    function _G.RyzenAntiBypassGetClosest()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil, math.huge end
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if tRoot and hum and hum.Health > 0 then
    local dist = (tRoot.Position - root.Position).Magnitude
    if dist < minDist then minDist, closest = dist, tRoot end
    end
    end
    end
    return closest, minDist
    end
    function _G.RyzenStartAntiBypassAimbot()
    if _G.RyzenSafeModeTryStart and not _G.RyzenSafeModeTryStart() then return false end
    if _G.RyzenStopAutoTPForAction then _G.RyzenStopAutoTPForAction() end
    if _G.RyzenStopNormalAimbot then _G.RyzenStopNormalAimbot() end
    _G.RyzenAntiBypassAimbotOn = true
    selectedAimbotMode = "Anti Bypass"
    if _G.RyzenAntiBypassAimbot.conn then _G.RyzenAntiBypassAimbot.conn:Disconnect() end
    local hum0 = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum0 then
    _G.RyzenAntiBypassAimbot.prevAutoRotate = hum0.AutoRotate
    hum0.AutoRotate = false
    end
    _G.RyzenAntiBypassAimbot.conn = RunService.Heartbeat:Connect(function()
    if not _G.RyzenAntiBypassAimbotOn or selectedAimbotMode ~= "Anti Bypass" then return end
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not root or hum.Health <= 0 then return end
    local S = _G.RyzenAntiBypassSettings
    hum.AutoRotate = false
    _G.RyzenAntiBypassEnsureBat()
    local target, targetDist = _G.RyzenAntiBypassGetClosest()
    if not target then
    root.AssemblyAngularVelocity = Vector3.zero
    return
    end
    local aimTargetPos = target.Position + Vector3.new(0, S.V_OFFSET, 0)
    local look = aimTargetPos - root.Position
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude > 0.01 then
    local targetYaw = math.deg(math.atan2(-flatLook.X, -flatLook.Z))
    local yawDelta = (targetYaw - root.Orientation.Y + 180) % 360 - 180
    local yawRate = math.clamp(yawDelta * 8, -S.MAX_TURN_RATE, S.MAX_TURN_RATE)
    root.AssemblyAngularVelocity = Vector3.new(0, yawRate, 0)
    else
    root.AssemblyAngularVelocity = Vector3.zero
    end
    if look.Magnitude > 0.01 then
    local dir = look.Unit
    local standPos = aimTargetPos - (dir * S.DISTANCE) + Vector3.new(0, S.HEIGHT, 0)
    local moveDir = standPos - root.Position
    local hDir = Vector3.new(moveDir.X, 0, moveDir.Z)
    local hVel = hDir.Magnitude > 0.1 and hDir.Unit * S.SPEED or Vector3.zero
    local vVel = Vector3.new(0, math.clamp(moveDir.Y * 3, -S.VERT_SPEED, S.VERT_SPEED), 0)
    root.AssemblyLinearVelocity = hVel + vVel
    if hDir.Magnitude > 0.5 then hum:Move(hDir.Unit, false) end
    end
    if S.AUTO_SWING and autoSwingEnabled and targetDist < 5 then _G.RyzenAntiBypassTrySwing() end
    end)
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    return true
    end
    function _G.RyzenStopAntiBypassAimbot(keepVisual)
    _G.RyzenAntiBypassAimbotOn = false
    if _G.RyzenAntiBypassAimbot and _G.RyzenAntiBypassAimbot.conn then
    _G.RyzenAntiBypassAimbot.conn:Disconnect()
    _G.RyzenAntiBypassAimbot.conn = nil
    end
    if _G.RyzenAntiBypassAimbot then _G.RyzenAntiBypassAimbot.swingCooldown = false end
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if root then
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    end
    if hum then
    hum.AutoRotate = (_G.RyzenAntiBypassAimbot.prevAutoRotate == nil) and true or _G.RyzenAntiBypassAimbot.prevAutoRotate
    end
    _G.RyzenAntiBypassAimbot.prevAutoRotate = nil
    if keepVisual ~= false and _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    end
    function _G.RyzenToggleSelectedAimbot()
    if selectedAimbotMode == "Anti Bypass" then
    if _G.RyzenAntiBypassAimbotOn then
    if _G.RyzenStopAntiBypassAimbot then _G.RyzenStopAntiBypassAimbot() else _G.RyzenAntiBypassAimbotOn = false end
    else
    if _G.RyzenStopNormalAimbot then _G.RyzenStopNormalAimbot() end
    if _G.RyzenStartAntiBypassAimbot then _G.RyzenStartAntiBypassAimbot() else _G.RyzenAntiBypassAimbotOn = true end
    end
    else
    if _G.RyzenNormalAimbotOn then
    _G.RyzenStopNormalAimbot()
    else
    if _G.RyzenStopAntiBypassAimbot then _G.RyzenStopAntiBypassAimbot(false) else _G.RyzenAntiBypassAimbotOn = false end
    _G.RyzenStartNormalAimbot()
    end
    end
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    function _G.RyzenRefreshAimbotVisual()
    if _G.RyzenAimbotSetVisual then
    if selectedAimbotMode == "Anti Bypass" then
    _G.RyzenAimbotSetVisual(_G.RyzenAntiBypassAimbotOn == true)
    else
    _G.RyzenAimbotSetVisual(_G.RyzenNormalAimbotOn == true)
    end
    end
    end
    _G.RyzenNormalAimbotStart = _G.RyzenStartNormalAimbot
    _G.RyzenNormalAimbotStop = _G.RyzenStopNormalAimbot
    _G.RyzenAntiBypassStart = _G.RyzenStartAntiBypassAimbot
    _G.RyzenAntiBypassStop = _G.RyzenStopAntiBypassAimbot

    local MIRROR_TP_DROP_THRESHOLD = 3
    local MIRROR_TP_DOWN_Y = -7.00
    local mirrorTPPreviousY = {}
    local mirrorTPLastTeleport = 0

    local function mirrorTPAimbotActive()
    return (_G.RyzenNormalAimbotOn == true) or (_G.RyzenAntiBypassAimbotOn == true)
    end

    local function mirrorTPTeleportDown()
    local character = LP.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid or humanoid.Health <= 0 then return end

    local now = tick()
    if now - (mirrorTPLastTeleport or 0) < 0.08 then return end
    mirrorTPLastTeleport = now

    local _, yaw = root.CFrame:ToEulerAnglesYXZ()
    local y = (MIRROR_TP_DOWN_Y or -7) + (math.random() * 0.6 - 0.3)
    root.CFrame = CFrame.new(root.Position.X, y, root.Position.Z) * CFrame.Angles(0, yaw, 0)
    root.AssemblyLinearVelocity = Vector3.new((math.random() - 0.5) * 0.4, 0, (math.random() - 0.5) * 0.4)
    end

    RunService.Heartbeat:Connect(function()
    if not mirrorTPDownEnabled or not mirrorTPAimbotActive() then
    if next(mirrorTPPreviousY) then
    table.clear(mirrorTPPreviousY)
    end
    return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if root then
    local currentY = root.Position.Y
    local previousY = mirrorTPPreviousY[plr.UserId]
    if previousY and previousY - currentY >= (MIRROR_TP_DROP_THRESHOLD or 3) then
    pcall(mirrorTPTeleportDown)
    table.clear(mirrorTPPreviousY)
    return
    end
    mirrorTPPreviousY[plr.UserId] = currentY
    end
    end
    end
    end)

    function _G.RyzenSetMirrorTPDown(enabled)
    mirrorTPDownEnabled = enabled == true
    if not mirrorTPDownEnabled then
    table.clear(mirrorTPPreviousY)
    end
    if _G.RyzenMirrorTPDownSetVisual then
    _G.RyzenMirrorTPDownSetVisual(mirrorTPDownEnabled)
    end
    end

    -- ============================================================
    -- ANTI DROP (donor: 404 Anti Drop - velocity spoof core)
    -- Spoofs the character root's replicated velocity through a
    -- metatable hook: external (non-caller) Lua reads of the root's
    -- AssemblyLinearVelocity / Velocity return the spoofed value and
    -- external writes are captured instead of applied, so knockback
    -- and drop forces never register in the game's Lua logic. Our
    -- own script's reads/writes pass through untouched (checkcaller).
    -- The donor's billboard cartel was removed on user request: anti
    -- drop is invisible while active. No keybind, no controller bind
    -- and no mobile button by design - toggle it from the Movement tab.
    -- ============================================================
    do
        local AD = _G.RyzenAntiDrop or {}
        AD.Enabled = true
        _G.RyzenAntiDrop = AD

        local spoofedVelocity = Vector3.zero
        local hookActive = false

        -- restore info kept in _G so a re-execute can never double-hook
        local function restoreHook()
            local prev = _G.__RyzenAntiDropHookInfo
            if prev then
                pcall(function()
                    setreadonly(prev.mt, false)
                    prev.mt.__index = prev.oldIdx
                    prev.mt.__newindex = prev.oldNewIdx
                    setreadonly(prev.mt, true)
                end)
                _G.__RyzenAntiDropHookInfo = nil
            end
            hookActive = false
            _G._RyzenAntiDropConn = nil
        end

        local function startAntiDrop()
            if hookActive then return end
            if not (typeof(getrawmetatable) == "function" and typeof(setreadonly) == "function"
                and typeof(newcclosure) == "function" and typeof(checkcaller) == "function") then
                return
            end
            -- restore any hook left by a previous execution first
            restoreHook()
            local mt = getrawmetatable(game)
            if not mt then return end
            local oldIdx, oldNewIdx = mt.__index, mt.__newindex
            pcall(function() setreadonly(mt, false) end)
            mt.__index = newcclosure(function(self, key)
                if not checkcaller() and (key == "AssemblyLinearVelocity" or key == "Velocity")
                    and typeof(self) == "Instance" and self:IsA("BasePart")
                    and self.Name == "HumanoidRootPart"
                    and LP.Character and self:IsDescendantOf(LP.Character) then
                    return spoofedVelocity
                end
                return oldIdx(self, key)
            end)
            mt.__newindex = newcclosure(function(self, key, value)
                if not checkcaller() and (key == "AssemblyLinearVelocity" or key == "Velocity")
                    and typeof(self) == "Instance" and self:IsA("BasePart")
                    and self.Name == "HumanoidRootPart"
                    and LP.Character and self:IsDescendantOf(LP.Character) then
                    spoofedVelocity = value
                    return
                end
                return oldNewIdx(self, key, value)
            end)
            pcall(function() setreadonly(mt, true) end)
            _G.__RyzenAntiDropHookInfo = { mt = mt, oldIdx = oldIdx, oldNewIdx = oldNewIdx }
            hookActive = true
            -- running marker for the boot-time guard
            _G._RyzenAntiDropConn = true
        end

        local function stopAntiDrop()
            restoreHook()
        end

        function _G.RyzenStartAntiDrop()
            AD.Enabled = true
            _G.RyzenAntiDropEnabled = true
            startAntiDrop()
        end

        function _G.RyzenStopAntiDrop()
            AD.Enabled = true
            _G.RyzenAntiDropEnabled = true
            startAntiDrop()
        end

        function _G.RyzenSetAntiDrop(on)
            on = true
            _G.RyzenStartAntiDrop()
            if _G.RyzenAntiDropSetVisual then
                _G.RyzenAntiDropSetVisual(on)
            end
            if showActionNotification then
                showActionNotification(on and "RXZ ANTI DROP - ACTIVE" or "RXZ ANTI DROP - OFF")
            end
            if saveRyzenConfig then
                pcall(saveRyzenConfig)
            end
            return true
        end
    end

    _G.__RyzenSetupNormalAutoSteal = function()
    local getconnections_v3 = getconnections or get_signal_cons or getconnects or (syn and syn.get_signal_cons)
    _G.RyzenGalaxyV3 = _G.RyzenGalaxyV3 or {
    conn=nil, active=false, progress=0, paused=false, pauseTime=nil,
    startTime=nil, progressConn=nil, dataCache={}, enabled=false,
    StealRadius=63, StealDuration=1.3, TriggerRadius=10
    }
    local GS = _G.RyzenGalaxyV3

    local function getHRP()
    local c=LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
    end

    local function isMyPlot(plotName)
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot=plots:FindFirstChild(plotName)
    if not plot then return false end
    local sign=plot:FindFirstChild("PlotSign")
    if sign then
    local yb=sign:FindFirstChild("YourBase")
    if yb and yb:IsA("BillboardGui") then return yb.Enabled==true end
    end
    return false
    end

    local function findPrompt()
    local hrp=getHRP()
    if not hrp then return nil,nil end
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return nil,nil end
    local bestPrompt,bestDist,bestSpawn=nil,math.huge,nil

    for _,plot in ipairs(plots:GetChildren()) do
    if not plot:IsA("Model") then continue end
    if isMyPlot(plot.Name) then continue end
    local pods=plot:FindFirstChild("AnimalPodiums")
    if not pods then continue end

    for _,pod in ipairs(pods:GetChildren()) do
    pcall(function()
    local base=pod:FindFirstChild("Base")
    local spawn=base and base:FindFirstChild("Spawn")
    if not spawn then return end
    local dist=(spawn.Position-hrp.Position).Magnitude
    if dist>=bestDist or dist>GS.StealRadius then return end

    local function tryPrompt(container)
    for _,ch in ipairs(container:GetChildren()) do
    if ch:IsA("ProximityPrompt") and ch.Enabled then
    bestPrompt=ch
    bestDist=dist
    bestSpawn=spawn
    return true
    end
    end
    end

    local att=spawn:FindFirstChild("PromptAttachment")
    if not (att and tryPrompt(att)) then
    for _,ch in ipairs(spawn:GetDescendants()) do
    if ch:IsA("ProximityPrompt") and ch.Enabled then
    bestPrompt=ch
    bestDist=dist
    bestSpawn=spawn
    break
    end
    end
    end
    end)
    end
    end
    return bestPrompt,bestSpawn
    end

    local function distToSpawn(spawnPart)
    local hrp=getHRP()
    if not hrp then return math.huge end
    if not spawnPart or not spawnPart.Parent then
    local _,ns=findPrompt()
    return ns and (hrp.Position-ns.Position).Magnitude or math.huge
    end
    return (hrp.Position-spawnPart.Position).Magnitude
    end

    local function updateBar(p,state)
    if _G.StealBar then
    pcall(function()
    _G.StealBar.SetProgress(p or 0)
    if state then _G.StealBar.SetState(state) end
    end)
    end
    end

    local function execute(prompt,spawnPart)
    if GS.active then return end

    if not GS.dataCache[prompt] then
    local data={hold={},trigger={},ready=true}
    if getconnections_v3 then
    pcall(function()
    for _,c in ipairs(getconnections_v3(prompt.PromptButtonHoldBegan)) do
    if c.Function then table.insert(data.hold,c.Function) end
    end
    for _,c in ipairs(getconnections_v3(prompt.Triggered)) do
    if c.Function then table.insert(data.trigger,c.Function) end
    end
    end)
    end
    GS.dataCache[prompt]=data
    end

    local data=GS.dataCache[prompt]
    if not data.ready then return end

    data.ready=false
    GS.active=true
    GS.paused=false
    GS.startTime=tick()-(GS.progress*GS.StealDuration)
    local pauseArmed=true
    local PAUSE_AT=0.75
    local PAUSE_WAIT=3.0
    local PAUSE_RELEASE_BEFORE=0.3

    if GS.progressConn then GS.progressConn:Disconnect() end
    updateBar(GS.progress,"STEALING")

    local function isLocalRagdolled()
    local c=LP.Character
    if not c then return false end
    local hum=c:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if _G.RyzenCounterIsRagdoll then return _G.RyzenCounterIsRagdoll(hum) end
    local st=hum:GetState()
    return st==Enum.HumanoidStateType.Physics
    or st==Enum.HumanoidStateType.Ragdoll
    or st==Enum.HumanoidStateType.FallingDown
    or hum.PlatformStand==true
    end

    GS.progressConn=RunService.Heartbeat:Connect(function()
    if not GS.active then
    if GS.progressConn then GS.progressConn:Disconnect();GS.progressConn=nil end
    return
    end

    if not GS.enabled or not autoStealEnabled or selectedStealMode~="__REMOVED_V2__" then
    GS.active=false
    GS.progress=0
    GS.paused=false
    data.ready=true
    updateBar(0,autoStealEnabled and "READY" or "IDLE")
    return
    end

    if GS.paused then
    local dist=distToSpawn(spawnPart)
    local waited=tick()-(GS.pauseTime or tick())
    if dist<=GS.TriggerRadius then
    GS.paused=false
    GS.pauseTime=nil
    GS.startTime=tick()-(PAUSE_AT*GS.StealDuration)
    else
    if not GS.pauseTime then
    GS.pauseTime=tick()
    elseif waited>=PAUSE_WAIT then
    GS.pauseTime=nil
    GS.paused=false
    GS.active=false
    GS.progress=0
    data.ready=true
    pauseArmed=true
    if GS.progressConn then GS.progressConn:Disconnect();GS.progressConn=nil end
    updateBar(0,autoStealEnabled and "READY" or "IDLE")
    return
    end
    GS.progress=PAUSE_AT
    updateBar(PAUSE_AT,"STEALING")
    if PAUSE_WAIT-waited<=PAUSE_RELEASE_BEFORE then
    GS.paused=false
    GS.pauseTime=nil
    GS.startTime=tick()-(PAUSE_AT*GS.StealDuration)
    end
    return
    end
    end

    local elapsed=tick()-GS.startTime
    local prog=math.clamp(elapsed/GS.StealDuration,0,1)
    GS.progress=prog

    if pauseArmed and prog>=PAUSE_AT then
    if isLocalRagdolled() then
    GS.paused=true
    pauseArmed=false
    GS.progress=PAUSE_AT
    GS.pauseTime=tick()
    updateBar(PAUSE_AT,"STEALING")
    return
    else
    pauseArmed=false
    end
    end

    updateBar(prog,"STEALING")

    if prog>=1 then
    GS.active=false
    GS.progress=0
    GS.paused=false
    pauseArmed=true
    if GS.progressConn then GS.progressConn:Disconnect();GS.progressConn=nil end

    for _,fn in ipairs(data.trigger) do
    task.spawn(function() pcall(fn) end)
    end

    data.ready=true
    updateBar(0,autoStealEnabled and "READY" or "IDLE")
    end
    end)

    for _,fn in ipairs(data.hold) do
    task.spawn(function() pcall(fn) end)
    end
    end

    _G.RyzenNormalAutoStealSetRadius=function(v)
    GS.StealRadius=tonumber(v) or GS.StealRadius or 63
    end

    _G.RyzenNormalAutoStealStart=function()
    if GS.conn then GS.conn:Disconnect();GS.conn=nil end
    GS.enabled=true
    GS.StealRadius=tonumber(autoStealRadius) or 63
    GS.StealDuration=1.3
    GS.TriggerRadius=10
    GS.conn=RunService.Heartbeat:Connect(function()
    if not GS.enabled or GS.active then return end
    if not autoStealEnabled or selectedStealMode~="__REMOVED_V2__" then return end
    local prompt,spawnPart=findPrompt()
    if prompt then execute(prompt,spawnPart) end
    end)
    updateBar(0,"READY")
    end

    _G.RyzenNormalAutoStealStop=function()
    GS.enabled=false
    if GS.conn then GS.conn:Disconnect();GS.conn=nil end
    if GS.progressConn then GS.progressConn:Disconnect();GS.progressConn=nil end
    GS.active=false
    GS.progress=0
    GS.paused=false
    GS.pauseTime=nil
    GS.dataCache={}
    updateBar(0,autoStealEnabled and "READY" or "IDLE")
    end

    _G.RyzenNormalAutoStealSync=function()
    if autoStealEnabled and selectedStealMode=="__REMOVED_V2__" then
    _G.RyzenNormalAutoStealStart()
    else
    _G.RyzenNormalAutoStealStop()
    end
    end
    end
    _G.__RyzenSetupNormalAutoSteal()
    _G.__RyzenSetupV3AutoSteal = function()
    -- Auto Steal V3 = Ryzen Balenci auto-grab: FREEZE bar at 75%, wait until within delay radius, then finish to 100% + fire.
    -- 3 phases: (1) fill 0->75% then FREEZE, (2) hold at 75% until within delay radius or timeout -> restart, (3) finish 75%->100% + fire.
    local getconnections_v3b = getconnections or get_signal_cons or getconnects or (syn and syn.get_signal_cons)
    _G.RyzenGalaxyV3New = _G.RyzenGalaxyV3New or {
    conn=nil, active=false, progress=0, paused=false, pauseTime=nil,
    startTime=nil, progressConn=nil, dataCache={}, enabled=false,
    StealRadius=63, StealDuration=1.3, TriggerRadius=10,
    DelayRadius=9, PAUSE_AT=0.75, PAUSE_WAIT=3.0, PAUSE_RELEASE_BEFORE=0.3
    }
    local G3 = _G.RyzenGalaxyV3New

    local function getHRP()
    local c=LP.Character
    return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso"))
    end

    local function isMyPlotV3(plotName)
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot=plots:FindFirstChild(plotName)
    if not plot then return false end
    local sign=plot:FindFirstChild("PlotSign")
    if sign then
    local yb=sign:FindFirstChild("YourBase")
    if yb and yb:IsA("BillboardGui") then return yb.Enabled==true end
    end
    return false
    end

    -- find nearest prompt + spawn (within steal radius)
    local function nearestPrompt()
    local hrp=getHRP()
    if not hrp then return nil,nil,nil,math.huge end
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return nil,nil,nil,math.huge end
    local bestPrompt,bestDist,bestSpawn=nil,math.huge,nil
    local rad=tonumber(G3.StealRadius) or 63
    for _,plot in ipairs(plots:GetChildren()) do
    if not plot:IsA("Model") then continue end
    if isMyPlotV3(plot.Name) then continue end
    local pods=plot:FindFirstChild("AnimalPodiums")
    if not pods then continue end
    for _,pod in ipairs(pods:GetChildren()) do
    pcall(function()
    local base=pod:FindFirstChild("Base")
    local spawn=base and base:FindFirstChild("Spawn")
    if not spawn then return end
    local dist=(spawn.Position-hrp.Position).Magnitude
    if dist<bestDist and dist<=rad then
    local function tryPrompt(container)
    for _,ch in ipairs(container:GetChildren()) do
    if ch:IsA("ProximityPrompt") and ch.Enabled then
    bestPrompt=ch
    bestDist=dist
    bestSpawn=spawn
    return true
    end
    end
    end
    local att=spawn:FindFirstChild("PromptAttachment")
    if not (att and tryPrompt(att)) then
    for _,ch in ipairs(spawn:GetDescendants()) do
    if ch:IsA("ProximityPrompt") and ch.Enabled then
    bestPrompt=ch
    bestDist=dist
    bestSpawn=spawn
    break
    end
    end
    end
    end
    end)
    end
    end
    return bestPrompt,bestSpawn,bestDist,bestDist
    end

    local function distToSpawn(spawnPart)
    local hrp=getHRP()
    if not hrp then return math.huge end
    if not spawnPart or not spawnPart.Parent then
    local _,ns=nearestPrompt()
    return ns and (hrp.Position-ns.Position).Magnitude or math.huge
    end
    return (hrp.Position-spawnPart.Position).Magnitude
    end

    local function updateBar(p,state)
    if _G.StealBar then
    pcall(function()
    _G.StealBar.SetProgress(p or 0)
    if state then _G.StealBar.SetState(state) end
    end)
    end
    end

    local function barSet(p, label)
    local progress = math.clamp(tonumber(p) or 0, 0, 1)
    local pct = math.floor(progress * 100 + 0.5)
    local text = tostring(pct) .. "%"
    if type(label) == "string" and label ~= "" then
    text = string.upper(label) .. "  " .. text
    end
    if _G.StealBar then
    pcall(function()
    _G.StealBar.SetProgress(progress)
    _G.StealBar.SetState(text)
    end)
    end
    end

    local function barReset()
    if _G.StealBar then
    pcall(function()
    _G.StealBar.SetProgress(0)
    _G.StealBar.SetState(autoStealEnabled and "READY" or "IDLE")
    end)
    end
    end

    -- Ryzen Balenci grab: pause at 75%, wait until delay radius, then finish + fire
    local function execute(prompt, spawnPart)
    if G3.active then return end
    if not prompt then return end

    if not G3.dataCache[prompt] then
    local data={hold={},trigger={},ready=true}
    if getconnections_v3b then
    pcall(function()
    for _,c in ipairs(getconnections_v3b(prompt.PromptButtonHoldBegan)) do
    if c.Function then table.insert(data.hold,c.Function) end
    end
    for _,c in ipairs(getconnections_v3b(prompt.Triggered)) do
    if c.Function then table.insert(data.trigger,c.Function) end
    end
    end)
    end
    G3.dataCache[prompt]=data
    end

    local data=G3.dataCache[prompt]
    if not data or not data.ready then return end
    data.ready=false
    G3.active=true
    G3.paused=false

    local duration = math.max(tonumber(G3.StealDuration) or 1.3, 0.5)
    -- Auto Steal Pause wiring: ON = freeze the bar at the set % (default 75)
    -- and wait for the delay radius before finishing; OFF = run straight
    -- through from 0% to 100% with no pause at all.
    local pauseEnabled = _G.RyzenAutoStealPause == true
    local pausePct = pauseEnabled
    and math.clamp((tonumber(_G.RyzenAutoStealPausePercent) or 75) / 100, 0.05, 1)
    or 1
    local stopTime = duration * pausePct -- time to reach the pause point
    local delayRadius = math.max(tonumber(G3.DelayRadius) or 9, 1)
    local stealRadius = tonumber(G3.StealRadius) or 63

    barSet(0, "STEAL")

    task.spawn(function()
    -- fire hold callbacks
    for _, fn in ipairs(data.hold or {}) do task.spawn(function() pcall(fn) end) end
    local startTime = tick()
    local promptFired = false

    local function stillOn()
    if not G3.active then return false end
    if not G3.enabled then return false end
    if not autoStealEnabled then return false end
    if selectedStealMode ~= "Auto Steal" then return false end
    if not prompt or not prompt.Parent then return false end
    return true
    end

    -- PHASE 1: fill 0% -> pause point (then freeze if Auto Steal Pause is on)
    while stillOn() do
    local elapsed = tick() - startTime
    local prog = math.clamp(elapsed / duration, 0, 1)
    if prog >= pausePct then
    if pauseEnabled then barSet(pausePct, "HOLD") end -- lock at the pause %
    break
    end
    barSet(prog, "STEAL")
    if distToSpawn(spawnPart) > stealRadius then break end
    task.wait()
    end

    if not stillOn() then
    barReset()
    data.ready = true
    G3.active = false
    G3.paused = false
    return
    end

    -- Auto Steal Pause OFF: skip the freeze + delay-radius wait entirely and
    -- fall straight through to the finish phase.
    if pauseEnabled then
    barSet(pausePct, "HOLD")

    -- PHASE 2: wait until within delay radius (9) or timeout -> restart
    local phase2Timeout = math.max(2.99 - stopTime - math.max(duration - stopTime, 0), 0.15)
    local phase2Start = tick()
    while stillOn() do
    if tick() - phase2Start >= phase2Timeout then
    -- restart: pick nearest prompt again
    barReset()
    data.ready = true
    G3.active = false
    G3.paused = false
    task.wait()
    local p2, sp2 = nearestPrompt()
    if p2 then execute(p2, sp2) end
    return
    end
    local dist = distToSpawn(spawnPart)
    if dist <= delayRadius then
    break
    elseif dist > stealRadius then
    barReset()
    data.ready = true
    G3.active = false
    G3.paused = false
    return
    end
    -- keep bar frozen at the pause %
    barSet(pausePct, "HOLD")
    task.wait()
    end
    end

    -- PHASE 3: finish pause% -> 100% then fire
    if stillOn() then
    local fillStart = tick()
    local fillDuration = math.max(duration * (1 - pausePct), 0.05)
    while stillOn() do
    local fp = math.clamp((tick() - fillStart) / fillDuration, 0, 1)
    local prog = pausePct + fp * (1 - pausePct)
    barSet(prog, "STEAL")
    if fp >= 1 and not promptFired then
    promptFired = true
    for _, fn in ipairs(data.trigger or {}) do task.spawn(function() pcall(fn) end) end
    pcall(function()
    if fireproximityprompt then fireproximityprompt(prompt) end
    end)
    pcall(function()
    if _G.AutoCarrySpeed and _G.AutoCarrySpeed.WatchPickup then
    _G.AutoCarrySpeed.WatchPickup(1.25)
    end
    end)
    break
    end
    task.wait()
    end
    end

    barReset()
    data.ready = true
    G3.active = false
    G3.paused = false
    end)
    end

    _G.RyzenV3AutoStealSetRadius=function(v)
    G3.StealRadius=tonumber(v) or G3.StealRadius or 63
    end

    _G.RyzenV3AutoStealStart=function()
    if G3.conn then G3.conn:Disconnect();G3.conn=nil end
    G3.enabled=true
    G3.StealRadius=tonumber(autoStealRadius) or 63
    G3.StealDuration=1.3
    G3.TriggerRadius=10
    G3.DelayRadius=9
    G3.conn=RunService.Heartbeat:Connect(function()
    if not G3.enabled or G3.active then return end
    if not autoStealEnabled or selectedStealMode~="Auto Steal" then return end
    local prompt,spawnPart=nearestPrompt()
    if prompt then execute(prompt,spawnPart) end
    end)
    barReset()
    end

    _G.RyzenV3AutoStealStop=function()
    G3.enabled=false
    if G3.conn then G3.conn:Disconnect();G3.conn=nil end
    G3.active=false
    G3.progress=0
    G3.paused=false
    G3.pauseTime=nil
    G3.dataCache={}
    barReset()
    end

    _G.RyzenV3AutoStealSync=function()
    if autoStealEnabled and selectedStealMode=="Auto Steal" then
    _G.RyzenV3AutoStealStart()
    else
    _G.RyzenV3AutoStealStop()
    end
    end
    end
    _G.__RyzenSetupV3AutoSteal()
    _G.__RyzenSetupSemiAutoSteal = function()
    local A = _G.RyzenSemiSteal
    if not A then
    A = {
    enabled = false,
    conn = nil,
    scanThread = nil,
    syncReady = false,
    plots = nil,
    animalsData = {},
    syncRemotes = nil,
    plotSync = {caches = {}, connections = {}},
    animals = {},
    promptCache = {},
    internalCache = {},
    radius = 9,
    primeRange = 80,
    holdMin = 1.3,
    holdMax = 2.6,
    entryDelay = 0.3,
    cooldown = 0.05,
    state = {
    active = false,
    startTime = 0,
    phase = "idle",
    label = "",
    lastResult = "",
    lastResultTime = 0,
    totalSteals = 0,
    failedSteals = 0,
    },
    }
    _G.RyzenSemiSteal = A
    end
    local function rootPart()
    local char = LP.Character
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso"))
    end
    local function barSet(pct, status)
    pct = math.clamp(pct or 0, 0, 1)


    if _G.StealBar then
        _G.StealBar.SetProgress(pct)
        _G.StealBar.SetState(status or "STEALING")
    end
    end
    local function barReset()
    if _G.StealBar then
        _G.StealBar.SetProgress(0)
        _G.StealBar.SetState(autoStealEnabled and "READY" or "IDLE")
    end
    end
    local function splitSyncPath(path)
    if typeof(path) == "table" then return path end
    local out = {}
    for part in string.gmatch(tostring(path), "[^%.]+") do table.insert(out, tonumber(part) or part) end
    return out
    end
    local function resolveSyncPath(path, root)
    local current, parent, key = root, nil, nil
    for _, part in ipairs(splitSyncPath(path)) do
    parent, key = current, part
    current = current and current[part] or nil
    end
    return current, parent, key
    end
    local function applyPlotSyncDiff(channelName, packet)
    local cache = A.plotSync.caches[channelName]
    if typeof(cache) ~= "table" then return end
    local path, action, a, b = packet[1], packet[2], packet[3], packet[4]
    local current, parent, key = resolveSyncPath(path, cache)
    if action == "Changed" then
    if parent ~= nil then parent[key] = a end
    elseif action == "ArrayInsert" then
    if current ~= nil then table.insert(current, b, a) end
    elseif action == "ArrayRemoved" then
    if current ~= nil then table.remove(current, b) end
    elseif action == "DictionaryInsert" then
    if current ~= nil then current[b] = a end
    elseif action == "DictionaryRemoved" then
    if current ~= nil then current[b] = nil end
    end
    end
    local function attachPlotChannel(remote)
    if not A.syncRemotes or A.plotSync.connections[remote] then return end
    local channelName = tostring(remote.Name)
    if not A.plots:FindFirstChild(channelName) then return end
    if A.syncRemotes.requestData and A.plotSync.caches[channelName] == nil then
    local ok, data = pcall(function() return A.syncRemotes.requestData:InvokeServer(channelName) end)
    A.plotSync.caches[channelName] = (ok and typeof(data) == "table") and data or {}
    elseif A.plotSync.caches[channelName] == nil then
    A.plotSync.caches[channelName] = {}
    end
    A.plotSync.connections[remote] = remote.OnClientEvent:Connect(function(queue)
    for _, packet in ipairs(queue) do applyPlotSyncDiff(channelName, packet) end
    end)
    end
    local syncThread = nil
    local function ensureSync()
    -- FIX: this used to run WaitForChild + one InvokeServer per plot channel
    -- synchronously inside the Semi start path, freezing the game for the
    -- duration of every remote round-trip when switching to Semi. The heavy
    -- work now runs in a single background thread; callers just see "not
    -- ready yet" and the scan thread retries until the data arrives.
    if A.syncReady then return true end
    if syncThread and coroutine.status(syncThread) ~= "dead" then return false end
    syncThread = task.spawn(function()
    pcall(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    A.plots = workspace:WaitForChild("Plots", 15)
    if not A.plots then return end
    local Packages = ReplicatedStorage:WaitForChild("Packages", 10)
    local Datas = ReplicatedStorage:WaitForChild("Datas", 10)
    if not Packages or not Datas then return end
    A.animalsData = require(Datas:WaitForChild("Animals"))
    local folder = Packages:WaitForChild("Synchronizer", 10)
    if not folder then return end
    A.syncRemotes = {
    channelFolder = folder:WaitForChild("Channel", 10),
    routeRemote = folder:WaitForChild("CommunicationRoute", 10),
    requestData = folder:FindFirstChild("RequestData"),
    }
    if not A.syncRemotes.channelFolder or not A.syncRemotes.routeRemote then return end
    for _, child in ipairs(A.syncRemotes.channelFolder:GetChildren()) do
    if child:IsA("RemoteEvent") then task.spawn(attachPlotChannel, child) end
    end
    A.syncRemotes.channelFolder.ChildAdded:Connect(function(child)
    if child:IsA("RemoteEvent") then task.spawn(attachPlotChannel, child) end
    end)
    A.syncRemotes.routeRemote.OnClientEvent:Connect(function(actions)
    for _, actionData in ipairs(actions) do
    local kind, channelName = actionData[1], tostring(actionData[2])
    if A.plots:FindFirstChild(channelName) then
    if kind == "ListenerAdded" then
    local remote = A.syncRemotes.channelFolder:FindFirstChild(channelName)
    if remote and remote:IsA("RemoteEvent") then task.spawn(attachPlotChannel, remote) end
    elseif kind == "ListenerRemoved" then
    for remote, conn in pairs(A.plotSync.connections) do
    if tostring(remote.Name) == channelName then
    conn:Disconnect()
    A.plotSync.connections[remote] = nil
    A.plotSync.caches[channelName] = nil
    break
    end
    end
    end
    end
    end
    end)
    A.syncReady = true
    end)
    end)
    return false
    end
    local function getPlotOwner(plot)
    local sign = plot and plot:FindFirstChild("PlotSign")
    local frame = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame")
    local label = frame and frame:FindFirstChild("TextLabel")
    if not label or label.Text == "Empty Base" then return nil end
    return label.Text:gsub("'s [Bb]ase$", ""):gsub("%s+$", "")
    end
    local function isMyBaseAnimal(animalData)
    if not animalData or not animalData.plot or not A.plots then return false end
    local plot = A.plots:FindFirstChild(animalData.plot)
    if not plot then return false end
    -- FIX: getPlotOwner() walks PlotSign > SurfaceGui > Frame > TextLabel and
    -- runs two string gsub's. Doing that for every animal on every Heartbeat
    -- was a major FPS hit while Semi was on. Owners are now cached per plot
    -- and refreshed with each background scan (every few seconds).
    A.plotOwnerCache = A.plotOwnerCache or {}
    local owner = A.plotOwnerCache[plot]
    if owner == nil then
    owner = getPlotOwner(plot) or false
    A.plotOwnerCache[plot] = owner
    end
    return owner == LP.DisplayName or owner == LP.Name
    end
    local function podiumFor(animalData)
    -- FIX: cache the podium instance per animal (uid includes plot + slot, so
    -- it is stable). This removes two FindFirstChild walks per animal per
    -- Heartbeat frame while Semi is running.
    A.podiumCache = A.podiumCache or {}
    local cached = A.podiumCache[animalData.uid]
    if cached and cached.Parent then return cached end
    local plot = A.plots and A.plots:FindFirstChild(animalData.plot)
    local podiums = plot and plot:FindFirstChild("AnimalPodiums")
    local podium = podiums and podiums:FindFirstChild(animalData.slot) or nil
    if podium then A.podiumCache[animalData.uid] = podium end
    return podium
    end
    local function animalPos(animalData)
    local podium = podiumFor(animalData)
    return podium and podium:GetPivot().Position or nil
    end
    local function distToAnimal(animalData)
    local root = rootPart()
    local pos = animalPos(animalData)
    return root and pos and (root.Position - pos).Magnitude or math.huge
    end
    local function findPromptForAnimal(animalData)
    if not animalData then return nil end
    local cached = A.promptCache[animalData.uid]
    if cached and cached.Parent then return cached end
    local podium = podiumFor(animalData)
    local base = podium and podium:FindFirstChild("Base")
    local spawn = base and base:FindFirstChild("Spawn")
    local attach = spawn and spawn:FindFirstChild("PromptAttachment")
    if not attach then return nil end
    for _, prompt in ipairs(attach:GetChildren()) do
    if prompt:IsA("ProximityPrompt") then
    A.promptCache[animalData.uid] = prompt
    return prompt
    end
    end
    return nil
    end
    local function scanAllPlots()
    if not ensureSync() then return 0 end
    local newCache = {}
    for _, plot in ipairs(A.plots:GetChildren()) do
    local cache = A.plotSync.caches[plot.Name]
    local animalList = cache and cache.AnimalList
    if typeof(animalList) == "table" then
    for slot, animalData in pairs(animalList) do
    if type(animalData) == "table" then
    local animalName = animalData.Index
    local info = A.animalsData and A.animalsData[animalName]
    if info then
    table.insert(newCache, {
    name = info.DisplayName or animalName,
    plot = plot.Name,
    slot = tostring(slot),
    uid = plot.Name .. "_" .. tostring(slot),
    })
    end
    end
    end
    end
    end
    A.animals = newCache
    -- refresh the owner / podium caches with each background scan
    A.plotOwnerCache = {}
    A.podiumCache = {}
    return #newCache
    end
    local function pickClosest()
    local root = rootPart()
    if not root then return nil end
    local best, bestDist = nil, math.huge
    for _, animalData in ipairs(A.animals) do
    if not isMyBaseAnimal(animalData) then
    local pos = animalPos(animalData)
    local dist = pos and (root.Position - pos).Magnitude or math.huge
    if dist <= (A.primeRange or 80) and dist < bestDist then
    best, bestDist = animalData, dist
    end
    end
    end
    return best
    end
    local function buildStealCallbacks(prompt)
    if A.internalCache[prompt] then return end
    local data = {holdCallbacks = {}, triggerCallbacks = {}, ready = true}
    local ok1, conns1 = false, nil
    if getconnections then ok1, conns1 = pcall(getconnections, prompt.PromptButtonHoldBegan) end
    if ok1 and type(conns1) == "table" then
    for _, conn in ipairs(conns1) do
    if type(conn.Function) == "function" then table.insert(data.holdCallbacks, conn.Function) end
    end
    end
    local ok2, conns2 = false, nil
    if getconnections then ok2, conns2 = pcall(getconnections, prompt.Triggered) end
    if ok2 and type(conns2) == "table" then
    for _, conn in ipairs(conns2) do
    if type(conn.Function) == "function" then table.insert(data.triggerCallbacks, conn.Function) end
    end
    end
    if #data.holdCallbacks > 0 or #data.triggerCallbacks > 0 then A.internalCache[prompt] = data end
    end
    local function executeCandySemi(prompt, animalData)
    if not prompt or not prompt.Parent or not animalData then return false end
    buildStealCallbacks(prompt)
    local data = A.internalCache[prompt]
    if not data or not data.ready then return false end
    data.ready = false
    local label = animalData.name or "Animal"
    A.state.active = true
    A.state.startTime = tick()
    A.state.phase = "holding"
    A.state.label = label
    task.spawn(function()
    for _, fn in ipairs(data.holdCallbacks) do task.spawn(function() pcall(fn) end) end
    local holdStart = A.state.startTime
    while A.enabled and selectedStealMode == "Semi" and tick() - holdStart < (A.holdMin or 1.3) do
    barSet((tick() - holdStart) / (A.holdMax or 2.6), "STEALING")
    task.wait()
    end
    A.state.phase = "waitingRange"
    local alreadyInRange = distToAnimal(animalData) <= (tonumber(A.radius) or 9)
    local fired = false
    while A.enabled and selectedStealMode == "Semi" do
    local elapsed = tick() - A.state.startTime
    if elapsed > (A.holdMax or 2.6) or not prompt.Parent then break end
    barSet(elapsed / (A.holdMax or 2.6), "WAITING RANGE")
    if distToAnimal(animalData) <= (tonumber(A.radius) or 9) then
    if not alreadyInRange then task.wait(A.entryDelay or 0.3) end
    if A.enabled and selectedStealMode == "Semi" then
    for _, fn in ipairs(data.triggerCallbacks) do task.spawn(function() pcall(fn) end) end
    pcall(function() if _G.AutoCarrySpeed and _G.AutoCarrySpeed.WatchPickup then _G.AutoCarrySpeed.WatchPickup(1.25) end end)
    fired = true
    end
    break
    end
    task.wait()
    end
    if fired then
    A.state.totalSteals = (A.state.totalSteals or 0) + 1
    A.state.lastResult = "Stole " .. label
    A.state.phase = "success"
    barSet(1, "SUCCESS")
    else
    A.state.failedSteals = (A.state.failedSteals or 0) + 1
    A.state.lastResult = "Missed window: " .. label
    A.state.phase = "failed"
    barSet(1, "FAILED")
    end
    A.state.active = false
    A.state.lastResultTime = tick()
    task.wait(A.cooldown or 0.05)
    data.ready = true
    task.delay(0.8, function()
    if not A.state.active then barReset() end
    end)
    end)
    return true
    end
    local function ensureScanThread()
    if A.scanThread then return end
    A.scanThread = task.spawn(function()
    while _G.RyzenSemiSteal do
    if A.enabled or selectedStealMode == "Semi" then
    if not A.syncReady then
    -- sync not ready yet: kick it (non-blocking) and retry shortly
    ensureSync()
    task.wait(0.5)
    else
    pcall(scanAllPlots)
    task.wait(5)
    end
    else
    task.wait(1)
    end
    end
    end)
    end
    _G.RyzenSemiAutoStealSetRadius = function(v)
    local n = tonumber(v)
    if n then A.radius = n end
    end
    _G.RyzenSemiAutoStealStop = function()
    A.enabled = false
    if A.conn then A.conn:Disconnect(); A.conn = nil end
    A.state.active = false
    A.state.phase = "idle"
    barReset()
    end
    _G.RyzenSemiAutoStealStart = function()
    A.radius = tonumber(autoStealRadius) or A.radius or 9
    A.enabled = true
    -- FIX: this used to block on ensureSync() (WaitForChild + InvokeServer
    -- round-trips per plot) and a synchronous scanAllPlots(), freezing the
    -- frame when switching to Semi. Sync now runs in the background and the
    -- scan thread picks the data up; the click returns instantly.
    ensureSync()
    ensureScanThread()
    if A.conn then A.conn:Disconnect(); A.conn = nil end
    A.conn = RunService.Heartbeat:Connect(function()
    if not A.enabled then return end
    if not A.syncReady then return end
    if selectedStealMode ~= "Semi" then _G.RyzenSemiAutoStealStop(); return end
    if A.state.active then return end
    local target = pickClosest()
    if not target then return end
    local prompt = A.promptCache[target.uid]
    if not prompt or not prompt.Parent then prompt = findPromptForAnimal(target) end
    if prompt then executeCandySemi(prompt, target) end
    end)
    end
    _G.RyzenSemiAutoStealSync = function()
    if selectedStealMode == "Semi" and autoStealEnabled then
    _G.RyzenSemiAutoStealStart()
    else
    _G.RyzenSemiAutoStealStop()
    end
    end
    end
    _G.__RyzenSetupSemiAutoSteal()
    _G.RyzenAutoStealSync = function()
    if not autoStealEnabled then
    if _G.RyzenNormalAutoStealStop then _G.RyzenNormalAutoStealStop() end
    if _G.RyzenV3AutoStealStop then _G.RyzenV3AutoStealStop() end
    if _G.RyzenSemiAutoStealStop then _G.RyzenSemiAutoStealStop() end
    return
    end
    if selectedStealMode == "__REMOVED_V2__" then
    if _G.RyzenV3AutoStealStop then _G.RyzenV3AutoStealStop() end
    if _G.RyzenSemiAutoStealStop then _G.RyzenSemiAutoStealStop() end
    if _G.RyzenNormalAutoStealSync then _G.RyzenNormalAutoStealSync() end
    elseif selectedStealMode == "Auto Steal" then
    if _G.RyzenNormalAutoStealStop then _G.RyzenNormalAutoStealStop() end
    if _G.RyzenSemiAutoStealStop then _G.RyzenSemiAutoStealStop() end
    if _G.RyzenV3AutoStealSync then _G.RyzenV3AutoStealSync() end
    elseif selectedStealMode == "Semi" then
    if _G.RyzenNormalAutoStealStop then _G.RyzenNormalAutoStealStop() end
    if _G.RyzenV3AutoStealStop then _G.RyzenV3AutoStealStop() end
    if _G.RyzenSemiAutoStealSync then _G.RyzenSemiAutoStealSync() end
    end
    end
    task.spawn(function()
    while task.wait(30) do
    do end
    end
    end)
    local lastMoveDir = Vector3.new(0, 0, 0)
    local function getCurrentSpeedValue()
    if currentSpeedMode == "Carry" then
    return CS
    elseif currentSpeedMode == "Lagger" then
    return LAGGER_SPEED
    elseif currentSpeedMode == "Lagger Carry" then
    return LAGGER_CARRY_SPEED
    end
    return NS
    end
    local refreshSpeedModeRows = nil
    -- Auto Carry drives setSpeedMode itself. Anything it calls is wrapped so
    -- we can tell an automatic mode change from one the player made.
    _ryzenAutoModeChange = false
    function _ryzenRunAutoModeChange(fn, ...)
    _ryzenAutoModeChange = true
    local ok, err = pcall(fn, ...)
    _ryzenAutoModeChange = false
    return ok, err
    end
    local function setSpeedMode(mode)
    if mode ~= "Normal" and mode ~= "Carry" and mode ~= "Lagger" and mode ~= "Lagger Carry" then
    mode = "Normal"
    end
    -- FIX: Auto Carry re-applied Carry every RenderStepped while you held a
    -- brainrot, so switching to Normal was reverted within a frame (and
    -- dropping it forced you back off Carry). A manual switch now takes
    -- ownership until the carry / steal session ends.
    if not _ryzenAutoModeChange then
    State = State or {}
    State._manualModeLock = true
    State._manualModeMark = tick()
    -- Also disown any Auto Carry session in flight. Otherwise it still holds
    -- an "_autoCarryReturnMode" snapshot and slams you back into it the
    -- moment the brainrot leaves your hands.
    State._autoCarryFromSteal = false
    State._autoCarryReturnMode = nil
    State._waitingForCarryPickup = false
    State._autoCarryGraceUntil = 0
    State._carryPickupWatchUntil = 0
    State.speedToggled = (mode == "Carry" or mode == "Lagger Carry")
    State.laggerEnabled = (mode == "Lagger" or mode == "Lagger Carry")
    if toggleRefs then
    if toggleRefs.carryMode then pcall(toggleRefs.carryMode, State.speedToggled) end
    if toggleRefs.laggerMode then pcall(toggleRefs.laggerMode, State.laggerEnabled) end
    end
    end
    currentSpeedMode = mode
    if refreshSpeedModeRows then
    refreshSpeedModeRows()
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    local function toggleCarryMode()
    if currentSpeedMode == "Normal" then
    setSpeedMode("Carry")
    elseif currentSpeedMode == "Carry" then
    setSpeedMode("Normal")
    elseif currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry" then
    setSpeedMode("Carry")
    else
    setSpeedMode("Normal")
    end
    end
    local function toggleLaggerMode()
    if currentSpeedMode == "Normal" or currentSpeedMode == "Carry" then
    setSpeedMode("Lagger")
    elseif currentSpeedMode == "Lagger" then
    setSpeedMode("Lagger Carry")
    elseif currentSpeedMode == "Lagger Carry" then
    setSpeedMode("Normal")
    else
    setSpeedMode("Normal")
    end
    end
    -- Published so every entry point (UI rows, keybinds, controller, mobile
    -- buttons) hits the same function instead of relying on the local being
    -- in scope at that point in the file.
    _G.RyzenSetSpeedMode = setSpeedMode
    _G.RyzenToggleCarryMode = toggleCarryMode
    _G.RyzenToggleLaggerMode = toggleLaggerMode
    _G.RyzenGetSpeedMode = function() return currentSpeedMode end
    State = State or {}
    State.normalSpeed = NS
    State.carrySpeed = CS
    State.laggerSpeed = LAGGER_SPEED
    State.speedToggled = (currentSpeedMode == "Carry" or currentSpeedMode == "Lagger Carry")
    State.laggerEnabled = (currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry")
    toggleRefs = toggleRefs or {}
    function setCarry(on)
    if on then
    setSpeedMode("Carry")
    else
    if currentSpeedMode == "Carry" or currentSpeedMode == "Lagger Carry" then
    setSpeedMode("Normal")
    end
    end
    State.speedToggled = on == true
    end
    function setLagger(on)
    if on then
    setSpeedMode("Lagger")
    else
    if currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry" then
    setSpeedMode("Normal")
    end
    end
    State.laggerEnabled = on == true
    end
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LP = Players.LocalPlayer
    State = State or {}
    State.normalSpeed = State.normalSpeed or 60
    State.carrySpeed = State.carrySpeed or 30
    State.laggerSpeed = State.laggerSpeed or 60
    State.speedToggled = State.speedToggled or false
    State.laggerEnabled = State.laggerEnabled or false
    State._autoCarryFromSteal = State._autoCarryFromSteal or false
    State._autoCarryGraceUntil = State._autoCarryGraceUntil or 0
    State._waitingForCarryPickup = State._waitingForCarryPickup or false
    State._carryPickupWatchUntil = State._carryPickupWatchUntil or 0
    State._autoCarryReturnMode = State._autoCarryReturnMode or nil
    toggleRefs = toggleRefs or {}
    local function safeSaveConfig()
    if type(saveRyzenConfig) == "function" then
    task.spawn(saveRyzenConfig)
    elseif type(saveConfig) == "function" then
    task.spawn(saveConfig)
    end
    end
    local function isCarryName(name)
    local n = tostring(name or ""):lower()
    return n:find("brainrot")
    or n:find("animal")
    or n:find("carry")
    or n:find("grab")
    or n:find("steal")
    or n:find("hold")
    end
    local function isIgnoredCarryTool(name)
    local n = tostring(name or ""):lower()
    return n:find("bat")
    or n:find("slap")
    or n:find("medusa")
    or n:find("head")
    or n:find("stone")
    end
    local function isCarryingBrainrot(char)
    if not char then return false end
    for _, name in ipairs({"Carrying", "IsCarrying", "Grabbed", "Holding", "StealHold", "HasGrab"}) do
    local v = char:FindFirstChild(name, true)
    if v then
    if v:IsA("BoolValue") and v.Value then
    return true
    end
    if v:IsA("ObjectValue") and v.Value then
    return true
    end
    if v:IsA("StringValue") and v.Value ~= "" then
    return true
    end
    end
    end
    for _, child in ipairs(char:GetChildren()) do
    if child:IsA("Model") and child:FindFirstChildWhichIsA("BasePart", true) then
    if child:FindFirstChildOfClass("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
    return true
    end
    if isCarryName(child.Name) then
    return true
    end
    elseif child:IsA("Tool") and not isIgnoredCarryTool(child.Name) then
    return true
    end
    end
    return false
    end
    local function setCarrySpeedMode(on)
    State.speedToggled = on
    if toggleRefs.carryMode then
    toggleRefs.carryMode(on)
    end
    if type(setCarry) == "function" then
    setCarry(on)
    end
    end
    local function setLaggerMode(on)
    State.laggerEnabled = on
    if toggleRefs.laggerMode then
    toggleRefs.laggerMode(on)
    end
    if type(setLagger) == "function" then
    setLagger(on)
    end
    end
    local function enableCarrySpeedForSteal()
    State._waitingForCarryPickup = false
    State._carryPickupWatchUntil = 0
    if not State._autoCarryFromSteal then
    State._autoCarryReturnMode = currentSpeedMode
    end
    State._autoCarryFromSteal = true
    State._autoCarryGraceUntil = tick() + 0.75
    local wasLagger = (State._autoCarryReturnMode == "Lagger" or State._autoCarryReturnMode == "Lagger Carry"
    or currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry")
    if wasLagger then
    State.laggerEnabled = true
    State.speedToggled = true
    if toggleRefs.laggerMode then toggleRefs.laggerMode(true) end
    if toggleRefs.carryMode then toggleRefs.carryMode(true) end
    setSpeedMode("Lagger Carry")
    else
    setLaggerMode(false)
    setCarrySpeedMode(true)
    end
    safeSaveConfig()
    end
    local function disableAutoCarrySpeed()
    if not State._autoCarryFromSteal and not State._waitingForCarryPickup then return end
    local wasAutoApplied = State._autoCarryFromSteal == true
    local returnMode = State._autoCarryReturnMode
    State._autoCarryFromSteal = false
    State._waitingForCarryPickup = false
    State._autoCarryGraceUntil = 0
    State._carryPickupWatchUntil = 0
    State._autoCarryReturnMode = nil
    if not wasAutoApplied then
    return
    end
    if returnMode == "Lagger" or returnMode == "Lagger Carry" then
    State.laggerEnabled = true
    State.speedToggled = false
    if toggleRefs.laggerMode then toggleRefs.laggerMode(true) end
    if toggleRefs.carryMode then toggleRefs.carryMode(false) end
    -- return to the exact lagger mode you were in (Lagger Carry stays Lagger Carry)
    setSpeedMode(returnMode == "Lagger Carry" and "Lagger Carry" or "Lagger")
    elseif returnMode == "Carry" then
    State.laggerEnabled = false
    State.speedToggled = true
    if toggleRefs.laggerMode then toggleRefs.laggerMode(false) end
    if toggleRefs.carryMode then toggleRefs.carryMode(true) end
    setSpeedMode("Carry")
    else
    setLaggerMode(false)
    setCarrySpeedMode(false)
    end
    safeSaveConfig()
    end
    local function startAutoCarryPickupWatch(seconds)
    if autoCarrySpeedEnabled ~= true then return end
    State._waitingForCarryPickup = true
    State._carryPickupWatchUntil = tick() + (seconds or 1.25)
    end
    local _stealAttrWasActive = false
    RunService.RenderStepped:Connect(function()
    if autoCarrySpeedEnabled ~= true then
    disableAutoCarrySpeed()
    return
    end
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not root then
    disableAutoCarrySpeed()
    _stealAttrWasActive = false
    return
    end
    local st = hum:GetState()
    local gotHit = st == Enum.HumanoidStateType.Physics
    or st == Enum.HumanoidStateType.Ragdoll
    or st == Enum.HumanoidStateType.FallingDown
    local stealingAttr = LP:GetAttribute("Stealing") == true
    local carryingBrainrot = isCarryingBrainrot(char)
    if stealingAttr and not _stealAttrWasActive then
    _stealAttrWasActive = true
    if not State._manualModeLock then _ryzenRunAutoModeChange(enableCarrySpeedForSteal) end
    elseif not stealingAttr then
    _stealAttrWasActive = false
    end
    if State._waitingForCarryPickup then
    if gotHit or tick() > (State._carryPickupWatchUntil or 0) then
    State._waitingForCarryPickup = false
    State._carryPickupWatchUntil = 0
    elseif carryingBrainrot then
    if not State._manualModeLock then _ryzenRunAutoModeChange(enableCarrySpeedForSteal) end
    end
    end
    -- FIX: when Auto Carry Speed is on and you are in a lagger mode, carrying a
    -- brainrot must switch you to the Lagger Carry speed (e.g. 15) even if Lagger
    -- was selected manually (the manual-mode lock used to block it, so it stayed
    -- on the Lagger speed, e.g. 29). Your chosen mode comes back after the drop.
    if carryingBrainrot and not State._autoCarryFromSteal then
    if (not State._manualModeLock)
    or currentSpeedMode == "Lagger"
    or currentSpeedMode == "Lagger Carry" then
    _ryzenRunAutoModeChange(enableCarrySpeedForSteal)
    end
    end
    if State._autoCarryFromSteal then
    local graceDone = tick() > (State._autoCarryGraceUntil or 0)
    if gotHit or (graceDone and not carryingBrainrot and not stealingAttr) then
    _ryzenRunAutoModeChange(disableAutoCarrySpeed)
    end
    end
    -- Hand control back to Auto Carry only once your hands are empty and
    -- you are not mid-steal. While you are still holding the brainrot your
    -- manual choice stands, no matter what this loop would prefer.
    if State._manualModeLock and not carryingBrainrot and not stealingAttr then
    State._manualModeLock = false
    end
    end)
    _G.AutoCarrySpeed = {
    IsCarryingBrainrot = isCarryingBrainrot,
    Enable = enableCarrySpeedForSteal,
    Disable = disableAutoCarrySpeed,
    WatchPickup = startAutoCarryPickupWatch,
    }
    _G.RyzenAutoCarryEnemyBase = _G.RyzenAutoCarryEnemyBase or {conn = nil, enabled = false}
    local function _ryzenIsMyPlot(plotName)
    local plots=workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot=plots:FindFirstChild(plotName)
    if not plot then return false end
    local sign=plot:FindFirstChild("PlotSign")
    if sign then
    local yb=sign:FindFirstChild("YourBase")
    if yb and yb:IsA("BillboardGui") then return yb.Enabled==true end
    end
    return false
    end
    local function _ryzenIsNearEnemyBase(range)
    range = tonumber(range) or autoCarryEnemyBaseRange or 35
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local myPos = hrp.Position
    for _, plot in ipairs(plots:GetChildren()) do
    if plot:IsA("Model") and not _ryzenIsMyPlot(plot.Name) then
    local pos
    local ok, pivot = pcall(function() return plot:GetPivot().Position end)
    if ok and pivot then pos = pivot
    else
    local sign = plot:FindFirstChild("PlotSign")
    if sign and sign:IsA("BasePart") then pos = sign.Position
    elseif sign then
    local pp = sign:FindFirstChildWhichIsA("BasePart", true)
    if pp then pos = pp.Position end
    end
    end
    if pos then
    local flat = Vector3.new(myPos.X - pos.X, 0, myPos.Z - pos.Z)
    if flat.Magnitude <= range then return true end
    end
    end
    end
    return false
    end
    local function _ryzenEnableCarryModeOnly()
    if currentSpeedMode == "Carry" then return end
    setSpeedMode("Carry")
    if toggleRefs and toggleRefs.carryMode then pcall(function() toggleRefs.carryMode(true) end) end
    if refreshSpeedModeRows then pcall(refreshSpeedModeRows) end
    end
    function _G.RyzenStartAutoCarryEnemyBase()
    local S = _G.RyzenAutoCarryEnemyBase
    if S.conn then return end
    local acc = 0
    S.conn = RunService.Heartbeat:Connect(function(dt)
    if not autoCarryEnemyBaseEnabled then return end
    acc = acc + (dt or 0.016)
    if acc < 0.2 then return end
    acc = 0
    if not _ryzenIsNearEnemyBase(autoCarryEnemyBaseRange) then
    -- Left the base. Release the manual lock only if the player is also not
    -- carrying anything - the RenderStepped loop owns that case.
    local _c = LP.Character
    if State._manualModeLock and _c and not isCarryingBrainrot(_c)
    and LP:GetAttribute("Stealing") ~= true then
    State._manualModeLock = false
    end
    return
    end
    if currentSpeedMode == "Carry" then return end
    if State._manualModeLock then return end
    _ryzenRunAutoModeChange(_ryzenEnableCarryModeOnly)
    end)
    end
    function _G.RyzenStopAutoCarryEnemyBase()
    local S = _G.RyzenAutoCarryEnemyBase
    if S.conn then pcall(function() S.conn:Disconnect() end); S.conn = nil end
    end
    function _G.RyzenSetAutoCarryEnemyBase(on)
    autoCarryEnemyBaseEnabled = on and true or false
    if autoCarryEnemyBaseEnabled then _G.RyzenStartAutoCarryEnemyBase() else _G.RyzenStopAutoCarryEnemyBase() end
    if setAutoCarryEnemyBaseVisual then pcall(function() setAutoCarryEnemyBaseVisual(autoCarryEnemyBaseEnabled) end) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    _G.RyzenAutoPathState = _G.RyzenAutoPathState or {leftConn=nil,rightConn=nil,leftPhase=1,rightPhase=1}
    _G.RyzenAutoPathPoints = _G.RyzenAutoPathPoints or {
    L1=Vector3.new(-476.48,-6.28,92.73), L2=Vector3.new(-483.12,-4.95,94.80), LFace=Vector3.new(-482.25,-4.96,92.09),
    R1=Vector3.new(-476.16,-6.52,25.62), R2=Vector3.new(-483.06,-5.03,25.48), RFace=Vector3.new(-482.06,-6.93,35.47),
    }
    -- Auto left/right (and the auto path engine) now move at the speed that is
    -- typed for the currently selected mode: Normal box, Carry box, Lagger box or
    -- Lagger Carry box. Previously it was hard-coded to _G.RyzenAutoMoveSpeed = 60,
    -- so typing e.g. 55 (or 29/15 for lagger) was ignored.
    function _G.RyzenAutoMoveActiveSpeed()
    -- FIX (user request): Auto Left / Auto Right always travel at the NORMAL
    -- speed. The speed mode (Carry / Lagger / Lagger Carry) no longer changes
    -- the auto path speed - only the Normal Speed setting drives it.
    return tonumber(NS) or 60
    end
    function _G.RyzenAutoMoveCarryPhaseSpeed()
    if currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry" then
    return tonumber(LAGGER_CARRY_SPEED) or 15
    end
    return tonumber(CS) or 30
    end
    function _G.RyzenAutoPathSpeed()
    return _G.RyzenAutoMoveActiveSpeed()
    end
    function _G.RyzenStopAutoLeft()
    local S=_G.RyzenAutoPathState
    if S.leftConn then S.leftConn:Disconnect(); S.leftConn=nil end
    S.leftPhase=1
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    if hum then hum:Move(Vector3.zero,false) end
    if hrp then hrp.AssemblyLinearVelocity=Vector3.new(0,hrp.AssemblyLinearVelocity.Y,0) end
    end
    function _G.RyzenStopAutoRight()
    local S=_G.RyzenAutoPathState
    if S.rightConn then S.rightConn:Disconnect(); S.rightConn=nil end
    S.rightPhase=1
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    if hum then hum:Move(Vector3.zero,false) end
    if hrp then hrp.AssemblyLinearVelocity=Vector3.new(0,hrp.AssemblyLinearVelocity.Y,0) end
    end
    function _G.RyzenSetAutoLeft(on, skipSave)
    if on and _G.RyzenSafeModeTryStart and not _G.RyzenSafeModeTryStart() then
    autoLeftEnabled = false
    if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(false) end
    if not skipSave then do end end
    return false
    end
    autoLeftEnabled = on and true or false
    if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(autoLeftEnabled) end
    if autoLeftEnabled then
    autoRightEnabled=false
    if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(false) end
    if _G.RyzenStopAutoRight then _G.RyzenStopAutoRight() end
    if _G.RyzenStartAutoLeft then _G.RyzenStartAutoLeft() end
    else
    if _G.RyzenStopAutoLeft then _G.RyzenStopAutoLeft() end
    end
    if not skipSave then do end end
    end
    function _G.RyzenSetAutoRight(on, skipSave)
    if on and _G.RyzenSafeModeTryStart and not _G.RyzenSafeModeTryStart() then
    autoRightEnabled = false
    if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(false) end
    if not skipSave then do end end
    return false
    end
    autoRightEnabled = on and true or false
    if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(autoRightEnabled) end
    if autoRightEnabled then
    autoLeftEnabled=false
    if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(false) end
    if _G.RyzenStopAutoLeft then _G.RyzenStopAutoLeft() end
    if _G.RyzenStartAutoRight then _G.RyzenStartAutoRight() end
    else
    if _G.RyzenStopAutoRight then _G.RyzenStopAutoRight() end
    end
    if not skipSave then do end end
    end


    _G.RyzenZombieMove = _G.RyzenZombieMove or {
        leftConn = nil,
        rightConn = nil,
        leftPhase = 1,
        rightPhase = 1,
        attachment = nil,
        linearVelocity = nil,
    }

    _G.RyzenAutoMoveSpeed = tonumber(_G.RyzenAutoMoveSpeed) or 60
    _G.RyzenAutoMoveCarrySpeed = tonumber(_G.RyzenAutoMoveCarrySpeed) or 30
    _G.RyzenDuelMode = (_G.RyzenDuelMode == "full") and "full" or "half"

    _G.RyzenZombieMovePoints = _G.RyzenZombieMovePoints or {
        L1 = Vector3.new(-476.48, -6.28, 92.73),
        L2 = Vector3.new(-483.12, -4.95, 94.80),
        LFace = Vector3.new(-482.25, -4.96, 92.09),

        R1 = Vector3.new(-476.16, -6.52, 25.62),
        R2 = Vector3.new(-483.06, -5.03, 25.48),
        RFace = Vector3.new(-482.06, -6.93, 35.47),

        FullLeft = {
            Vector3.new(-474.0, -7.3, 90.2),
            Vector3.new(-484.9, -5.1, 97.2),
            Vector3.new(-473.6, -7.3, 93.5),
            Vector3.new(-473.0, -7.3, 27.6),
            Vector3.new(-487.2, -5.3, 20.9),
        },

        FullRight = {
            Vector3.new(-472.5, -7.3, 30.9),
            Vector3.new(-483.8, -5.4, 25.5),
            Vector3.new(-472.4, -7.3, 30.5),
            Vector3.new(-472.0, -7.3, 93.6),
            Vector3.new(-482.8, -5.4, 97.8),
        }
    }

    function _G.RyzenZombieEnsureLinearVelocity(hrp)
        local S = _G.RyzenZombieMove

        if S.linearVelocity and S.linearVelocity.Parent and S.attachment and S.attachment.Parent == hrp then
            return S.linearVelocity
        end

        if S.linearVelocity then
            pcall(function() S.linearVelocity:Destroy() end)
        end
        if S.attachment then
            pcall(function() S.attachment:Destroy() end)
        end

        local att = Instance.new("Attachment")
        att.Name = "RyzenZombieMoveAttachment"
        att.Parent = hrp

        local lv = Instance.new("LinearVelocity")
        lv.Name = "RyzenZombieMoveVelocity"
        lv.Attachment0 = att
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.ForceLimitMode = Enum.ForceLimitMode.PerAxis
        lv.MaxAxesForce = Vector3.new(math.huge, 0, math.huge)
        lv.VectorVelocity = Vector3.zero
        lv.Parent = att

        S.attachment = att
        S.linearVelocity = lv
        return lv
    end

    function _G.RyzenZombieStopVelocity()
        local S = _G.RyzenZombieMove
        if S.linearVelocity and S.linearVelocity.Parent then
            S.linearVelocity.VectorVelocity = Vector3.zero
            S.linearVelocity.MaxAxesForce = Vector3.zero
            S.linearVelocity.Enabled = false
        end
    end

    function _G.RyzenStopAutoLeft()
        local S = _G.RyzenZombieMove
        if S.leftConn then
            S.leftConn:Disconnect()
            S.leftConn = nil
        end
        S.leftPhase = 1

        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
        _G.RyzenZombieStopVelocity()

        if _G.RyzenSetAutoLeftVisual then
            pcall(function() _G.RyzenSetAutoLeftVisual(false) end)
        end
    end

    function _G.RyzenStopAutoRight()
        local S = _G.RyzenZombieMove
        if S.rightConn then
            S.rightConn:Disconnect()
            S.rightConn = nil
        end
        S.rightPhase = 1

        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
        _G.RyzenZombieStopVelocity()

        if _G.RyzenSetAutoRightVisual then
            pcall(function() _G.RyzenSetAutoRightVisual(false) end)
        end
    end

    function _G.RyzenZombieMoveIsFull()
        return (_G.RyzenDuelMode == "full")
            or (_G.RyzenDuelMode == "Full")
            or (typeof(State) == "table" and State.duelMode == "full")
    end

    function _G.RyzenStartAutoLeft()
        if autoRightEnabled then
            autoRightEnabled = false
            _G.RyzenStopAutoRight()
        end

        local S = _G.RyzenZombieMove
        if S.leftConn then S.leftConn:Disconnect() end
        S.leftPhase = 1

        S.leftConn = RunService.Heartbeat:Connect(function()
            if not autoLeftEnabled then return end
            if dropBrainrotActive then return end

            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            local st = hum:GetState()
            if hum.PlatformStand
                or st == Enum.HumanoidStateType.Physics
                or st == Enum.HumanoidStateType.Ragdoll
                or st == Enum.HumanoidStateType.FallingDown then
                hum:Move(Vector3.zero, false)
                _G.RyzenZombieStopVelocity()
                return
            end

            local lv = _G.RyzenZombieEnsureLinearVelocity(hrp)
            lv.Enabled = true
            lv.MaxAxesForce = Vector3.new(math.huge, 0, math.huge)
            local P = _G.RyzenZombieMovePoints
            local spd = _G.RyzenAutoMoveActiveSpeed()

            if _G.RyzenZombieMoveIsFull() then
                local points = P.FullLeft
                if S.leftPhase > #points then
                    _G.RyzenZombieStopVelocity()
                    local prev = points[#points - 1] or points[#points]
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(prev.X, hrp.Position.Y, prev.Z))
                    hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                    hum:Move(Vector3.zero, false)
                    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
                    autoLeftEnabled = false
                    if S.leftConn then S.leftConn:Disconnect(); S.leftConn = nil end
                    S.leftPhase = 1
                    if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(false) end
                    return
                end

                local tgt = points[S.leftPhase]
                local flat = Vector3.new(tgt.X, hrp.Position.Y, tgt.Z)
                if (flat - hrp.Position).Magnitude < 1 then
                    S.leftPhase += 1
                    return
                end

                local dir = (flat - hrp.Position).Unit
                -- FIX: whole trip runs at the normal speed - the carry-phase
                -- (carry speed) no longer affects Auto Left.
                local fspd = _G.RyzenAutoMoveActiveSpeed()

                lv.VectorVelocity = Vector3.new(dir.X * fspd, 0, dir.Z * fspd)
            else
                if S.leftPhase == 1 then
                    local tgt = Vector3.new(P.L1.X, hrp.Position.Y, P.L1.Z)
                    if (tgt - hrp.Position).Magnitude < 1 then
                        S.leftPhase = 2
                        return
                    end

                    local d = P.L1 - hrp.Position
                    local mv = Vector3.new(d.X, 0, d.Z).Unit
                    lv.VectorVelocity = Vector3.new(mv.X * spd, 0, mv.Z * spd)
                else
                    local tgt = Vector3.new(P.L2.X, hrp.Position.Y, P.L2.Z)
                    if (tgt - hrp.Position).Magnitude < 1 then
                        hum:Move(Vector3.zero, false)
                        _G.RyzenZombieStopVelocity()
                        hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                        hum:Move(Vector3.zero, false)
                        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
                        autoLeftEnabled = false
                        if S.leftConn then S.leftConn:Disconnect(); S.leftConn = nil end
                        S.leftPhase = 1
                        if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(false) end
                        if P.LFace and (P.LFace - hrp.Position).Magnitude > 0.01 then
                            hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(P.LFace.X, hrp.Position.Y, P.LFace.Z))
                        end
                        return
                    end

                    local d = P.L2 - hrp.Position
                    local mv = Vector3.new(d.X, 0, d.Z).Unit
                    lv.VectorVelocity = Vector3.new(mv.X * spd, 0, mv.Z * spd)
                end
            end
        end)
    end

    function _G.RyzenStartAutoRight()
        if autoLeftEnabled then
            autoLeftEnabled = false
            _G.RyzenStopAutoLeft()
        end

        local S = _G.RyzenZombieMove
        if S.rightConn then S.rightConn:Disconnect() end
        S.rightPhase = 1

        S.rightConn = RunService.Heartbeat:Connect(function()
            if not autoRightEnabled then return end
            if dropBrainrotActive then return end

            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            local st = hum:GetState()
            if hum.PlatformStand
                or st == Enum.HumanoidStateType.Physics
                or st == Enum.HumanoidStateType.Ragdoll
                or st == Enum.HumanoidStateType.FallingDown then
                hum:Move(Vector3.zero, false)
                _G.RyzenZombieStopVelocity()
                return
            end

            local lv = _G.RyzenZombieEnsureLinearVelocity(hrp)
            lv.Enabled = true
            lv.MaxAxesForce = Vector3.new(math.huge, 0, math.huge)
            local P = _G.RyzenZombieMovePoints
            local spd = _G.RyzenAutoMoveActiveSpeed()

            if _G.RyzenZombieMoveIsFull() then
                local points = P.FullRight
                if S.rightPhase > #points then
                    _G.RyzenZombieStopVelocity()
                    local prev = points[#points - 1] or points[#points]
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(prev.X, hrp.Position.Y, prev.Z))
                    hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                    hum:Move(Vector3.zero, false)
                    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
                    autoRightEnabled = false
                    if S.rightConn then S.rightConn:Disconnect(); S.rightConn = nil end
                    S.rightPhase = 1
                    if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(false) end
                    return
                end

                local tgt = points[S.rightPhase]
                local flat = Vector3.new(tgt.X, hrp.Position.Y, tgt.Z)
                if (flat - hrp.Position).Magnitude < 1 then
                    S.rightPhase += 1
                    return
                end

                local dir = (flat - hrp.Position).Unit
                -- FIX: whole trip runs at the normal speed - the carry-phase
                -- (carry speed) no longer affects Auto Right.
                local fspd = _G.RyzenAutoMoveActiveSpeed()

                lv.VectorVelocity = Vector3.new(dir.X * fspd, 0, dir.Z * fspd)
            else
                if S.rightPhase == 1 then
                    local tgt = Vector3.new(P.R1.X, hrp.Position.Y, P.R1.Z)
                    if (tgt - hrp.Position).Magnitude < 1 then
                        S.rightPhase = 2
                        return
                    end

                    local d = P.R1 - hrp.Position
                    local mv = Vector3.new(d.X, 0, d.Z).Unit
                    lv.VectorVelocity = Vector3.new(mv.X * spd, 0, mv.Z * spd)
                else
                    local tgt = Vector3.new(P.R2.X, hrp.Position.Y, P.R2.Z)
                    if (tgt - hrp.Position).Magnitude < 1 then
                        hum:Move(Vector3.zero, false)
                        _G.RyzenZombieStopVelocity()
                        hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                        hum:Move(Vector3.zero, false)
                        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
                        autoRightEnabled = false
                        if S.rightConn then S.rightConn:Disconnect(); S.rightConn = nil end
                        S.rightPhase = 1
                        if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(false) end
                        if P.RFace and (P.RFace - hrp.Position).Magnitude > 0.01 then
                            hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(P.RFace.X, hrp.Position.Y, P.RFace.Z))
                        end
                        return
                    end

                    local d = P.R2 - hrp.Position
                    local mv = Vector3.new(d.X, 0, d.Z).Unit
                    lv.VectorVelocity = Vector3.new(mv.X * spd, 0, mv.Z * spd)
                end
            end
        end)
    end


    function _G.RyzenSetAutoLeft(on, skipSave)
        autoLeftEnabled = on == true
        if autoLeftEnabled then
            autoRightEnabled = false
            _G.RyzenStopAutoRight()
            _G.RyzenStartAutoLeft()
        else
            _G.RyzenStopAutoLeft()
        end
        if _G.RyzenSetAutoLeftVisual then _G.RyzenSetAutoLeftVisual(autoLeftEnabled) end
    end

    function _G.RyzenSetAutoRight(on, skipSave)
        autoRightEnabled = on == true
        if autoRightEnabled then
            autoLeftEnabled = false
            _G.RyzenStopAutoLeft()
            _G.RyzenStartAutoRight()
        else
            _G.RyzenStopAutoRight()
        end
        if _G.RyzenSetAutoRightVisual then _G.RyzenSetAutoRightVisual(autoRightEnabled) end
    end


    LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if autoLeftEnabled and _G.RyzenStartAutoLeft then _G.RyzenStartAutoLeft() end
    if autoRightEnabled and _G.RyzenStartAutoRight then _G.RyzenStartAutoRight() end
    end)
    local overheadGui = nil
    local overheadSpeedLabel = nil

    -- Speed numbers follow the Ryzen Hub theme, exactly like the ESP highlight does
    -- (which reads _G.RyzenThemeColors[_G.RyzenThemeName]). applyThemeColor()
    -- calls _G.RyzenApplySpeedThemeColor() so the colour changes the instant a
    -- new theme is picked, on your number and on everyone else's.
    function _G.RyzenSpeedThemeTint()
    local t = _G.RyzenThemeColors and _G.RyzenThemeName and _G.RyzenThemeColors[_G.RyzenThemeName]
    return t or THEME_ACCENT or Color3.fromRGB(255, 255, 255)
    end

    function _G.RyzenApplySpeedThemeColor()
    local tint = _G.RyzenSpeedThemeTint()
    pcall(function()
    if overheadSpeedLabel and overheadSpeedLabel.Parent then
    overheadSpeedLabel.TextColor3 = tint
    end
    end)
    -- your 3 2 1 GO counter
    pcall(function()
    if ragdollCountdownLabel and ragdollCountdownLabel.Parent then
    ragdollCountdownLabel.TextColor3 = tint
    end
    end)
    pcall(function()
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local head = plr.Character:FindFirstChild("Head")
    if head then
    local bb = head:FindFirstChild("RyzenSpeedBB_Other")
    local lbl = bb and bb:FindFirstChild("SpeedLabel")
    if lbl then lbl.TextColor3 = tint end
    -- their 3 2 1 GO counter
    local rbb = head:FindFirstChild("RyzenRagdollTimer_Other")
    local rlbl = rbb and rbb:FindFirstChild("Count")
    if rlbl then rlbl.TextColor3 = tint end
    end
    end
    end
    end)
    end
    local function setupOverheadInfo(char)
    if overheadGui then
    pcall(function() overheadGui:Destroy() end)
    overheadGui = nil
    overheadSpeedLabel = nil
    end
    if not char then return end
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
    if not head then return end
    -- ===== overhead billboard styled EXACTLY like Ryzenx =====
    -- 220x100 board sitting 4.2 studs up, FredokaOne, TextScaled, hard black
    -- stroke, and Ryzenx's three-row split: ragdoll timer 40% on top, discord
    -- 26% at y=0.38, speed 36% at y=0.64.
    overheadGui = Instance.new("BillboardGui")
    overheadGui.Name = "RyzenDuelsOverheadInfo"
    overheadGui.Size = UDim2.new(0, 220, 0, 100)
    overheadGui.StudsOffset = Vector3.new(0, 4.2, 0)
    overheadGui.AlwaysOnTop = true
    overheadGui.LightInfluence = 0
    overheadGui.Parent = head

    ragdollCountdownLabel = Instance.new("TextLabel")
    ragdollCountdownLabel.Name = "RagdollCountdown"
    ragdollCountdownLabel.Size = UDim2.new(1, 0, 0.40, 0)
    ragdollCountdownLabel.Position = UDim2.new(0, 0, 0, 0)
    ragdollCountdownLabel.BackgroundTransparency = 1
    ragdollCountdownLabel.Text = ""
    ragdollCountdownLabel.TextColor3 = _G.RyzenSpeedThemeTint()
    ragdollCountdownLabel.Font = Enum.Font.FredokaOne
    ragdollCountdownLabel.TextScaled = true
    ragdollCountdownLabel.TextStrokeTransparency = 0
    ragdollCountdownLabel.Visible = false
    ragdollCountdownLabel.ZIndex = 10
    ragdollCountdownLabel.Parent = overheadGui

    local discordLbl = Instance.new("TextLabel")
    discordLbl.Name = "Discord"
    discordLbl.Size = UDim2.new(1, 0, 0.26, 0)
    discordLbl.Position = UDim2.new(0, 0, 0.38, 0)
    discordLbl.BackgroundTransparency = 1
    discordLbl.Text = ""
    discordLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordLbl.Font = Enum.Font.FredokaOne
    discordLbl.TextScaled = true
    discordLbl.TextStrokeTransparency = 0
    discordLbl.ZIndex = 10
    discordLbl.Parent = overheadGui

    overheadSpeedLabel = Instance.new("TextLabel")
    overheadSpeedLabel.Name = "SpeedValue"
    overheadSpeedLabel.Size = UDim2.new(1, 0, 0.36, 0)
    overheadSpeedLabel.Position = UDim2.new(0, 0, 0.64, 0)
    overheadSpeedLabel.BackgroundTransparency = 1
    overheadSpeedLabel.Text = ""
    overheadSpeedLabel.TextColor3 = _G.RyzenSpeedThemeTint()
    overheadSpeedLabel.Font = Enum.Font.FredokaOne
    overheadSpeedLabel.TextScaled = true
    overheadSpeedLabel.TextStrokeTransparency = 0
    overheadSpeedLabel.ZIndex = 10
    overheadSpeedLabel.Parent = overheadGui
    end
    -- =====================================================================
    -- RAGDOLL TIMER - Ryzenx "3 2 1 GO" countdown (ported)
    -- Replaces Ryzen's "GET UP: 2.4s" text. Whole seconds counting down,
    -- then GO for 0.7s, then it hides. Same triggers Ryzenx uses:
    -- StateChanged (bat ragdoll, 3s) and PlatformStand (stone/medusa, 4s).
    -- =====================================================================
    local ragdollTimerConn = nil
    local ragdollTriggerConns = {}
    activeBatBillboard = nil
    activeMedusaBillboard = nil
    _skipRagdollFromTP = _skipRagdollFromTP or 0

    function stopRagdollCountdown()
    if ragdollTimerConn then pcall(function() ragdollTimerConn:Disconnect() end); ragdollTimerConn = nil end
    for _, c in ipairs(ragdollTriggerConns) do pcall(function() c:Disconnect() end) end
    ragdollTriggerConns = {}
    activeBatBillboard = nil
    activeMedusaBillboard = nil
    if ragdollCountdownLabel then
    ragdollCountdownLabel.Visible = false
    ragdollCountdownLabel.Text = ""
    end
    end

    function createRagdollTimer(duration, labelText)
    if not ragdollCountdownEnabled then return nil end
    local timerLbl = ragdollCountdownLabel
    if (not timerLbl) or (not timerLbl.Parent) then
    pcall(function() setupOverheadInfo(LP.Character) end)
    timerLbl = ragdollCountdownLabel
    end
    if not timerLbl then return nil end
    if ragdollTimerConn then pcall(function() ragdollTimerConn:Disconnect() end); ragdollTimerConn = nil end
    duration = duration or 3
    -- 3 2 1 GO countdown: whole seconds, then "GO"
    timerLbl.TextColor3 = _G.RyzenSpeedThemeTint()
    timerLbl.Text = tostring(math.max(1, math.ceil(duration)))
    timerLbl.Visible = true
    local startTime = tick()
    ragdollTimerConn = RunService.Heartbeat:Connect(function()
    local remaining = duration - (tick() - startTime)
    if remaining <= 0 then
    if ragdollTimerConn then ragdollTimerConn:Disconnect(); ragdollTimerConn = nil end
    if timerLbl and timerLbl.Parent then
    timerLbl.Text = "GO"
    task.delay(0.7, function()
    if timerLbl and timerLbl.Parent then timerLbl.Text = ""; timerLbl.Visible = false end
    end)
    end
    elseif timerLbl and timerLbl.Parent then
    local secs = math.ceil(remaining - 0.001)
    if secs < 1 then secs = 1 end
    timerLbl.Text = tostring(secs)
    end
    end)
    return timerLbl
    end

    function hookRagdollCountdown(char)
    stopRagdollCountdown()
    if not ragdollCountdownEnabled then return end
    char = char or LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 4)
    if not hum then return end

    table.insert(ragdollTriggerConns, hum.StateChanged:Connect(function(old, new)
    if not ragdollCountdownEnabled then return end
    if tick() < (_skipRagdollFromTP or 0) then return end
    local isRag = (new == Enum.HumanoidStateType.Physics
    or new == Enum.HumanoidStateType.Ragdoll
    or new == Enum.HumanoidStateType.FallingDown)
    if isRag and not hum.PlatformStand and not activeBatBillboard then
    activeBatBillboard = createRagdollTimer(3, "RAGDOLL")
    task.delay(3.9, function() activeBatBillboard = nil end)
    end
    end))

    table.insert(ragdollTriggerConns, hum:GetPropertyChangedSignal("PlatformStand"):Connect(function()
    if not ragdollCountdownEnabled then return end
    if tick() < (_skipRagdollFromTP or 0) then return end
    if hum.PlatformStand and not activeMedusaBillboard then
    activeMedusaBillboard = createRagdollTimer(4, "STONE")
    task.delay(4.9, function() activeMedusaBillboard = nil end)
    end
    end))
    end
    if LP.Character then
    task.spawn(function()
    setupOverheadInfo(LP.Character)
    task.wait(0.05)
    if ragdollCountdownEnabled then hookRagdollCountdown(LP.Character) end
    end)
    end
    LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    setupOverheadInfo(char)
    if ragdollCountdownEnabled then hookRagdollCountdown(char) end
    end)

    -- =====================================================================
    -- OTHER PLAYERS: Ryzenx ragdoll timer + Ryzenx speed tag (both ported)
    -- Ragdoll: same 3 2 1 GO countdown over every other player's head, fired
    -- by StateChanged AND PlatformStand (the fake ragdoll most bats use never
    -- changes HumanoidStateType, so StateChanged alone misses it).
    -- Speed: Ryzenx's boxed tag - dark rounded panel, accent stroke, player
    -- name on top, live "%.1f" speed underneath with the shimmer gradient.
    -- =====================================================================
    otherRagdollConns = otherRagdollConns or {}
    local otherSpeedUpdateConn = nil
    local otherRagdollHooked = {}

    -- ---------------- ragdoll timer over other players ----------------
    function getOtherRagdollLabel(plr)
    local char = plr and plr.Character
    local head = char and char:FindFirstChild("Head")
    if not head then return nil end
    local bb = head:FindFirstChild("RyzenRagdollTimer_Other")
    if not bb then
    bb = Instance.new("BillboardGui")
    bb.Name = "RyzenRagdollTimer_Other"
    bb.Size = UDim2.new(0, 110, 0, 40)
    bb.StudsOffset = Vector3.new(0, 3.6, 0)
    bb.AlwaysOnTop = true
    bb.Enabled = false
    bb.Parent = head
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Count"
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = ""
    lbl.TextColor3 = _G.RyzenSpeedThemeTint()
    lbl.Font = Enum.Font.FredokaOne
    lbl.TextScaled = true
    lbl.TextStrokeTransparency = 0
    lbl.ZIndex = 5
    lbl.Visible = false
    lbl.Parent = bb
    end
    return bb, bb:FindFirstChild("Count")
    end

    function startOtherRagdollCountdown(plr, duration)
    if not ragdollCountdownEnabled then return end
    local bb, lbl = getOtherRagdollLabel(plr)
    if not lbl then return end
    duration = duration or 3
    local key = tostring(plr.UserId)
    if otherRagdollConns[key] then
    pcall(function() otherRagdollConns[key]:Disconnect() end)
    otherRagdollConns[key] = nil
    end
    lbl.TextColor3 = _G.RyzenSpeedThemeTint()
    lbl.Text = tostring(math.max(1, math.ceil(duration)))
    lbl.Visible = true
    if bb then bb.Enabled = true end
    local startTime = tick()
    otherRagdollConns[key] = RunService.Heartbeat:Connect(function()
    if not (lbl and lbl.Parent) then
    if otherRagdollConns[key] then otherRagdollConns[key]:Disconnect(); otherRagdollConns[key] = nil end
    return
    end
    local remaining = duration - (tick() - startTime)
    if remaining <= 0 then
    if otherRagdollConns[key] then otherRagdollConns[key]:Disconnect(); otherRagdollConns[key] = nil end
    lbl.Text = "GO"
    task.delay(0.7, function()
    if lbl and lbl.Parent then lbl.Text = ""; lbl.Visible = false end
    if bb and bb.Parent then bb.Enabled = false end
    end)
    else
    local secs = math.ceil(remaining - 0.001)
    if secs < 1 then secs = 1 end
    lbl.Text = tostring(secs)
    end
    end)
    end

    function hookOtherPlayerRagdoll(plr)
    if not plr or plr == LP then return end
    if otherRagdollHooked[plr] then return end
    otherRagdollHooked[plr] = true
    local function hookChar(char)
    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
    if not hum then return end
    hum.StateChanged:Connect(function(old, new)
    if not ragdollCountdownEnabled then return end
    local isRag = (new == Enum.HumanoidStateType.Physics
    or new == Enum.HumanoidStateType.Ragdoll
    or new == Enum.HumanoidStateType.FallingDown)
    if isRag then startOtherRagdollCountdown(plr, 3) end
    end)
    hum:GetPropertyChangedSignal("PlatformStand"):Connect(function()
    if ragdollCountdownEnabled and hum.PlatformStand then
    startOtherRagdollCountdown(plr, 3)
    end
    end)
    end
    plr.CharacterAdded:Connect(hookChar)
    if plr.Character then hookChar(plr.Character) end
    end

    -- ---------------- Ryzenx-style speed tag over other players ----------------
    function setupOtherSpeedIndicator(char, plr)
    if not char or plr == LP then return end
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
    if not head then return end
    local old = head:FindFirstChild("RyzenSpeedBB_Other")
    if old then old:Destroy() end

    local bb = Instance.new("BillboardGui")
    bb.Name = "RyzenSpeedBB_Other"
    bb.Size = UDim2.new(0, 220, 0, 34)
    bb.StudsOffset = Vector3.new(0, 4.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = head

    -- no ESP box, no player name: just the speed number, plain white,
    -- same look as your own overhead speed
    local spdLabel = Instance.new("TextLabel", bb)
    spdLabel.Name = "SpeedLabel"
    spdLabel.Size = UDim2.new(1, 0, 1, 0)
    spdLabel.Position = UDim2.new(0, 0, 0, 0)
    spdLabel.BackgroundTransparency = 1
    spdLabel.Text = ""
    spdLabel.TextColor3 = _G.RyzenSpeedThemeTint()
    spdLabel.Font = Enum.Font.FredokaOne
    spdLabel.TextScaled = true
    spdLabel.TextStrokeTransparency = 0
    spdLabel.ZIndex = 2
    return bb
    end

    function updateOtherPlayerSpeeds()
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    local head = plr.Character:FindFirstChild("Head")
    if hrp and head then
    local bb = head:FindFirstChild("RyzenSpeedBB_Other")
    if not bb then
    setupOtherSpeedIndicator(plr.Character, plr)
    bb = head:FindFirstChild("RyzenSpeedBB_Other")
    end
    if bb then
    local spdLabel = bb:FindFirstChild("SpeedLabel")
    if spdLabel then
    -- same reading Ryzenx uses
    local speed = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z).Magnitude
    spdLabel.Text = string.format("%.1f", speed)
    local tint = _G.RyzenSpeedThemeTint()
    if spdLabel.TextColor3 ~= tint then spdLabel.TextColor3 = tint end
    end
    end
    end
    end
    end
    end

    function stopOtherPlayerSpeedUpdates()
    if otherSpeedUpdateConn then pcall(function() otherSpeedUpdateConn:Disconnect() end); otherSpeedUpdateConn = nil end
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local head = plr.Character:FindFirstChild("Head")
    if head then
    local bb = head:FindFirstChild("RyzenSpeedBB_Other")
    if bb then bb:Destroy() end
    end
    end
    end
    end

    function startOtherPlayerSpeedUpdates()
    if otherSpeedUpdateConn then return end
    otherSpeedUpdateConn = RunService.Heartbeat:Connect(updateOtherPlayerSpeeds)
    end

    -- ---------------- wiring (kept under the old Ryzen names) ----------------
    function _G.RyzenStopAllPlayerRagdoll()
    for key, c in pairs(otherRagdollConns) do
    pcall(function() c:Disconnect() end)
    otherRagdollConns[key] = nil
    end
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP and plr.Character then
    local head = plr.Character:FindFirstChild("Head")
    local bb = head and head:FindFirstChild("RyzenRagdollTimer_Other")
    if bb then pcall(function() bb:Destroy() end) end
    end
    end
    end

    function _G.RyzenStartAllPlayerRagdoll()
    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then hookOtherPlayerRagdoll(plr) end
    end
    end

    Players.PlayerAdded:Connect(function(plr)
    if plr == LP then return end
    hookOtherPlayerRagdoll(plr)
    plr.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    setupOtherSpeedIndicator(char, plr)
    end)
    if plr.Character then
    task.defer(function() setupOtherSpeedIndicator(plr.Character, plr) end)
    end
    end)

    Players.PlayerRemoving:Connect(function(plr)
    local key = tostring(plr.UserId)
    if otherRagdollConns[key] then
    pcall(function() otherRagdollConns[key]:Disconnect() end)
    otherRagdollConns[key] = nil
    end
    otherRagdollHooked[plr] = nil
    end)

    for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then
    plr.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    setupOtherSpeedIndicator(char, plr)
    end)
    end
    end

    task.defer(function()
    task.wait(1)
    pcall(_G.RyzenStartAllPlayerRagdoll)
    pcall(startOtherPlayerSpeedUpdates)
    end)

    -- =====================================================================
    -- TP BAT (ported from M10RU standalone / Ryzen Ryzen Hub)
    -- Every Heartbeat: lock onto the closest player, teleport to them
    -- (with a PhysicsRepRootPart spoof where the executor supports it), face
    -- the camera at them and swing the Bat (tool:Activate + its RemoteEvent)
    -- with a small hit cooldown.
    -- =====================================================================
    _G.RyzenTPBatEnabled = _G.RyzenTPBatEnabled or false
    _G.RyzenTPBatMode = (_G.RyzenTPBatMode == "V2") and "V2" or "Classic"
    local _tpBatConn = nil
    local _tpBatHittingCD = false
    local _tpBatV2Conn = nil
    local _tpBatV2LastStep = 0
    local _tpBatV2LastTarget = nil
    local _tpBatV2TargetLockUntil = 0
    local _tpBatV2Generation = 0

    local function _tpBatGetClosestPlayer()
        local char = LP.Character
        if not char then return nil end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local closest, dist = nil, math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local tr = p.Character:FindFirstChild("HumanoidRootPart")
                if tr then
                    local d = (hrp.Position - tr.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = p
                    end
                end
            end
        end
        return closest, dist
    end

    local function _tpBatGetBat()
        local char = LP.Character
        if not char then return nil end
        local tool = char:FindFirstChild("Bat")
        if tool then return tool end
        local bp = LP:FindFirstChild("Backpack")
        if bp then
            tool = bp:FindFirstChild("Bat")
            if tool then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(tool) end) end
                return tool
            end
        end
        return nil
    end

    local function _tpBatTryHit()
        if _tpBatHittingCD then return end
        _tpBatHittingCD = true
        pcall(function()
            local bat = _tpBatGetBat()
            if bat then
                bat:Activate()
                local ev = bat:FindFirstChildWhichIsA("RemoteEvent")
                if ev then ev:FireServer() end
            end
        end)
        task.delay(0.08, function() _tpBatHittingCD = false end)
    end

    local function _tpBatStart()
        if _tpBatConn then return end
        _G.RyzenTPBatEnabled = true
        _tpBatConn = RunService.Heartbeat:Connect(function()
            if not _G.RyzenTPBatEnabled then return end
            if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
                _G.RyzenSetTPBat(false)
                return
            end
            local char = LP.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local target = _tpBatGetClosestPlayer()
            if target and target.Character then
                local tr = target.Character:FindFirstChild("HumanoidRootPart")
                if tr then
                    if sethiddenproperty then
                        pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", tr) end)
                    end
                    local targetPos = tr.Position + Vector3.new(0, 0.9, 0)
                    if (hrp.Position - targetPos).Magnitude > 8 then
                        hrp.CFrame = CFrame.new(targetPos)
                    end
                    local cam = workspace.CurrentCamera
                    if cam then
                        cam.CFrame = CFrame.new(cam.CFrame.Position, tr.Position)
                    end
                    _tpBatTryHit()
                end
            end
        end)
    end

    local function _tpBatStop()
        if _tpBatConn then _tpBatConn:Disconnect(); _tpBatConn = nil end
        _G.RyzenTPBatEnabled = false
    end

    local function _tpBatV2Stop()
        _tpBatV2Generation = _tpBatV2Generation + 1
        if _tpBatV2Conn then
            pcall(function() _tpBatV2Conn:Disconnect() end)
            _tpBatV2Conn = nil
        end
        _tpBatV2LastStep = 0
        _tpBatV2LastTarget = nil
        _tpBatV2TargetLockUntil = 0
    end

    local function _tpBatV2GetTarget(root, now)
        local locked = _tpBatV2LastTarget
        local lockedRoot = locked and locked.Character and locked.Character:FindFirstChild("HumanoidRootPart")
        local lockedHumanoid = locked and locked.Character and locked.Character:FindFirstChildOfClass("Humanoid")
        if lockedRoot and lockedHumanoid and lockedHumanoid.Health > 0 and now < _tpBatV2TargetLockUntil then
            return locked, lockedRoot
        end

        local target, targetRoot, targetHumanoid
        local closestDistance = math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and player.Character then
                local candidateRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local candidateHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if candidateRoot and candidateHumanoid and candidateHumanoid.Health > 0 then
                    local distance = (root.Position - candidateRoot.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        target = player
                        targetRoot = candidateRoot
                        targetHumanoid = candidateHumanoid
                    end
                end
            end
        end
        if not target or not targetRoot or not targetHumanoid then
            _tpBatV2LastTarget = nil
            _tpBatV2TargetLockUntil = 0
            return nil, nil
        end

        _tpBatV2LastTarget = target
        _tpBatV2TargetLockUntil = now + 0.45
        return target, targetRoot
    end

    local function _tpBatV2Start()
        if _tpBatV2Conn then return end
        _tpBatV2Generation = _tpBatV2Generation + 1
        local generation = _tpBatV2Generation
        _G.RyzenTPBatEnabled = true
        _tpBatV2Conn = RunService.Heartbeat:Connect(function()
            if generation ~= _tpBatV2Generation or not _G.RyzenTPBatEnabled or _G.RyzenTPBatMode ~= "V2" then
                _tpBatV2Stop()
                return
            end
            if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
                _G.RyzenSetTPBat(false)
                return
            end

            local now = tick()
            -- V2 follows the classic heartbeat cadence. The hit routine still
            -- owns its cooldown, so responsiveness does not create a swing loop.
            if now - _tpBatV2LastStep < 0.016 then return end
            _tpBatV2LastStep = now

            local char = LP.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if not root or not humanoid or humanoid.Health <= 0 then
                _tpBatV2LastTarget = nil
                return
            end

            -- Reacquire every step like V1, while retaining V2's health checks.
            -- This prevents a stale lock from following a respawned character.
            _tpBatV2LastTarget = nil
            _tpBatV2TargetLockUntil = 0
            local target, targetRoot = _tpBatV2GetTarget(root, now)
            if not targetRoot then
                _tpBatV2LastTarget = nil
                return
            end

            local targetHumanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if not targetHumanoid or targetHumanoid.Health <= 0 then
                _tpBatV2LastTarget = nil
                return
            end

            local targetPosition = targetRoot.Position + Vector3.new(0, 0.9, 0)
            local distance = (root.Position - targetPosition).Magnitude
            if distance > 7 then
                local _, yaw = root.CFrame:ToEulerAnglesYXZ()
                pcall(function()
                    root.CFrame = CFrame.new(targetPosition) * CFrame.Angles(0, yaw, 0)
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end)
            else
                -- Clear residual movement when already inside the hit range so
                -- V2 does not drift away between consecutive swings.
                pcall(function()
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end)
            end

            local camera = Workspace.CurrentCamera
            if camera then
                pcall(function()
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
                end)
            end
            _tpBatTryHit()
        end)
    end

    function _G.RyzenSetTPBat(on)
        local want = on == true
        if want then
            if _G.RyzenTPBatMode == "V2" then
                _tpBatStop()
                _tpBatV2Start()
            else
                _tpBatV2Stop()
                _tpBatStart()
            end
        else
            _tpBatStop()
            _tpBatV2Stop()
        end
        if _G.RyzenTPBatSetVisual then pcall(_G.RyzenTPBatSetVisual, _G.RyzenTPBatEnabled) end
    end

    function _G.RyzenSetTPBatMode(mode)
        _G.RyzenTPBatMode = (mode == "V2") and "V2" or "Classic"
        if _G.RyzenTPBatEnabled then
            _G.RyzenSetTPBat(true)
        end
        if saveRyzenConfig then pcall(saveRyzenConfig) end
        if _G.RyzenRefreshTPBatMode then pcall(_G.RyzenRefreshTPBatMode) end
    end

    function _G.RyzenToggleTPBat()
        _G.RyzenSetTPBat(not (_G.RyzenTPBatEnabled == true))
    end

    function _G.RyzenTPBatIsOn()
        return _G.RyzenTPBatEnabled == true
    end


    -- =====================================================================
    -- E01 NOTIFIER (from "Anti E01 (Notifier)")
    -- When you start carrying a brainrot a small rounded black banner shows
    -- "DONT ENTER" with a white outline that stays for the whole 3-second
    -- countdown while a white bar fills along the bottom. When the bar
    -- completes its progress the banner flips to white with a dark "ENTER"
    -- and a green subtext, holds 3 seconds, then fades out.
    local _e01WasCarrying = false
    local _e01CurrentGui = nil
    local function _e01ThemeTint()
        return (_G.RyzenThemeColors and _G.RyzenThemeName and _G.RyzenThemeColors[_G.RyzenThemeName])
            or Color3.fromRGB(255, 255, 255)
    end

    local function _e01ThemeTextColor(tint)
        local luminance = tint.R * 0.299 + tint.G * 0.587 + tint.B * 0.114
        return luminance > 0.58 and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(255, 255, 255)
    end

    function _G.RyzenRefreshDontEnterTheme()
        local gui = _e01CurrentGui
        if not gui or not gui.Parent then return end
        local tint = _e01ThemeTint()
        local textColor = _e01ThemeTextColor(tint)
        local bar = gui:FindFirstChild("DontEnterBar", true)
        if bar then
            bar.BackgroundColor3 = tint:Lerp(Color3.fromRGB(0, 0, 0), 0.82)
            local label = bar:FindFirstChildOfClass("TextLabel")
            if label then label.TextColor3 = textColor end
        end
        for _, outline in ipairs(gui:GetDescendants()) do
            if outline.Name == "DontEnterOutline" then
                outline.BackgroundColor3 = tint
            end
        end
    end

    local function _e01IsCarrying()
        local char = LP.Character
        if not char then return false end
        for _, child in pairs(char:GetChildren()) do
            local name = child.Name:lower()
            if name:find("brainrot") or name:find("brain") or name:find("animal")
                or name:find("carry") or name:find("stolen") or name:find("held")
                or name:find("steal") then
                return true
            end
        end
        for attrName, attrValue in pairs(char:GetAttributes()) do
            local name = attrName:lower()
            if (name:find("carrying") or name:find("carry") or name:find("stealing")
                or name:find("isstealing") or name:find("hasbrainrot")) and attrValue == true then
                return true
            end
        end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed > 0 and humanoid.WalkSpeed <= 25 and humanoid.WalkSpeed ~= 16 then
            return true
        end
        return false
    end

    local function _e01ShowWarning()
        -- kill any previous banner first
        if _e01CurrentGui then
            pcall(function() _e01CurrentGui:Destroy() end)
            _e01CurrentGui = nil
        end
        local playerGui = LP:FindFirstChildOfClass("PlayerGui")
        if not playerGui then return end

        -- DontEnter pill. The outline is one white pill revealed by four clip
        -- windows, so EVERY side (straight or rounded) renders identically:
        -- the top line grows -> the right cap sweeps down -> the bottom line
        -- grows back -> the left cap sweeps up and closes the loop, all in
        -- exactly 3 seconds. Plain Frames only (no CanvasGroup anywhere -
        -- ClipsDescendants does not work inside CanvasGroups). The pill pops
        -- up when it appears and pops out when it leaves.
        local W, H = 260, 38 -- the pill
        local THICK = 2      -- outline band thickness
        local PAD = 3        -- root margin
        local RW, RH = W + 2 * PAD, H + 2 * PAD

        local gui = Instance.new("ScreenGui")
        gui.Name = "DontEnterGui"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.DisplayOrder = 50
        gui.Parent = playerGui
        _e01CurrentGui = gui

        local root = Instance.new("Frame")
        root.Name = "DontEnterRoot"
        root.AnchorPoint = Vector2.new(0.5, 0)
        root.Position = UDim2.new(0.5, 0, 0, 12)
        root.Size = UDim2.new(0, RW, 0, RH)
        root.BackgroundTransparency = 1
        root.Parent = gui

        local uiScale = Instance.new("UIScale") -- pop on completion
        uiScale.Scale = 1
        uiScale.Parent = root

        -- ===== THE OUTLINE RING (revealed by clip windows) =====
        local ring = Instance.new("Frame")
        ring.Name = "Ring"
        ring.Size = UDim2.new(0, RW, 0, RH)
        ring.BackgroundTransparency = 1
        ring.ZIndex = 1
        ring.Parent = root

        local pr = H / 2               -- cap radius
        local L1 = W - H               -- straight top/bottom length
        local LA = math.pi * pr        -- half-circle cap length
        local PER = 2 * L1 + 2 * LA    -- full perimeter

        -- a clip window holding a copy of the white pill (root-absolute).
        -- IMPORTANT: the white copy is anchored to the edge of the window
        -- that stays FIXED while the window grows, so it never slides when
        -- the window resizes (bottom grows leftward, left grows upward).
        local function newWindow(px, py, ax, ay, wa, wpos)
            local win = Instance.new("Frame")
            win.AnchorPoint = Vector2.new(ax, ay)
            win.Position = UDim2.new(0, px, 0, py)
            win.Size = UDim2.new(0, 0, 0, 0)
            win.BackgroundTransparency = 1
            win.ClipsDescendants = true
            win.Parent = ring
            local white = Instance.new("Frame")
            white.Name = "DontEnterOutline"
            white.AnchorPoint = wa
            white.Position = wpos
            white.Size = UDim2.fromOffset(W + 2 * THICK, H + 2 * THICK)
            white.BackgroundColor3 = _e01ThemeTint()
            white.BorderSizePixel = 0
            white.Parent = win
            Instance.new("UICorner", white).CornerRadius = UDim.new(1, 0)
            return win, white
        end

        local winTop, wTop = newWindow(PAD + pr, 0, 0, 0, Vector2.new(0, 0), UDim2.new(0, -pr - THICK, 0, PAD - THICK)) -- grows rightward
        local winRight, wRight = newWindow(PAD + W - pr, 0, 0, 0, Vector2.new(0, 0), UDim2.new(0, pr - W - THICK, 0, PAD - THICK)) -- grows downward
        local winBottom, wBottom = newWindow(PAD + W - pr, PAD + H, 1, 0, Vector2.new(1, 0), UDim2.new(1, pr + THICK, 0, -H - THICK)) -- grows leftward
        local winLeft, wLeft = newWindow(0, RH, 0, 1, Vector2.new(0, 1), UDim2.new(0, PAD - THICK, 1, THICK - PAD)) -- grows upward
        local CAPW = RW - (PAD + W - pr) -- right window width
        local LEFTW = PAD + pr           -- left window width
        local whites = {wTop, wRight, wBottom, wLeft}

        -- ===== THE PILL (renders above the ring and masks its inside) =====
        local bar = Instance.new("Frame")
        bar.Name = "DontEnterBar"
        bar.AnchorPoint = Vector2.new(0.5, 0.5)
        bar.Position = UDim2.new(0.5, 0, 0.5, 0)
        bar.Size = UDim2.fromOffset(0, 0) -- starts at 0: it pops up
        bar.BackgroundColor3 = _e01ThemeTint():Lerp(Color3.fromRGB(0, 0, 0), 0.82)
        bar.BorderSizePixel = 0
        bar.ZIndex = 2
        bar.Parent = root

        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.fromScale(1, 1)
        label.Font = Enum.Font.GothamBold
        label.Text = "DONT ENTER"
        label.TextColor3 = _e01ThemeTextColor(_e01ThemeTint())
        label.TextSize = 15
        label.TextTransparency = 1 -- hidden until the pop-up finishes
        label.ZIndex = 2
        label.Parent = bar

        local hit = Instance.new("TextButton")
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.fromScale(1, 1)
        hit.Text = ""
        hit.AutoButtonColor = false
        hit.ZIndex = 3
        hit.Parent = bar

        local function press(down)
            TweenService:Create(bar, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = down and UDim2.fromOffset(W - 4, H - 2) or UDim2.fromOffset(W, H),
            }):Play()
        end

        hit.MouseButton1Down:Connect(function() press(true) end)
        hit.MouseButton1Up:Connect(function() press(false) end)
        hit.MouseLeave:Connect(function() press(false) end)
        hit.Activated:Connect(function()
            print("[DontEnter] pressed")
        end)

        -- ===== POP-UP ENTRANCE =====
        TweenService:Create(bar, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(W, H),
        }):Play()
        task.delay(0.18, function()
            if bar.Parent then
                TweenService:Create(label, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
            end
        end)

        -- ===== COUNTDOWN: the outline draws around the pill over 3.00s =====
        local duration = 3.0
        local startTime = tick() + 0.25 -- let the pop finish first
        local finished = false
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if finished or not root.Parent then
                if conn then conn:Disconnect() end
                return
            end
            local elapsed = math.max(0, tick() - startTime)
            local remaining = math.max(0, duration - elapsed)
            local progress = 1 - (remaining / duration)
            local s1 = progress * PER -- how far round the outline has reached
            -- top: the window grows rightward
            local g1 = math.floor(math.clamp(s1, 0, L1) + 0.5)
            winTop.Size = UDim2.new(0, g1, 0, PAD + 1)
            -- right cap: the window sweeps down
            local f2 = math.clamp((s1 - L1) / LA, 0, 1)
            winRight.Size = UDim2.new(0, CAPW, 0, math.floor(f2 * RH + 0.5))
            -- bottom: the window grows leftward
            local g3 = math.floor(math.clamp(s1 - L1 - LA, 0, L1) + 0.5)
            winBottom.Size = UDim2.new(0, g3, 0, PAD + 1)
            -- left cap: the window sweeps up and closes the loop
            local f4 = math.clamp((s1 - 2 * L1 - LA) / LA, 0, 1)
            local g4 = math.floor(f4 * RH + 0.5)
            winLeft.Size = UDim2.new(0, LEFTW, 0, g4)
            if remaining <= 0 and elapsed > 0 then
                finished = true
                if conn then conn:Disconnect() end
                -- the loop is complete: flip to the safe state
                label.Text = "ENTER"
                local tint = _e01ThemeTint()
                label.TextColor3 = _e01ThemeTextColor(tint)
                local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(bar, ti, {BackgroundColor3 = tint}):Play()
                for _, wh in pairs(whites) do
                    TweenService:Create(wh, ti, {BackgroundTransparency = 1}):Play()
                end
                -- little pop when it completes
                TweenService:Create(uiScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.05}):Play()
                task.delay(0.15, function()
                    TweenService:Create(uiScale, TweenInfo.new(0.12), {Scale = 1}):Play()
                end)
                -- hold the safe state, then pop OUT and disable
                task.delay(3, function()
                    if _e01CurrentGui ~= gui then return end
                    TweenService:Create(bar, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = UDim2.fromOffset(0, 0),
                    }):Play()
                    local fo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    TweenService:Create(bar, fo, {BackgroundTransparency = 1}):Play()
                    TweenService:Create(label, fo, {TextTransparency = 1}):Play()
                    task.delay(0.3, function()
                        if _e01CurrentGui == gui then
                            _e01CurrentGui = nil
                            pcall(function() gui:Destroy() end)
                        end
                    end)
                end)
            end
        end)
    end
    -- automatic detection (rising edge: not carrying -> carrying)
    task.spawn(function()
        while true do
            task.wait(0.1)
            local ok, carrying = pcall(_e01IsCarrying)
            if ok then
                if (not _e01WasCarrying) and carrying then
                    _e01ShowWarning()
                end
                _e01WasCarrying = carrying
            end
        end
    end)


    -- =====================================================================
    -- SPEED ENGINE - Ryzen Ryzen Hub movement core (ported)
    -- How it works: every Heartbeat the engine reads the Humanoid's move
    -- direction and pushes the root toward the exact target velocity with a
    -- mass-scaled ApplyImpulse (impulse = (target - current) * mass * gain).
    -- The gain ryzens to the ground (slope normal + grounded / air) so the
    -- set studs/sec is actually reached, and an active brake kills residual
    -- horizontal velocity when you stop so you don't skate on slopes.
    --
    -- Wired into Ryzen: speed comes from getCurrentSpeedValue() so Normal /
    -- Carry / Lagger / Lagger Carry all still work, and the same gates are
    -- respected (ragdoll, aimbot, auto-left / auto-right).
    -- =====================================================================
    local _pepSpeedActive = false
    local _pepLastGroundNormalY = 1

    local function _pepSampleGround(hrp)
        -- pcall only returns ONE value from the fn; pack results in a table
        local ok, res = pcall(function()
            local origin = hrp.Position + Vector3.new(0, 2, 0)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            local char = hrp.Parent
            if char then params.FilterDescendantsInstances = {char} end
            params.IgnoreWater = true
            local hit = workspace:Raycast(origin, Vector3.new(0, -8, 0), params)
            if hit and hit.Normal then
                return {ny = hit.Normal.Y, grounded = (hit.Distance < 4.2)}
            end
            return {ny = 1, grounded = false}
        end)
        if ok and type(res) == "table" and type(res.ny) == "number" then
            _pepLastGroundNormalY = res.ny
            return res.ny, res.grounded == true
        end
        return _pepLastGroundNormalY, false
    end

    local function _pepSetSpeedConstraint(hrp, horizVel)
        if not hrp or not hrp.Parent then return end
        local hx, hz = horizVel.X, horizVel.Z
        local mag = math.sqrt(hx * hx + hz * hz)
        _pepSpeedActive = mag > 0.05
        if mag < 0.05 then return end
        pcall(function()
            local ny, grounded = _pepSampleGround(hrp)
            local v = hrp.AssemblyLinearVelocity
            local mass = hrp.AssemblyMass
            if not mass or mass ~= mass or mass <= 0 then mass = 1 end

            local gain = 0.85
            if grounded then
                if ny < 0.55 then
                    gain = 0.45
                elseif ny < 0.78 then
                    gain = 0.62
                else
                    gain = 0.9
                end
            else
                gain = 0.7
            end

            local target = Vector3.new(hx, v.Y, hz)
            hrp:ApplyImpulse((target - v) * mass * gain)
        end)
    end

    -- Hard-stop residual horizontal velocity when grounded & not intending to move
    local function _pepBrakeHorizontal(hrp)
        if not hrp or not hrp.Parent then return end
        pcall(function()
            local ny, grounded = _pepSampleGround(hrp)
            if not grounded then return end
            local v = hrp.AssemblyLinearVelocity
            local hx, hz = v.X, v.Z
            local hMag = math.sqrt(hx * hx + hz * hz)
            if hMag < 0.8 then
                if hMag > 0.05 then
                    hrp.AssemblyLinearVelocity = Vector3.new(0, v.Y, 0)
                end
                return
            end
            local mass = hrp.AssemblyMass
            if not mass or mass ~= mass or mass <= 0 then mass = 1 end
            local target = Vector3.new(0, v.Y, 0)
            hrp:ApplyImpulse((target - v) * mass * 0.92)
        end)
    end

    -- Impulse speed loop (Pepsi: mass-scaled ApplyImpulse every frame)
    RunService.Heartbeat:Connect(function()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        -- ragdolled: never fight the physics
        local state = hum:GetState()
        if hum.PlatformStand
        or state == Enum.HumanoidStateType.Physics
        or state == Enum.HumanoidStateType.Ragdoll
        or state == Enum.HumanoidStateType.FallingDown then
            lastMoveDir = Vector3.new(0, 0, 0)
            _pepSpeedActive = false
            _pepBrakeHorizontal(hrp)
            _G.RyzenCommandedSpeed = nil
            return
        end

        -- these features own movement while they run
        local aimbotActive = _G.RyzenNormalAimbotOn == true
        or _G.RyzenAntiBypassAimbotOn == true
        if autoLeftEnabled or autoRightEnabled or aimbotActive then
            lastMoveDir = Vector3.new(0, 0, 0)
            _pepSpeedActive = false
            _pepBrakeHorizontal(hrp)
            _G.RyzenCommandedSpeed = nil
            return
        end

        local spd = getCurrentSpeedValue()
        local md = hum.MoveDirection
        if md.Magnitude > 0.05 then
            lastMoveDir = Vector3.new(md.X, 0, md.Z).Unit
            _pepSpeedActive = true
            pcall(function()
                if hrp.SetNetworkOwner then hrp:SetNetworkOwner(LP) end
            end)
            _pepSetSpeedConstraint(hrp, lastMoveDir * spd)
            _G.RyzenCommandedSpeed = spd
        else
            lastMoveDir = Vector3.new(0, 0, 0)
            _pepSpeedActive = false
            _pepBrakeHorizontal(hrp)
            _G.RyzenCommandedSpeed = nil
        end
    end)

    -- =============================================================
    -- ANTI-FLING SHIELD (donor: Irsh anti-die "ANTI-FLING SHIELD") -
    -- ALWAYS ON and invisible: no toggle, no config entry, no
    -- notifications, nothing in the UI. Heartbeat watchdog: if the root
    -- is suddenly moving faster than a fling (and faster than any speed
    -- the Ryzen Hub itself is commanding), the horizontal velocity is zeroed
    -- (Y is kept so falls/jumps still feel normal - donor behavior) and
    -- any spin is killed. The threshold scales with the commanded speed
    -- (speed engine / Auto L+R / aimbot / WalkSpeed) so it NEVER fights
    -- the Ryzen Hub's own movement, and a spike must persist 3 frames so
    -- single-frame physics transients are ignored.
    -- =============================================================
    do
    local _flingTrips = 0
    RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then
    _flingTrips = 0
    return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    -- highest speed the Ryzen Hub could legitimately be commanding right now
    local expected = tonumber(_G.RyzenCommandedSpeed) or 0
    local autoMove = (autoLeftEnabled == true) or (autoRightEnabled == true)
    or (_G.RyzenNormalAimbotOn == true) or (_G.RyzenAntiBypassAimbotOn == true)
    if autoMove then
    local ns = tonumber(NS) or 60
    if expected < ns then expected = ns end
    end
    local ws = (hum and tonumber(hum.WalkSpeed)) or 16
    if expected < ws then expected = ws end
    local threshold = math.max(80, expected * 1.5 + 40)
    local v = root.AssemblyLinearVelocity
    if v.Magnitude > threshold then
    _flingTrips = _flingTrips + 1
    if _flingTrips >= 3 then
    root.AssemblyLinearVelocity = Vector3.new(0, v.Y, 0)
    root.AssemblyAngularVelocity = Vector3.zero
    end
    else
    _flingTrips = 0
    end
    end)
    end

    -- =============================================================
    -- SPEED COUNTER - Ryzen Ryzen Hub logic (ported)
    -- Pepsi shows the ACTIVE SET SPEED while you are moving and the engine
    -- is driving ("60.0", "30.0", ...) and "0.0" when idle or when another
    -- feature (aimbot / auto path) owns your movement. It never samples the
    -- part, so the number always reads exactly what you configured.
    -- =============================================================
    local _spdNextRebuild = 0
    local _spdCurrent = 0
    RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then
    if overheadSpeedLabel and overheadSpeedLabel.Parent then overheadSpeedLabel.Text = "" end
    return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    -- self-heal: rebuild the billboard if the label got destroyed / reparented
    if (not overheadSpeedLabel) or (not overheadSpeedLabel.Parent) then
    local now = os.clock()
    if now >= _spdNextRebuild then
    _spdNextRebuild = now + 1
    pcall(function() setupOverheadInfo(char) end)
    end
    if not overheadSpeedLabel then return end
    end

    local aimbotActive = _G.RyzenNormalAimbotOn == true
    or _G.RyzenAntiBypassAimbotOn == true
    local controlled = not aimbotActive and not autoLeftEnabled and not autoRightEnabled
    local moving = controlled and (hum.MoveDirection.Magnitude > 0.05)
    -- Auto Left / Right own the movement for the whole trip: show the speed
    -- the auto path is actually travelling at - the NORMAL speed (the trip
    -- always runs at NS regardless of speed mode).
    if autoLeftEnabled or autoRightEnabled then
    _spdCurrent = tonumber(NS) or 60
    elseif moving or _pepSpeedActive then
    _spdCurrent = getCurrentSpeedValue()
    else
    _spdCurrent = 0
    end
    overheadSpeedLabel.Text = string.format("%.1f", _spdCurrent)
    local tint = _G.RyzenSpeedThemeTint()
    if overheadSpeedLabel.TextColor3 ~= tint then overheadSpeedLabel.TextColor3 = tint end
    end)

    -- expose the live value in case other modules want it
    function _G.RyzenGetRealSpeed()
    return _spdCurrent or 0
    end

    local COLORS = {
    bg = Color3.fromRGB(0, 0, 0),
    row = Color3.fromRGB(6, 6, 9),
    row2 = Color3.fromRGB(8, 8, 12),
    stroke = Color3.fromRGB(90, 90, 105),
    strokeSoft = Color3.fromRGB(60, 60, 72),
    white = Color3.fromRGB(255, 255, 255),
    textDim = Color3.fromRGB(180, 180, 190),
    toggleBg = Color3.fromRGB(18, 18, 26),
    knob = Color3.fromRGB(238, 238, 245),
    }
    function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
    end
    function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Color = color or COLORS.stroke
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.35
    s.Parent = parent
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 160, 185)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
    })
    g.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.55),
    NumberSequenceKeypoint.new(0.5, 0.1),
    NumberSequenceKeypoint.new(1, 0.55),
    })
    g.Parent = s
    return s
    end
    function tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end

    function _G.RyzenAddMovingEdgeLight(btn)
    if not btn or not btn:IsA("GuiButton") then return end
    if btn.Name ~= "ArrowButton" then return end
    if btn:FindFirstChild("RyzenMovingEdge") then return end

    local edge = Instance.new("UIStroke")
    edge.Name = "RyzenMovingEdge"
    edge.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    edge.Color = Color3.fromRGB(255,255,255)
    edge.Thickness = 1.35
    edge.Transparency = 0.24
    edge.LineJoinMode = Enum.LineJoinMode.Round
    edge.Parent = btn

    local grad = Instance.new("UIGradient")
    grad.Name = "MovingLight"
    grad.Rotation = 0
    grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(95,95,95)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(125,125,125)),
    ColorSequenceKeypoint.new(0.46, Color3.fromRGB(235,235,235)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.54, Color3.fromRGB(235,235,235)),
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(125,125,125)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(95,95,95))
    })
    grad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.00, 0.90),
    NumberSequenceKeypoint.new(0.37, 0.82),
    NumberSequenceKeypoint.new(0.45, 0.28),
    NumberSequenceKeypoint.new(0.50, 0.00),
    NumberSequenceKeypoint.new(0.55, 0.28),
    NumberSequenceKeypoint.new(0.63, 0.82),
    NumberSequenceKeypoint.new(1.00, 0.90)
    })
    grad.Parent = edge

    local info = TweenInfo.new(1.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0)
    pcall(function()
    TweenService:Create(grad, info, {Rotation = 360}):Play()
    end)
    end

    function _G.RyzenApplyMovingEdgeLights(root)
    root = root or PlayerGui
    if not root then return end

    for _, obj in ipairs(root:GetDescendants()) do
    if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Name == "ArrowButton" then
    pcall(function() _G.RyzenAddMovingEdgeLight(obj) end)
    end
    end

    root.DescendantAdded:Connect(function(obj)
    if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Name == "ArrowButton" then
    task.defer(function()
    task.wait()
    pcall(function() _G.RyzenAddMovingEdgeLight(obj) end)
    end)
    end
    end)
    end

    function makeDraggable(frame)
    local dragging = false
    local dragStart
    local startPos
    local dragInput
    frame.InputBegan:Connect(function(input)
    if _G.RyzenGuiLocked == true then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    dragging = true
    dragStart = input.Position
    startPos = frame.Position
    input.Changed:Connect(function()
    if input.UserInputState == Enum.UserInputState.End then
    dragging = false
    end
    end)
    end
    end)
    frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
    dragInput = input
    end
    end)
    UserInputService.InputChanged:Connect(function(input)
    if _G.RyzenGuiLocked == true then return end
    if input == dragInput and dragging then
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
    startPos.X.Scale,
    startPos.X.Offset + delta.X,
    startPos.Y.Scale,
    startPos.Y.Offset + delta.Y
    )
    end
    end)
    end
    -- FIX: destroy any Ryzen Hub left over from a previous execution. Stale copies
    -- of the pill selector / toggle rows used to survive re-execution and
    -- fight the fresh UI (e.g. the mode outline snapping back, rows flipping).
    do
        local function killOldHubs(parent)
            if not parent then return end
            for _, v in ipairs(parent:GetChildren()) do
                if v:IsA("ScreenGui") and v.Name == "RyzenHubPolished" then
                    pcall(function() v:Destroy() end)
                end
            end
        end
        local parents = {}
        pcall(function()
            if typeof(gethui) == "function" then table.insert(parents, gethui()) end
        end)
        pcall(function() table.insert(parents, game:GetService("CoreGui")) end)
        pcall(function() table.insert(parents, PlayerGui) end)
        for _, p in ipairs(parents) do killOldHubs(p) end
    end
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "RyzenHubPolished"
    Gui.ResetOnSpawn = false
    Gui.IgnoreGuiInset = true
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.DisplayOrder = 1001 -- above mobile buttons/toasts (1000) so tab clicks always land
    safeParentGui(Gui)
    local FULL_MAIN_SIZE = UDim2.new(0, 340, 0, 520)
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.AnchorPoint = Vector2.new(0, 0.5)
    Main.Size = FULL_MAIN_SIZE
    Main.Position = tableToUDim2(savedMainPositionTable, UDim2.new(0, 20, 0.5, 0))
    savedMainPositionTable = udim2ToTable(Main.Position)
    Main.BackgroundColor3 = COLORS.bg
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.ClipsDescendants = false
    Main.Parent = Gui
    corner(Main, 14)
    stroke(Main, COLORS.stroke, 1.1, 0.35)
    makeDraggable(Main)
    Main:GetPropertyChangedSignal("Position"):Connect(function()
    savedMainPositionTable = udim2ToTable(Main.Position)
    end)

    -- FIX: a saved position (or a small phone screen) could leave the hub fully
    -- off-screen, so the script "ran" with no window visible. Clamp on screen
    -- and scale it down to fit small viewports.
    local RXZ_BASE_W, RXZ_BASE_H = 340, 520
    local function _rxzFitMainToScreen()
        local cam = workspace.CurrentCamera
        local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
        if vp.X < 50 or vp.Y < 50 then return end
        local scale = math.min((vp.X - 20) / RXZ_BASE_W, (vp.Y - 20) / RXZ_BASE_H, 1)
        scale = math.clamp(scale, 0.55, 1)
        local uiScale = Main:FindFirstChild("RxzMainScale")
        if not uiScale then
            uiScale = Instance.new("UIScale")
            uiScale.Name = "RxzMainScale"
            uiScale.Parent = Main
        end
        uiScale.Scale = scale
        local w, h = RXZ_BASE_W * scale, RXZ_BASE_H * scale
        local absX = Main.Position.X.Scale * vp.X + Main.Position.X.Offset
        local absY = Main.Position.Y.Scale * vp.Y + Main.Position.Y.Offset
        local maxX = math.max(8, vp.X - w - 8)
        local minY = h / 2 + 8
        local maxY = math.max(minY, vp.Y - h / 2 - 8)
        local nx = math.clamp(absX, 8, maxX)
        local ny = math.clamp(absY, minY, maxY)
        if math.abs(nx - absX) > 0.5 or math.abs(ny - absY) > 0.5 then
            Main.Position = UDim2.new(0, nx, 0, ny)
        end
    end
    _G.RxzFitMainToScreen = _rxzFitMainToScreen
    pcall(_rxzFitMainToScreen)
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then
            cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                pcall(_rxzFitMainToScreen)
            end)
        end
    end)
    -- RYZEN wordmark builder: replicates the RYZEN logo's letter style
    -- (ultra-heavy upright caps with tight INTERLOCKED tracking - the original
    -- logo's letters actually overlap by up to 5% of cap height). Roblox text
    -- has no letter-spacing control, so each letter is its own label and the
    -- UIListLayout padding is negative to interlock them the same way.
    function _G.RyzenBuildRyzenWordmark(container, textSize, tracking)
    local letters = {"R", "X", "Z"}
    for i = 1, #letters do
    local letter = Instance.new("TextLabel")
    letter.Name = "RyzenLetter" .. i
    letter.BackgroundTransparency = 1
    letter.Text = letters[i]
    letter.Font = Enum.Font.GothamBlack
    letter.TextSize = textSize or 96
    letter.TextColor3 = Color3.fromRGB(255, 255, 255)
    letter.TextStrokeTransparency = 1
    letter.Size = UDim2.new(0, 0, 0, 0)
    letter.AutomaticSize = Enum.AutomaticSize.XY
    letter.LayoutOrder = i
    letter.Parent = container
    end
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, tracking or -5)
    layout.Parent = container
    end

    local MiniFrame = Instance.new("Frame")
    MiniFrame.Name = "MiniFrame"
    MiniFrame.AnchorPoint = Vector2.new(0, 0)
    MiniFrame.Size = UDim2.new(0, 124, 0, 34)
    local MINI_DEFAULT_POSITION = UDim2.new(0, 12, 0, 12)
    MiniFrame.Position = tableToUDim2(savedMiniPositionTable, MINI_DEFAULT_POSITION)
    savedMiniPositionTable = udim2ToTable(MiniFrame.Position)
    MiniFrame:GetPropertyChangedSignal("Position"):Connect(function()
        savedMiniPositionTable = udim2ToTable(MiniFrame.Position)
    end)
    MiniFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
    MiniFrame.BackgroundTransparency = 0.08
    MiniFrame.BorderSizePixel = 0
    MiniFrame.Visible = false
    MiniFrame.Active = true
    MiniFrame.ZIndex = 20
    MiniFrame.Parent = Gui
    corner(MiniFrame, 5)
    local MiniButton = Instance.new("TextButton")
    MiniButton.Name = "MiniButton"
    MiniButton.Size = UDim2.new(1, -4, 1, -4)
    MiniButton.Position = UDim2.new(0, 2, 0, 2)
    MiniButton.BackgroundTransparency = 1
    MiniButton.Text = "RXZ HUB"
    MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiniButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    MiniButton.TextStrokeTransparency = 1
    MiniButton.TextSize = 14
    MiniButton.Font = Enum.Font.GothamBold
    MiniButton.TextXAlignment = Enum.TextXAlignment.Center
    MiniButton.AutoButtonColor = false
    MiniButton.ZIndex = 24
    MiniButton.Parent = MiniFrame

    local RyzenMiniLogo = Instance.new("Frame")
    RyzenMiniLogo.Name = "RyzenMiniLogo"
    RyzenMiniLogo.BackgroundTransparency = 1
    RyzenMiniLogo.Size = UDim2.new(1, -12, 1, -8)
    RyzenMiniLogo.Position = UDim2.new(0, 6, 0, 4)
    RyzenMiniLogo.ZIndex = 23
    RyzenMiniLogo.Active = false
    RyzenMiniLogo.Parent = MiniButton
    -- The compact launcher uses plain RXZ HUB text instead of the logo.
    RyzenMiniLogo.Visible = false


    local MiniShimmerText = Instance.new("TextLabel")
    MiniShimmerText.Name = "MiniShimmerText"
    MiniShimmerText.Size = UDim2.new(1, 0, 1, 0)
    MiniShimmerText.Position = UDim2.new(0, 0, 0, 0)
    MiniShimmerText.BackgroundTransparency = 1
    MiniShimmerText.Text = ""
    MiniShimmerText.TextColor3 = Color3.fromRGB(255,255,255)
    MiniShimmerText.TextTransparency = 0
    MiniShimmerText.TextStrokeTransparency = 1
    MiniShimmerText.TextSize = 11
    MiniShimmerText.Font = Enum.Font.GothamMedium
    MiniShimmerText.TextXAlignment = Enum.TextXAlignment.Center
    MiniShimmerText.Active = false
    MiniShimmerText.Selectable = false
    MiniShimmerText.ZIndex = 22
    MiniShimmerText.Visible = false
    MiniShimmerText.Parent = MiniFrame


    local MiniShimmerGradient = Instance.new("UIGradient")
    MiniShimmerGradient.Rotation = 8
    MiniShimmerGradient.Offset = Vector2.new(-1.45, 0)
    MiniShimmerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.44, Color3.fromRGB(235,235,235)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.56, Color3.fromRGB(235,235,235)),
        ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,255,255))
    })
    MiniShimmerGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 1.00),
        NumberSequenceKeypoint.new(0.34, 1.00),
        NumberSequenceKeypoint.new(0.40, 0.88),
        NumberSequenceKeypoint.new(0.44, 0.55),
        NumberSequenceKeypoint.new(0.48, 0.16),
        NumberSequenceKeypoint.new(0.50, 0.00),
        NumberSequenceKeypoint.new(0.52, 0.16),
        NumberSequenceKeypoint.new(0.56, 0.55),
        NumberSequenceKeypoint.new(0.60, 0.88),
        NumberSequenceKeypoint.new(0.66, 1.00),
        NumberSequenceKeypoint.new(1.00, 1.00)
    })
    MiniShimmerGradient.Parent = MiniShimmerText


    local MiniGlowText = MiniShimmerText:Clone()
    MiniGlowText.Name = "MiniGlowText"
    MiniGlowText.TextTransparency = 0.42
    MiniGlowText.TextStrokeTransparency = 1
    MiniGlowText.ZIndex = 21
    MiniGlowText.Visible = false
    MiniGlowText.Parent = MiniFrame

    local MiniGlowGradient = MiniShimmerGradient:Clone()
    MiniGlowGradient.Parent = MiniGlowText

    task.spawn(function()
        while false do
            MiniShimmerGradient.Offset = Vector2.new(-1.45, 0)
            MiniGlowGradient.Offset = Vector2.new(-1.45, 0)

            local t1 = TweenService:Create(
                MiniShimmerGradient,
                TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Offset = Vector2.new(1.45, 0)}
            )
            local t2 = TweenService:Create(
                MiniGlowGradient,
                TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Offset = Vector2.new(1.45, 0)}
            )

            t1:Play()
            t2:Play()
            t1.Completed:Wait()

            
            task.wait(1.1)
        end
    end)

    local MiniShade = Instance.new("Frame")
    MiniShade.Name = "MiniShade"
    MiniShade.Size = UDim2.new(1, -4, 1, -4)
    MiniShade.Position = UDim2.new(0, 2, 0, 2)
    MiniShade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MiniShade.BackgroundTransparency = 0.12
    MiniShade.BorderSizePixel = 0
    MiniShade.ZIndex = 20
    MiniShade.Parent = MiniFrame
    MiniButton.MouseEnter:Connect(function()
    TweenService:Create(MiniFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 20, 24)}):Play()
    end)
    MiniButton.MouseLeave:Connect(function()
    TweenService:Create(MiniFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 14, 18)}):Play()
    end)
    corner(MiniShade, 5)
    MiniShade.ZIndex = 20 -- keep the RXZ HUB label above the shade
    local MiniRyzenStroke = Instance.new("UIStroke")
    MiniRyzenStroke.Color = Color3.fromRGB(255,255,255)
    MiniRyzenStroke.Thickness = 1
    MiniRyzenStroke.Transparency = 0.45
    MiniRyzenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MiniRyzenStroke.Parent = MiniFrame
    do
    local miniDragging = false
    local miniDragStart = nil
    local miniStartPos = nil
    local miniMoved = false
    local miniHeldInput = nil
    local DRAG_DEADZONE = 6
    MiniButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    miniDragging = true
    miniMoved = false
    miniHeldInput = input
    miniDragStart = input.Position
    miniStartPos = MiniFrame.Position
    end
    end)
    UserInputService.InputChanged:Connect(function(input)
    if not miniDragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    if not miniDragStart or not miniStartPos then return end
    local delta = input.Position - miniDragStart
    if math.abs(delta.X) > DRAG_DEADZONE or math.abs(delta.Y) > DRAG_DEADZONE then
    miniMoved = true
    end
    MiniFrame.Position = UDim2.new(
    miniStartPos.X.Scale,
    miniStartPos.X.Offset + delta.X,
    miniStartPos.Y.Scale,
    miniStartPos.Y.Offset + delta.Y
    )
    end)
    UserInputService.InputEnded:Connect(function(input)
    if input ~= miniHeldInput then return end
    local wasDrag = miniMoved
    miniDragging = false
    miniHeldInput = nil
    miniDragStart = nil
    miniStartPos = nil
    if wasDrag then
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    Main.Visible = true
    MiniFrame.Visible = false
    Main.Size = FULL_MAIN_SIZE
    savedMainPositionTable = udim2ToTable(Main.Position)
    end)
    end
    local BackgroundIDs = {
    "137075062534290",
    "109619268613730",
    "88369503310562",
    "80708025126373",
    "102253425322931",
    "90453834580322",
    "135181794444219",
    }

    local ButtonImageIDs = {
    "90631990302263",
    "111941119745474",
    "88369503310562",
    "80708025126373",
    "102253425322931",
    "138739435956313",
    "135181794444219",
    }

    _G.RyzenThemeColors = _G.RyzenThemeColors or {
    PURPLE = Color3.fromRGB(207, 159, 255),
    BLUE   = Color3.fromRGB(58, 128, 245),
    RED    = Color3.fromRGB(232, 52, 68),
    PINK   = Color3.fromRGB(255, 105, 180),
    YELLOW = Color3.fromRGB(255, 214, 0),
    GREY   = Color3.fromRGB(90, 90, 90),
    WHITE  = Color3.fromRGB(255, 255, 255),
    FOREST = Color3.fromRGB(46, 139, 87),
    BLACK  = Color3.fromRGB(0, 0, 0),
    }

    _G.RyzenThemeName = tostring(savedConfig.currentThemeName or _G.RyzenThemeName or "WHITE")
    currentBackground = tonumber(savedConfig.currentBackground) or 0
    _G.RyzenBodyLockEnabled = savedConfig.bodyLockEnabled == true
    _G.RyzenBodyLockRadius = tonumber(savedConfig.bodyLockRadius) or _G.RyzenBodyLockRadius or 60
    if savedConfig.mobileButtonScale ~= nil then _G.RyzenMobileButtonScale = tonumber(savedConfig.mobileButtonScale) or _G.RyzenMobileButtonScale or 0.75 end
    if savedConfig.guiScaleValue ~= nil then _G.RyzenGuiScaleValue = tonumber(savedConfig.guiScaleValue) or _G.RyzenGuiScaleValue end
    if savedConfig.stealUiScaleValue ~= nil then _G.RyzenProgressBarScaleValue = tonumber(savedConfig.stealUiScaleValue) or _G.RyzenProgressBarScaleValue end
    _G.RyzenHeadlessEnabled = savedConfig.headlessEnabled == true
    _G.RyzenKorbloxEnabled = savedConfig.korbloxEnabled == true
    local BgImage = Instance.new("ImageLabel")
    BgImage.Name = "CustomBackground"
    BgImage.BackgroundTransparency = 1
    BgImage.ImageTransparency = 0
    BgImage.ScaleType = Enum.ScaleType.Crop
    BgImage.Size = UDim2.new(1, 0, 1, 0)
    BgImage.Position = UDim2.new(0, 0, 0, 0)
    BgImage.Visible = false
    BgImage.ZIndex = 1
    BgImage.Parent = Main
    corner(BgImage, 14)
    function applyBackground(index)
    currentBackground = index or 0
    if currentBackground == 0 then
    Main.BackgroundColor3 = COLORS.bg
    BgImage.Visible = false
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return "None"
    end
    local id = BackgroundIDs[currentBackground]
    if id then
    BgImage.Image = "rbxassetid://" .. id
    local selectedTint = _G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE
    BgImage.ImageColor3 = selectedTint
    if _G.RyzenSetWordmarkTint then _G.RyzenSetWordmarkTint(_G.RyzenLogoTint(selectedTint)) end
    BgImage.Visible = true
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return "Image " .. tostring(currentBackground)
    end
    currentBackground = 0
    BgImage.Visible = false
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return "None"
    end
    applyBackground(currentBackground)
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -110, 0, 44)
    Title.Position = UDim2.new(0, 55, 0, 24)
    Title.Text = ""
    Title.TextColor3 = COLORS.white
    Title.TextStrokeTransparency = 1
    Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 38
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.ZIndex = 6
    Title.Parent = Main
    Title.Visible = false

    -- Keep the Ryzen logo visible on every theme: a pure black tint (BLACK
    -- theme) would vanish into the dark Ryzen Hub background, so near-black tints
    -- render the logo in white instead.
    function _G.RyzenLogoTint(tint)
    tint = tint or (_G.RyzenThemeColors and _G.RyzenThemeColors[_G.RyzenThemeName]) or _G.RyzenThemeColors.WHITE
    if tint and (tint.R + tint.G + tint.B) < 0.12 then
    return Color3.fromRGB(255, 255, 255)
    end
    return tint or Color3.fromRGB(255, 255, 255)
    end

    -- RYZEN wordmark in the RYZEN-logo letter style (per-letter labels with
    -- interlocked tracking; tinted per letter since the container is a Frame)
    local RyzenLogoAsset = Instance.new("ImageLabel")
    RyzenLogoAsset.Name = "LogoAsset"
    RyzenLogoAsset.ZIndex = 6
    RyzenLogoAsset.AnchorPoint = Vector2.new(0.5, 0)
    RyzenLogoAsset.Position = UDim2.new(0.5, 0, 0, 10)
    RyzenLogoAsset.Size = UDim2.new(0, 218, 0, 96)
    RyzenLogoAsset.BackgroundTransparency = 1
    RyzenLogoAsset.Image = "rbxassetid://107538982245640"
    RyzenLogoAsset.ScaleType = Enum.ScaleType.Fit
    RyzenLogoAsset.Parent = Main
    _G.RyzenLogoWordmark = RyzenLogoAsset

    function _G.RyzenSetWordmarkTint(color)
    local wm = _G.RyzenLogoWordmark
    if not wm then return end
    if wm:IsA("ImageLabel") or wm:IsA("ImageButton") then
        wm.ImageColor3 = Color3.fromRGB(255, 255, 255)
        return
    end
    for _, l in ipairs(wm:GetChildren()) do
        if l:IsA("TextLabel") then l.TextColor3 = color end
    end
    end
    _G.RyzenSetWordmarkTint(_G.RyzenLogoTint(_G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE))


    local TitleSweepText = Title:Clone()
    TitleSweepText.Name = "TitleSweepText"
    TitleSweepText.TextColor3 = Color3.fromRGB(0, 0, 0)
    TitleSweepText.TextTransparency = 0
    TitleSweepText.TextStrokeTransparency = 1
    TitleSweepText.BackgroundTransparency = 1
    TitleSweepText.ZIndex = Title.ZIndex + 1
    TitleSweepText.Visible = false
    TitleSweepText.Parent = Main

    local SweepGradient = Instance.new("UIGradient")
    SweepGradient.Rotation = 12
    SweepGradient.Offset = Vector2.new(-1.25, 0)
    SweepGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 1),
        NumberSequenceKeypoint.new(0.43, 1),
        NumberSequenceKeypoint.new(0.49, 0.55),
        NumberSequenceKeypoint.new(0.50, 0.00),
        NumberSequenceKeypoint.new(0.51, 0.55),
        NumberSequenceKeypoint.new(0.57, 1),
        NumberSequenceKeypoint.new(1.00, 1)
    })
    SweepGradient.Parent = TitleSweepText

    task.spawn(function()
        while false do
            SweepGradient.Offset = Vector2.new(-1.25, 0)
            local sweepTween = TweenService:Create(
                SweepGradient,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Offset = Vector2.new(1.25, 0)}
            )
            sweepTween:Play()
            sweepTween.Completed:Wait()
            task.wait(1.2)
        end
    end)
    local HeaderDivider = Instance.new("Frame")
    HeaderDivider.Name = "HeaderDivider"
    HeaderDivider.BackgroundColor3 = Color3.fromRGB(70, 70, 82)
    HeaderDivider.BackgroundTransparency = 1
    HeaderDivider.BorderSizePixel = 0
    HeaderDivider.Size = UDim2.new(1, -34, 0, 1)
    HeaderDivider.Position = UDim2.new(0, 17, 0, 96)
    HeaderDivider.ZIndex = 6
    HeaderDivider.Visible = false
    HeaderDivider.Parent = Main
    local Close = Instance.new("TextButton")
    Close.Name = "Close"
    Close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Close.BackgroundTransparency = 0.28
    Close.Text = "-"
    Close.TextColor3 = COLORS.white
    Close.TextSize = 22
    Close.Font = Enum.Font.GothamMedium
    Close.Size = UDim2.new(0, 32, 0, 28)
    Close.Position = UDim2.new(1, -42, 0, 14)
    Close.AutoButtonColor = false
    Close.ZIndex = 5
    Close.Parent = Main
    corner(Close, 8)
    stroke(Close, COLORS.stroke, 1, 0.35)

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 13, 0, 196)
    Content.Size = UDim2.new(1, -26, 1, -209)
    Content.ZIndex = 3
    Content.Parent = Main
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    Tabs.BackgroundTransparency = 0.22
    Tabs.Position = UDim2.new(0, 13, 0, 103)
    Tabs.Size = UDim2.new(1, -26, 0, 82)
    Tabs.ZIndex = 3
    Tabs.Parent = Main
    corner(Tabs, 12)
    stroke(Tabs, COLORS.strokeSoft, 1.1, 0.28)



    do
    local IDLE_DELAY = 5
    local FADE_TIME = 0.45
    local idleToken = 0
    local idleCollapsed = false
    local savedTransparency = setmetatable({}, {__mode = "k"})
    local activeTweens = setmetatable({}, {__mode = "k"})

    local function rememberObject(obj)
        if savedTransparency[obj] then return end
        local data = {}
        if obj:IsA("GuiObject") then
            data.BackgroundTransparency = obj.BackgroundTransparency
        end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            data.TextTransparency = obj.TextTransparency
            data.TextStrokeTransparency = obj.TextStrokeTransparency
        end
        if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            data.ImageTransparency = obj.ImageTransparency
        end
        if obj:IsA("UIStroke") then
            data.Transparency = obj.Transparency
        end
        savedTransparency[obj] = data
    end

    local function tweenObject(obj, collapsed)
        rememberObject(obj)
        local base = savedTransparency[obj]
        if not base then return end

        if activeTweens[obj] then
            pcall(function() activeTweens[obj]:Cancel() end)
            activeTweens[obj] = nil
        end

        local goal = {}
        if base.BackgroundTransparency ~= nil then
            goal.BackgroundTransparency = collapsed and math.max(base.BackgroundTransparency, 0.78) or base.BackgroundTransparency
        end
        if base.TextTransparency ~= nil then
            goal.TextTransparency = collapsed and math.max(base.TextTransparency, 0.58) or base.TextTransparency
        end
        if base.TextStrokeTransparency ~= nil then
            goal.TextStrokeTransparency = collapsed and math.max(base.TextStrokeTransparency, 0.82) or base.TextStrokeTransparency
        end
        if base.ImageTransparency ~= nil then
            goal.ImageTransparency = collapsed and math.max(base.ImageTransparency, 0.68) or base.ImageTransparency
        end
        if base.Transparency ~= nil then
            goal.Transparency = collapsed and math.max(base.Transparency, 0.72) or base.Transparency
        end

        if next(goal) then
            local tw = TweenService:Create(
                obj,
                TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                goal
            )
            activeTweens[obj] = tw
            tw:Play()
        end
    end

    local restoreToken = 0

    local function forceOriginalTransparency()
        for obj, base in pairs(savedTransparency) do
            if obj and obj.Parent and base then
                if activeTweens[obj] then
                    pcall(function() activeTweens[obj]:Cancel() end)
                    activeTweens[obj] = nil
                end
                pcall(function()
                    if base.BackgroundTransparency ~= nil then obj.BackgroundTransparency = base.BackgroundTransparency end
                    if base.TextTransparency ~= nil then obj.TextTransparency = base.TextTransparency end
                    if base.TextStrokeTransparency ~= nil then obj.TextStrokeTransparency = base.TextStrokeTransparency end
                    if base.ImageTransparency ~= nil then obj.ImageTransparency = base.ImageTransparency end
                    if base.Transparency ~= nil then obj.Transparency = base.Transparency end
                end)
            end
        end
    end

    local function setMenuIdleCollapsed(state)
        local newState = state == true
        restoreToken += 1
        local myRestoreToken = restoreToken

        
        
        if newState and not idleCollapsed then
            savedTransparency = setmetatable({}, {__mode = "k"})
            for _, root in ipairs({Content, Tabs, Close, HeaderDivider}) do
                rememberObject(root)
                for _, obj in ipairs(root:GetDescendants()) do
                    rememberObject(obj)
                end
            end
        end

        idleCollapsed = newState

        Content.Visible = true
        Tabs.Visible = true
        Close.Visible = true
        HeaderDivider.Visible = false

        for _, root in ipairs({Content, Tabs, Close, HeaderDivider}) do
            tweenObject(root, idleCollapsed)
            for _, obj in ipairs(root:GetDescendants()) do
                tweenObject(obj, idleCollapsed)
            end
        end

        if not newState then
            
            
            task.delay(FADE_TIME + 0.08, function()
                if myRestoreToken ~= restoreToken or idleCollapsed then return end
                
                
                local untilTime = tick() + 1.5
                repeat
                    if myRestoreToken ~= restoreToken or idleCollapsed then return end
                    forceOriginalTransparency()
                    RunService.RenderStepped:Wait()
                until tick() >= untilTime
                forceOriginalTransparency()
                
            end)
        end
    end

    local function cancelIdleAndRestore()
        idleToken += 1
        if idleCollapsed then
            setMenuIdleCollapsed(false)
        elseif next(savedTransparency) then
            
            forceOriginalTransparency()
        end
    end

    local function scheduleIdleCollapse()
        
        if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then return end
        idleToken += 1
        local myToken = idleToken
        task.delay(IDLE_DELAY, function()
            if myToken ~= idleToken then return end
            if not Main or not Main.Parent or not Main.Visible then return end
            setMenuIdleCollapsed(true)
        end)
    end

    Main.MouseEnter:Connect(cancelIdleAndRestore)
    Main.MouseLeave:Connect(scheduleIdleCollapse)



    RunService.RenderStepped:Connect(function()
        if not Main or not Main.Parent or not Main.Visible then return end
        if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then return end
        local mousePos = UserInputService:GetMouseLocation()
        local pos = Main.AbsolutePosition
        local size = Main.AbsoluteSize
        local inside = mousePos.X >= pos.X and mousePos.X <= pos.X + size.X
            and mousePos.Y >= pos.Y and mousePos.Y <= pos.Y + size.Y
        if inside then
            if idleCollapsed then
                cancelIdleAndRestore()
            else
                
                
                for _, root in ipairs({Content, Tabs, Close, HeaderDivider}) do
                    if root:IsA("TextLabel") or root:IsA("TextButton") or root:IsA("TextBox") then
                        root.TextTransparency = 0
                    end
                    for _, obj in ipairs(root:GetDescendants()) do
                        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                            if obj.Visible then
                                obj.TextTransparency = 0
                            end
                        end
                    end
                end
            end
        end
    end)


    Main.DescendantAdded:Connect(function(obj)
        
        
        if idleCollapsed then
            task.defer(function()
                if obj and obj.Parent then
                    savedTransparency[obj] = nil
                    tweenObject(obj, true)
                end
            end)
        end
    end)


    task.defer(scheduleIdleCollapse)
    end

    local TabLayout = Instance.new("UIGridLayout")
    TabLayout.CellSize = UDim2.new(0.333, -5, 0, 35)
    TabLayout.CellPadding = UDim2.new(0, 4, 0, 4)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Parent = Tabs
    local pages = {}
    local tabButtons = {}
    local tabNames = {"MOVEMENT", "COMBAT", "KEYBINDS", "VISUALS", "MENU", "SETTINGS"}
    local activeTab = "MOVEMENT"

    -- Roblox profile card removed.

    function addPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 0
    page.ScrollBarImageTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Size = UDim2.new(1, 0, 1, 0)
    page.ZIndex = 3
    page.Visible = false
    page.Parent = Content
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 7)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    pages[name] = page
    return page
    end
    function setTab(name)
    activeTab = name
    -- remember the tab so a re-execute / fresh boot lands back where the
    -- user was, instead of always snapping to MOVEMENT
    _G.RyzenLastActiveTab = name
    if saveRyzenConfig then
    _G.__RyzenTabSaveAt = tick()
    local stamp = _G.__RyzenTabSaveAt
    task.delay(0.4, function()
    -- only the most recent switch writes the config (no click hitch)
    if _G.__RyzenTabSaveAt == stamp then
    pcall(function() saveRyzenConfig() end)
    end
    end)
    end
    for pageName, page in pairs(pages) do
    page.Visible = pageName == name
    end
    for tabName, btn in pairs(tabButtons) do
    local on = tabName == name
    btn.TextColor3 = on and Color3.fromRGB(255,255,255) or Color3.fromRGB(190,187,202)
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundTransparency = on and 0.78 or 1
    local st = btn:FindFirstChildOfClass("UIStroke")
    if st then
    st.Color = Color3.fromRGB(255,255,255)
    st.Thickness = 1.2
    st.Transparency = on and 0.15 or 0.52
    end
    end
    end
    for _, name in ipairs(tabNames) do
    addPage(name)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(5,5,7)
    btn.BackgroundTransparency = 0.04
    btn.BorderSizePixel = 0
    btn.Rotation = 0
    btn.Text = ({KEYBINDS="KBM", MENU="CTRL", VISUALS="VISUAL"})[name] or name
    btn.LayoutOrder = ({MOVEMENT=1, COMBAT=2, KEYBINDS=3, MENU=4, VISUALS=5, SETTINGS=7})[name] or 99
    btn.TextColor3 = Color3.fromRGB(190,187,202)
    btn.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    btn.TextStrokeTransparency = 1
    btn.TextSize = 11
    btn.TextScaled = true
    btn.TextWrapped = true
    btn.Font = Enum.Font.GothamBlack
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = Tabs
    local tabTextConstraint = Instance.new("UITextSizeConstraint")
    tabTextConstraint.MinTextSize = 6
    tabTextConstraint.MaxTextSize = 12
    tabTextConstraint.Parent = btn
    corner(btn, 9)
    stroke(btn, Color3.fromRGB(255,255,255), 1.2, 0.52)
    tabButtons[name] = btn
    local targetTabName = name
    btn.MouseButton1Click:Connect(function()
    setTab(targetTabName)
    end)
    btn.Activated:Connect(function()
    setTab(targetTabName)
    end)
    end
    -- TAB SAFEGUARD: after boot, page visibility must only ever change via
    -- setTab (user clicks). If anything disturbs the pages (an overlay gui
    -- glitch, renderer hiccup, unexpected code path), re-assert the selected
    -- tab so the visible page always matches the tab the user is on. The
    -- re-assert goes through setTab itself so the tab button outline and
    -- the page content can never disagree with each other.
    task.spawn(function()
    while Gui and Gui.Parent do
    task.wait(0.5)
    pcall(function()
    local active = pages[activeTab]
    if not active then return end
    for pageName, page in pairs(pages) do
    if page.Visible ~= (page == active) then
    -- mismatch: full re-assert (pages + outlines, atomically)
    setTab(activeTab)
    return
    end
    end
    end)
    end
    end)

    function section(parent, text, order)
    local label = Instance.new("TextLabel")
    label.Name = text
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(245, 245, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 1
    label.TextSize = 11
    label.Font = Enum.Font.GothamBlack
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, -6, 0, 15)
    label.LayoutOrder = order
    label.ZIndex = 8
    label.Parent = parent
    return label
    end
    function baseRow(parent, labelText, order)
    local row = Instance.new("Frame")
    row.Name = labelText
    row.BackgroundColor3 = COLORS.row
    row.BackgroundTransparency = 0.3
    row.Size = UDim2.new(1, -4, 0, 34)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.ZIndex = 4
    row.Parent = parent
    corner(row, 9)
    stroke(row, COLORS.strokeSoft, 1.15, 0.38)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(245, 245, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 1
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(1, -132, 1, 0)
    label.ZIndex = 5
    label.Parent = row

    return row
    end
    function textboxRow(parent, labelText, value, order)
    local row = baseRow(parent, labelText, order)
    local box = Instance.new("TextBox")
    box.Name = "ValueBox"
    box.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    box.BackgroundTransparency = 0.08
    box.Text = tostring(value or "")
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 12
    box.Font = Enum.Font.GothamMedium
    box.ClearTextOnFocus = false
    box.Size = UDim2.new(0, 56, 0, 28)
    box.Position = UDim2.new(1, -66, 0.5, -14)
    box.BorderSizePixel = 0
    box.ZIndex = 6
    box.Parent = row
    corner(box, 14)
    stroke(box, Color3.fromRGB(255, 255, 255), 1.1, 0.55)
    return row, box
    end
    -- =============================================================
    -- THEMED TOGGLES
    -- Both toggle builders used to paint the track white whether the
    -- feature was on or off - only the knob slid across. Now an enabled
    -- toggle fills with the active theme colour (same tint the ESP,
    -- speed numbers and ragdoll timers use) and every live toggle is
    -- registered so switching theme repaints the ones already on.
    -- =============================================================
    _G.RyzenToggleThemeItems = _G.RyzenToggleThemeItems or {}

    function _G.RyzenToggleTint()
    if _G.RyzenSpeedThemeTint then
    local ok, t = pcall(_G.RyzenSpeedThemeTint)
    if ok and t then return t end
    end
    local t = _G.RyzenThemeColors and _G.RyzenThemeName and _G.RyzenThemeColors[_G.RyzenThemeName]
    return t or THEME_ACCENT or Color3.fromRGB(255, 255, 255)
    end

    -- paint one toggle for its current state
    function _G.RyzenPaintToggle(entry, animate)
    if not entry or not entry.track or not entry.track.Parent then return end
    local tint = _G.RyzenToggleTint()
    local offTint = tint:Lerp(Color3.fromRGB(12, 12, 16), 0.78)
    local props = entry.on
    and { BackgroundColor3 = tint, BackgroundTransparency = 0.02 }
    or  { BackgroundColor3 = offTint, BackgroundTransparency = 0.08 }
    if animate and tween then
    tween(entry.track, props)
    else
    entry.track.BackgroundColor3 = props.BackgroundColor3
    entry.track.BackgroundTransparency = props.BackgroundTransparency
    end
    if entry.stroke and entry.stroke.Parent then
    local sprops = entry.on
    and { Color = tint, Transparency = 0.05, Thickness = 1.35 }
    or  { Color = tint:Lerp(Color3.fromRGB(255,255,255), 0.25), Transparency = 0.42, Thickness = 1.05 }
    if animate and tween then
    tween(entry.stroke, sprops)
    else
    entry.stroke.Color = sprops.Color
    entry.stroke.Transparency = sprops.Transparency
    entry.stroke.Thickness = sprops.Thickness
    end
    if entry.knob and entry.knob.Parent then
    local knobProps = entry.on
    and { BackgroundColor3 = Color3.fromRGB(255,255,255) }
    or  { BackgroundColor3 = tint:Lerp(Color3.fromRGB(245,245,250), 0.35) }
    if animate and tween then
    tween(entry.knob, knobProps)
    else
    entry.knob.BackgroundColor3 = knobProps.BackgroundColor3
    end
    end
    end
    end

    -- repaint every registered toggle (called when the theme changes)
    function _G.RyzenApplyToggleThemeColor()
    local keep = {}
    for _, entry in ipairs(_G.RyzenToggleThemeItems) do
    if entry.track and entry.track.Parent then
    table.insert(keep, entry)
    pcall(_G.RyzenPaintToggle, entry, false)
    end
    end
    _G.RyzenToggleThemeItems = keep
    end

    function toggleRow(parent, labelText, default, order)
    local row = baseRow(parent, labelText, order)
    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.AutoButtonColor = false
    button.ZIndex = 7
    button.Parent = row
    local track = Instance.new("Frame")
    track.Name = "Track"
    track.BackgroundColor3 = Color3.fromRGB(12,12,16)
    track.BackgroundTransparency = 0.08
    track.Size = UDim2.new(0, 40, 0, 22)
    track.Position = UDim2.new(1, -50, 0.5, -11)
    track.BorderSizePixel = 0
    track.ZIndex = 5
    track.Parent = button
    corner(track, 11)
    stroke(track, COLORS.strokeSoft, 1.1, 0.42)
    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.fromRGB(245,245,250)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BorderSizePixel = 0
    knob.ZIndex = 6
    knob.Parent = track
    corner(knob, 999)
    local shine = Instance.new("Frame")
    shine.Name = "Shine"
    shine.BackgroundColor3 = COLORS.white
    shine.BackgroundTransparency = 0.72
    shine.Size = UDim2.new(1, -4, 0, 4)
    shine.Position = UDim2.new(0, 2, 0, 2)
    shine.BorderSizePixel = 0
    shine.ZIndex = 7
    shine.Parent = knob
    corner(shine, 4)
    local state = default and true or false
    local trackStroke = track:FindFirstChildOfClass("UIStroke")
    local rowStroke = row:FindFirstChildOfClass("UIStroke")
    local themeEntry = { track = track, stroke = trackStroke, knob = knob, on = state }
    table.insert(_G.RyzenToggleThemeItems, themeEntry)
    local function setVisual(on)
    state = on and true or false
    tween(knob, {
    Position = state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)
    })
    -- enabled = theme colour, disabled = plain white
    themeEntry.on = state
    _G.RyzenPaintToggle(themeEntry, true)
    if rowStroke then
    rowStroke.Thickness = 1.15
    end
    row.BackgroundTransparency = 0.3
    end
    setVisual(state)
    button.Activated:Connect(function()
    end)
    return row, setVisual
    end
    _G.RyzenSyncToggleVisuals = function()
    pcall(function() if setAutoStealVisual then setAutoStealVisual(autoStealEnabled == true) end end)
    pcall(function() if setInfJumpVisual then setInfJumpVisual(infJumpEnabled == true) end end)
    pcall(function() if setAntiRagdollVisual then setAntiRagdollVisual(antiRagdollEnabled == true) end end)
    pcall(function() if setAutoCarrySpeedVisual then setAutoCarrySpeedVisual(autoCarrySpeedEnabled == true) end end)
    pcall(function() if setAutoCarryEnemyBaseVisual then setAutoCarryEnemyBaseVisual(autoCarryEnemyBaseEnabled == true) end end)
    pcall(function() if autoCarryEnemyBaseRangeBox then autoCarryEnemyBaseRangeBox.Text = tostring(autoCarryEnemyBaseRange or 35) end end)
    pcall(function() if autoCarryEnemyBaseEnabled and _G.RyzenStartAutoCarryEnemyBase then _G.RyzenStartAutoCarryEnemyBase() end end)
    pcall(function() if setAutoTPVisual then setAutoTPVisual(autoTPEnabled == true) end end)
    pcall(function() if setAutoResetOnMedVisual then setAutoResetOnMedVisual(autoResetOnMedEnabled == true) end end)
    end
    _G.RyzenActionToggleRow = function(parent, labelText, default, order)
    local row = baseRow(parent, labelText, order)
    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.AutoButtonColor = false
    button.ZIndex = 7
    button.Parent = row
    local track = Instance.new("Frame")
    track.Name = "Track"
    track.BackgroundColor3 = Color3.fromRGB(12,12,16)
    track.BackgroundTransparency = 0.08
    track.Size = UDim2.new(0, 40, 0, 22)
    track.Position = UDim2.new(1, -50, 0.5, -11)
    track.BorderSizePixel = 0
    track.ZIndex = 5
    track.Parent = button
    corner(track, 11)
    stroke(track, COLORS.strokeSoft, 1.1, 0.42)
    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.fromRGB(245,245,250)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BorderSizePixel = 0
    knob.ZIndex = 6
    knob.Parent = track
    corner(knob, 999)
    local shine = Instance.new("Frame")
    shine.Name = "Shine"
    shine.BackgroundColor3 = COLORS.white
    shine.BackgroundTransparency = 0.72
    shine.Size = UDim2.new(1, -4, 0, 4)
    shine.Position = UDim2.new(0, 2, 0, 2)
    shine.BorderSizePixel = 0
    shine.ZIndex = 7
    shine.Parent = knob
    corner(shine, 4)
    local trackStroke = track:FindFirstChildOfClass("UIStroke")
    local rowStroke = row:FindFirstChildOfClass("UIStroke")
    local themeEntry = { track = track, stroke = trackStroke, knob = knob, on = default and true or false }
    table.insert(_G.RyzenToggleThemeItems, themeEntry)
    local function setVisual(on)
    local state = on and true or false
    tween(knob, {
    Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    })
    -- enabled = theme colour, disabled = plain white
    themeEntry.on = state
    _G.RyzenPaintToggle(themeEntry, true)
    if rowStroke then
    tween(rowStroke, {
    Color = state and Color3.fromRGB(245, 245, 255) or COLORS.strokeSoft,
    Transparency = state and 0.12 or 0.38,
    Thickness = state and 1.25 or 1.15
    })
    end
    tween(row, {BackgroundTransparency = 0.3})
    end
    setVisual(default)
    return row, setVisual, button
    end
    function dropdownRow(parent, labelText, value, order)
    local row = baseRow(parent, labelText, order)
    local select = Instance.new("TextButton")
    select.Name = "Dropdown"
    select.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    select.BackgroundTransparency = 0.08
    select.Text = tostring(value or "None") .. "  v"
    select.TextColor3 = COLORS.white
    select.TextSize = 12
    select.Font = Enum.Font.GothamMedium
    select.Size = UDim2.new(0, 118, 0, 28)
    select.Position = UDim2.new(1, -128, 0.5, -14)
    select.BorderSizePixel = 0
    select.AutoButtonColor = false
    select.ZIndex = 6
    select.Parent = row
    corner(select, 14)
    local st = stroke(select, Color3.fromRGB(255, 255, 255), 1.1, 0.55)
    -- soft inner fill to match Combat pill look
    local fill = Instance.new("Frame")
    fill.Name = "PillFill"
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BackgroundTransparency = 0.92
    fill.Size = UDim2.new(1, 0, 1, 0)
    fill.BorderSizePixel = 0
    fill.ZIndex = 5
    fill.Parent = select
    corner(fill, 14)
    select.ZIndex = 7
    return row, select
    end
    function refreshAnimationPackRow()
    local displayName = tostring(selectedAnimationPack or "OFF")

    if animationPackValueLabel and animationPackValueLabel.Parent then
    animationPackValueLabel.Text = displayName
    end




    pcall(function()
        if pages and pages.VISUALS then
            for _, obj in ipairs(pages.VISUALS:GetDescendants()) do
                if obj:IsA("TextLabel") and obj.Name == "AnimationPackValue" then
                    obj.Text = displayName
                end
            end
        end
    end)
    end
    function animationPackRow(parent, order)
    local row = baseRow(parent, "Animation Pack", order)
    row.Size = UDim2.new(1,-4,0,52)
    row.BackgroundTransparency = 1
    local animRowStroke = row:FindFirstChildOfClass("UIStroke")
    if animRowStroke then animRowStroke.Transparency = 1 end
    local label = row:FindFirstChild("Label")
    if label then
    label.Text = "Animation Pack"
    label.Position = UDim2.new(0,2,0,0)
    label.Size = UDim2.new(1,0,0,16)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBlack
    end
    local left = Instance.new("TextButton")
    left.Name = "LeftArrow"
    left.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    left.BackgroundTransparency = 0.18
    left.Text = "<"
    left.TextColor3 = COLORS.white
    left.TextSize = 12
    left.Font = Enum.Font.GothamMedium
    left.Size = UDim2.new(0,44,0,25)
    left.Position = UDim2.new(0,0,0,22)
    left.BorderSizePixel = 0
    left.ZIndex = 6
    left.Parent = row
    corner(left, 7)
    stroke(left, COLORS.strokeSoft, 1, 0.45)
    animationPackValueLabel = Instance.new("TextLabel")
    animationPackValueLabel.Name = "AnimationPackValue"
    animationPackValueLabel.BackgroundColor3 = Color3.fromRGB(8,8,12)
    animationPackValueLabel.BackgroundTransparency = 0.18
    animationPackValueLabel.BorderSizePixel = 0
    animationPackValueLabel.Text = selectedAnimationPack
    animationPackValueLabel.TextColor3 = COLORS.white
    animationPackValueLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    animationPackValueLabel.TextStrokeTransparency = 1
    animationPackValueLabel.TextSize = 11
    animationPackValueLabel.Font = Enum.Font.GothamMedium
    animationPackValueLabel.TextXAlignment = Enum.TextXAlignment.Center
    animationPackValueLabel.Size = UDim2.new(1,-96,0,28)
    animationPackValueLabel.Position = UDim2.new(0,48,0,22)
    animationPackValueLabel.ZIndex = 6
    animationPackValueLabel.Parent = row
    corner(animationPackValueLabel,7)
    stroke(animationPackValueLabel,COLORS.strokeSoft,1,0.45)


    local rowAnimationPackValueLabel = animationPackValueLabel

    local more = Instance.new("TextButton")
    more.Name = "MoreAnimations"
    more.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    more.BackgroundTransparency = 0.18
    more.Text = "MORE"
    more.TextColor3 = COLORS.white
    more.TextSize = 9
    more.Font = Enum.Font.GothamMedium
    more.Size = UDim2.new(0, 52, 0, 28)
    more.Position = UDim2.new(0, 116, 0.5, -14)
    more.BorderSizePixel = 0
    more.ZIndex = 6
    more.Parent = row
    more.Visible = false
    corner(more, 8)
    stroke(more, COLORS.strokeSoft, 1, 0.45)

    local function getPackThumb(packName)
        if packName == "OFF" then
            local ok, img = pcall(function()
                return Players:GetUserThumbnailAsync(
                    LP.UserId,
                    Enum.ThumbnailType.AvatarBust,
                    Enum.ThumbnailSize.Size150x150
                )
            end)
            if ok then return img end
            return ""
        end
        if packName == "Unwalk" then
            return "rbxassetid://71408678974152"
        end
        local pack = AnimationPacks[packName]
        local idle = pack and pack.idle and pack.idle[1] and pack.idle[1][1]
        local id = idle and tostring(idle):match("(%d+)")
        if id then
            return "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
        end
        return ""
    end



    local function resolveBundleMappings(bundledItems)
        local mappings = {}
        if type(bundledItems) ~= "table" then return mappings end

        for _, assetIds in pairs(bundledItems) do
            if type(assetIds) == "table" then
                for _, assetId in pairs(assetIds) do
                    local success, objects = pcall(function()
                        return game:GetObjects("rbxassetid://" .. tostring(assetId))
                    end)
                    if success and objects then
                        local function searchTree(parent, parentPath)
                            for _, child in pairs(parent:GetChildren()) do
                                if child:IsA("Animation") then
                                    local animationPath = parentPath .. "." .. child.Name
                                    local pathParts = animationPath:split(".")
                                    table.insert(mappings, {
                                        category = pathParts[#pathParts - 1],
                                        name = pathParts[#pathParts],
                                        animationId = child.AnimationId
                                    })
                                elseif #child:GetChildren() > 0 then
                                    searchTree(child, parentPath .. "." .. child.Name)
                                end
                            end
                        end

                        for _, obj in pairs(objects) do
                            searchTree(obj, obj.Name)
                            pcall(function() obj:Destroy() end)
                        end
                    end
                end
            end
        end
        return mappings
    end

    applyFullAnimationBundle = function(animationData)
        local char = LP.Character
        local animate = char and char:FindFirstChild("Animate")
        if not char or not animate then return end

        backupAnimations(char)
        if unwalkEnabled then
            disableUnwalk()
            animate = char:FindFirstChild("Animate") or char:WaitForChild("Animate", 2)
            if not animate then return end
        end

        local mappings = resolveBundleMappings(animationData.bundledItems)
        if #mappings == 0 then
            if showActionNotification then
                pcall(function() showActionNotification("ANIMATION DATA NOT FOUND") end)
            end
            return
        end

        stopCurrentAnimations(char)

        for _, m in ipairs(mappings) do
            local cat = tostring(m.category or ""):lower()
            local name = tostring(m.name or "")
            local folder = animate:FindFirstChild(cat)
            if folder then
                local target = folder:FindFirstChild(name)
                if not target then
                    if cat == "walk" then target = folder:FindFirstChild("WalkAnim")
                    elseif cat == "run" then target = folder:FindFirstChild("RunAnim")
                    elseif cat == "jump" then target = folder:FindFirstChild("JumpAnim")
                    elseif cat == "fall" then target = folder:FindFirstChild("FallAnim")
                    elseif cat == "climb" then target = folder:FindFirstChild("ClimbAnim")
                    elseif cat == "swim" then target = folder:FindFirstChild("Swim")
                    elseif cat == "swimidle" then target = folder:FindFirstChild("SwimIdle")
                    elseif cat == "idle" then
                        target = folder:FindFirstChild(name) or folder:FindFirstChild("Animation1")
                    end
                end
                setAnimId(target, m.animationId)
            end
        end

        reloadAnimate(animate)

        _G.RyzenSelectedMoreAnimationBundle = {
            id = animationData.id,
            name = animationData.name,
            bundledItems = animationData.bundledItems
        }

        selectedAnimationPack = "OFF"
        syncAnimationPackIndex()
        if refreshAnimationPackRow then refreshAnimationPackRow() end
        if saveRyzenConfig then pcall(saveRyzenConfig) end

        if showActionNotification then
            pcall(function() showActionNotification("ANIMATION - " .. tostring(animationData.name or animationData.id)) end)
        end
    end

    local function openAnimationGallery()
        local existing = PlayerGui:FindFirstChild("RyzenAnimationGallery")
        if existing then existing:Destroy() end

        local sg = Instance.new("ScreenGui")
        sg.Name = "RyzenAnimationGallery"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.DisplayOrder = 99999
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        safeParentGui(sg)

        local shade = Instance.new("TextButton")
        shade.Text = ""
        shade.AutoButtonColor = false
        shade.BackgroundColor3 = Color3.fromRGB(0,0,0)
        shade.BackgroundTransparency = 0.25
        shade.Size = UDim2.fromScale(1,1)
        shade.ZIndex = 1
        shade.Parent = sg

        local panel = Instance.new("Frame")
        panel.AnchorPoint = Vector2.new(0.5,0.5)
        panel.Position = UDim2.fromScale(0.5,0.5)
        panel.Size = UDim2.new(0, 540, 0, 480)
        panel.BackgroundColor3 = Color3.fromRGB(10,10,15)
        panel.BackgroundTransparency = 0.04
        panel.BorderSizePixel = 0
        panel.ZIndex = 2
        panel.Parent = sg
        corner(panel,16)
        stroke(panel,COLORS.strokeSoft,1.2,0.15)

        pcall(function()
            local selectedColor = (_G.RyzenThemeColors and _G.RyzenThemeColors[_G.RyzenThemeName])
                or Color3.fromRGB(255,255,255)

            panel.BackgroundColor3 = selectedColor:Lerp(Color3.fromRGB(8,8,12), 0.78)

            local exactImage = nil
            local exactColor = selectedColor
            local exactTransparency = 0

            
            if BgImage and BgImage.Parent and BgImage.Visible and BgImage.Image and BgImage.Image ~= "" then
                exactImage = BgImage.Image
                exactColor = BgImage.ImageColor3
                exactTransparency = BgImage.ImageTransparency
            elseif currentBackground and tonumber(currentBackground) and tonumber(currentBackground) > 0
                and BackgroundIDs and BackgroundIDs[tonumber(currentBackground)] then
                exactImage = "rbxassetid://" .. tostring(BackgroundIDs[tonumber(currentBackground)])
            end

            if exactImage and exactImage ~= "" then
                local image = Instance.new("ImageLabel")
                image.Name = "ThemeBackground"
                image.BackgroundTransparency = 1
                image.Size = UDim2.fromScale(1,1)
                image.Position = UDim2.fromScale(0,0)
                image.Image = exactImage
                image.ImageColor3 = exactColor
                image.ImageTransparency = exactTransparency
                image.ScaleType = Enum.ScaleType.Crop
                image.ZIndex = 2
                image.Parent = panel
                corner(image,16)

                local wash = Instance.new("Frame")
                wash.Name = "BackgroundWash"
                wash.BackgroundColor3 = Color3.fromRGB(0,0,0)
                wash.BackgroundTransparency = 0.52
                wash.BorderSizePixel = 0
                wash.Size = UDim2.fromScale(1,1)
                wash.ZIndex = 2
                wash.Parent = panel
                corner(wash,16)
            end
        end)

        if UserInputService.TouchEnabled then
            panel.Size = UDim2.new(0.95,0,0.80,0)
        end

        
        do
            local dragging = false
            local dragStart = nil
            local startPos = nil

            local function updateDrag(input)
                if not dragging or not dragStart or not startPos then return end
                local delta = input.Position - dragStart
                panel.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end

            panel.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = panel.Position

                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch then
                    updateDrag(input)
                end
            end)
        end

        local title = Instance.new("TextLabel")
        title.BackgroundTransparency = 1
        title.Text = "ALL ANIMATION BUNDLES"
        title.TextColor3 = COLORS.white
        title.Font = Enum.Font.GothamMedium
        title.TextSize = 14
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Position = UDim2.new(0,16,0,10)
        title.Size = UDim2.new(1,-60,0,28)
        title.ZIndex = 3
        title.Parent = panel

        local sub = Instance.new("TextLabel")
        sub.BackgroundTransparency = 1
        sub.Text = "Online + Offsale animation bundles"
        sub.TextColor3 = Color3.fromRGB(175,175,185)
        sub.Font = Enum.Font.GothamMedium
        sub.TextSize = 11
        sub.TextXAlignment = Enum.TextXAlignment.Left
        sub.Position = UDim2.new(0,16,0,34)
        sub.Size = UDim2.new(1,-60,0,20)
        sub.ZIndex = 3
        sub.Parent = panel

        local close = Instance.new("TextButton")
        close.Text = "X"
        close.Font = Enum.Font.GothamMedium
        close.TextSize = 12
        close.TextColor3 = COLORS.white
        close.BackgroundColor3 = Color3.fromRGB(18,18,24)
        close.BackgroundTransparency = 0.08
        close.Size = UDim2.fromOffset(32,32)
        close.Position = UDim2.new(1,-42,0,8)
        close.BorderSizePixel = 0
        close.ZIndex = 4
        close.Parent = panel
        corner(close,9)

        local searchBox = Instance.new("TextBox")
        searchBox.PlaceholderText = "Search bundle / ID..."
        searchBox.Text = ""
        searchBox.ClearTextOnFocus = false
        searchBox.Font = Enum.Font.GothamMedium
        searchBox.TextSize = 12
        searchBox.TextColor3 = COLORS.white
        searchBox.PlaceholderColor3 = Color3.fromRGB(135,135,145)
        searchBox.BackgroundColor3 = Color3.fromRGB(16,16,22)
        searchBox.BackgroundTransparency = 0.06
        searchBox.BorderSizePixel = 0
        searchBox.Position = UDim2.new(0,14,0,60)
        searchBox.Size = UDim2.new(1,-28,0,32)
        searchBox.ZIndex = 3
        searchBox.Parent = panel
        corner(searchBox,9)
        stroke(searchBox,COLORS.strokeSoft,1,0.5)

        local scroll = Instance.new("ScrollingFrame")
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.Position = UDim2.new(0,10,0,102)
        scroll.Size = UDim2.new(1,-20,1,-116)
        scroll.ScrollBarThickness = 4
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.CanvasSize = UDim2.new(0,0,0,0)
        scroll.ZIndex = 3
        scroll.Parent = panel

        local grid = Instance.new("UIGridLayout")
        grid.CellSize = UDim2.fromOffset(122,145)
        grid.CellPadding = UDim2.fromOffset(8,8)
        grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
        grid.SortOrder = Enum.SortOrder.LayoutOrder
        grid.Parent = scroll

        local status = Instance.new("TextLabel")
        status.BackgroundTransparency = 1
        status.Text = "Loading..."
        status.TextColor3 = Color3.fromRGB(160,160,170)
        status.Font = Enum.Font.GothamMedium
        status.TextSize = 10
        status.TextXAlignment = Enum.TextXAlignment.Left
        status.Position = UDim2.new(0,16,1,-27)
        status.Size = UDim2.new(1,-32,0,20)
        status.ZIndex = 4
        status.Parent = panel

        local allAnimations = {}

        local function clearCards()
            for _, child in ipairs(scroll:GetChildren()) do
                if child:IsA("GuiButton") then child:Destroy() end
            end
        end

        local function addCard(item, order)
            local card = Instance.new("TextButton")
            card.Text = ""
            card.AutoButtonColor = false
            card.BackgroundColor3 = Color3.fromRGB(16,16,22)
            card.BackgroundTransparency = 0.07
            card.BorderSizePixel = 0
            card.LayoutOrder = order
            card.ZIndex = 4
            card.Parent = scroll
            corner(card,11)
            stroke(card,COLORS.strokeSoft,1,0.55)

            local img = Instance.new("ImageLabel")
            img.BackgroundColor3 = Color3.fromRGB(7,7,11)
            img.BackgroundTransparency = 0.12
            img.BorderSizePixel = 0
            img.Image = "rbxthumb://type=BundleThumbnail&id=" .. tostring(item.id) .. "&w=150&h=150"
            img.ScaleType = Enum.ScaleType.Fit
            img.Position = UDim2.new(0,7,0,7)
            img.Size = UDim2.new(1,-14,0,92)
            img.ZIndex = 5
            img.Parent = card
            corner(img,8)

            local name = Instance.new("TextLabel")
            name.BackgroundTransparency = 1
            name.Text = tostring(item.name or ("Animation " .. tostring(item.id)))
            name.TextColor3 = COLORS.white
            name.Font = Enum.Font.GothamMedium
            name.TextSize = 10
            name.TextWrapped = true
            name.TextYAlignment = Enum.TextYAlignment.Top
            name.Position = UDim2.new(0,6,0,104)
            name.Size = UDim2.new(1,-12,0,32)
            name.ZIndex = 5
            name.Parent = card

            card.MouseButton1Click:Connect(function()
                applyFullAnimationBundle(item)
                if sg and sg.Parent then
                    sg:Destroy()
                end
            end)
        end

        local function render()
            clearCards()
            local q = (searchBox.Text or ""):lower()
            local count = 0
            for _, item in ipairs(allAnimations) do
                local match = q == "" or tostring(item.id) == q or tostring(item.name or ""):lower():find(q,1,true)
                if match then
                    count += 1
                    addCard(item,count)
                end
            end
            status.Text = tostring(count) .. " animation bundles"
        end

        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            task.defer(render)
        end)

        close.MouseButton1Click:Connect(function() sg:Destroy() end)
        

        task.spawn(function()
            local seen = {}
            local urls = {
                "https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniper.json",
                "https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniperoffsale.json"
            }

            for _, url in ipairs(urls) do
                local ok, body = pcall(function() return game:HttpGet(url) end)
                if ok and body and body ~= "" then
                    local ok2, data = pcall(function() return HttpService:JSONDecode(body) end)
                    if ok2 and data then
                        for _, item in pairs(data.data or {}) do
                            local id = tonumber(item.id)
                            if id and id > 0 and not seen[id] and item.bundledItems then
                                seen[id] = true
                                table.insert(allAnimations, {
                                    id = id,
                                    name = item.name or ("Animation_" .. tostring(id)),
                                    bundledItems = item.bundledItems
                                })
                            end
                        end
                    end
                end
            end

            table.sort(allAnimations,function(a,b)
                return tostring(a.name or ""):lower() < tostring(b.name or ""):lower()
            end)
            render()
        end)
    end

    more.MouseButton1Click:Connect(openAnimationGallery)

    local right = Instance.new("TextButton")
    right.Name = "RightArrow"
    right.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    right.BackgroundTransparency = 0.18
    right.Text = ">"
    right.TextColor3 = COLORS.white
    right.TextSize = 12
    right.Font = Enum.Font.GothamMedium
    right.Size = UDim2.new(0,44,0,25)
    right.Position = UDim2.new(1,-44,0,22)
    right.BorderSizePixel = 0
    right.ZIndex = 6
    right.Parent = row
    corner(right, 7)
    stroke(right, COLORS.strokeSoft, 1, 0.45)
    local function setPackIndex(nextIndex)
    if nextIndex < 1 then nextIndex = #AnimationPackList end
    if nextIndex > #AnimationPackList then nextIndex = 1 end

    AnimationPackIndex = nextIndex
    local chosenPack = AnimationPackList[AnimationPackIndex] or "OFF"
    _G.RyzenSelectedMoreAnimationBundle = nil


    selectedAnimationPack = chosenPack


    if rowAnimationPackValueLabel and rowAnimationPackValueLabel.Parent then
        rowAnimationPackValueLabel.Text = chosenPack
    end
    refreshAnimationPackRow()



    applyAnimationPack(chosenPack)


    task.defer(function()
        if rowAnimationPackValueLabel and rowAnimationPackValueLabel.Parent then
            rowAnimationPackValueLabel.Text = chosenPack
        end
        if selectedAnimationPack == chosenPack then
            refreshAnimationPackRow()
        end
    end)

    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    left.MouseButton1Click:Connect(function()
    setPackIndex(AnimationPackIndex - 1)
    end)
    right.MouseButton1Click:Connect(function()
    setPackIndex(AnimationPackIndex + 1)
    end)
    return row
    end
    function keyName(key)
    if not key then return "None" end
    local name = tostring(key):gsub("Enum.KeyCode.", "")
    name = name:gsub("Button", "BTN ")
    name = name:gsub("DPad", "DPad ")
    return name
    end
    function refreshSpeedKeybindButton(keyId)
    local btn = speedKeybindButtons[keyId]
    if btn then
    if listeningForSpeedKey == keyId then
    btn.Text = "Press..."
    else
    btn.Text = keyName(speedKeybinds[keyId])
    end
    end
    end
    function refreshAllSpeedKeybinds()
    for keyId in pairs(speedKeybindButtons) do
    refreshSpeedKeybindButton(keyId)
    end
    end
    function refreshTPDownKeybind()
    if tpDownKeybindButton then
    tpDownKeybindButton.Text = listeningForTPDownKey and "Press..." or keyName(tpDownKeybind)
    end
    end
    function tpDownKeybindRow(parent, order)
    local row = baseRow(parent, "TP Down", order)
    local btn = Instance.new("TextButton")
    btn.Name = "TPDownKeybindButton"
    btn.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    btn.BackgroundTransparency = 0.18
    btn.Text = keyName(tpDownKeybind)
    btn.TextColor3 = COLORS.white
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamMedium
    btn.Size = UDim2.new(0, 56, 0, 24)
    btn.Position = UDim2.new(1, -64, 0.5, -12)
    btn.BorderSizePixel = 0
    btn.ZIndex = 6
    btn.AutoButtonColor = false
    btn.Parent = row
    corner(btn, 14)
    stroke(btn, COLORS.strokeSoft, 1, 0.45)
    local clearBtn = Instance.new("TextButton")
    clearBtn.Name = "ClearKeybindButton"
    clearBtn.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    clearBtn.BackgroundTransparency = 0.18
    clearBtn.Text = "X"
    clearBtn.TextColor3 = COLORS.white
    clearBtn.TextSize = 14
    clearBtn.Font = Enum.Font.GothamMedium
    clearBtn.Size = UDim2.new(0, 22, 0, 24)
    clearBtn.Position = UDim2.new(1, -90, 0.5, -12)
    clearBtn.BorderSizePixel = 0
    clearBtn.ZIndex = 6
    clearBtn.AutoButtonColor = false
    clearBtn.Parent = row
    corner(clearBtn, 7)
    stroke(clearBtn, COLORS.strokeSoft, 1, 0.45)
    tpDownKeybindButton = btn
    btn.Activated:Connect(function()
    listeningForSpeedKey = nil
    listeningForTPDownKey = true
    keybindListenStartedAt = tick()
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    task.delay(3, function()
    if listeningForTPDownKey then
    listeningForTPDownKey = false
    refreshTPDownKeybind()
    end
    end)
    end)
    clearBtn.Activated:Connect(function()
    listeningForSpeedKey = nil
    listeningForTPDownKey = false
    tpDownKeybind = nil
    if tpDownKeybindButton then tpDownKeybindButton.Text = "None" end
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    return row, btn
    end
    function speedKeybindRow(parent, labelText, keyId, order)
    local row = baseRow(parent, labelText, order)
    local btn = Instance.new("TextButton")
    btn.Name = "KeybindButton"
    btn.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    btn.BackgroundTransparency = 0.18
    btn.Text = keyName(speedKeybinds[keyId])
    btn.TextColor3 = COLORS.white
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamMedium
    btn.Size = UDim2.new(0, 56, 0, 24)
    btn.Position = UDim2.new(1, -64, 0.5, -12)
    btn.BorderSizePixel = 0
    btn.ZIndex = 6
    btn.AutoButtonColor = false
    btn.Parent = row
    corner(btn, 14)
    stroke(btn, COLORS.strokeSoft, 1, 0.45)
    local clearBtn = Instance.new("TextButton")
    clearBtn.Name = "ClearKeybindButton"
    clearBtn.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    clearBtn.BackgroundTransparency = 0.18
    clearBtn.Text = "X"
    clearBtn.TextColor3 = COLORS.white
    clearBtn.TextSize = 14
    clearBtn.Font = Enum.Font.GothamMedium
    clearBtn.Size = UDim2.new(0, 22, 0, 24)
    clearBtn.Position = UDim2.new(1, -90, 0.5, -12)
    clearBtn.BorderSizePixel = 0
    clearBtn.ZIndex = 6
    clearBtn.AutoButtonColor = false
    clearBtn.Parent = row
    corner(clearBtn, 7)
    stroke(clearBtn, COLORS.strokeSoft, 1, 0.45)
    speedKeybindButtons[keyId] = btn
    btn.Activated:Connect(function()
    listeningForSpeedKey = keyId
    listeningForTPDownKey = false
    keybindListenStartedAt = tick()
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    task.delay(3, function()
    if listeningForSpeedKey == keyId then
    listeningForSpeedKey = nil
    refreshAllSpeedKeybinds()
    end
    end)
    end)
    clearBtn.Activated:Connect(function()
    listeningForSpeedKey = nil
    listeningForTPDownKey = false
    speedKeybinds[keyId] = nil
    if speedKeybindButtons[keyId] then speedKeybindButtons[keyId].Text = "None" end
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    return row, btn
    end
    local normalModeValueLabel = nil
    local laggerModeValueLabel = nil
    local aimbotButtonLabel = nil
    local aimbotSpeedLabel = nil
    local laggerAimbotSpeedLabel = nil
    local combatAimbotKeybindLabel = nil
    function getAimbotModeDisplay()
    if selectedAimbotMode == "Anti Bypass" or selectedAimbotMode == "Bypass" then
    return "Anti Bypass"
    end
    return "Normal"
    end
    function refreshAimbotButtonLabel()
    if aimbotButtonLabel then
    aimbotButtonLabel.Text = getAimbotModeDisplay() .. " Aimbot"
    end
    end
    function refreshAimbotModeLabels()
    local modeName = getAimbotModeDisplay()
    if aimbotSpeedLabel then
    aimbotSpeedLabel.Text = modeName .. " Aimbot Speed"
    end
    if laggerAimbotSpeedLabel then
    laggerAimbotSpeedLabel.Text = modeName .. " Lagger Aimbot Speed"
    end
    if combatAimbotKeybindLabel then
    combatAimbotKeybindLabel.Text = modeName .. " Aimbot"
    end
    refreshAimbotButtonLabel()
    end
    refreshSpeedModeRows = function()
    if normalModeValueLabel then
    normalModeValueLabel.Text = (currentSpeedMode == "Carry") and "Carry" or "Normal"
    end
    if laggerModeValueLabel then
    laggerModeValueLabel.Text = (currentSpeedMode == "Lagger Carry") and "Lagger Carry" or "Lagger"
    end
    end
    -- =============================================================
    -- ACTION TOAST
    -- showActionNotification() is called in ~8 places in this Ryzen Hub but was
    -- never defined anywhere, so _safeNotify() and every one of those calls
    -- silently did nothing. Defining it here also gives the Mode rows real
    -- confirmation that a tap landed.
    -- =============================================================
    local _toastGui = nil
    local _toastLabel = nil
    local _toastToken = 0
    function showActionNotification(msg)
    if _G.RyzenNotificationsEnabled == false then return end
    pcall(function()
    if not _toastGui or not _toastGui.Parent then
    _toastGui = Instance.new("ScreenGui")
    _toastGui.Name = "RyzenActionToast"
    _toastGui.ResetOnSpawn = false
    _toastGui.IgnoreGuiInset = true
    _toastGui.DisplayOrder = 1000
    _toastGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    safeParentGui(_toastGui)
    local holder = Instance.new("Frame")
    holder.Name = "Holder"
    holder.AnchorPoint = Vector2.new(0.5, 0)
    holder.Position = UDim2.new(0.5, 0, 0, 14)
    holder.Size = UDim2.new(0, 250, 0, 34)
    holder.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    holder.BackgroundTransparency = 0.15
    holder.BorderSizePixel = 0
    holder.Visible = false
    holder.ZIndex = 20
    holder.Parent = _toastGui
    corner(holder, 10)
    stroke(holder, Color3.fromRGB(255, 255, 255), 1, 0.55)
    _toastLabel = Instance.new("TextLabel")
    _toastLabel.Name = "Text"
    _toastLabel.BackgroundTransparency = 1
    _toastLabel.Size = UDim2.new(1, -16, 1, 0)
    _toastLabel.Position = UDim2.new(0, 8, 0, 0)
    _toastLabel.Font = Enum.Font.GothamBold
    _toastLabel.TextSize = 13
    _toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    _toastLabel.ZIndex = 21
    _toastLabel.Text = ""
    _toastLabel.Parent = holder
    end
    local holder = _toastGui and _toastGui:FindFirstChild("Holder")
    if not holder or not _toastLabel then return end
    _toastLabel.Text = tostring(msg)
    _toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    holder.Visible = true
    _toastToken = _toastToken + 1
    local myToken = _toastToken
    task.delay(1.4, function()
    if myToken == _toastToken and holder and holder.Parent then
    holder.Visible = false
    end
    end)
    end)
    end
    _G.RyzenToast = showActionNotification
    -- =============================================================
    -- MODE ROW  (Normal <-> Carry  /  Lagger <-> Lagger Carry)
    -- Rebuilt. The old row was an invisible full-size TextButton with
    -- AutoButtonColor off: no pill, no press feedback, and it only listened
    -- for MouseButton1Click. Now the mode sits in a real tappable pill (same
    -- look as the dropdown rows), every input path is wired, the call is
    -- guarded, and a Heartbeat sync keeps the text equal to the live value
    -- of currentSpeedMode - so if anything ever overrides the mode you see
    -- it happen instead of guessing.
    -- =============================================================
    _G.RyzenModePills = _G.RyzenModePills or {}
    function modeDisplayRow(parent, order, side)
    local row = baseRow(parent, "Mode", order)
    row.Size = UDim2.new(1, -4, 0, 34)
    row.BackgroundTransparency = 0.3
    local label = row:FindFirstChild("Label")
    if label then
    label.Text = "Mode"
    label.TextSize = 11
    label.Size = UDim2.new(1, -132, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.TextColor3 = Color3.fromRGB(245, 245, 255)
    end

    -- the tappable pill
    local value = Instance.new("TextButton")
    value.Name = "ModeValue"
    value.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    value.BackgroundTransparency = 0.18
    value.BorderSizePixel = 0
    value.AutoButtonColor = false
    value.Active = true
    value.Selectable = true
    value.Text = (side == "Normal") and "Normal" or "Lagger"
    value.TextColor3 = Color3.fromRGB(255, 255, 255)
    value.TextSize = 11
    value.Font = Enum.Font.GothamBold
    value.Size = UDim2.new(0, 104, 0, 26)
    value.Position = UDim2.new(1, -114, 0.5, -13)
    value.ZIndex = 30
    value.Parent = row
    corner(value, 7)
    stroke(value, COLORS.strokeSoft, 1, 0.45)

    -- whole row stays tappable as a fallback
    local click = Instance.new("TextButton")
    click.Name = "ModeClick"
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Size = UDim2.new(1, 0, 1, 0)
    click.Position = UDim2.new(0, 0, 0, 0)
    click.AutoButtonColor = false
    click.Active = true
    click.ZIndex = 8
    click.Parent = row

    if side == "Normal" then
    normalModeValueLabel = value
    else
    laggerModeValueLabel = value
    end

    local _modeLastFire = 0
    local function _fireModeSwitch()
    if tick() - _modeLastFire < 0.15 then return end
    _modeLastFire = tick()

    -- press flash
    pcall(function()
    value.BackgroundTransparency = 0.02
    task.delay(0.12, function()
    if value and value.Parent then value.BackgroundTransparency = 0.18 end
    end)
    end)

    local target
    if side == "Normal" then
    target = (currentSpeedMode == "Normal") and "Carry" or "Normal"
    else
    target = (currentSpeedMode == "Lagger") and "Lagger Carry" or "Lagger"
    end

    local apply = setSpeedMode or _G.RyzenSetSpeedMode
    if type(apply) ~= "function" then
    showActionNotification("MODE SWITCH - NO HANDLER")
    return
    end
    local ok, err = pcall(apply, target)
    if not ok then
    warn("[RYZEN] setSpeedMode failed: " .. tostring(err))
    showActionNotification("MODE SWITCH ERROR")
    return
    end
    if currentSpeedMode ~= target then
    showActionNotification("MODE BLOCKED - STUCK ON " .. string.upper(tostring(currentSpeedMode)))
    else
    showActionNotification("MODE - " .. string.upper(tostring(currentSpeedMode))
    .. "  (" .. tostring(math.floor((getCurrentSpeedValue and getCurrentSpeedValue()) or 0)) .. ")")
    end
    if refreshSpeedModeRows then pcall(refreshSpeedModeRows) end
    end

    value.Activated:Connect(_fireModeSwitch)
    value.MouseButton1Click:Connect(_fireModeSwitch)
    click.Activated:Connect(_fireModeSwitch)
    click.MouseButton1Click:Connect(_fireModeSwitch)
    click.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
    _fireModeSwitch()
    end
    end)

    table.insert(_G.RyzenModePills, {pill = value, side = side})
    -- Respect Modes gui visibility
    if value and value.Parent then
        value.Visible = (_G.RyzenModesGuiEnabled == true)
    end
    refreshSpeedModeRows()
    return row, value
    end

    -- Live sync + override watchdog. refreshSpeedModeRows() only ran when
    -- something remembered to call it; this guarantees the pills always show
    -- the truth, and reports any mode change the player did not ask for.
    do
    local _lastSeenMode = nil
    local _modeSyncAcc = 0
    game:GetService("RunService").Heartbeat:Connect(function(dt)
    _modeSyncAcc = _modeSyncAcc + (dt or 0.016)
    if _modeSyncAcc < 0.12 then return end
    _modeSyncAcc = 0
    local mode = currentSpeedMode
    for i = #_G.RyzenModePills, 1, -1 do
    local entry = _G.RyzenModePills[i]
    local pill = entry and entry.pill
    if not pill or not pill.Parent then
    table.remove(_G.RyzenModePills, i)
    else
    if entry.side == "Normal" then
    pill.Text = (mode == "Carry") and "Carry" or "Normal"
    else
    pill.Text = (mode == "Lagger Carry") and "Lagger Carry" or "Lagger"
    end
    -- Modes gui: keep visibility glued to the toggle. The one-shot apply at
    -- boot / on click could be undone by any stray Visible write; this makes
    -- the toggle self-healing.
    local wantVis = (_G.RyzenModesGuiEnabled == true)
    if pill.Visible ~= wantVis then
    pill.Visible = wantVis
    end
    end
    end
    if _lastSeenMode == nil then
    _lastSeenMode = mode
    elseif _lastSeenMode ~= mode then
    _lastSeenMode = mode
    -- changed by something other than a tap or a keybind
    if State and State._manualModeMark and tick() - State._manualModeMark > 0.4 then
    showActionNotification("MODE FORCED TO " .. string.upper(tostring(mode)))
    end
    end
    end)
    end

    function aimbotModeButtonRow(parent, order)
    local row, setVisual = toggleRow(parent, tostring(selectedAimbotMode) .. " Aimbot", false, order)
    aimbotButtonLabel = row and row:FindFirstChild("Label")
    _G.RyzenAimbotSetVisual = setVisual
    refreshAimbotButtonLabel()
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end

    local toggleBtn = row and row:FindFirstChild("ToggleButton")
    if toggleBtn then
    toggleBtn.Size = UDim2.new(0, 54, 1, 0)
    toggleBtn.Position = UDim2.new(1, -54, 0, 0)
    toggleBtn.Activated:Connect(function()
    if _G.RyzenToggleSelectedAimbot then
    _G.RyzenToggleSelectedAimbot()
    end
    end)
    end

    local arrow = Instance.new("TextButton")
    arrow.Name = "ArrowButton"
    arrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    arrow.BackgroundTransparency = 0.08
    arrow.BorderSizePixel = 0
    arrow.Text = "v"
    arrow.TextColor3 = COLORS.white
    arrow.TextSize = 12
    arrow.Font = Enum.Font.GothamMedium
    arrow.AutoButtonColor = false
    arrow.Size = UDim2.new(0, 36, 0, 28)
    arrow.Position = UDim2.new(1, -100, 0.5, -14)
    arrow.ZIndex = 20
    arrow.Parent = row
    corner(arrow, 14)
    stroke(arrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    return row, setVisual, arrow
    end
    _G.RyzenAimbotSelectorRow = function(parent, order)
    local holder = Instance.new("Frame")
    holder.Name = "Aimbot Mode"
    holder.BackgroundColor3 = COLORS.row
    holder.BackgroundTransparency = 0.28
    holder.Size = UDim2.new(1, -4, 0, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.ZIndex = 4
    holder.ClipsDescendants = true
    holder.Parent = parent
    corner(holder, 9)
    stroke(holder, COLORS.strokeSoft, 1.15, 0.38)
    local slide = Instance.new("Frame")
    slide.Name = "SelectedSlide"
    slide.BackgroundColor3 = Color3.fromRGB(58, 58, 64)
    slide.BackgroundTransparency = 0.08
    slide.Size = UDim2.new(0.5, -3, 1, -8)
    slide.Position = UDim2.new(0, 4, 0, 4)
    slide.BorderSizePixel = 0
    slide.ZIndex = 5
    slide.Parent = holder
    corner(slide, 9)
    local slideStroke = Instance.new("UIStroke")
    slideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    slideStroke.Color = Color3.fromRGB(235, 235, 245)
    slideStroke.Thickness = 1
    slideStroke.Transparency = 0.08
    slideStroke.Parent = slide
    local slideGradient = Instance.new("UIGradient")
    slideGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 28)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(46, 46, 52)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)),
    })
    slideGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.08),
    NumberSequenceKeypoint.new(0.5, 0.02),
    NumberSequenceKeypoint.new(1, 0.08),
    })
    slideGradient.Parent = slide
    local normalText = Instance.new("TextLabel")
    normalText.Name = "NormalText"
    normalText.BackgroundTransparency = 1
    normalText.Text = "NORMAL"
    normalText.TextColor3 = COLORS.white
    normalText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    normalText.TextStrokeTransparency = 1
    normalText.TextSize = 11
    normalText.Font = Enum.Font.GothamMedium
    normalText.TextXAlignment = Enum.TextXAlignment.Center
    normalText.Size = UDim2.new(0.5, 0, 1, 0)
    normalText.Position = UDim2.new(0, 0, 0, 0)
    normalText.ZIndex = 8
    normalText.Parent = holder
    local bypassText = Instance.new("TextLabel")
    bypassText.Name = "BypassText"
    bypassText.BackgroundTransparency = 1
    bypassText.Text = "BYPASS"
    bypassText.TextColor3 = COLORS.white
    bypassText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    bypassText.TextStrokeTransparency = 1
    bypassText.TextSize = 10
    bypassText.Font = Enum.Font.GothamMedium
    bypassText.TextXAlignment = Enum.TextXAlignment.Center
    bypassText.Size = UDim2.new(0.5, 0, 1, 0)
    bypassText.Position = UDim2.new(0.5, 0, 0, 0)
    bypassText.ZIndex = 8
    bypassText.Parent = holder
    local normalClick = Instance.new("TextButton")
    normalClick.Name = "NormalClick"
    normalClick.BackgroundTransparency = 1
    normalClick.Text = ""
    normalClick.AutoButtonColor = false
    normalClick.Size = UDim2.new(0.5, 0, 1, 0)
    normalClick.Position = UDim2.new(0, 0, 0, 0)
    normalClick.ZIndex = 10
    normalClick.Parent = holder
    local bypassClick = Instance.new("TextButton")
    bypassClick.Name = "BypassClick"
    bypassClick.BackgroundTransparency = 1
    bypassClick.Text = ""
    bypassClick.AutoButtonColor = false
    bypassClick.Size = UDim2.new(0.5, 0, 1, 0)
    bypassClick.Position = UDim2.new(0.5, 0, 0, 0)
    bypassClick.ZIndex = 10
    bypassClick.Parent = holder
    local function setMode(mode)
    if mode == "Bypass" then
    mode = "Anti Bypass"
    elseif mode ~= "Anti Bypass" then
    mode = "Normal"
    end
    selectedAimbotMode = mode
    refreshAimbotModeLabels()
    if _G.RyzenRefreshAimbotSpeedBoxes then _G.RyzenRefreshAimbotSpeedBoxes() end
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    local onBypass = selectedAimbotMode == "Anti Bypass"
    tween(slide, {
    Position = onBypass and UDim2.new(0.5, -1, 0, 4) or UDim2.new(0, 4, 0, 4)
    }, 0.18)
    tween(normalText, {
    TextTransparency = onBypass and 0.18 or 0,
    TextStrokeTransparency = onBypass and 0.38 or 0.2
    }, 0.14)
    tween(bypassText, {
    TextTransparency = onBypass and 0 or 0.18,
    TextStrokeTransparency = onBypass and 0.2 or 0.38
    }, 0.14)
    end
    normalClick.MouseButton1Click:Connect(function()
    setMode("Normal")
    end)
    bypassClick.MouseButton1Click:Connect(function()
    setMode("Anti Bypass")
    end)
    setMode(selectedAimbotMode)
    return holder, setMode
    end
    function autoStealSelectorRow(parent, order)
    local holder = Instance.new("Frame")
    holder.Name = "Auto Steal Mode"
    holder.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    holder.BackgroundTransparency = 0.08
    holder.Size = UDim2.new(1, -4, 0, 34)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.ZIndex = 4
    holder.ClipsDescendants = true
    holder.Parent = parent
    corner(holder, 14)
    stroke(holder, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    local slide = Instance.new("Frame")
    slide.Name = "SelectedSlide"
    slide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    slide.BackgroundTransparency = 0.82
    slide.Size = UDim2.new(0.5, -8, 1, -8)
    slide.Position = UDim2.new(0, 4, 0, 4)
    slide.BorderSizePixel = 0
    slide.ZIndex = 5
    slide.Parent = holder
    corner(slide, 12)
    stroke(slide, Color3.fromRGB(255, 255, 255), 1.2, 0.35)

    local modeLabels = {"AUTO STEAL", "SEMI"}
    local modeValues = {"Auto Steal", "Semi"}
    local texts, clicks = {}, {}
    for i = 1, 2 do
    local lbl = Instance.new("TextLabel")
    lbl.Name = modeLabels[i]
    lbl.BackgroundTransparency = 1
    lbl.Text = modeLabels[i]
    lbl.TextColor3 = COLORS.white
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Position = UDim2.new((i - 1) * 0.5, 0, 0, 0)
    lbl.ZIndex = 8
    lbl.Parent = holder
    texts[i] = lbl
    local btn = Instance.new("TextButton")
    btn.Name = modeLabels[i] .. "Click"
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new((i - 1) * 0.5, 0, 0, 0)
    btn.ZIndex = 9
    btn.Parent = holder
    clicks[i] = btn
    end

    local function slidePositionFor(idx)
    return UDim2.new((idx - 1) * 0.5, 4, 0, 4)
    end

    local function setMode(mode)
    if mode == "Auto Steal V3" or mode == "Auto Steal V2" then mode = "Auto Steal" end
    if mode ~= "Auto Steal" and mode ~= "Semi" then mode = "Auto Steal" end
    _G.RyzenStealRadii = _G.RyzenStealRadii or {["Auto Steal"] = 63, Semi = 9}
    -- persist radius for the mode we are leaving
    if selectedStealMode == "Semi" then
    _G.RyzenStealRadii.Semi = tonumber(autoStealRadius) or _G.RyzenStealRadii.Semi or 9
    elseif selectedStealMode == "Auto Steal" then
    _G.RyzenStealRadii["Auto Steal"] = tonumber(autoStealRadius) or _G.RyzenStealRadii["Auto Steal"] or 63
    end
    selectedStealMode = mode
    if mode == "Semi" then
    autoStealRadius = tonumber(_G.RyzenStealRadii.Semi) or 9
    else
    autoStealRadius = tonumber(_G.RyzenStealRadii["Auto Steal"]) or 63
    end
    -- update the main row label so it always shows the active mode.
    -- FIX: this used to rename `_aceRow`, but that global is reused by later
    -- rows (Bat Counter / Med Counter / Hard Hit), so every post-boot mode
    -- switch relabelled the Hard Hit row while the main row stayed
    -- "Auto Steal". The row Name is now kept fixed ("Auto Steal") so the
    -- Combat tab reorganisation's byName() lookups keep finding it.
    pcall(function()
    local row = _G.RyzenAutoStealMainRow
    or (pages and pages.COMBAT and pages.COMBAT:FindFirstChild("Auto Steal"))
    if row then
    local lab = row:FindFirstChild("Label")
    if lab then lab.Text = mode end
    end
    end)
    if autoStealRadiusBox then
    autoStealRadiusBox.Text = tostring(autoStealRadius)
    end
    if _G.RyzenV3AutoStealSetRadius then pcall(_G.RyzenV3AutoStealSetRadius, _G.RyzenStealRadii["Auto Steal"] or 63) end
    if _G.RyzenSemiAutoStealSetRadius then pcall(_G.RyzenSemiAutoStealSetRadius, _G.RyzenStealRadii.Semi or 9) end
    -- force engine onto the new mode immediately
    if _G.RyzenAutoStealSync then pcall(_G.RyzenAutoStealSync) end
    -- FIX: writing the config file (JSON encode + writefile) on every click
    -- added a hitch to the mode switch; defer it so the click stays snappy.
    if saveRyzenConfig then task.defer(function() pcall(saveRyzenConfig) end) end
    local idx = (mode == "Semi") and 2 or 1
    -- kill any in-flight tween by rewriting Size then Position
    slide.Size = UDim2.new(0.5, -8, 1, -8)
    slide.Position = slidePositionFor(idx)
    pcall(function()
    tween(slide, {Position = slidePositionFor(idx)}, 0.12)
    end)
    for i = 1, 2 do
    local active = (i == idx)
    texts[i].TextTransparency = active and 0 or 0.4
    texts[i].Font = active and Enum.Font.GothamBold or Enum.Font.GothamMedium
    pcall(function()
    tween(texts[i], {TextTransparency = active and 0 or 0.4}, 0.12)
    end)
    end
    end
    for i = 1, 2 do
    clicks[i].MouseButton1Click:Connect(function()
    setMode(modeValues[i])
    end)
    end
    -- public so other UI can force refresh
    _G.RyzenSetStealMode = setMode
    setMode(selectedStealMode or "Auto Steal")

    -- â”€â”€ Self-healing mode guard â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    -- The slide outline could get stuck on AUTO STEAL (stale tween, boot
    -- restyler, leftover GUI from a previous execution). This guard forces
    -- the pill to mirror the live selectedStealMode every frame: the outline
    -- sits on the active mode, the label styles follow, and the main row
    -- keeps its enabled ("online") toggle look in every mode.
    do
    local wantSize = UDim2.new(0.5, -8, 1, -8)
    local lastMode, lastEnabled, wrongSince = nil, nil, nil
    local function syncPillVisual()
    local mode = selectedStealMode
    local enabled = autoStealEnabled == true
    local idx = (mode == "Semi") and 2 or 1
    local wantPos = slidePositionFor(idx)
    -- give the 0.12s click tween a grace period, then snap anything stuck
    if slide.Position == wantPos then
    wrongSince = nil
    else
    local now = os.clock()
    if not wrongSince then
    wrongSince = now
    elseif now - wrongSince > 0.2 then
    slide.Position = wantPos
    slide.Size = wantSize
    wrongSince = nil
    end
    end
    if slide.Size ~= wantSize and slide.Position == wantPos then
    slide.Size = wantSize
    end
    for i = 1, 2 do
    local active = (i == idx)
    local wantT = active and 0 or 0.4
    if texts[i].TextTransparency ~= wantT then
    texts[i].TextTransparency = wantT
    end
    local wantF = active and Enum.Font.GothamBold or Enum.Font.GothamMedium
    if texts[i].Font ~= wantF then
    texts[i].Font = wantF
    end
    end
    -- re-assert the main row only when something actually changed
    if mode ~= lastMode or enabled ~= lastEnabled then
    lastMode, lastEnabled = mode, enabled
    pcall(function()
    if setAutoStealVisual then setAutoStealVisual(enabled) end
    local row = _G.RyzenAutoStealMainRow
    or (pages and pages.COMBAT and pages.COMBAT:FindFirstChild("Auto Steal"))
    if row then
    local lab = row:FindFirstChild("Label")
    if lab and lab.Text ~= mode then lab.Text = mode end
    end
    end)
    end
    end
    if _G.RyzenStealPillGuardConn then
    pcall(function() _G.RyzenStealPillGuardConn:Disconnect() end)
    end
    -- throttled to 10 checks/sec (plenty for a 0.2s snap window) so the
    -- guard itself never costs a frame
    local guardAcc = 0
    _G.RyzenStealPillGuardConn = RunService.Heartbeat:Connect(function(dt)
    guardAcc = guardAcc + (dt or 0)
    if guardAcc < 0.1 then return end
    guardAcc = 0
    syncPillVisual()
    end)
    syncPillVisual()
    end
    return holder, setMode
    end

    function infiniteJumpSelectorRow(parent, order)
    local holder = Instance.new("Frame")
    holder.Name = "Infinite Jump Mode"
    holder.BackgroundColor3 = COLORS.row
    holder.BackgroundTransparency = 0.28
    holder.Size = UDim2.new(1, -4, 0, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.ZIndex = 4
    holder.ClipsDescendants = true
    holder.Parent = parent
    corner(holder, 9)
    stroke(holder, COLORS.strokeSoft, 1.15, 0.38)

    local slide = Instance.new("Frame")
    slide.Name = "SelectedSlide"
    slide.BackgroundColor3 = Color3.fromRGB(58, 58, 64)
    slide.BackgroundTransparency = 0.08
    slide.Size = UDim2.new(0.5, -3, 1, -8)
    slide.Position = UDim2.new(0, 4, 0, 4)
    slide.BorderSizePixel = 0
    slide.ZIndex = 5
    slide.Parent = holder
    corner(slide, 9)

    local slideStroke = Instance.new("UIStroke")
    slideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    slideStroke.Color = Color3.fromRGB(235, 235, 245)
    slideStroke.Thickness = 1
    slideStroke.Transparency = 0.08
    slideStroke.Parent = slide

    local slideGradient = Instance.new("UIGradient")
    slideGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 28)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(46, 46, 52)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)),
    })
    slideGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.08),
    NumberSequenceKeypoint.new(0.5, 0.02),
    NumberSequenceKeypoint.new(1, 0.08),
    })
    slideGradient.Parent = slide

    local tapText = Instance.new("TextLabel")
    tapText.Name = "TapText"
    tapText.BackgroundTransparency = 1
    tapText.Text = "TAP"
    tapText.TextColor3 = COLORS.white
    tapText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    tapText.TextStrokeTransparency = 1
    tapText.TextSize = 11
    tapText.Font = Enum.Font.GothamMedium
    tapText.TextXAlignment = Enum.TextXAlignment.Center
    tapText.Size = UDim2.new(0.5, 0, 1, 0)
    tapText.Position = UDim2.new(0, 0, 0, 0)
    tapText.ZIndex = 8
    tapText.Parent = holder

    local holdText = Instance.new("TextLabel")
    holdText.Name = "HoldText"
    holdText.BackgroundTransparency = 1
    holdText.Text = "HOLD"
    holdText.TextColor3 = COLORS.white
    holdText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    holdText.TextStrokeTransparency = 1
    holdText.TextSize = 11
    holdText.Font = Enum.Font.GothamMedium
    holdText.TextXAlignment = Enum.TextXAlignment.Center
    holdText.Size = UDim2.new(0.5, 0, 1, 0)
    holdText.Position = UDim2.new(0.5, 0, 0, 0)
    holdText.ZIndex = 8
    holdText.Parent = holder

    local tapClick = Instance.new("TextButton")
    tapClick.Name = "TapClick"
    tapClick.BackgroundTransparency = 1
    tapClick.Text = ""
    tapClick.AutoButtonColor = false
    tapClick.Size = UDim2.new(0.5, 0, 1, 0)
    tapClick.Position = UDim2.new(0, 0, 0, 0)
    tapClick.ZIndex = 10
    tapClick.Parent = holder

    local holdClick = Instance.new("TextButton")
    holdClick.Name = "HoldClick"
    holdClick.BackgroundTransparency = 1
    holdClick.Text = ""
    holdClick.AutoButtonColor = false
    holdClick.Size = UDim2.new(0.5, 0, 1, 0)
    holdClick.Position = UDim2.new(0.5, 0, 0, 0)
    holdClick.ZIndex = 10
    holdClick.Parent = holder

    local function setMode(mode)
    if mode ~= "Hold" then
    mode = "Tap"
    end
    _G.RyzenInfJumpMode = mode
    if _G.RyzenStopNormalInfJumpHoldState then
    _G.RyzenStopNormalInfJumpHoldState()
    end
    _G.RyzenRestartInfJump()
    if saveRyzenConfig then pcall(saveRyzenConfig) end

    local onHold = _G.RyzenInfJumpMode == "Hold"
    tween(slide, {
    Position = onHold and UDim2.new(0.5, -1, 0, 4) or UDim2.new(0, 4, 0, 4)
    }, 0.18)
    tween(tapText, {
    TextTransparency = onHold and 0.18 or 0,
    TextStrokeTransparency = onHold and 0.38 or 0.2
    }, 0.14)
    tween(holdText, {
    TextTransparency = onHold and 0 or 0.18,
    TextStrokeTransparency = onHold and 0.2 or 0.38
    }, 0.14)
    end

    tapClick.MouseButton1Click:Connect(function()
    setMode("Tap")
    end)

    holdClick.MouseButton1Click:Connect(function()
    setMode("Hold")
    end)

    setMode(_G.RyzenInfJumpMode)
    return holder, setMode
    end


    function antiRagdollSelectorRow(parent, order)
    local holder = Instance.new("Frame")
    holder.Name = "Anti Ragdoll Mode"
    holder.BackgroundColor3 = COLORS.row
    holder.BackgroundTransparency = 0.28
    holder.Size = UDim2.new(1, -4, 0, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.ZIndex = 4
    holder.ClipsDescendants = true
    holder.Parent = parent
    corner(holder, 9)
    stroke(holder, COLORS.strokeSoft, 1.15, 0.38)

    local slide = Instance.new("Frame")
    slide.Name = "SelectedSlide"
    slide.BackgroundColor3 = Color3.fromRGB(58,58,64)
    slide.BackgroundTransparency = 0.08
    slide.Size = UDim2.new(0.5, -3, 1, -8)
    slide.Position = UDim2.new(0, 4, 0, 4)
    slide.BorderSizePixel = 0
    slide.ZIndex = 5
    slide.Parent = holder
    corner(slide, 9)

    local slideStroke = Instance.new("UIStroke")
    slideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    slideStroke.Color = Color3.fromRGB(235,235,245)
    slideStroke.Thickness = 1
    slideStroke.Transparency = 0.08
    slideStroke.Parent = slide

    local slideGradient = Instance.new("UIGradient")
    slideGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24,24,28)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(46,46,52)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18,18,22)),
    })
    slideGradient.Parent = slide

    local v1Text = Instance.new("TextLabel")
    v1Text.BackgroundTransparency = 1
    v1Text.Text = "ANTI RAGDOLL V1"
    v1Text.TextColor3 = COLORS.white
    v1Text.TextSize = 9
    v1Text.Font = Enum.Font.GothamMedium
    v1Text.Size = UDim2.new(0.5, 0, 1, 0)
    v1Text.ZIndex = 8
    v1Text.Parent = holder

    local v2Text = Instance.new("TextLabel")
    v2Text.BackgroundTransparency = 1
    v2Text.Text = "ANTI RAGDOLL V2"
    v2Text.TextColor3 = COLORS.white
    v2Text.TextSize = 9
    v2Text.Font = Enum.Font.GothamMedium
    v2Text.Size = UDim2.new(0.5, 0, 1, 0)
    v2Text.Position = UDim2.new(0.5, 0, 0, 0)
    v2Text.ZIndex = 8
    v2Text.Parent = holder

    local v1Click = Instance.new("TextButton")
    v1Click.BackgroundTransparency = 1
    v1Click.Text = ""
    v1Click.AutoButtonColor = false
    v1Click.Size = UDim2.new(0.5, 0, 1, 0)
    v1Click.ZIndex = 10
    v1Click.Parent = holder

    local v2Click = Instance.new("TextButton")
    v2Click.BackgroundTransparency = 1
    v2Click.Text = ""
    v2Click.AutoButtonColor = false
    v2Click.Size = UDim2.new(0.5, 0, 1, 0)
    v2Click.Position = UDim2.new(0.5, 0, 0, 0)
    v2Click.ZIndex = 10
    v2Click.Parent = holder

    local function setMode(mode)
    _G.RyzenAntiRagdollMode = (mode == "V2") and "V2" or "V1"

    local onV2 = _G.RyzenAntiRagdollMode == "V2"
    tween(slide, {
    Position = onV2 and UDim2.new(0.5, -1, 0, 4) or UDim2.new(0, 4, 0, 4)
    }, 0.18)

    tween(v1Text, {
    TextTransparency = onV2 and 0.18 or 0,
    TextStrokeTransparency = onV2 and 0.38 or 0.2
    }, 0.14)

    tween(v2Text, {
    TextTransparency = onV2 and 0 or 0.18,
    TextStrokeTransparency = onV2 and 0.2 or 0.38
    }, 0.14)

    if antiRagdollEnabled then
    setAntiRagdoll(true)
    end

    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end

    v1Click.MouseButton1Click:Connect(function()
    setMode("V1")
    end)

    v2Click.MouseButton1Click:Connect(function()
    setMode("V2")
    end)

    setMode(_G.RyzenAntiRagdollMode)
    return holder, setMode
    end


    function dropModeSelectorRow(parent, order)
    local holder = Instance.new("Frame")
    holder.Name = "Drop Mode"
    holder.BackgroundColor3 = COLORS.row
    holder.BackgroundTransparency = 0.28
    holder.Size = UDim2.new(1, -4, 0, 42)
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.ZIndex = 4
    holder.ClipsDescendants = true
    holder.Parent = parent
    corner(holder, 9)
    stroke(holder, COLORS.strokeSoft, 1.15, 0.38)

    local slide = Instance.new("Frame")
    slide.Name = "SelectedSlide"
    slide.BackgroundColor3 = Color3.fromRGB(58,58,64)
    slide.BackgroundTransparency = 0.08
    slide.Size = UDim2.new(0.5, -3, 1, -8)
    slide.Position = UDim2.new(0, 4, 0, 4)
    slide.BorderSizePixel = 0
    slide.ZIndex = 5
    slide.Parent = holder
    corner(slide, 9)

    local st = Instance.new("UIStroke")
    st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    st.Color = Color3.fromRGB(235,235,245)
    st.Thickness = 1
    st.Transparency = 0.08
    st.Parent = slide

    local standText = Instance.new("TextLabel")
    standText.BackgroundTransparency = 1
    standText.Text = "STAND DROP"
    standText.TextColor3 = COLORS.white
    standText.TextSize = 10
    standText.Font = Enum.Font.GothamMedium
    standText.Size = UDim2.new(0.5,0,1,0)
    standText.ZIndex = 8
    standText.Parent = holder

    local jumpText = Instance.new("TextLabel")
    jumpText.BackgroundTransparency = 1
    jumpText.Text = "JUMP DROP"
    jumpText.TextColor3 = COLORS.white
    jumpText.TextSize = 10
    jumpText.Font = Enum.Font.GothamMedium
    jumpText.Size = UDim2.new(0.5,0,1,0)
    jumpText.Position = UDim2.new(0.5,0,0,0)
    jumpText.ZIndex = 8
    jumpText.Parent = holder

    local standClick = Instance.new("TextButton")
    standClick.BackgroundTransparency = 1
    standClick.Text = ""
    standClick.AutoButtonColor = false
    standClick.Size = UDim2.new(0.5,0,1,0)
    standClick.ZIndex = 10
    standClick.Parent = holder

    local jumpClick = Instance.new("TextButton")
    jumpClick.BackgroundTransparency = 1
    jumpClick.Text = ""
    jumpClick.AutoButtonColor = false
    jumpClick.Size = UDim2.new(0.5,0,1,0)
    jumpClick.Position = UDim2.new(0.5,0,0,0)
    jumpClick.ZIndex = 10
    jumpClick.Parent = holder

    local function setMode(mode)
    _G.RyzenDropMode = (mode == "Jump Drop") and "Jump Drop" or "Stand Drop"
    local jump = _G.RyzenDropMode == "Jump Drop"

    tween(slide, {
    Position = jump and UDim2.new(0.5,-1,0,4) or UDim2.new(0,4,0,4)
    }, 0.18)

    tween(standText, {TextTransparency = jump and 0.18 or 0}, 0.14)
    tween(jumpText, {TextTransparency = jump and 0 or 0.18}, 0.14)

    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end

    standClick.MouseButton1Click:Connect(function() setMode("Stand Drop") end)
    jumpClick.MouseButton1Click:Connect(function() setMode("Jump Drop") end)

    setMode(_G.RyzenDropMode)
    return holder, setMode
    end



    task.wait()
    Movement = pages.MOVEMENT

    section(Movement, "AUTO SPEED", -2)
    _, setAutoCarrySpeedVisual = toggleRow(Movement, "Auto Carry Speed", autoCarrySpeedEnabled, -1)
    do
    local row = Movement:FindFirstChild("Auto Carry Speed")
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    autoCarrySpeedEnabled = not autoCarrySpeedEnabled
    if autoCarrySpeedEnabled ~= true and _G.AutoCarrySpeed and _G.AutoCarrySpeed.Disable then
    _G.AutoCarrySpeed.Disable()
    end
    if setAutoCarrySpeedVisual then setAutoCarrySpeedVisual(autoCarrySpeedEnabled == true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _, setAutoCarryEnemyBaseVisual = toggleRow(Movement, "Auto Carry on Enemy Base", autoCarryEnemyBaseEnabled, 0)
    do
    local row = Movement:FindFirstChild("Auto Carry on Enemy Base")
    local btn = row and row:FindFirstChild("ToggleButton")
    if btn then
    btn.Activated:Connect(function()
    _G.RyzenSetAutoCarryEnemyBase(not autoCarryEnemyBaseEnabled)
    end)
    end
    end
    _, autoCarryEnemyBaseRangeBox = textboxRow(Movement, "Enemy Base Range", tostring(autoCarryEnemyBaseRange or 35), 0)
    if autoCarryEnemyBaseRangeBox then
    autoCarryEnemyBaseRangeBox.FocusLost:Connect(function()
    local v = tonumber(autoCarryEnemyBaseRangeBox.Text)
    if v and v >= 5 and v <= 150 then
    autoCarryEnemyBaseRange = math.floor(v)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    autoCarryEnemyBaseRangeBox.Text = tostring(autoCarryEnemyBaseRange or 35)
    end)
    end
    section(Movement, "NORMAL SPEED", 1)
    _, normalSpeedBox = textboxRow(Movement, "Normal Speed", tostring(NS), 2)
    normalSpeedBox.FocusLost:Connect(function()
    local v = tonumber(normalSpeedBox.Text)
    if v and v > 0 and v <= 250 then
    NS = v
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    normalSpeedBox.Text = tostring(NS)
    end)
    _, carrySpeedBox = textboxRow(Movement, "Carry Speed", tostring(CS), 3)
    carrySpeedBox.FocusLost:Connect(function()
    local v = tonumber(carrySpeedBox.Text)
    if v and v > 0 and v <= 250 then
    CS = v
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    carrySpeedBox.Text = tostring(CS)
    end)
    modeDisplayRow(Movement, 4, "Normal")
    section(Movement, "LAGGER SPEED", 5)
    _, laggerSpeedBox = textboxRow(Movement, "Lagger Speed", tostring(LAGGER_SPEED), 6)
    laggerSpeedBox.FocusLost:Connect(function()
    local v = tonumber(laggerSpeedBox.Text)
    if v and v > 0 and v <= 250 then
    LAGGER_SPEED = v
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    laggerSpeedBox.Text = tostring(LAGGER_SPEED)
    end)
    _, laggerCarrySpeedBox = textboxRow(Movement, "Lagger Carry Speed", tostring(LAGGER_CARRY_SPEED), 7)
    laggerCarrySpeedBox.FocusLost:Connect(function()
    local v = tonumber(laggerCarrySpeedBox.Text)
    if v and v > 0 and v <= 250 then
    LAGGER_CARRY_SPEED = v
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    laggerCarrySpeedBox.Text = tostring(LAGGER_CARRY_SPEED)
    end)
    modeDisplayRow(Movement, 8, "Lagger")
    section(Movement, "TELEPORT", 9)
    autoTPRow = nil
    autoTPRow, setAutoTPVisual = toggleRow(Movement, "Auto TP Down", autoTPEnabled, 10)
    do
    local autoTPButton = autoTPRow and autoTPRow:FindFirstChild("ToggleButton")
    if autoTPButton then
    autoTPButton.MouseButton1Click:Connect(function()
    if autoTPClickDebounce then return end
    autoTPClickDebounce = true
    local nextState = not autoTPEnabled
    toggleAutoTP(nextState)
    task.delay(0.15, function()
    autoTPClickDebounce = false
    if setAutoTPVisual then setAutoTPVisual(autoTPEnabled) end
    end)
    end)
    end
    if autoTPEnabled then
    startAutoTP()
    else
    stopAutoTP()
    end
    end
    _, autoTPHeightBox = textboxRow(Movement, "Auto TP Height", tostring(autoTPHeight), 11)
    autoTPHeightBox.FocusLost:Connect(function()
    local v = tonumber(autoTPHeightBox.Text)
    if v and v >= -500 and v <= 500 then
    autoTPHeight = v
    end
    autoTPHeightBox.Text = tostring(autoTPHeight)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    section(Movement, "JUMP", 15)
    _, setInfJumpVisual = toggleRow(Movement, "Infinite Jump", infJumpEnabled, 16)

    _G.RyzenInfJumpMainRow = Movement:FindFirstChild("Infinite Jump")
    _G.RyzenInfJumpToggleBtn = _G.RyzenInfJumpMainRow and _G.RyzenInfJumpMainRow:FindFirstChild("ToggleButton")
    if _G.RyzenInfJumpToggleBtn then
    _G.RyzenInfJumpToggleBtn.Size = UDim2.new(0, 54, 1, 0)
    _G.RyzenInfJumpToggleBtn.Position = UDim2.new(1, -54, 0, 0)
    end

    _G.RyzenInfJumpArrow = Instance.new("TextButton")
    _G.RyzenInfJumpArrow.Name = "ArrowButton"
    _G.RyzenInfJumpArrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    _G.RyzenInfJumpArrow.BackgroundTransparency = 0.08
    _G.RyzenInfJumpArrow.BorderSizePixel = 0
    _G.RyzenInfJumpArrow.Text = "v"
    _G.RyzenInfJumpArrow.TextColor3 = COLORS.white
    _G.RyzenInfJumpArrow.TextSize = 12
    _G.RyzenInfJumpArrow.Font = Enum.Font.GothamMedium
    _G.RyzenInfJumpArrow.AutoButtonColor = false
    _G.RyzenInfJumpArrow.Size = UDim2.new(0, 36, 0, 28)
    _G.RyzenInfJumpArrow.Position = UDim2.new(1, -100, 0.5, -14)
    _G.RyzenInfJumpArrow.ZIndex = 20
    _G.RyzenInfJumpArrow.Parent = _G.RyzenInfJumpMainRow
    corner(_G.RyzenInfJumpArrow, 14)
    stroke(_G.RyzenInfJumpArrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    _G.RyzenInfJumpSelector = infiniteJumpSelectorRow(Movement, 16.1)
    _G.RyzenInfJumpSelector.Visible = false
    _G.RyzenInfJumpSelector.Size = UDim2.new(1, -4, 0, 0)
    _G.RyzenInfJumpExpanded = false

    _G.RyzenInfJumpArrow.MouseButton1Click:Connect(function()
    _G.RyzenInfJumpExpanded = not _G.RyzenInfJumpExpanded
    if _G.RyzenInfJumpExpanded then
    _G.RyzenInfJumpSelector.Visible = true
    tween(_G.RyzenInfJumpSelector, {Size = UDim2.new(1, -4, 0, 42)}, 0.2)
    tween(_G.RyzenInfJumpArrow, {Rotation = 180}, 0.15)
    else
    tween(_G.RyzenInfJumpArrow, {Rotation = 0}, 0.15)
    tween(_G.RyzenInfJumpSelector, {Size = UDim2.new(1, -4, 0, 0)}, 0.2)
    task.delay(0.2, function()
    if not _G.RyzenInfJumpExpanded then
    _G.RyzenInfJumpSelector.Visible = false
    end
    end)
    end
    end)

    do
    local row = Movement:FindFirstChild("Infinite Jump")
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    setInfJumpInternal(not infJumpEnabled)
    if setInfJumpVisual then setInfJumpVisual(infJumpEnabled == true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _, setAntiRagdollVisual = toggleRow(Movement, "Anti Ragdoll", antiRagdollEnabled, 17)
    do
        local row = Movement:FindFirstChild("Anti Ragdoll")
        local btn = row and row:FindFirstChild("ToggleButton")
        if btn then
            btn.Activated:Connect(function()
                setAntiRagdoll(not antiRagdollEnabled)
                if setAntiRagdollVisual then
                    setAntiRagdollVisual(antiRagdollEnabled == true)
                end
            end)
        end
    end

    -- AUTO PATH (Movement copy so Auto Left / Auto Right are reachable from Movement)
    section(Movement, "AUTO PATH", 17.5)
    _G.RyzenMoveAutoLeftRow, _G.RyzenMoveAutoLeftSetVisual, _G.RyzenMoveAutoLeftBtn = _G.RyzenActionToggleRow(Movement, "Auto Left", autoLeftEnabled, 17.6)
    do
    local _mALBtn = _G.RyzenMoveAutoLeftBtn
    if _mALBtn then
    _mALBtn.MouseButton1Click:Connect(function()
    if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(not autoLeftEnabled) end
    if _G.RyzenMoveAutoLeftSetVisual then _G.RyzenMoveAutoLeftSetVisual(autoLeftEnabled) end
    end)
    end
    end
    _G.RyzenMoveAutoRightRow, _G.RyzenMoveAutoRightSetVisual, _G.RyzenMoveAutoRightBtn = _G.RyzenActionToggleRow(Movement, "Auto Right", autoRightEnabled, 17.7)
    do
    local _mARBtn = _G.RyzenMoveAutoRightBtn
    if _mARBtn then
    _mARBtn.MouseButton1Click:Connect(function()
    if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(not autoRightEnabled) end
    if _G.RyzenMoveAutoRightSetVisual then _G.RyzenMoveAutoRightSetVisual(autoRightEnabled) end
    end)
    end
    end

    refreshSpeedModeRows()
    task.wait()
    Combat = pages.COMBAT
    section(Combat, "AUTO STEAL", 1)

    _aceRow, setAutoStealVisual = toggleRow(Combat, "Auto Steal", autoStealEnabled, 2)
    -- FIX: keep a dedicated reference to the main steal row. The global _aceRow
    -- is reused further down the build (Bat Counter / Med Counter / Hard Hit),
    -- so the mode pill must never trust it when updating the row label.
    _G.RyzenAutoStealMainRow = _aceRow
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Size = UDim2.new(0, 54, 1, 0)
    _aceBtn.Position = UDim2.new(1, -54, 0, 0)
    _aceBtn.Activated:Connect(function()
    autoStealEnabled = not autoStealEnabled
    if setAutoStealVisual then
    setAutoStealVisual(autoStealEnabled)
    end
    if _G.RyzenAutoStealSync then _G.RyzenAutoStealSync() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end

    _G.RyzenStealArrow = Instance.new("TextButton")
    _G.RyzenStealArrow.Name = "ArrowButton"
    _G.RyzenStealArrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    _G.RyzenStealArrow.BackgroundTransparency = 0.08
    _G.RyzenStealArrow.BorderSizePixel = 0
    _G.RyzenStealArrow.Text = "v"
    _G.RyzenStealArrow.TextColor3 = COLORS.white
    _G.RyzenStealArrow.TextSize = 12
    _G.RyzenStealArrow.Font = Enum.Font.GothamMedium
    _G.RyzenStealArrow.AutoButtonColor = false
    _G.RyzenStealArrow.Size = UDim2.new(0, 36, 0, 28)
    _G.RyzenStealArrow.Position = UDim2.new(1, -100, 0.5, -14)
    _G.RyzenStealArrow.ZIndex = 20
    _G.RyzenStealArrow.Parent = _aceRow
    corner(_G.RyzenStealArrow, 14)
    stroke(_G.RyzenStealArrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    _G.RyzenStealSelector = autoStealSelectorRow(Combat, 2.1)
    _G.RyzenStealSelector.Visible = false
    _G.RyzenStealSelector.Size = UDim2.new(1, -4, 0, 0)
    _G.RyzenStealExpanded = false

    _G.RyzenStealArrow.MouseButton1Click:Connect(function()
    _G.RyzenStealExpanded = not _G.RyzenStealExpanded
    if _G.RyzenStealExpanded then
    _G.RyzenStealSelector.Visible = true
    tween(_G.RyzenStealSelector, {Size = UDim2.new(1, -4, 0, 34)}, 0.2)
    tween(_G.RyzenStealArrow, {Rotation = 180}, 0.15)
    else
    tween(_G.RyzenStealArrow, {Rotation = 0}, 0.15)
    tween(_G.RyzenStealSelector, {Size = UDim2.new(1, -4, 0, 0)}, 0.2)
    task.delay(0.2, function()
    if not _G.RyzenStealExpanded then
    _G.RyzenStealSelector.Visible = false
    end
    end)
    end
    end)

    _, radiusBox = textboxRow(Combat, "Radius", tostring(autoStealRadius), 3)
    autoStealRadiusBox = radiusBox
    radiusBox.FocusLost:Connect(function()
    local v = tonumber(radiusBox.Text)
    if v and v > 0 and v <= 500 then
    autoStealRadius = v
    _G.RyzenStealRadii = _G.RyzenStealRadii or {}
    if selectedStealMode == "Semi" then
        _G.RyzenStealRadii.Semi = v
    else
        _G.RyzenStealRadii["Auto Steal"] = v
    end
    end
    _G.RyzenStealRadii = _G.RyzenStealRadii or {["Auto Steal"] = 63, ["Auto Steal"] = 63, Semi = 9}
    _G.RyzenStealRadii[selectedStealMode] = autoStealRadius
    radiusBox.Text = tostring(autoStealRadius)
    if _G.RyzenNormalAutoStealSetRadius then _G.RyzenNormalAutoStealSetRadius(_G.RyzenStealRadii["Auto Steal"] or 63) end
    if _G.RyzenV3AutoStealSetRadius then _G.RyzenV3AutoStealSetRadius(_G.RyzenStealRadii["Auto Steal"] or 63) end
    if _G.RyzenSemiAutoStealSetRadius then _G.RyzenSemiAutoStealSetRadius(_G.RyzenStealRadii.Semi or 9) end
    if _G.RyzenAutoStealSync then _G.RyzenAutoStealSync() end
    if saveRyzenConfig then
        pcall(saveRyzenConfig)
    end
    do end
    end)
    -- â”€â”€ Auto Steal Pause â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    -- Auto Steal Pause is ON by default (user request): the steal bar freezes
    -- at the set % and waits for the delay radius before finishing.
    _G.RyzenAutoStealPause = true
    _G.RyzenAutoStealPausePercent = tonumber(_G.RyzenAutoStealPausePercent) or 75

    local _pauseRow, _pauseSetVisual = toggleRow(Combat, "Auto Steal Pause", _G.RyzenAutoStealPause, 3.5)
    do
        local pauseBtn = _pauseRow and _pauseRow:FindFirstChild("ToggleButton")
        if pauseBtn then
            pauseBtn.Activated:Connect(function()
                _G.RyzenAutoStealPause = not _G.RyzenAutoStealPause
                if _pauseSetVisual then _pauseSetVisual(_G.RyzenAutoStealPause) end
                if saveRyzenConfig then pcall(saveRyzenConfig) end
            end)
        end
    end

    local _pausePctRow = baseRow(Combat, "Steal Pause %", 3.6)
    do
        local leftBtn = Instance.new("TextButton")
        leftBtn.Name = "PauseLeft"
        leftBtn.BackgroundColor3 = Color3.fromRGB(8,8,12)
        leftBtn.BackgroundTransparency = 0.1
        leftBtn.Text = "<"
        leftBtn.TextColor3 = COLORS.white
        leftBtn.TextSize = 13
        leftBtn.Font = Enum.Font.GothamBold
        leftBtn.Size = UDim2.new(0,28,0,28)
        leftBtn.Position = UDim2.new(1,-126,0.5,-14)
        leftBtn.BorderSizePixel = 0
        leftBtn.ZIndex = 6
        leftBtn.Parent = _pausePctRow
        corner(leftBtn, 14)
        stroke(leftBtn, COLORS.strokeSoft, 1.2, 0.28)

        local pctLbl = Instance.new("TextLabel")
        pctLbl.Name = "PausePctLabel"
        pctLbl.BackgroundColor3 = Color3.fromRGB(8,8,12)
        pctLbl.BackgroundTransparency = 0.1
        pctLbl.Text = tostring(_G.RyzenAutoStealPausePercent).."%"
        pctLbl.TextColor3 = COLORS.white
        pctLbl.TextSize = 11
        pctLbl.Font = Enum.Font.GothamMedium
        pctLbl.Size = UDim2.new(0,52,0,28)
        pctLbl.Position = UDim2.new(1,-94,0.5,-14)
        pctLbl.BorderSizePixel = 0
        pctLbl.ZIndex = 6
        pctLbl.Parent = _pausePctRow
        corner(pctLbl, 14)
        stroke(pctLbl, COLORS.strokeSoft, 1.2, 0.28)

        local rightBtn = Instance.new("TextButton")
        rightBtn.Name = "PauseRight"
        rightBtn.BackgroundColor3 = Color3.fromRGB(8,8,12)
        rightBtn.BackgroundTransparency = 0.1
        rightBtn.Text = ">"
        rightBtn.TextColor3 = COLORS.white
        rightBtn.TextSize = 13
        rightBtn.Font = Enum.Font.GothamBold
        rightBtn.Size = UDim2.new(0,28,0,28)
        rightBtn.Position = UDim2.new(1,-38,0.5,-14)
        rightBtn.BorderSizePixel = 0
        rightBtn.ZIndex = 6
        rightBtn.Parent = _pausePctRow
        corner(rightBtn, 14)
        stroke(rightBtn, COLORS.strokeSoft, 1.2, 0.28)

        local steps = {25,50,60,65,70,75,80,85,90,95,100}
        local function getIdx(v) for i,s in ipairs(steps) do if s==v then return i end end return 6 end
        leftBtn.Activated:Connect(function()
            local i = math.max(1, getIdx(_G.RyzenAutoStealPausePercent)-1)
            _G.RyzenAutoStealPausePercent = steps[i]
            pctLbl.Text = tostring(_G.RyzenAutoStealPausePercent).."%"
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end)
        rightBtn.Activated:Connect(function()
            local i = math.min(#steps, getIdx(_G.RyzenAutoStealPausePercent)+1)
            _G.RyzenAutoStealPausePercent = steps[i]
            pctLbl.Text = tostring(_G.RyzenAutoStealPausePercent).."%"
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end)
    end

    local aimbotMainRow, _, aimbotArrow = aimbotModeButtonRow(Combat, 5)
    local aimbotSelector = _G.RyzenAimbotSelectorRow(Combat, 5.1)
    aimbotSelector.Visible = false
    aimbotSelector.Size = UDim2.new(1, -4, 0, 0)

    local aimbotExpanded = false
    if aimbotArrow then
    aimbotArrow.MouseButton1Click:Connect(function()
    aimbotExpanded = not aimbotExpanded
    if aimbotExpanded then
    aimbotSelector.Visible = true
    tween(aimbotSelector, {Size = UDim2.new(1, -4, 0, 42)}, 0.2)
    tween(aimbotArrow, {Rotation = 180}, 0.15)
    else
    tween(aimbotArrow, {Rotation = 0}, 0.15)
    tween(aimbotSelector, {Size = UDim2.new(1, -4, 0, 0)}, 0.2)
    task.delay(0.2, function()
    if not aimbotExpanded then
    aimbotSelector.Visible = false
    end
    end)
    end
    end)
    end

    if _G.RyzenRefreshAimbotVisual then
    _G.RyzenRefreshAimbotVisual()
    end
    _G.RyzenNormalAutoSwingRow, _G.RyzenNormalAutoSwingSetVisual, _G.RyzenNormalAutoSwingBtn = _G.RyzenActionToggleRow(Combat, "Auto Swing", autoSwingEnabled, 7)
    do
    if _G.RyzenNormalAutoSwingBtn then
    _G.RyzenNormalAutoSwingBtn.MouseButton1Click:Connect(function()
    if _G.RyzenAutoSwingClickBusy then return end
    _G.RyzenAutoSwingClickBusy = true
    autoSwingEnabled = not autoSwingEnabled
    if _G.RyzenNormalAutoSwingSetVisual then _G.RyzenNormalAutoSwingSetVisual(autoSwingEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    task.delay(0.12, function() _G.RyzenAutoSwingClickBusy = false end)
    end)
    end
    end
    _G.RyzenMirrorTPDownRow, _G.RyzenMirrorTPDownSetVisual, _G.RyzenMirrorTPDownBtn = _G.RyzenActionToggleRow(Combat, "Mirror TP Down (Recommended)", mirrorTPDownEnabled, 7.1)
    local mirrorTPDownLabel = _G.RyzenMirrorTPDownRow and _G.RyzenMirrorTPDownRow:FindFirstChild("Label")
    if mirrorTPDownLabel then mirrorTPDownLabel.TextSize = 10 end
    if _G.RyzenMirrorTPDownBtn then
    _G.RyzenMirrorTPDownBtn.MouseButton1Click:Connect(function()
    if _G.RyzenMirrorTPDownClickBusy then return end
    _G.RyzenMirrorTPDownClickBusy = true
    _G.RyzenSetMirrorTPDown(not mirrorTPDownEnabled)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    task.delay(0.12, function() _G.RyzenMirrorTPDownClickBusy = false end)
    end)
    end
    aimbotSpeedRow, aimbotSpeedBox = textboxRow(Combat, "Normal Aimbot Speed", tostring(AIMBOT_SPEED), 8)
    _G.RyzenAimbotSpeedBox = aimbotSpeedBox
    aimbotSpeedLabel = aimbotSpeedRow and aimbotSpeedRow:FindFirstChild("Label")
    refreshAimbotModeLabels()
    aimbotSpeedBox.FocusLost:Connect(function()
    local v = tonumber(aimbotSpeedBox.Text)
    if v and v > 0 and v <= 250 then
    _G.RyzenSetSelectedAimbotSpeedValues(v, nil)
    end
    if _G.RyzenRefreshAimbotSpeedBoxes then _G.RyzenRefreshAimbotSpeedBoxes() else aimbotSpeedBox.Text = tostring(AIMBOT_SPEED) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    local tpBatModeHeader = Instance.new("Frame")
    tpBatModeHeader.Name = "TP Bat Mode Header"
    tpBatModeHeader.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    tpBatModeHeader.BackgroundTransparency = 0.08
    tpBatModeHeader.BorderSizePixel = 0
    tpBatModeHeader.Size = UDim2.new(1, -4, 0, 34)
    tpBatModeHeader.LayoutOrder = 8.5
    tpBatModeHeader.ZIndex = 4
    tpBatModeHeader.Parent = Combat
    corner(tpBatModeHeader, 14)
    stroke(tpBatModeHeader, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    local tpBatModeLabel = Instance.new("TextLabel")
    tpBatModeLabel.Name = "Label"
    tpBatModeLabel.BackgroundTransparency = 1
    tpBatModeLabel.TextColor3 = COLORS.white
    tpBatModeLabel.TextSize = 11
    tpBatModeLabel.Font = Enum.Font.GothamMedium
    tpBatModeLabel.TextXAlignment = Enum.TextXAlignment.Left
    tpBatModeLabel.Position = UDim2.new(0, 12, 0, 0)
    tpBatModeLabel.Size = UDim2.new(1, -58, 1, 0)
    tpBatModeLabel.ZIndex = 5
    tpBatModeLabel.Parent = tpBatModeHeader

    local tpBatModeArrow = Instance.new("TextButton")
    tpBatModeArrow.Name = "ArrowButton"
    tpBatModeArrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    tpBatModeArrow.BackgroundTransparency = 0.08
    tpBatModeArrow.BorderSizePixel = 0
    tpBatModeArrow.Text = "v"
    tpBatModeArrow.TextColor3 = COLORS.white
    tpBatModeArrow.TextSize = 12
    tpBatModeArrow.Font = Enum.Font.GothamMedium
    tpBatModeArrow.AutoButtonColor = false
    tpBatModeArrow.Size = UDim2.new(0, 36, 0, 28)
    tpBatModeArrow.Position = UDim2.new(1, -44, 0.5, -14)
    tpBatModeArrow.ZIndex = 6
    tpBatModeArrow.Parent = tpBatModeHeader
    corner(tpBatModeArrow, 14)
    stroke(tpBatModeArrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    local tpBatModeHolder = Instance.new("Frame")
    tpBatModeHolder.Name = "TP Bat Mode"
    tpBatModeHolder.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    tpBatModeHolder.BackgroundTransparency = 0.08
    tpBatModeHolder.BorderSizePixel = 0
    tpBatModeHolder.Size = UDim2.new(1, -4, 0, 34)
    tpBatModeHolder.LayoutOrder = 8.6
    tpBatModeHolder.Visible = false
    tpBatModeHolder.ClipsDescendants = true
    tpBatModeHolder.ZIndex = 4
    tpBatModeHolder.Parent = Combat
    corner(tpBatModeHolder, 14)
    stroke(tpBatModeHolder, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    local tpBatModeSlide = Instance.new("Frame")
    tpBatModeSlide.Name = "SelectedSlide"
    tpBatModeSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tpBatModeSlide.BackgroundTransparency = 0.82
    tpBatModeSlide.Size = UDim2.new(0.5, -8, 1, -8)
    tpBatModeSlide.Position = UDim2.new(_G.RyzenTPBatMode == "V2" and 0.5 or 0, 4, 0, 4)
    tpBatModeSlide.BorderSizePixel = 0
    tpBatModeSlide.Parent = tpBatModeHolder
    corner(tpBatModeSlide, 14)

    local function makeTPBatModeButton(name, text, position)
        local button = Instance.new("TextButton")
        button.Name = name
        button.BackgroundTransparency = 1
        button.Text = text
        button.TextColor3 = COLORS.white
        button.TextSize = 10
        button.Font = Enum.Font.GothamMedium
        button.AutoButtonColor = false
        button.Size = UDim2.new(0.5, 0, 1, 0)
        button.Position = position
        button.ZIndex = 5
        button.Parent = tpBatModeHolder
        return button
    end

    local tpBatClassicButton = makeTPBatModeButton("ClassicMode", "TP BAT", UDim2.new(0, 0, 0, 0))
    local tpBatV2Button = makeTPBatModeButton("V2Mode", "TP BAT V2", UDim2.new(0.5, 0, 0, 0))
    local function refreshTPBatMode()
        local v2 = _G.RyzenTPBatMode == "V2"
        tpBatModeLabel.Text = v2 and "TP BAT V2" or "TP BAT V1 (OLD)"
        tpBatModeSlide.Position = UDim2.new(v2 and 0.5 or 0, 4, 0, 4)
        tpBatClassicButton.TextTransparency = v2 and 0.18 or 0
        tpBatV2Button.TextTransparency = v2 and 0 or 0.18
    end
    _G.RyzenRefreshTPBatMode = refreshTPBatMode
    tpBatClassicButton.MouseButton1Click:Connect(function()
        if _G.RyzenSetTPBatMode then _G.RyzenSetTPBatMode("Classic") end
    end)
    tpBatV2Button.MouseButton1Click:Connect(function()
        if _G.RyzenSetTPBatMode then _G.RyzenSetTPBatMode("V2") end
    end)
    refreshTPBatMode()
    local tpBatModeExpanded = false
    tpBatModeArrow.MouseButton1Click:Connect(function()
        tpBatModeExpanded = not tpBatModeExpanded
        tpBatModeArrow.Rotation = tpBatModeExpanded and 180 or 0
        if tpBatModeExpanded then
            tpBatModeHolder.Visible = true
            tween(tpBatModeHolder, {Size = UDim2.new(1, -4, 0, 34)}, 0.18)
        else
            tween(tpBatModeHolder, {Size = UDim2.new(1, -4, 0, 0)}, 0.18)
            task.delay(0.2, function()
                if not tpBatModeExpanded then tpBatModeHolder.Visible = false end
            end)
        end
    end)

    -- TP BAT: toggle row below the mode selector
    _G.RyzenTPBatRow, _G.RyzenTPBatSetVisual = toggleRow(Combat, "TP Bat", _G.RyzenTPBatEnabled == true, 9)
    do
    local _tpb = _G.RyzenTPBatRow and _G.RyzenTPBatRow:FindFirstChild("ToggleButton")
    if _tpb then
    _tpb.Activated:Connect(function()
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    if _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE LOCK") end
    return
    end
    _G.RyzenSetTPBat(not (_G.RyzenTPBatEnabled == true))
    if _G.RyzenTPBatSetVisual then _G.RyzenTPBatSetVisual(_G.RyzenTPBatEnabled == true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    laggerAimbotSpeedRow, laggerAimbotSpeedBox = textboxRow(Combat, "Normal Lagger Aimbot Speed", tostring(LAGGER_AIMBOT_SPEED), 9)
    _G.RyzenLaggerAimbotSpeedBox = laggerAimbotSpeedBox
    laggerAimbotSpeedLabel = laggerAimbotSpeedRow and laggerAimbotSpeedRow:FindFirstChild("Label")
    refreshAimbotModeLabels()
    if _G.RyzenRefreshAimbotSpeedBoxes then _G.RyzenRefreshAimbotSpeedBoxes() end
    laggerAimbotSpeedBox.FocusLost:Connect(function()
    local v = tonumber(laggerAimbotSpeedBox.Text)
    if v and v > 0 and v <= 250 then
    _G.RyzenSetSelectedAimbotSpeedValues(nil, v)
    end
    if _G.RyzenRefreshAimbotSpeedBoxes then _G.RyzenRefreshAimbotSpeedBoxes() else laggerAimbotSpeedBox.Text = tostring(LAGGER_AIMBOT_SPEED) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)

    _, _G.RyzenBodyLockVisual = toggleRow(Combat, "Body Lock", _G.RyzenBodyLockEnabled, 6.5)

    _G.RyzenBodyLockMainRow = Combat:FindFirstChild("Body Lock")
    _G.RyzenBodyLockToggleBtn = _G.RyzenBodyLockMainRow and _G.RyzenBodyLockMainRow:FindFirstChild("ToggleButton")
    if _G.RyzenBodyLockToggleBtn then
    _G.RyzenBodyLockToggleBtn.Size = UDim2.new(0, 54, 1, 0)
    _G.RyzenBodyLockToggleBtn.Position = UDim2.new(1, -54, 0, 0)
    end

    _G.RyzenBodyLockArrow = Instance.new("TextButton")
    _G.RyzenBodyLockArrow.Name = "ArrowButton"
    _G.RyzenBodyLockArrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    _G.RyzenBodyLockArrow.BackgroundTransparency = 0.08
    _G.RyzenBodyLockArrow.BorderSizePixel = 0
    _G.RyzenBodyLockArrow.Text = "v"
    _G.RyzenBodyLockArrow.TextColor3 = COLORS.white
    _G.RyzenBodyLockArrow.TextSize = 12
    _G.RyzenBodyLockArrow.Font = Enum.Font.GothamMedium
    _G.RyzenBodyLockArrow.AutoButtonColor = false
    _G.RyzenBodyLockArrow.Size = UDim2.new(0, 36, 0, 28)
    _G.RyzenBodyLockArrow.Position = UDim2.new(1, -100, 0.5, -14)
    _G.RyzenBodyLockArrow.ZIndex = 20
    _G.RyzenBodyLockArrow.Parent = _G.RyzenBodyLockMainRow
    corner(_G.RyzenBodyLockArrow, 14)
    stroke(_G.RyzenBodyLockArrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    _G.RyzenBodyLockSettings = baseRow(Combat, "", 6.6)
    _G.RyzenBodyLockSettings.Visible = false
    _G.RyzenBodyLockSettings.Size = UDim2.new(1, -4, 0, 0)
    _G.RyzenBodyLockSettings.ClipsDescendants = true

    _G.RyzenBodyLockRadiusLabel = Instance.new("TextLabel")
    _G.RyzenBodyLockRadiusLabel.BackgroundTransparency = 1
    _G.RyzenBodyLockRadiusLabel.Text = "RADIUS"
    _G.RyzenBodyLockRadiusLabel.TextColor3 = COLORS.white
    _G.RyzenBodyLockRadiusLabel.TextSize = 10
    _G.RyzenBodyLockRadiusLabel.Font = Enum.Font.GothamMedium
    _G.RyzenBodyLockRadiusLabel.TextXAlignment = Enum.TextXAlignment.Left
    _G.RyzenBodyLockRadiusLabel.Size = UDim2.new(0.45, 0, 1, 0)
    _G.RyzenBodyLockRadiusLabel.Position = UDim2.new(0, 12, 0, 0)
    _G.RyzenBodyLockRadiusLabel.ZIndex = 7
    _G.RyzenBodyLockRadiusLabel.Parent = _G.RyzenBodyLockSettings

    _G.RyzenBodyLockRadiusBox = Instance.new("TextBox")
    _G.RyzenBodyLockRadiusBox.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    _G.RyzenBodyLockRadiusBox.BackgroundTransparency = 0.18
    _G.RyzenBodyLockRadiusBox.Text = tostring(_G.RyzenBodyLockRadius)
    _G.RyzenBodyLockRadiusBox.TextColor3 = COLORS.white
    _G.RyzenBodyLockRadiusBox.TextSize = 11
    _G.RyzenBodyLockRadiusBox.Font = Enum.Font.GothamMedium
    _G.RyzenBodyLockRadiusBox.ClearTextOnFocus = false
    _G.RyzenBodyLockRadiusBox.Size = UDim2.new(0, 76, 0, 28)
    _G.RyzenBodyLockRadiusBox.Position = UDim2.new(1, -88, 0.5, -14)
    _G.RyzenBodyLockRadiusBox.BorderSizePixel = 0
    _G.RyzenBodyLockRadiusBox.ZIndex = 7
    _G.RyzenBodyLockRadiusBox.Parent = _G.RyzenBodyLockSettings
    corner(_G.RyzenBodyLockRadiusBox, 7)
    stroke(_G.RyzenBodyLockRadiusBox, COLORS.strokeSoft, 1, 0.35)

    _G.RyzenBodyLockRadiusBox.FocusLost:Connect(function()
    local n = tonumber(_G.RyzenBodyLockRadiusBox.Text)
    if n then
    _G.RyzenBodyLockRadius = math.clamp(n, 5, 200)
    end
    _G.RyzenBodyLockRadiusBox.Text = tostring(_G.RyzenBodyLockRadius)
    end)

    _G.RyzenBodyLockExpanded = false
    _G.RyzenBodyLockArrow.MouseButton1Click:Connect(function()
    _G.RyzenBodyLockExpanded = not _G.RyzenBodyLockExpanded

    if _G.RyzenBodyLockExpanded then
    _G.RyzenBodyLockArrow.Text = "^"
    _G.RyzenBodyLockSettings.Visible = true
    tween(_G.RyzenBodyLockSettings, {Size = UDim2.new(1, -4, 0, 42)}, 0.2)
    else
    _G.RyzenBodyLockArrow.Text = "v"
    tween(_G.RyzenBodyLockSettings, {Size = UDim2.new(1, -4, 0, 0)}, 0.2)
    task.delay(0.2, function()
    if not _G.RyzenBodyLockExpanded and _G.RyzenBodyLockSettings then
    _G.RyzenBodyLockSettings.Visible = false
    end
    end)
    end
    end)

    _G.RyzenBodyLockButton = _G.RyzenBodyLockToggleBtn
    if _G.RyzenBodyLockButton then
    _G.RyzenBodyLockButton.Activated:Connect(function()
    _G.RyzenSetBodyLock(not _G.RyzenBodyLockEnabled)
    if _G.RyzenBodyLockVisual then
    _G.RyzenBodyLockVisual(_G.RyzenBodyLockEnabled)
    end
    end)
    end

    task.defer(function()
    task.wait(0.5)
    if _G.RyzenBodyLockEnabled then
    _G.RyzenStartBodyLock()
    end
    if _G.RyzenBodyLockVisual then
    _G.RyzenBodyLockVisual(_G.RyzenBodyLockEnabled)
    end
    end)

    -- LAGGER (Combat copy so the config is reachable from the Combat tab)
    section(Combat, "LAGGER", 9.5)
    _G.RyzenCombatLaggerModeRow, _G.RyzenCombatLaggerModeSetVisual, _G.RyzenCombatLaggerModeBtn = _G.RyzenActionToggleRow(Combat, "Lagger Mode", (_G.RyzenGetSpeedMode and _G.RyzenGetSpeedMode() == "Lagger"), 9.6)
    do
    local _lagBtn = _G.RyzenCombatLaggerModeBtn
    if _lagBtn then
    _lagBtn.MouseButton1Click:Connect(function()
    local before = (_G.RyzenGetSpeedMode and _G.RyzenGetSpeedMode()) or "Normal"
    if _G.RyzenToggleLaggerMode then pcall(_G.RyzenToggleLaggerMode) end
    task.delay(0.05, function()
    local now = (_G.RyzenGetSpeedMode and _G.RyzenGetSpeedMode()) or before
    local on = (now == "Lagger" or now == "Lagger Carry")
    if _G.RyzenCombatLaggerModeSetVisual then
    _G.RyzenCombatLaggerModeSetVisual(on)
    end
    local lbl = _G.RyzenCombatLaggerModeRow and _G.RyzenCombatLaggerModeRow:FindFirstChild("Label")
    if lbl then lbl.Text = "Lagger Mode (" .. tostring(now) .. ")" end
    end)
    end)
    end
    end
    _G.RyzenCombatLaggerSpeedRow, _G.RyzenCombatLaggerSpeedBox = textboxRow(Combat, "Lagger Speed", tostring(LAGGER_SPEED), 9.7)
    _G.RyzenCombatLaggerSpeedBox.FocusLost:Connect(function()
    local v = tonumber(_G.RyzenCombatLaggerSpeedBox.Text)
    if v and v > 0 and v <= 250 then
    LAGGER_SPEED = v
    if laggerSpeedBox then laggerSpeedBox.Text = tostring(LAGGER_SPEED) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    _G.RyzenCombatLaggerSpeedBox.Text = tostring(LAGGER_SPEED)
    end)
    _G.RyzenCombatLaggerCarryRow, _G.RyzenCombatLaggerCarryBox = textboxRow(Combat, "Lagger Carry Speed", tostring(LAGGER_CARRY_SPEED), 9.8)
    _G.RyzenCombatLaggerCarryBox.FocusLost:Connect(function()
    local v = tonumber(_G.RyzenCombatLaggerCarryBox.Text)
    if v and v > 0 and v <= 350 then
    LAGGER_CARRY_SPEED = v
    if laggerCarrySpeedBox then laggerCarrySpeedBox.Text = tostring(LAGGER_CARRY_SPEED) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    _G.RyzenCombatLaggerCarryBox.Text = tostring(LAGGER_CARRY_SPEED)
    end)

    section(Combat, "COUNTERS", 13)
    _aceRow, setBatCounterVisual = _G.RyzenActionToggleRow(Combat, "Bat Counter", batCounterEnabled, 14)
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    batCounterEnabled = not batCounterEnabled
    if setBatCounterVisual then
    setBatCounterVisual(batCounterEnabled)
    end
    if batCounterEnabled then
    if _G.RyzenStartBatCounter then _G.RyzenStartBatCounter() end
    else
    if _G.RyzenStopBatCounter then _G.RyzenStopBatCounter() end
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _aceRow, setMedCounterVisual = _G.RyzenActionToggleRow(Combat, "Med Counter", medCounterEnabled, 15)
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    medCounterEnabled = not medCounterEnabled
    if setMedCounterVisual then
    setMedCounterVisual(medCounterEnabled)
    end
    if medCounterEnabled then
    if _G.RyzenStartMedCounter then _G.RyzenStartMedCounter(LP.Character) end
    else
    if _G.RyzenStopMedCounter then _G.RyzenStopMedCounter() end
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    section(Combat, "HARD HIT", 15.2)
    _aceRow, setHardHitVisual = _G.RyzenActionToggleRow(Combat, "Hard Hit", hardHitEnabled == true, 15.3)
    _G.RyzenHardHitVisual = setHardHitVisual
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    hardHitEnabled = not hardHitEnabled
    if setHardHitVisual then
    setHardHitVisual(hardHitEnabled)
    end
    if hardHitEnabled then
    if _G.RyzenStartHardHit then _G.RyzenStartHardHit() end
    else
    if _G.RyzenStopHardHit then _G.RyzenStopHardHit() end
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _, hardHitRadiusBox = textboxRow(Combat, "Hard Hit Range", tostring(hardHitRadius or 10), 15.4)
    hardHitRadiusBox.FocusLost:Connect(function()
    local v = tonumber(hardHitRadiusBox.Text)
    if v and v >= 1 and v <= 100 then
    if _G.RyzenSetHardHitRadius then _G.RyzenSetHardHitRadius(v) end
    end
    hardHitRadiusBox.Text = tostring(hardHitRadius or 10)
    if saveRyzenConfig then
        pcall(saveRyzenConfig)
    end
    end)
    section(Combat, "PERFECT HIT", 15.5)
    _aceRow, setPerfectHitVisual = _G.RyzenActionToggleRow(Combat, "Perfect Hit", perfectHitEnabled == true, 15.6)
    _G.RyzenPerfectHitVisual = setPerfectHitVisual
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    perfectHitEnabled = not perfectHitEnabled
    if setPerfectHitVisual then
    setPerfectHitVisual(perfectHitEnabled)
    end
    if perfectHitEnabled then
    if _G.RyzenStartPerfectHit then _G.RyzenStartPerfectHit() end
    else
    if _G.RyzenStopPerfectHit then _G.RyzenStopPerfectHit() end
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _, perfectHitRangeBox = textboxRow(Combat, "Perfect Hit Range", tostring(perfectHitRange or 175), 15.7)
    perfectHitRangeBox.FocusLost:Connect(function()
    local v = tonumber(perfectHitRangeBox.Text)
    if v and v >= 10 and v <= 500 then
    if _G.RyzenSetPerfectHitRange then _G.RyzenSetPerfectHitRange(v) end
    end
    perfectHitRangeBox.Text = tostring(perfectHitRange or 175)
    if saveRyzenConfig then
        pcall(saveRyzenConfig)
    end
    end)
    _aceRow, _G.RyzenSetNoPlayerCollisionVisual = _G.RyzenActionToggleRow(Combat, "No Player Collision", _G.RyzenNoPlayerCollisionEnabled, 16)
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    _G.RyzenNoPlayerCollisionEnabled = not _G.RyzenNoPlayerCollisionEnabled
    if _G.RyzenSetNoPlayerCollisionVisual then _G.RyzenSetNoPlayerCollisionVisual(_G.RyzenNoPlayerCollisionEnabled) end
    if _G.RyzenNoPlayerCollisionEnabled then
    if enableNoPlayerCollision then enableNoPlayerCollision() end
    else
    if disableNoPlayerCollision then disableNoPlayerCollision() end
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    _aceRow, setSafeModeVisual = _G.RyzenActionToggleRow(Combat, "Safe Mode", antiKickEnabled, 17)
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    antiKickEnabled = not antiKickEnabled
    if setSafeModeVisual then setSafeModeVisual(antiKickEnabled) end
    if antiKickEnabled and _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE") end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end

    _, _G.RyzenAntiResetVisual = toggleRow(Combat, "Anti Die", _G.RyzenAntiResetEnabled, 18)
    _G.RyzenAntiResetRow = Combat:FindFirstChild("Anti Die")
    _G.RyzenAntiResetButton = _G.RyzenAntiResetRow and _G.RyzenAntiResetRow:FindFirstChild("ToggleButton")
    if _G.RyzenAntiResetButton then
    _G.RyzenAntiResetButton.Activated:Connect(function()
    _G.RyzenSetAntiReset(not _G.RyzenAntiResetEnabled)
    if _G.RyzenAntiResetVisual then _G.RyzenAntiResetVisual(_G.RyzenAntiResetEnabled == true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end



    _G.RyzenDropModeMainRow = baseRow(Combat, "Drop", 18.5)
    do
    local _dropLbl = _G.RyzenDropModeMainRow and _G.RyzenDropModeMainRow:FindFirstChild("Label")
    if _dropLbl then
        _dropLbl.TextXAlignment = Enum.TextXAlignment.Center
        _dropLbl.AnchorPoint = Vector2.new(0.5, 0)
        _dropLbl.Position = UDim2.new(0.5, -14, 0, 0)
        _dropLbl.Size = UDim2.new(0, 64, 1, 0)
    end
    end

    _G.RyzenDropAction = Instance.new("TextButton")
    _G.RyzenDropAction.Name = "DropAction"
    _G.RyzenDropAction.BackgroundTransparency = 1
    _G.RyzenDropAction.Text = ""
    _G.RyzenDropAction.AutoButtonColor = false
    _G.RyzenDropAction.Size = UDim2.new(1, -50, 1, 0)
    _G.RyzenDropAction.Position = UDim2.new(0, 0, 0, 0)
    _G.RyzenDropAction.ZIndex = 15
    _G.RyzenDropAction.Parent = _G.RyzenDropModeMainRow

    _G.RyzenDropArrow = Instance.new("TextButton")
    _G.RyzenDropArrow.Name = "ArrowButton"
    _G.RyzenDropArrow.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    _G.RyzenDropArrow.BackgroundTransparency = 0.08
    _G.RyzenDropArrow.BorderSizePixel = 0
    _G.RyzenDropArrow.Text = "v"
    _G.RyzenDropArrow.TextColor3 = COLORS.white
    _G.RyzenDropArrow.TextSize = 12
    _G.RyzenDropArrow.Font = Enum.Font.GothamMedium
    _G.RyzenDropArrow.AutoButtonColor = false
    _G.RyzenDropArrow.Size = UDim2.new(0, 36, 0, 28)
    _G.RyzenDropArrow.Position = UDim2.new(0.5, 24, 0.5, -14)
    _G.RyzenDropArrow.ZIndex = 20
    _G.RyzenDropArrow.Parent = _G.RyzenDropModeMainRow
    corner(_G.RyzenDropArrow, 14)
    stroke(_G.RyzenDropArrow, Color3.fromRGB(255, 255, 255), 1.1, 0.55)

    _G.RyzenDropSelector = dropModeSelectorRow(Combat, 18.6)
    _G.RyzenDropSelector.Visible = false
    _G.RyzenDropSelector.Size = UDim2.new(1,-4,0,0)
    _G.RyzenDropExpanded = false

    _G.RyzenDropAction.MouseButton1Click:Connect(function()
    pcall(runDrop)
    end)

    _G.RyzenDropArrow.MouseButton1Click:Connect(function()

    tween(_G.RyzenDropArrow, {
    BackgroundTransparency = 0.02,
    TextColor3 = Color3.fromRGB(255,255,255)
    }, 0.08)

    task.delay(0.09, function()
    if _G.RyzenDropArrow then
    tween(_G.RyzenDropArrow, {
    BackgroundTransparency = 0.18
    }, 0.12)
    end
    end)

    _G.RyzenDropExpanded = not _G.RyzenDropExpanded

    if _G.RyzenDropExpanded then
    _G.RyzenDropArrow.Text = "^"
    _G.RyzenDropSelector.Visible = true
    tween(_G.RyzenDropSelector, {Size = UDim2.new(1,-4,0,42)}, 0.2)
    else
    _G.RyzenDropArrow.Text = "v"
    tween(_G.RyzenDropSelector, {Size = UDim2.new(1,-4,0,0)}, 0.2)
    task.delay(0.2, function()
    if not _G.RyzenDropExpanded and _G.RyzenDropSelector then
    _G.RyzenDropSelector.Visible = false
    end
    end)
    end
    end)


    _, _G.RyzenAntiVoidVisual = toggleRow(Combat, "Anti Void", _G.RyzenAntiVoidEnabled, 19)
    _G.RyzenAntiVoidRow = Combat:FindFirstChild("Anti Void")
    _G.RyzenAntiVoidButton = _G.RyzenAntiVoidRow and _G.RyzenAntiVoidRow:FindFirstChild("ToggleButton")
    if _G.RyzenAntiVoidButton then
    _G.RyzenAntiVoidButton.Activated:Connect(function()
    _G.RyzenAntiVoidSet(not _G.RyzenAntiVoidEnabled)
    if _G.RyzenAntiVoidVisual then _G.RyzenAntiVoidVisual(_G.RyzenAntiVoidEnabled == true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end

    _aceRow, setAutoResetOnMedVisual = toggleRow(Combat, "Auto Reset On Med Fling", autoResetOnMedEnabled, 18)
    do
    _aceBtn = _aceRow and _aceRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    if _G.RyzenSetAutoResetOnMed then
    _G.RyzenSetAutoResetOnMed(not autoResetOnMedEnabled)
    else
    autoResetOnMedEnabled = not autoResetOnMedEnabled
    if setAutoResetOnMedVisual then setAutoResetOnMedVisual(autoResetOnMedEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    end)
    end
    end


    section(Movement, "AUTO PLAY", 100)

    do
        local duelModeRow = baseRow(Movement, "Duel Mode", 101)
        duelModeRow.Size = UDim2.new(1,-4,0,42)

        local lbl = duelModeRow:FindFirstChild("Label")
        if lbl then
            lbl.Text = "Duel Mode"
            lbl.Size = UDim2.new(0.35,0,1,0)
        end

        local halfBtn = Instance.new("TextButton")
        halfBtn.Name = "HalfButton"
        halfBtn.Size = UDim2.new(0,58,0,28)
        halfBtn.Position = UDim2.new(1,-134,0.5,-14)
        halfBtn.BackgroundTransparency = 1
        halfBtn.BorderSizePixel = 0
        halfBtn.Text = "HALF"
        halfBtn.Font = Enum.Font.GothamMedium
        halfBtn.TextSize = 10
        halfBtn.ZIndex = 20
        halfBtn.Parent = duelModeRow
        corner(halfBtn,6)
        stroke(halfBtn,COLORS.strokeSoft,1,0.45)

        local fullBtn = Instance.new("TextButton")
        fullBtn.Name = "FullButton"
        fullBtn.Size = UDim2.new(0,58,0,28)
        fullBtn.Position = UDim2.new(1,-70,0.5,-14)
        fullBtn.BackgroundTransparency = 1
        fullBtn.BorderSizePixel = 0
        fullBtn.Text = "FULL"
        fullBtn.Font = Enum.Font.GothamMedium
        fullBtn.TextSize = 10
        fullBtn.ZIndex = 20
        fullBtn.Parent = duelModeRow
        corner(fullBtn,6)
        stroke(fullBtn,COLORS.strokeSoft,1,0.45)

        local function refreshDuelBtns()
            halfBtn.TextColor3 = (_G.RyzenDuelMode == "half")
                and Color3.fromRGB(255,255,255)
                or Color3.fromRGB(140,140,140)

            fullBtn.TextColor3 = (_G.RyzenDuelMode == "full")
                and Color3.fromRGB(255,255,255)
                or Color3.fromRGB(140,140,140)

            if _G.RyzenAutoMoveCarrySpeedBox then
                local row = _G.RyzenAutoMoveCarrySpeedBox.Parent
                if row then
                    row.Visible = (_G.RyzenDuelMode == "full")
                end
            end
        end

        _G.RyzenRefreshDuelModeButtons = refreshDuelBtns

        halfBtn.MouseButton1Click:Connect(function()
            _G.RyzenDuelMode = "half"
            refreshDuelBtns()
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end)

        fullBtn.MouseButton1Click:Connect(function()
            _G.RyzenDuelMode = "full"
            refreshDuelBtns()
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end)

        refreshDuelBtns()
    end


    task.wait()
    MenuCustomize = pages.MENU

    task.wait()
    Keybinds = pages.KEYBINDS
    section(Keybinds, "MOVEMENT KEYBINDS", 1)
    speedKeybindRow(Keybinds, "Speed Key", "SpeedToggle", 2)
    speedKeybindRow(Keybinds, "Lagger Mode Key", "LaggerToggle", 3)
    tpDownKeybindRow(Keybinds, 4)
    speedKeybindRow(Keybinds, "Drop Brainrot", "DropBrainrot", 5)
    section(Keybinds, "COMBAT KEYBINDS", 6)
    aimbotKeybindRow = speedKeybindRow(Keybinds, "Normal Aimbot", "Aimbot", 7)
    combatAimbotKeybindLabel = aimbotKeybindRow and aimbotKeybindRow:FindFirstChild("Label")
    refreshAimbotModeLabels()
    speedKeybindRow(Keybinds, "TP Bat", "TPBat", 7.5)
    speedKeybindRow(Keybinds, "Auto Left", "AutoLeft", 9)
    speedKeybindRow(Keybinds, "Auto Right", "AutoRight", 10)
    do
    THEME_ACCENT = THEME_ACCENT or Color3.fromRGB(230, 230, 230)
    THEME_ACCENT_DIM = THEME_ACCENT_DIM or Color3.fromRGB(145, 145, 145)
    PlayerESP = PlayerESP or {enabled=false, playerData={}, conns={}, discordText=""}
    BoxedESPOptions = BoxedESPOptions or {box=false, tracer=false}
    BoxedESPData = BoxedESPData or {}
    BoxedESPConn = BoxedESPConn or nil
    stretchRezConn = stretchRezConn or nil
    antiLagDescConn = antiLagDescConn or nil
    noCamCollisionConn = noCamCollisionConn or nil
    noCamCollisionParts = noCamCollisionParts or {}
    _aceNukeConns = _aceNukeConns or {}
    _aceNukeOn = _aceNukeOn or false
    _aceCustomFontOrig = _aceCustomFontOrig or {}
    _aceCustomFontConn = _aceCustomFontConn or nil
    _aceCustomFont = _aceCustomFont or nil
    function startPlayerESP()
    if PlayerESP.enabled then return end
    PlayerESP.enabled = true
    function cleanup(plr)
    local d=PlayerESP.playerData[plr]; if not d then return end
    pcall(function() if d.highlight then d.highlight:Destroy() end end)
    pcall(function() if d.billboard then d.billboard:Destroy() end end)
    if d.conns then for _,c in ipairs(d.conns) do pcall(function() c:Disconnect() end) end end
    PlayerESP.playerData[plr]=nil
    end
    function setup(plr,char)
    if not PlayerESP.enabled or plr==LP then return end
    cleanup(plr)
    local hrp=char and (char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart",5))
    local head=char and (char:FindFirstChild("Head") or char:WaitForChild("Head",5))
    if not hrp or not head then return end
    local hl=Instance.new("Highlight")
    hl.Name="RyzenDuelsESP"; hl.Adornee=char; hl.FillColor=(_G.RyzenThemeColors and _G.RyzenThemeColors[_G.RyzenThemeName]) or THEME_ACCENT; hl.FillTransparency=0.72
    hl.OutlineColor=(_G.RyzenThemeColors and _G.RyzenThemeColors[_G.RyzenThemeName]) or THEME_ACCENT; hl.OutlineTransparency=0; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=char
    -- REMOVED: Ryzen's old ESP tag ("Speed: 0.0" over the player's name).
    -- It duplicated the new speed number above their head. The ESP highlight
    -- stays; only the old billboard and its Heartbeat updater are gone.
    -- Clean up the old tag if a previous run left one behind.
    pcall(function()
    local stale = head:FindFirstChild("RyzenDuelsESPTag")
    if stale then stale:Destroy() end
    end)
    PlayerESP.playerData[plr]={highlight=hl,billboard=nil,conns={}}
    end
    for _,plr in ipairs(Players:GetPlayers()) do if plr~=LP then if plr.Character then setup(plr,plr.Character) end; table.insert(PlayerESP.conns, plr.CharacterAdded:Connect(function(c) task.defer(setup,plr,c) end)) end end
    table.insert(PlayerESP.conns, Players.PlayerAdded:Connect(function(plr) if plr~=LP then table.insert(PlayerESP.conns, plr.CharacterAdded:Connect(function(c) task.defer(setup,plr,c) end)) end end))
    table.insert(PlayerESP.conns, Players.PlayerRemoving:Connect(cleanup))
    end
    function stopPlayerESP()
    PlayerESP.enabled=false
    for _,c in ipairs(PlayerESP.conns or {}) do pcall(function() c:Disconnect() end) end
    PlayerESP.conns={}
    for plr,d in pairs(PlayerESP.playerData or {}) do pcall(function() if d.highlight then d.highlight:Destroy() end end); pcall(function() if d.billboard then d.billboard:Destroy() end end) end
    PlayerESP.playerData={}
    end
    function _aceEspColor()
    -- FIX: tracers / boxes used THEME_ACCENT, which is a neutral grey at boot
    -- (it only picks up the theme after a manual theme click). Read the live
    -- GUI theme colour instead so ESP boxes + tracers always match the Ryzen Hub.
    local t = _G.RyzenThemeColors and _G.RyzenThemeName and _G.RyzenThemeColors[_G.RyzenThemeName]
    return t or THEME_ACCENT or Color3.fromRGB(230,230,230)
    end
    function _safeDrawing(kind, props)
    if not Drawing or not Drawing.new then return nil end
    local ok, obj = pcall(function() return Drawing.new(kind) end)
    if not ok or not obj then return nil end
    for k,v in pairs(props or {}) do pcall(function() obj[k]=v end) end
    return obj
    end
    function _cleanupBoxedESPPlayer(player)
    local data = BoxedESPData[player]
    if not data then return end
    for _,obj in pairs(data) do
    pcall(function()
    obj.Visible = false
    if obj.Remove then obj:Remove() end
    end)
    end
    BoxedESPData[player] = nil
    end
    function _cleanupBoxedESP()
    for player,_ in pairs(BoxedESPData) do _cleanupBoxedESPPlayer(player) end
    end
    function _updateBoxedESP()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local anyOn = BoxedESPOptions.box or BoxedESPOptions.tracer
    if not anyOn then
    _cleanupBoxedESP()
    return
    end
    for _,player in ipairs(Players:GetPlayers()) do
    if player == LP then continue end
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local head = char and char:FindFirstChild("Head")
    if not root or not head then
    _cleanupBoxedESPPlayer(player)
    continue
    end
    local rootPos,onScreen = cam:WorldToViewportPoint(root.Position)
    local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0,0.55,0))
    local data = BoxedESPData[player]
    if not data then
    data = {
    box = _safeDrawing("Square",{Thickness=2,Filled=false,Transparency=1,Color=_aceEspColor()}),
    tracer = _safeDrawing("Line",{Thickness=2,Transparency=1,Color=_aceEspColor()}),
    }
    BoxedESPData[player] = data
    end
    local color = _aceEspColor()
    local height = math.abs(headPos.Y - rootPos.Y) * 2.15
    if height < 20 or height ~= height then height = 65 end
    local width = height / 2.15
    local view = cam.ViewportSize
    local centerX, centerY = view.X/2, view.Y/2
    local targetX, targetY = rootPos.X, rootPos.Y + height/2
    local targetVisible = onScreen and rootPos.Z > 0
    if not targetVisible then
    local dx = rootPos.X - centerX
    local dy = rootPos.Y - centerY
    if rootPos.Z <= 0 then
    dx = -dx
    dy = -dy
    end
    if math.abs(dx) < 1 and math.abs(dy) < 1 then
    local rel = cam.CFrame:PointToObjectSpace(root.Position)
    dx = rel.X
    dy = -rel.Y
    if rootPos.Z <= 0 then
    dx = -dx
    dy = -dy
    end
    end
    local edgePad = 10
    local scaleX = (dx ~= 0) and ((view.X/2 - edgePad) / math.abs(dx)) or math.huge
    local scaleY = (dy ~= 0) and ((view.Y/2 - edgePad) / math.abs(dy)) or math.huge
    local scale = math.min(scaleX, scaleY)
    if scale == math.huge or scale ~= scale then scale = 1 end
    targetX = math.clamp(centerX + dx * scale, edgePad, view.X - edgePad)
    targetY = math.clamp(centerY + dy * scale, edgePad, view.Y - edgePad)
    end
    if data.box then
    data.box.Color = color
    data.box.Size = Vector2.new(width,height)
    data.box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
    data.box.Visible = false
    end
    if data.tracer then
    data.tracer.Color = color
    local localChar = LP.Character
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
    local localHead = localChar and localChar:FindFirstChild("Head")
    local fromX, fromY
    if localRoot then
    local localScreen = cam:WorldToViewportPoint(localRoot.Position)
    fromX = localScreen.X
    fromY = localScreen.Y + 15
    end
    if not fromX or not fromY then
    fromX = cam.ViewportSize.X/2
    fromY = cam.ViewportSize.Y - 88
    end
    data.tracer.From = Vector2.new(fromX, fromY)
    data.tracer.To = Vector2.new(targetX, targetY)
    data.tracer.Visible = BoxedESPOptions.tracer == true
    end
    end
    end
    function refreshBoxedESP()
    local anyOn = BoxedESPOptions.box or BoxedESPOptions.tracer
    if anyOn and not BoxedESPConn then
    BoxedESPConn = RunService.RenderStepped:Connect(_updateBoxedESP)
    elseif (not anyOn) and BoxedESPConn then
    BoxedESPConn:Disconnect()
    BoxedESPConn = nil
    _cleanupBoxedESP()
    end
    end
    Players.PlayerRemoving:Connect(_cleanupBoxedESPPlayer)
    SKY_PRESETS_LIST = {"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","Pink Night","Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse","Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}
    SKY_PRESETS = {
        ["Off"]={kind="off"},
        ["Night"]={clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
        ["Aurora"]={clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
        ["Sunset"]={clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
        ["Galaxy"]={clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
        ["Cyber"]={clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
        ["Sakura"]={clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
        ["Pink Night"]={clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
        ["Blood Moon"]={clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
        ["Emerald Dawn"]={clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
        ["Volcanic"]={clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
        ["Arctic"]={clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
        ["Midnight Ocean"]={clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
        ["Vaporwave"]={clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.55,dens=0.55,color={200,150,255}}},
        ["Toxic"]={clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
        ["Solar Eclipse"]={clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
        ["Hellscape"]={clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
        ["Heaven"]={clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
        ["Storm"]={clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
        ["Sunrise"]={clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
        ["Deep Space"]={clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
        ["Lavender Dream"]={clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
        ["Inferno"]={clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
        ["Mint Sky"]={clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
    }


    local function _vC3(t)
        return Color3.fromRGB(t[1], t[2], t[3])
    end

    function _v4mpClearSky()
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:GetAttribute("_RyzenDuelsSky") then
                pcall(function() child:Destroy() end)
            end
        end

        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            for _, child in ipairs(terrain:GetChildren()) do
                if child:GetAttribute("_RyzenDuelsSky") then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end

    function applyCustomSky(mode)
        mode = "Off"
        _v4mpClearSky()

        local preset = SKY_PRESETS[mode]
        if not preset or preset.kind == "off" then
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
            Lighting.Ambient = Color3.fromRGB(127,127,127)
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.FogColor = Color3.fromRGB(192,192,192)
            Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
            Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
            Lighting.GlobalShadows = true
            skyTheme = "Off"
            return
        end

        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.fromRGB(200,200,200)
        Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
        Lighting.GlobalShadows = true

        Lighting.ClockTime = preset.clock or 14
        Lighting.Brightness = preset.brightness or 2

        if preset.outAmb then
            Lighting.OutdoorAmbient = _vC3(preset.outAmb)
        end

        if preset.ambient then
            Lighting.Ambient = _vC3(preset.ambient)
        end

        if preset.sky then
            local skyInst = Instance.new("Sky")
            skyInst:SetAttribute("_RyzenDuelsSky", true)

            if preset.sky.stars then skyInst.StarCount = preset.sky.stars end
            if preset.sky.moon then skyInst.MoonAngularSize = preset.sky.moon end
            if preset.sky.sun then skyInst.SunAngularSize = preset.sky.sun end
            if preset.sky.moonTex then skyInst.MoonTextureId = "rbxasset://sky/moon.jpg" end

            skyInst.Parent = Lighting
        end

        if preset.atm then
            local atm = Instance.new("Atmosphere")
            atm:SetAttribute("_RyzenDuelsSky", true)
            atm.Density = preset.atm.dens or 0.3
            atm.Color = _vC3(preset.atm.color)
            atm.Decay = _vC3(preset.atm.decay)
            atm.Glare = preset.atm.glare or 1
            atm.Haze = preset.atm.haze or 1
            atm.Parent = Lighting
        end

        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if preset.clouds and terrain then
            local clouds = Instance.new("Clouds")
            clouds:SetAttribute("_RyzenDuelsSky", true)
            clouds.Cover = preset.clouds.cover or 0.5
            clouds.Density = preset.clouds.dens or 0.5
            clouds.Color = _vC3(preset.clouds.color)
            clouds.Parent = terrain
        end

        skyTheme = mode
    end

    _G.RyzenStretchValue = 0.70
    _G.RyzenStretchPreset = "Medium"

    _G.RyzenStretchPresets = {
        ["Light"] = 0.85,
        ["Medium"] = 0.70,
        ["Strong"] = 0.55,
        ["Extreme"] = 0.40,
    }

    function enableStretchRez()
        fpsBoostEnabled = true
        if stretchRezConn then stretchRezConn:Disconnect(); stretchRezConn=nil end

        stretchRezConn = RunService.RenderStepped:Connect(function()
            if not fpsBoostEnabled then
                if stretchRezConn then stretchRezConn:Disconnect(); stretchRezConn=nil end
                return
            end

            local cam = Workspace.CurrentCamera or workspace.CurrentCamera
            if cam then
                local sv = 0.70
                
                cam.CFrame = cam.CFrame * CFrame.new(
                    0,0,0,
                    1,0,0,
                    0,sv,0,
                    0,0,1
                )
            end
        end)
    end

    function disableStretchRez()
        fpsBoostEnabled = false
        if stretchRezConn then
            stretchRezConn:Disconnect()
            stretchRezConn = nil
        end
    end

    function _G.RyzenSetStretchPreset(name)
        local v = _G.RyzenStretchPresets[name]
        if not v then return end
        _G.RyzenStretchPreset = name
        _G.RyzenStretchValue = v
    end

    function enableCustomFov() fovEnabled=true; workspace.CurrentCamera.FieldOfView=fovValue; if customFovConn then customFovConn:Disconnect() end; customFovConn=RunService.RenderStepped:Connect(function() if not fovEnabled then customFovConn:Disconnect(); customFovConn=nil; return end; workspace.CurrentCamera.FieldOfView=fovValue end) end
    function disableCustomFov() fovEnabled=false; if customFovConn then customFovConn:Disconnect(); customFovConn=nil end; workspace.CurrentCamera.FieldOfView=fpsBoostEnabled and 107 or 70 end
    _G.RyzenAntiLagV2State = _G.RyzenAntiLagV2State or {
        active = false,
        conn = nil,
        quality = nil,
        lighting = nil,
        terrain = nil,
        objects = {},
        generation = 0,
        scanToken = 0,
    }
    _G.RyzenAntiLagV2State.active = false
    _G.RyzenAntiLagV2State.lighting = nil
    _G.RyzenAntiLagV2State.quality = nil
    _G.RyzenAntiLagV2State.objects = {}

    local function _captureAntiLagV2Object(obj)
        local state = _G.RyzenAntiLagV2State
        if state.objects[obj] then return end
        if obj:IsA("BasePart") then
            state.objects[obj] = {
                kind = "part",
                CastShadow = obj.CastShadow,
                Material = obj.Material,
                Reflectance = obj.Reflectance,
            }
            obj.CastShadow = false
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
            or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            state.objects[obj] = {kind = "enabled", Enabled = obj.Enabled}
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            state.objects[obj] = {kind = "transparency", Transparency = obj.Transparency}
            obj.Transparency = 1
        elseif obj:IsA("PostEffect") then
            state.objects[obj] = {kind = "enabled", Enabled = obj.Enabled}
            obj.Enabled = false
        end
    end

    function enableAntiLagV2()
        local state = _G.RyzenAntiLagV2State
        if state.active then return end
        state.active = true
        antiLagV2Enabled = true
        state.scanToken = (state.scanToken or 0) + 1
        local scanToken = state.scanToken
        state.objects = {}
        state.terrain = nil
        state.lighting = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            Ambient = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            GlobalShadows = Lighting.GlobalShadows,
            FogStart = Lighting.FogStart,
            FogEnd = Lighting.FogEnd,
            FogColor = Lighting.FogColor,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        }
        pcall(function() state.quality = settings().Rendering.QualityLevel end)
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            state.terrain = {
                instance = terrain,
                WaterWaveSize = terrain.WaterWaveSize,
                WaterWaveSpeed = terrain.WaterWaveSpeed,
                WaterReflectance = terrain.WaterReflectance,
            }
            pcall(function() terrain.WaterWaveSize = 0 end)
            pcall(function() terrain.WaterWaveSpeed = 0 end)
            pcall(function() terrain.WaterReflectance = 0 end)
        end
        pcall(function() Lighting.Brightness = 3.25 end)
        pcall(function() Lighting.ClockTime = 14 end)
        pcall(function() Lighting.Ambient = Color3.fromRGB(190, 190, 190) end)
        pcall(function() Lighting.OutdoorAmbient = Color3.fromRGB(190, 190, 190) end)
        pcall(function() Lighting.GlobalShadows = false end)
        pcall(function() Lighting.FogStart = 0 end)
        pcall(function() Lighting.FogEnd = 100000 end)
        pcall(function() Lighting.EnvironmentDiffuseScale = 1 end)
        pcall(function() Lighting.EnvironmentSpecularScale = 0 end)
        task.spawn(function()
            local descendants = workspace:GetDescendants()
            for index, object in ipairs(descendants) do
                if not state.active or state.scanToken ~= scanToken then return end
                pcall(_captureAntiLagV2Object, object)
                if index % 150 == 0 then task.wait() end
            end
        end)
    end

    function disableAntiLagV2()
        local state = _G.RyzenAntiLagV2State
        state.scanToken = (state.scanToken or 0) + 1
        state.active = false
        antiLagV2Enabled = false
        for object, original in pairs(state.objects or {}) do
            pcall(function()
                if not object.Parent then return end
                if original.kind == "part" then
                    object.CastShadow = original.CastShadow
                    object.Material = original.Material
                    object.Reflectance = original.Reflectance
                elseif original.kind == "enabled" then
                    object.Enabled = original.Enabled
                elseif original.kind == "transparency" then
                    object.Transparency = original.Transparency
                end
            end)
        end
        if state.lighting then
            for property, value in pairs(state.lighting) do
                pcall(function() Lighting[property] = value end)
            end
        end
        if state.terrain and state.terrain.instance and state.terrain.instance.Parent then
            local terrain = state.terrain.instance
            pcall(function() terrain.WaterWaveSize = state.terrain.WaterWaveSize end)
            pcall(function() terrain.WaterWaveSpeed = state.terrain.WaterWaveSpeed end)
            pcall(function() terrain.WaterReflectance = state.terrain.WaterReflectance end)
        end
        pcall(function() if state.quality then settings().Rendering.QualityLevel = state.quality end end)
        pcall(function() if setfpscap then setfpscap(240) end end)
        state.lighting = nil
        state.quality = nil
        state.terrain = nil
        state.objects = {}
    end
    _G.RyzenZombieAntiLag = _G.RyzenZombieAntiLag or {
        conn=nil,
        active=false,
        defBrightness=nil,
        defFog=nil,
        defDiffuse=nil,
        defSpecular=nil,
    }

    function _applyAntiLagObj(obj)
        pcall(function()
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter")
                or obj:IsA("Trail")
                or obj:IsA("Beam")
                or obj:IsA("Fire")
                or obj:IsA("Smoke")
                or obj:IsA("Sparkles") then
                obj.Enabled = false
            elseif obj:IsA("AnimationController") or obj:IsA("Animator") then
                for _,tr in ipairs(obj:GetPlayingAnimationTracks()) do
                    pcall(function() tr:Stop(0) end)
                end
            end
        end)
    end

    function enableAntiLag()
        antiLagVisualEnabled = true
        local S = _G.RyzenZombieAntiLag
        S.active = true
        S.defBrightness = S.defBrightness or Lighting.Brightness
        S.defFog = S.defFog or Lighting.FogEnd
        S.defDiffuse = S.defDiffuse or Lighting.EnvironmentDiffuseScale
        S.defSpecular = S.defSpecular or Lighting.EnvironmentSpecularScale

        for _,obj in ipairs(workspace:GetDescendants()) do
            _applyAntiLagObj(obj)
        end

        if S.conn then S.conn:Disconnect() end
        S.conn = workspace.DescendantAdded:Connect(function(obj)
            if S.active then _applyAntiLagObj(obj) end
        end)
        antiLagDescConn = S.conn
    end

    function disableAntiLag()
        antiLagVisualEnabled = false
        local S = _G.RyzenZombieAntiLag
        S.active = false

        if S.conn then
            S.conn:Disconnect()
            S.conn = nil
        end
        antiLagDescConn = nil

        pcall(function()
            if S.defBrightness then Lighting.Brightness = S.defBrightness end
            if S.defFog then Lighting.FogEnd = S.defFog end
            if S.defDiffuse then Lighting.EnvironmentDiffuseScale = S.defDiffuse end
            if S.defSpecular then Lighting.EnvironmentSpecularScale = S.defSpecular end

            for _,e in pairs(Lighting:GetChildren()) do
                pcall(function()
                    if e:IsA("BlurEffect")
                        or e:IsA("SunRaysEffect")
                        or e:IsA("ColorCorrectionEffect")
                        or e:IsA("BloomEffect")
                        or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = true
                    end
                end)
            end
        end)
    end

    function applyKTMOptimization()
        enableAntiLag()
    end

    -- [legacy nuke optimiser kept for reference only - it was always overwritten
    -- by the definition further down; renamed so the real one below is the only
    -- thing the UI toggle can ever call]
    function _legacy_enableNukeOptimizer()
    nukeOptimiserEnabled=true; _aceNukeOn=true; applyKTMOptimization(); applyCustomSky("Off")
    for _,c in ipairs(_aceNukeConns) do pcall(function() c:Disconnect() end) end; _aceNukeConns={}
    table.insert(_aceNukeConns, workspace.DescendantAdded:Connect(function(o) if nukeOptimiserEnabled then _applyAntiLagObj(o) end end))
    task.spawn(function() while nukeOptimiserEnabled do pcall(function() setfpscap(240) end); task.wait(3) end end)
    end
    function _legacy_disableNukeOptimizer() nukeOptimiserEnabled=false; _aceNukeOn=false; for _,c in ipairs(_aceNukeConns) do pcall(function() c:Disconnect() end) end; _aceNukeConns={} end
    function enableNoCamCollision()
    noCamCollisionEnabled=true; if noCamCollisionConn then noCamCollisionConn:Disconnect() end
    noCamCollisionConn=RunService.RenderStepped:Connect(function()
    if not noCamCollisionEnabled then return end
    local cam=workspace.CurrentCamera; local char=LP.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); if not cam or not hrp then return end
    local params=RaycastParams.new(); params.FilterType=Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances=workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("_RyzenAvatarOverlay") and {char,workspace.CurrentCamera:FindFirstChild("_RyzenAvatarOverlay")} or {char}; params.IgnoreWater=true
    local res=workspace:Raycast(cam.CFrame.Position,(hrp.Position+Vector3.new(0,1.5,0))-cam.CFrame.Position,params)
    local hit={}
    if res and res.Instance and res.Instance:IsA("BasePart") then hit[res.Instance]=true; if noCamCollisionParts[res.Instance]==nil then noCamCollisionParts[res.Instance]=res.Instance.LocalTransparencyModifier end; res.Instance.LocalTransparencyModifier=1 end
    for part,orig in pairs(noCamCollisionParts) do if not hit[part] then pcall(function() if part and part.Parent then part.LocalTransparencyModifier=orig end end); noCamCollisionParts[part]=nil end end
    end)
    end
    function disableNoCamCollision() noCamCollisionEnabled=false; if noCamCollisionConn then noCamCollisionConn:Disconnect(); noCamCollisionConn=nil end; for p,orig in pairs(noCamCollisionParts) do pcall(function() if p and p.Parent then p.LocalTransparencyModifier=orig end end) end; noCamCollisionParts={} end
    function enableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    function disableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    end
    V = V or {}
    V.skyTheme = skyTheme or V.skyTheme or "Off"
    V.nukeOptEnabled = nukeOptimiserEnabled == true
    V.customFontEnabled = false
    V.potatoGraphicsEnabled = V.potatoGraphicsEnabled or false
    function enableNoCamCollision()
    noCamCollisionEnabled = true
    if noCamCollisionConn then noCamCollisionConn:Disconnect() end
    noCamCollisionConn = RunService.RenderStepped:Connect(function()
    if not noCamCollisionEnabled then
    if noCamCollisionConn then noCamCollisionConn:Disconnect();noCamCollisionConn=nil end
    return
    end
    local cam = workspace.CurrentCamera
    local char = LP.Character
    if not cam or not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local camPos = cam.CFrame.Position
    local charPos = hrp.Position + Vector3.new(0,1.5,0)
    local toChar = charPos - camPos
    if toChar.Magnitude < 0.3 then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("_RyzenAvatarOverlay") and {char, workspace.CurrentCamera:FindFirstChild("_RyzenAvatarOverlay")} or {char}
    params.IgnoreWater = true
    local hit = {}
    local origin = camPos
    local remaining = toChar
    for _ = 1,12 do
    if remaining.Magnitude < 0.2 then break end
    local res = workspace:Raycast(origin,remaining,params)
    if not res then break end
    local part = res.Instance
    if part and part:IsA("BasePart") and not part:IsDescendantOf(char) then
    hit[part] = true
    if noCamCollisionParts[part] == nil then noCamCollisionParts[part] = part.LocalTransparencyModifier end
    part.LocalTransparencyModifier = 1
    end
    origin = res.Position + remaining.Unit * 0.02
    remaining = charPos - origin
    end
    for part,orig in pairs(noCamCollisionParts) do
    if not hit[part] then
    pcall(function() if part and part.Parent then part.LocalTransparencyModifier = orig end end)
    noCamCollisionParts[part] = nil
    end
    end
    end)
    end
    function disableNoCamCollision()
    noCamCollisionEnabled = false
    if noCamCollisionConn then noCamCollisionConn:Disconnect();noCamCollisionConn=nil end
    for part,orig in pairs(noCamCollisionParts) do
    pcall(function() if part and part.Parent then part.LocalTransparencyModifier = orig end end)
    end
    noCamCollisionParts = {}
    end
    SKY_PRESETS_LIST = {"Off","Night","Aurora","Sunset","Galaxy","Tech","Sakura","Pink Night",
    "Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse",
    "Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}
    SKY_PRESETS = {
    ["Off"] = {kind = "off"},
    ["Night"] = {clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
    ["Aurora"] = {clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
    ["Sunset"] = {clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
    ["Galaxy"] = {clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
    ["Tech"] = {clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
    ["Sakura"] = {clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
    ["Pink Night"] = {clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
    ["Blood Moon"] = {clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
    ["Emerald Dawn"] = {clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
    ["Volcanic"] = {clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
    ["Arctic"] = {clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
    ["Midnight Ocean"] = {clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
    ["Vaporwave"] = {clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.5,dens=0.55,color={200,150,255}}},
    ["Toxic"] = {clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
    ["Solar Eclipse"] = {clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
    ["Hellscape"] = {clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
    ["Heaven"] = {clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
    ["Storm"] = {clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
    ["Sunrise"] = {clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
    ["Deep Space"] = {clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
    ["Lavender Dream"] = {clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
    ["Inferno"] = {clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
    ["Mint Sky"] = {clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
    }
    function _vC3(t) return Color3.fromRGB(t[1], t[2], t[3]) end
    function _v4mpClearSky()
    for _, v in ipairs(Lighting:GetChildren()) do
    if v:GetAttribute("_RyzenDuelsSky") then pcall(function() v:Destroy() end) end
    end
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
    for _, v in ipairs(terrain:GetChildren()) do
    if v:GetAttribute("_RyzenDuelsSky") then pcall(function() v:Destroy() end) end
    end
    end
    end
    function applyCustomSky(mode)
    mode = "Off"
    _v4mpClearSky()
    local preset = SKY_PRESETS[mode]
    if not preset or preset.kind == "off" then
    Lighting.FogEnd = 100000; Lighting.FogStart = 0
    Lighting.FogColor = Color3.fromRGB(192,192,192)
    Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
    Lighting.Ambient = Color3.fromRGB(127,127,127)
    Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
    Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
    V.skyTheme = "Off"
    return
    end
    Lighting.FogEnd = 100000; Lighting.FogStart = 0
    Lighting.FogColor = Color3.fromRGB(200,200,200)
    Lighting.GlobalShadows = true
    Lighting.ClockTime = preset.clock or 14
    Lighting.Brightness = preset.brightness or 2
    if preset.outAmb then Lighting.OutdoorAmbient = _vC3(preset.outAmb) end
    if preset.ambient then Lighting.Ambient = _vC3(preset.ambient) end
    if preset.sky then
    local sky = Instance.new("Sky")
    sky:SetAttribute("_RyzenDuelsSky", true)
    if preset.sky.stars then sky.StarCount = preset.sky.stars end
    if preset.sky.moon then sky.MoonAngularSize = preset.sky.moon end
    if preset.sky.sun then sky.SunAngularSize = preset.sky.sun end
    if preset.sky.moonTex then sky.MoonTextureId = "rbxasset://sky/moon.jpg" end
    sky.Parent = Lighting
    end
    if preset.atm then
    local atm = Instance.new("Atmosphere")
    atm:SetAttribute("_RyzenDuelsSky", true)
    atm.Density = preset.atm.dens or 0.3
    atm.Color = _vC3(preset.atm.color)
    atm.Decay = _vC3(preset.atm.decay)
    atm.Glare = preset.atm.glare or 1
    atm.Haze = preset.atm.haze or 1
    atm.Parent = Lighting
    end
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if preset.clouds and terrain then
    local clouds = Instance.new("Clouds")
    clouds:SetAttribute("_RyzenDuelsSky", true)
    clouds.Cover = preset.clouds.cover or 0.5
    clouds.Density = preset.clouds.dens or 0.5
    clouds.Color = _vC3(preset.clouds.color)
    clouds.Parent = terrain
    end
    V.skyTheme = mode
    skyTheme = "Off"
    end
    if _G.RyzenDaySkyConnection then
        pcall(function() _G.RyzenDaySkyConnection:Disconnect() end)
    end
    _G.RyzenDaySkyConnection = RunService.Heartbeat:Connect(function()
        if Lighting.ClockTime ~= 14 then Lighting.ClockTime = 14 end
    end)
    function enableUltraMode()
    V.ultraModeEnabled = true
    applyKTMOptimization()
    end
    function disableUltraMode()
    V.ultraModeEnabled = false
    end
    function enableRemoveAccessories()
    V.removeAccessoriesEnabledSep = true
    removeAccessoriesEnabled = true
    removeAllAccessories()
    if V.removeAccConn then V.removeAccConn:Disconnect() end
    V.removeAccConn = Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if V.removeAccessoriesEnabledSep or removeAccessoriesEnabled then
    for _,obj in ipairs(char:GetDescendants()) do processAntiLagDescendant(obj) end
    end
    end)
    end)
    if antiLagDescConn then antiLagDescConn:Disconnect() end
    antiLagDescConn = Workspace.DescendantAdded:Connect(function(obj)
    if antiLagEnabled or V.ultraModeEnabled or removeAccessoriesEnabled or V.removeAccessoriesEnabledSep then
    processAntiLagDescendant(obj)
    end
    end)
    end
    function disableRemoveAccessories()
    V.removeAccessoriesEnabledSep = false
    removeAccessoriesEnabled = false
    if V.removeAccConn then V.removeAccConn:Disconnect(); V.removeAccConn = nil end
    if not antiLagEnabled and not V.ultraModeEnabled and antiLagDescConn then antiLagDescConn:Disconnect(); antiLagDescConn = nil end
    end
    -- =====================================================================
    -- MAX OPTIMIZER (ported from your Max Opt script - replaces Ryzen's nuke)
    -- Verbatim port of StartMaxOptimizer / StopMaxOptimizer, with only the
    -- glue needed to live inside Ryzen: flag sync, Ryzen Hub-GUI protection, and a
    -- real teardown on Stop. Aliased to enableNukeOptimizer/disableNukeOptimizer.
    -- =====================================================================
    maxOptimizerEnabled = maxOptimizerEnabled or false
    _nukeOptimizerOn = false
    _nukeOptimizerConns = {}
    _nukeOptimizerThreads = {}
    _nukeOptimizerSaved = nil
    -- ===== NUKE OPTIMIZER (ported) =====
    function StartMaxOptimizer()
        if _nukeOptimizerOn then return end
        _nukeOptimizerOn = true
        maxOptimizerEnabled = true
        -- keep Ryzen's own flags in sync so the UI toggle / config save still work
        nukeOptimiserEnabled = true
        if V then V.nukeOptEnabled = true end
        local LightingSvc = game:GetService("Lighting")

        -- [Ryzen addition] snapshot Lighting so Stop can put it back
        _nukeOptimizerSaved = {
            Brightness       = LightingSvc.Brightness,
            GlobalShadows    = LightingSvc.GlobalShadows,
            FogEnd           = LightingSvc.FogEnd,
            FogStart         = LightingSvc.FogStart,
            Ambient          = LightingSvc.Ambient,
            EnvDiffuse       = LightingSvc.EnvironmentDiffuseScale,
            EnvSpecular      = LightingSvc.EnvironmentSpecularScale,
            Quality          = nil,
        }
        pcall(function() _nukeOptimizerSaved.Quality = settings().Rendering.QualityLevel end)
        local MaterialService = game:GetService("MaterialService")
        local XMin, XMax = -560, -240
        local ClothingClasses = {"Shirt","Pants","ShirtGraphic","Accessory","Hat","HairAccessory","FaceAccessory","NeckAccessory","ShoulderAccessory","FrontAccessory","BackAccessory","WaistAccessory"}
        local BASE_NAMES = {"baseplate","spawnlocation","spawn location","spawn"}
        local function IsUnderPlots(obj)
            if not obj then return false end
            local p = obj
            while p and p ~= game do
                if p.Name == "Plots" or p.Name == "AnimalPodiums" or p.Name == "PlotSign" then
                    return true
                end
                local nl = tostring(p.Name):lower()
                if nl:find("plot", 1, true) or nl:find("base", 1, true) and p:IsA("Model") then
                    local q = p.Parent
                    while q and q ~= game do
                        if q.Name == "Plots" then return true end
                        q = q.Parent
                    end
                end
                p = p.Parent
            end
            return false
        end
        local function IsCharacterPart(obj)
            if not obj then return false end
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character and obj:IsDescendantOf(plr.Character) then return true end
            end
            -- also treat Humanoid-parent models as characters (npcs/avatars)
            local p = obj
            while p and p ~= game do
                if p:IsA("Model") and p:FindFirstChildOfClass("Humanoid") then
                    return true
                end
                p = p.Parent
            end
            return false
        end
        local function SafeDestroy(obj)
            if not obj or obj.Name == "Overhead" then return end
            -- [Ryzen addition] never touch the Ryzen Hub's own GUIs / overhead billboards
            if tostring(obj.Name):sub(1, 5) == "Ryzen" then return end
            if obj:IsA("LayerCollector") or obj:IsA("GuiObject") or obj:IsA("BillboardGui")
                or obj:IsA("SurfaceGui") or obj:IsA("ScreenGui") then return end
            if IsUnderPlots(obj) then return end
            if IsCharacterPart(obj) then return end
            if obj:IsA("Beam") or obj:IsA("Laser") then return end
            pcall(function() obj:Destroy() end)
        end
        local function IsClothing(obj)
            -- never treat character clothing as destroyable via clothing path alone
            if IsCharacterPart(obj) then return false end
            for _, c in ipairs(ClothingClasses) do if obj:IsA(c) then return true end end
            return false
        end
        local function IsOutOfRange(obj)
            if IsUnderPlots(obj) then return false end
            if obj:IsA("BasePart") then
                local x = obj.Position.X
                return x < XMin or x > XMax
            end
            return false
        end
        local function IsBase(obj)
            if IsUnderPlots(obj) then return false end
            if not obj:IsA("BasePart") then return false end
            local nl = obj.Name:lower()
            for _, n in ipairs(BASE_NAMES) do
                if nl:find(n, 1, true) then return true end
            end
            return false
        end
        local function IsInBase(obj)
            if IsUnderPlots(obj) then return true end
            local p = obj.Parent
            while p and p ~= workspace do
                if IsBase(p) then return true end
                p = p.Parent
            end
            return false
        end
        local function MakeTransparent(obj)
            if IsUnderPlots(obj) then return end
            pcall(function()
                if IsBase(obj) and not IsCharacterPart(obj) then
                    obj.Transparency = 1
                    obj.CastShadow = false
                end
            end)
        end
        local function StripObject(obj)
            pcall(function()
                if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SpecialMesh") then
                    SafeDestroy(obj)
                elseif obj:IsA("Beam") then
                    return
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    pcall(function() obj.Enabled = false end)
                    SafeDestroy(obj)
                elseif obj:IsA("SurfaceAppearance") then
                    SafeDestroy(obj)
                elseif obj:IsA("BasePart") then
                    obj.CastShadow = false
                    obj.Material = Enum.Material.Plastic
                    pcall(function() obj.MaterialVariant = "" end)
                    obj.Reflectance = 0
                end
            end)
        end
        local function CleanObject(obj)
            pcall(function()
                if obj:IsA("SurfaceAppearance") then
                    SafeDestroy(obj)
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    if not (obj.Name == "face" and obj.Parent and obj.Parent.Name == "Head") then
                        SafeDestroy(obj)
                    end
                elseif obj:IsA("SpecialMesh") then
                    SafeDestroy(obj)
                end
            end)
        end
        local function ApplyGreySky()
            pcall(function()
                for _, obj in ipairs(LightingSvc:GetChildren()) do
                    if obj:IsA("Sky") then obj:Destroy() end
                end
                local sky = Instance.new("Sky")
                sky.SkyboxBk = ""; sky.SkyboxDn = ""; sky.SkyboxFt = ""
                sky.SkyboxLf = ""; sky.SkyboxRt = ""; sky.SkyboxUp = ""
                sky.CelestialBodiesShown = false
                sky.Name = "_RyzenNukeSky"
                sky.Parent = LightingSvc
            end)
        end
        local function OptimizeLighting()
            for _, v in ipairs(LightingSvc:GetChildren()) do
                if v:GetAttribute("RyzenSaturatedCC") or v.Name == "RyzenSaturated" then
                    -- keep Saturated Colours
                elseif v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect")
                    or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect")
                    or v:IsA("Atmosphere") or v:IsA("Clouds") then
                    v:Destroy()
                end
            end
            ApplyGreySky()
        end
        local function ApplyTerrain()
            pcall(function()
                local t = workspace:FindFirstChildOfClass("Terrain")
                if t then
                    pcall(function() t.WaterWaveSize = 0 end)
                    pcall(function() t.WaterWaveSpeed = 0 end)
                    pcall(function() t.WaterReflectance = 0 end)
                    pcall(function() t.WaterTransparency = 1 end)
                end
            end)
        end
        local function OptimizeCharacter(char)
            -- never modify player avatars / clothing / accessories
            return
        end
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        end)
        pcall(function() if setfpscap then setfpscap(999) end end)
        table.insert(_nukeOptimizerThreads, task.spawn(function()
            if not game:IsLoaded() then game.Loaded:Wait() end
            -- yield once so Main GUI can finish mounting first
            task.wait(0.15)
            if not _nukeOptimizerOn then return end
            OptimizeLighting()
            ApplyTerrain()
            -- rebuild char cache once for this pass
            local charSet = {}
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then charSet[plr.Character] = true end
            end
            local function isCharFast(obj)
                if not obj then return false end
                local p = obj
                while p and p ~= game do
                    if charSet[p] then return true end
                    if p:IsA("Model") and p:FindFirstChildOfClass("Humanoid") then return true end
                    p = p.Parent
                end
                return false
            end
            local list = workspace:GetDescendants()
            local batch = 80
            for i, obj in ipairs(list) do
                if not _nukeOptimizerOn then return end
                if IsUnderPlots(obj) then
                elseif isCharFast(obj) then
                elseif IsBase(obj) then
                    MakeTransparent(obj)
                elseif IsClothing(obj) then
                    SafeDestroy(obj)
                elseif IsInBase(obj) then
                elseif IsOutOfRange(obj) then
                    SafeDestroy(obj)
                else
                    CleanObject(obj)
                    StripObject(obj)
                end
                if i % batch == 0 then task.wait() end
            end
            -- second pass: transparent bases only (lighter)
            local list2 = workspace:GetDescendants()
            for i, obj in ipairs(list2) do
                if not _nukeOptimizerOn then return end
                if not IsUnderPlots(obj) and not isCharFast(obj) then
                    MakeTransparent(obj)
                end
                if i % 120 == 0 then task.wait() end
            end
        end))
        table.insert(_nukeOptimizerConns, workspace.DescendantAdded:Connect(function(obj)
            if not _nukeOptimizerOn then return end
            task.defer(function()
                if not _nukeOptimizerOn then return end
                if IsUnderPlots(obj) then return end
                if IsBase(obj) then MakeTransparent(obj); return end
                if IsClothing(obj) then SafeDestroy(obj)
                elseif IsInBase(obj) then
                elseif IsCharacterPart(obj) then
                elseif IsOutOfRange(obj) then SafeDestroy(obj)
                else CleanObject(obj); StripObject(obj) end
            end)
        end))
        table.insert(_nukeOptimizerConns, LightingSvc.DescendantAdded:Connect(function(obj)
            if not _nukeOptimizerOn then return end
            if obj:IsA("Atmosphere") or obj:IsA("Clouds") or obj:IsA("PostEffect") then
                SafeDestroy(obj)
            end
        end))
        table.insert(_nukeOptimizerConns, MaterialService.DescendantAdded:Connect(function(obj)
            if not _nukeOptimizerOn then return end
            SafeDestroy(obj)
        end))
        for _, plr in ipairs(Players:GetPlayers()) do
            OptimizeCharacter(plr.Character)
            table.insert(_nukeOptimizerConns, plr.CharacterAdded:Connect(OptimizeCharacter))
        end
        table.insert(_nukeOptimizerConns, Players.PlayerAdded:Connect(function(plr)
            table.insert(_nukeOptimizerConns, plr.CharacterAdded:Connect(OptimizeCharacter))
        end))
        table.insert(_nukeOptimizerThreads, task.spawn(function()
            while _nukeOptimizerOn do
                task.wait(15)
                pcall(function() collectgarbage("collect") end)
            end
        end))
    end

    function StopMaxOptimizer()
        _nukeOptimizerOn = false
        maxOptimizerEnabled = false
        -- keep Ryzen's own flags in sync
        nukeOptimiserEnabled = false
        if V then V.nukeOptEnabled = false end

        for _, c in ipairs(_nukeOptimizerConns) do pcall(function() c:Disconnect() end) end
        _nukeOptimizerConns = {}
        for _, t in ipairs(_nukeOptimizerThreads) do
            if type(t) == "thread" then pcall(task.cancel, t) end
        end
        _nukeOptimizerThreads = {}

        -- [Ryzen addition] kill the old ace-nuke connections too, if they ever ran
        if _aceNukeConns then
            for _, c in ipairs(_aceNukeConns) do pcall(function() c:Disconnect() end) end
            _aceNukeConns = {}
        end
        _aceNukeOn = false

        -- [Ryzen addition] restore Lighting + quality, drop the flat sky
        local S = _nukeOptimizerSaved
        if S then
            pcall(function()
                local L = game:GetService("Lighting")
                L.Brightness = S.Brightness
                L.GlobalShadows = S.GlobalShadows
                L.FogEnd = S.FogEnd
                L.FogStart = S.FogStart
                L.Ambient = S.Ambient
                L.EnvironmentDiffuseScale = S.EnvDiffuse
                L.EnvironmentSpecularScale = S.EnvSpecular
            end)
            pcall(function()
                if S.Quality then settings().Rendering.QualityLevel = S.Quality end
            end)
            _nukeOptimizerSaved = nil
        end
        pcall(function()
            local sky = game:GetService("Lighting"):FindFirstChild("_RyzenNukeSky")
            if sky then sky:Destroy() end
        end)
        pcall(function() if setfpscap then setfpscap(240) end end)
        pcall(function() collectgarbage("collect") end)
    end

    -- Ryzen calls these names everywhere (UI toggle, config load, reset).
    -- Point them at the Max Optimizer so nothing else has to change.
    enableNukeOptimizer  = StartMaxOptimizer
    disableNukeOptimizer = StopMaxOptimizer

    function enableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    function disableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    __ace_src_enableNoCamCollision = enableNoCamCollision
    function enableNoCamCollision()
    __ace_src_enableNoCamCollision()
    noCamCollisionEnabled = true
    end
    __ace_src_disableNoCamCollision = disableNoCamCollision
    function disableNoCamCollision()
    __ace_src_disableNoCamCollision()
    noCamCollisionEnabled = false
    end

    _G.RyzenInstallAvatarChanger = function()
        local XAC = {
            model = nil,
            renderConn = nil,
            fpConn = nil,
            hideConn = nil,
            hideEnforceConn = nil,
            motorPairs = {},
            fpHidden = {},
            hiddenParts = {},
            paused = false,
            lastUserId = nil,
            lastUsername = nil,
        }
        _G.RyzenAvatarChangerState = XAC

        local function getFolder()
            local cam = workspace.CurrentCamera
            if not cam then return nil end
            local folder = cam:FindFirstChild("_RyzenAvatarOverlay")
            if not folder then
                folder = Instance.new("Folder")
                folder.Name = "_RyzenAvatarOverlay"
                folder.Parent = cam
            end
            return folder
        end

        local function stopConn(name)
            local c = XAC[name]
            if c then pcall(function() c:Disconnect() end) end
            XAC[name] = nil
        end

        local function restoreReal()
            for inst, old in pairs(XAC.hiddenParts) do
                if inst and inst.Parent then
                    pcall(function()
                        if inst:IsA("BasePart") then
                            inst.LocalTransparencyModifier = old
                        elseif inst:IsA("Decal") or inst:IsA("Texture") then
                            inst.Transparency = old
                        end
                    end)
                end
            end
            table.clear(XAC.hiddenParts)
        end

        local function setRealHidden(on)
            stopConn("hideConn")
            stopConn("hideEnforceConn")
            restoreReal()
            if not on then return end

            local function hideOne(inst)
                if inst:IsA("BasePart") then
                    if XAC.hiddenParts[inst] == nil then
                        XAC.hiddenParts[inst] = inst.LocalTransparencyModifier
                    end
                    inst.LocalTransparencyModifier = 1
                elseif inst:IsA("Decal") or inst:IsA("Texture") then
                    if XAC.hiddenParts[inst] == nil then
                        XAC.hiddenParts[inst] = inst.Transparency
                    end
                    inst.Transparency = 1
                end
            end

            local char = LP.Character
            if not char then return end
            for _, inst in ipairs(char:GetDescendants()) do pcall(hideOne, inst) end

            XAC.hideConn = char.DescendantAdded:Connect(function(inst)
                task.defer(function()
                    if inst and inst.Parent then pcall(hideOne, inst) end
                end)
            end)

            XAC.hideEnforceConn = RunService.RenderStepped:Connect(function()
                local c = LP.Character
                if not c or not XAC.model then return end
                for _, inst in ipairs(c:GetDescendants()) do pcall(hideOne, inst) end
            end)
        end

        local function restoreOverlay()
            for inst, old in pairs(XAC.fpHidden) do
                if inst and inst.Parent then
                    pcall(function()
                        if inst:IsA("BasePart") then
                            inst.LocalTransparencyModifier = old
                        elseif inst:IsA("Decal") or inst:IsA("Texture") then
                            inst.Transparency = old
                        end
                    end)
                end
            end
            table.clear(XAC.fpHidden)
        end

        local function hideOverlay()
            if not XAC.model then return end
            for _, inst in ipairs(XAC.model:GetDescendants()) do
                if inst:IsA("BasePart") then
                    if XAC.fpHidden[inst] == nil then
                        XAC.fpHidden[inst] = inst.LocalTransparencyModifier
                    end
                    inst.LocalTransparencyModifier = 1
                elseif inst:IsA("Decal") or inst:IsA("Texture") then
                    if XAC.fpHidden[inst] == nil then
                        XAC.fpHidden[inst] = inst.Transparency
                    end
                    inst.Transparency = 1
                end
            end
        end

        local function startFirstPerson()
            stopConn("fpConn")
            local hidden = false
            XAC.fpConn = RunService.RenderStepped:Connect(function()
                local cam = workspace.CurrentCamera
                local char = LP.Character
                local head = char and char:FindFirstChild("Head")
                if not XAC.model or not cam or not head then return end

                local d = (cam.CFrame.Position - head.Position).Magnitude
                local lockFP = LP.CameraMode == Enum.CameraMode.LockFirstPerson

                
                if hidden then
                    if not lockFP and d > 1.15 then hidden = false end
                else
                    if lockFP or d <= 0.95 then hidden = true end
                end

                if hidden then
                    
                    hideOverlay()
                    for _, inst in ipairs(XAC.model:GetDescendants()) do
                        if inst:IsA("BasePart") then
                            inst.LocalTransparencyModifier = 1
                        elseif inst:IsA("Decal") or inst:IsA("Texture") then
                            inst.Transparency = 1
                        end
                    end
                elseif next(XAC.fpHidden) ~= nil then
                    restoreOverlay()
                end
            end)
        end

        local function destroyOverlay()
            stopConn("renderConn")
            stopConn("fpConn")
            restoreOverlay()
            if XAC.model then pcall(function() XAC.model:Destroy() end) end
            XAC.model = nil
            XAC.paused = false
        end

        local function prepare(model)
            for _, d in ipairs(model:GetDescendants()) do
                if d:IsA("Script") or d:IsA("LocalScript") then
                    d.Disabled = true
                elseif d:IsA("BasePart") then
                    d.CanCollide = false
                    d.CanTouch = false
                    d.CanQuery = false
                    d.Massless = true
                end
            end
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = true
                hum.AutoRotate = false
                hum.Sit = true
                hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                hum.NameDisplayDistance = 0
                hum.HealthDisplayDistance = 0
            end
            return model
        end

        local function motorKey(m)
            return m.Name .. "|" ..
                ((m.Part0 and m.Part0.Name) or "nil") .. ">" ..
                ((m.Part1 and m.Part1.Name) or "nil")
        end

        local function buildPairs(srcChar, target)
            table.clear(XAC.motorPairs)
            local a, b = {}, {}
            for _, d in ipairs(srcChar:GetDescendants()) do
                if d:IsA("Motor6D") then a[motorKey(d)] = d end
            end
            for _, d in ipairs(target:GetDescendants()) do
                if d:IsA("Motor6D") then b[motorKey(d)] = d end
            end
            for k, src in pairs(a) do
                if b[k] then table.insert(XAC.motorPairs, {src = src, tgt = b[k]}) end
            end
        end

        local function startMirror()
            stopConn("renderConn")
            XAC.renderConn = RunService.RenderStepped:Connect(function()
                if XAC.paused or not XAC.model then return end
                for _, pair in ipairs(XAC.motorPairs) do
                    if pair.src and pair.tgt and pair.src.Parent and pair.tgt.Parent then
                        pair.tgt.Transform = pair.src.Transform
                    end
                end
            end)
        end

        local function resolve(value)
            value = tostring(value or ""):gsub("^%s+",""):gsub("%s+$","")
            if value == "" then return false, "ENTER USERNAME / USER ID" end
            local n = tonumber(value)
            if n then
                local uid = math.floor(n)
                local ok, name = pcall(function() return Players:GetNameFromUserIdAsync(uid) end)
                if not ok or not name then return false, "USER NOT FOUND" end
                return true, uid, name
            end
            local ok, uid = pcall(function() return Players:GetUserIdFromNameAsync(value) end)
            if not ok or not uid then return false, "USER NOT FOUND" end
            return true, uid, value
        end

        local function spawnAvatar(uid, username, status)
            status = status or function() end
            status("SPAWNING...")
            destroyOverlay()

            local ok, model = pcall(function()
                return Players:CreateHumanoidModelFromUserIdAsync(uid)
            end)
            if not ok or typeof(model) ~= "Instance" then
                status("FAILED")
                return
            end

            model = prepare(model)
            model.Name = "RyzenAvatarOverlay_" .. tostring(uid)

            local folder = getFolder()
            local char = LP.Character
            local myHRP = char and char:FindFirstChild("HumanoidRootPart")
            local oHRP = model:FindFirstChild("HumanoidRootPart")
            if not folder or not myHRP or not oHRP then
                model:Destroy()
                status("HRP NOT READY")
                return
            end

            model.Parent = folder
            model:PivotTo(myHRP.CFrame)

            local weld = Instance.new("WeldConstraint")
            weld.Part0 = oHRP
            weld.Part1 = myHRP
            weld.Parent = oHRP

            XAC.model = model
            XAC.lastUserId = uid
            XAC.lastUsername = username
            _G.RyzenAvatarChangerCleared = false
            XAC.paused = false

            
            pcall(function()
                if _G.RyzenApplyHeadless then
                    _G.RyzenApplyHeadless(model, _G.RyzenHeadlessEnabled == true)
                end
                if _G.RyzenApplyKorblox then
                    _G.RyzenApplyKorblox(model, _G.RyzenKorbloxEnabled == true)
                end
            end)

            setRealHidden(true)
            buildPairs(char, model)
            startMirror()
            startFirstPerson()
            status("ACTIVE - " .. tostring(username))
        end

        _G.RyzenAvatarChangerSpawn = spawnAvatar
        _G.RyzenAvatarChangerRemove = function()
            destroyOverlay()
            setRealHidden(false)
            XAC.lastUserId = nil
            XAC.lastUsername = nil
            _G.RyzenAvatarChangerCleared = true
        end
        _G.RyzenAvatarChangerResolve = resolve

        _G.RyzenOpenAvatarChanger = function()
            local old = PlayerGui:FindFirstChild("RyzenAvatarChangerGallery")
            if old then old:Destroy() end

            local sg = Instance.new("ScreenGui")
            sg.Name = "RyzenAvatarChangerGallery"
            sg.IgnoreGuiInset = true
            sg.ResetOnSpawn = false
            sg.DisplayOrder = 99999
            sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            safeParentGui(sg)

            local shade = Instance.new("TextButton")
            shade.Text = ""
            shade.AutoButtonColor = false
            shade.BackgroundColor3 = Color3.fromRGB(0,0,0)
            shade.BackgroundTransparency = 0.25
            shade.Size = UDim2.fromScale(1,1)
            shade.ZIndex = 1
            shade.Parent = sg

            local panel = Instance.new("Frame")
            panel.AnchorPoint = Vector2.new(0.5,0.5)
            panel.Position = UDim2.fromScale(0.5,0.5)
            panel.Size = UDim2.new(0, 620, 0, 500)
            panel.BackgroundColor3 = Color3.fromRGB(10,10,15)
            panel.BackgroundTransparency = 0.04
            panel.BorderSizePixel = 0
            panel.ZIndex = 2
            panel.Parent = sg
            corner(panel,16)
            stroke(panel,COLORS.strokeSoft,1.2,0.15)

            pcall(function()
                local bg = Main and Main:FindFirstChild("CustomBackground")
                if bg and bg:IsA("ImageLabel") and bg.Visible and bg.Image ~= "" then
                    local pbg = bg:Clone()
                    pbg.Name = "PanelBackground"
                    pbg.Size = UDim2.fromScale(1,1)
                    pbg.Position = UDim2.fromScale(0,0)
                    pbg.ZIndex = 2
                    pbg.ImageTransparency = math.max(bg.ImageTransparency,0.18)
                    pbg.Parent = panel
                    corner(pbg,16)
                end
            end)

            local title = Instance.new("TextLabel")
            title.BackgroundTransparency = 1
            title.Text = "RXZ AVATAR CHANGER (NOT WORKING)"
            title.TextColor3 = COLORS.white
            title.Font = Enum.Font.GothamMedium
            title.TextSize = 19
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Position = UDim2.new(0,18,0,10)
            title.Size = UDim2.new(1,-70,0,38)
            title.ZIndex = 4
            title.Parent = panel

            local close = Instance.new("TextButton")
            close.Text = "X"
            close.Font = Enum.Font.GothamMedium
            close.TextSize = 11
            close.TextColor3 = COLORS.white
            close.BackgroundColor3 = Color3.fromRGB(16,16,22)
            close.Size = UDim2.fromOffset(34,30)
            close.Position = UDim2.new(1,-46,0,14)
            close.ZIndex = 5
            close.Parent = panel
            corner(close,9)
            stroke(close,COLORS.strokeSoft,1,0.45)

            local input = Instance.new("TextBox")
            input.PlaceholderText = "SEARCH ANY ROBLOX USER..."
            input.ClearTextOnFocus = false
            input.Text = ""
            input.Font = Enum.Font.GothamMedium
            input.TextSize = 11
            input.TextColor3 = COLORS.white
            input.PlaceholderColor3 = Color3.fromRGB(140,140,150)
            input.BackgroundColor3 = Color3.fromRGB(16,16,22)
            input.BackgroundTransparency = 0.06
            input.Position = UDim2.new(0,18,0,58)
            input.Size = UDim2.new(1,-36,0,36)
            input.ZIndex = 4
            input.Parent = panel
            corner(input,9)
            stroke(input,COLORS.strokeSoft,1,0.5)

            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = "FEATURED"
            sectionLabel.TextColor3 = COLORS.white
            sectionLabel.Font = Enum.Font.GothamMedium
            sectionLabel.TextSize = 10
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.Position = UDim2.new(0,18,0,98)
            sectionLabel.Size = UDim2.new(1,-36,0,20)
            sectionLabel.ZIndex = 4
            sectionLabel.Parent = panel

            local status = Instance.new("TextLabel")
            status.BackgroundTransparency = 1
            status.Text = "LOADING FEATURED..."
            status.TextColor3 = Color3.fromRGB(180,180,190)
            status.Font = Enum.Font.GothamMedium
            status.TextSize = 9
            status.TextXAlignment = Enum.TextXAlignment.Left
            status.Position = UDim2.new(0,18,1,-28)
            status.Size = UDim2.new(1,-36,0,20)
            status.ZIndex = 4
            status.Parent = panel
            status.Size = UDim2.new(1,-190,0,20)

            
            local removeAvatarBtn = Instance.new("TextButton")
            removeAvatarBtn.Name = "RemoveAvatarButton"
            removeAvatarBtn.Text = "REMOVE AVATAR"
            removeAvatarBtn.Font = Enum.Font.GothamMedium
            removeAvatarBtn.TextSize = 9
            removeAvatarBtn.TextColor3 = Color3.fromRGB(255,255,255)
            removeAvatarBtn.BackgroundColor3 = Color3.fromRGB(170,35,35)
            removeAvatarBtn.BackgroundTransparency = 0
            removeAvatarBtn.BorderSizePixel = 0
            removeAvatarBtn.Position = UDim2.new(1,-168,1,-34)
            removeAvatarBtn.Size = UDim2.new(0,150,0,26)
            removeAvatarBtn.ZIndex = 6
            removeAvatarBtn.Parent = panel
            corner(removeAvatarBtn,8)
            stroke(removeAvatarBtn,Color3.fromRGB(235,75,75),1,0.15)

            removeAvatarBtn.MouseButton1Click:Connect(function()
                if _G.RyzenAvatarChangerRemove then
                    pcall(_G.RyzenAvatarChangerRemove)
                    status.Text = "AVATAR REMOVED"
                else
                    status.Text = "REMOVE FAILED"
                end
            end)

            local scroll = Instance.new("ScrollingFrame")
            scroll.BackgroundTransparency = 1
            scroll.BorderSizePixel = 0
            scroll.Position = UDim2.new(0,12,0,122)
            scroll.Size = UDim2.new(1,-24,1,-160)
            scroll.ScrollBarThickness = 4
            scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
            scroll.CanvasSize = UDim2.new(0,0,0,0)
            scroll.ZIndex = 4
            scroll.Parent = panel

            local grid = Instance.new("UIGridLayout")
            grid.CellSize = UDim2.fromOffset(132,160)
            grid.CellPadding = UDim2.fromOffset(10,10)
            grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
            grid.SortOrder = Enum.SortOrder.LayoutOrder
            grid.Parent = scroll

            local famousSeeds = {
                "Roblox","Builderman","KreekCraft","Flamingo","ItsFunneh",
                "DenisDaily","RussoTalks","MeganPlays","LeahAshe","Thinknoodles",
                "SharkBlox","InquisitorMaster","GamingWithKev","Sketch","Bandites",
                "TanqR","DVPlays","NightFoxx","iamSanna","Temprist",
                "MiniToon","asimo3089","badcc","NewFissy","Coeptus",
                "Wolfpaq","BelowNatural","callmehbob"
            }

            local featuredUsers = {}
            local searchResults = {}
            local searchToken = 0

            local function clearCards()
                for _, child in ipairs(scroll:GetChildren()) do
                    if child:IsA("GuiButton") then child:Destroy() end
                end
            end

            local function addCard(userData, order)
                local card = Instance.new("TextButton")
                card.Text = ""
                card.AutoButtonColor = false
                card.BackgroundColor3 = Color3.fromRGB(16,16,22)
                card.BackgroundTransparency = 0.07
                card.BorderSizePixel = 0
                card.LayoutOrder = order
                card.ZIndex = 5
                card.Parent = scroll
                corner(card,11)
                stroke(card,COLORS.strokeSoft,1,0.55)

                local thumb = Instance.new("ImageLabel")
                thumb.BackgroundColor3 = Color3.fromRGB(10,10,14)
                thumb.BackgroundTransparency = 0.08
                thumb.BorderSizePixel = 0
                thumb.Position = UDim2.new(0,8,0,8)
                thumb.Size = UDim2.new(1,-16,0,108)
                thumb.ScaleType = Enum.ScaleType.Crop
                thumb.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userData.id) .. "&w=150&h=150"
                thumb.ZIndex = 6
                thumb.Parent = card
                corner(thumb,9)

                if userData.hasVerifiedBadge == true then
                    local verified = Instance.new("TextLabel")
                    verified.BackgroundColor3 = Color3.fromRGB(255,255,255)
                    verified.BackgroundTransparency = 0.08
                    verified.Text = "OK"
                    verified.TextColor3 = Color3.fromRGB(10,10,15)
                    verified.Font = Enum.Font.GothamMedium
                    verified.TextSize = 12
                    verified.Size = UDim2.fromOffset(20,20)
                    verified.Position = UDim2.new(1,-26,0,14)
                    verified.ZIndex = 8
                    verified.Parent = card
                    corner(verified,999)
                end

                local display = Instance.new("TextLabel")
                display.BackgroundTransparency = 1
                display.Text = tostring(userData.displayName or userData.name)
                display.TextColor3 = COLORS.white
                display.Font = Enum.Font.GothamMedium
                display.TextSize = 9
                display.TextWrapped = true
                display.TextXAlignment = Enum.TextXAlignment.Center
                display.Position = UDim2.new(0,5,0,119)
                display.Size = UDim2.new(1,-10,0,17)
                display.ZIndex = 6
                display.Parent = card

                local username = Instance.new("TextLabel")
                username.BackgroundTransparency = 1
                username.Text = "@" .. tostring(userData.name)
                username.TextColor3 = Color3.fromRGB(160,160,175)
                username.Font = Enum.Font.GothamMedium
                username.TextSize = 9
                username.TextXAlignment = Enum.TextXAlignment.Center
                username.Position = UDim2.new(0,5,0,137)
                username.Size = UDim2.new(1,-10,0,15)
                username.ZIndex = 6
                username.Parent = card

                card.MouseButton1Click:Connect(function()
                    spawnAvatar(userData.id, userData.name, function(v)
                        status.Text = tostring(v)
                    end)
                    task.defer(function()
                        if sg and sg.Parent then
                            sg:Destroy()
                        end
                    end)
                end)
            end

            local function renderFeatured()
                clearCards()
                sectionLabel.Text = "FEATURED"
                local count = 0
                for _, u in ipairs(featuredUsers) do
                    count += 1
                    addCard(u, count)
                end
                status.Text = tostring(count) .. " FEATURED AVATARS"
            end

            local function renderSearch()
                clearCards()
                sectionLabel.Text = "SEARCH RESULTS"
                local count = 0
                for _, u in ipairs(searchResults) do
                    count += 1
                    addCard(u, count)
                end
                status.Text = tostring(count) .. " RESULTS"
            end

            local function searchAnyUser(query)
                query = tostring(query or ""):gsub("^%s+",""):gsub("%s+$","")
                searchToken += 1
                local myToken = searchToken

                if query == "" then
                    searchResults = {}
                    renderFeatured()
                    return
                end

                status.Text = "SEARCHING..."
                sectionLabel.Text = "SEARCH RESULTS"

                task.spawn(function()
                    local results = {}

                    
                    local okId, uid = pcall(function()
                        return Players:GetUserIdFromNameAsync(query)
                    end)

                    if myToken ~= searchToken then return end

                    if okId and uid and uid > 0 then
                        local okInfo, body = pcall(function()
                            return game:HttpGet("https://users.roblox.com/v1/users/" .. tostring(uid))
                        end)
                        if okInfo and body and body ~= "" then
                            local okJson, data = pcall(function()
                                return HttpService:JSONDecode(body)
                            end)
                            if okJson and type(data) == "table" then
                                table.insert(results, {
                                    id = tonumber(data.id) or uid,
                                    name = tostring(data.name or query),
                                    displayName = tostring(data.displayName or data.name or query),
                                    hasVerifiedBadge = data.hasVerifiedBadge == true
                                })
                            end
                        end
                    end

                    
                    local encoded = HttpService:UrlEncode(query)
                    local okSearch, body = pcall(function()
                        return game:HttpGet(
                            "https://users.roblox.com/v1/users/search?keyword=" ..
                            encoded .. "&limit=20"
                        )
                    end)

                    if myToken ~= searchToken then return end

                    if okSearch and body and body ~= "" then
                        local okJson, data = pcall(function()
                            return HttpService:JSONDecode(body)
                        end)
                        if okJson and type(data) == "table" and type(data.data) == "table" then
                            local seen = {}
                            for _, r in ipairs(results) do seen[r.id] = true end

                            for _, item in ipairs(data.data) do
                                local id = tonumber(item.id)
                                if id and not seen[id] then
                                    seen[id] = true
                                    table.insert(results, {
                                        id = id,
                                        name = tostring(item.name or id),
                                        displayName = tostring(item.displayName or item.name or id),
                                        hasVerifiedBadge = item.hasVerifiedBadge == true
                                    })
                                end
                            end
                        end
                    end

                    if myToken ~= searchToken then return end
                    searchResults = results
                    renderSearch()
                end)
            end

            input:GetPropertyChangedSignal("Text"):Connect(function()
                local current = input.Text
                task.delay(0.18, function()
                    if input.Text == current then
                        searchAnyUser(current)
                    end
                end)
            end)

            close.MouseButton1Click:Connect(function()
                sg:Destroy()
            end)

            
            task.spawn(function()
                local pending = #famousSeeds
                local seen = {}

                if pending == 0 then
                    status.Text = "NO FEATURED USERS"
                    return
                end

                for _, seedName in ipairs(famousSeeds) do
                    task.spawn(function()
                        local okId, uid = pcall(function()
                            return Players:GetUserIdFromNameAsync(seedName)
                        end)

                        if okId and uid and uid > 0 and not seen[uid] then
                            seen[uid] = true

                            local okInfo, body = pcall(function()
                                return game:HttpGet("https://users.roblox.com/v1/users/" .. tostring(uid))
                            end)

                            if okInfo and body and body ~= "" then
                                local okJson, data = pcall(function()
                                    return HttpService:JSONDecode(body)
                                end)

                                if okJson and type(data) == "table" then
                                    
                                    table.insert(featuredUsers, {
                                        id = tonumber(data.id) or uid,
                                        name = tostring(data.name or seedName),
                                        displayName = tostring(data.displayName or data.name or seedName),
                                        hasVerifiedBadge = data.hasVerifiedBadge == true
                                    })

                                    table.sort(featuredUsers, function(a,b)
                                        return string.lower(a.displayName or a.name)
                                            < string.lower(b.displayName or b.name)
                                    end)

                                    if input.Text == "" and sg.Parent then
                                        renderFeatured()
                                    end
                                end
                            end
                        end

                        pending -= 1
                        if pending <= 0 and input.Text == "" and sg.Parent then
                            renderFeatured()
                        end
                    end)
                end
            end)
        end

        LP.CharacterAdded:Connect(function()
            task.wait(0.35)
            if XAC.lastUserId then
                local uid, name = XAC.lastUserId, XAC.lastUsername
                task.defer(function()
                    spawnAvatar(uid,name or tostring(uid),function() end)
                end)
            end
        end)

        
        task.defer(function()
            task.wait(0.5)
            if XAC.lastUserId and LP.Character then
                spawnAvatar(XAC.lastUserId, XAC.lastUsername or tostring(XAC.lastUserId), function() end)
            end
        end)
    end

    _G.RyzenInstallAvatarChanger()
    _G.RyzenInstallAvatarChanger = nil


    if _G.RyzenAvatarChangerState then
        _G.RyzenAvatarChangerState.lastUserId = _G.RyzenSavedAvatarChangerUserId
        _G.RyzenAvatarChangerState.lastUsername = (_G.RyzenSavedAvatarChangerUsername ~= "" and _G.RyzenSavedAvatarChangerUsername) or nil
    end


    do
        local originalApplyHeadless = _G.RyzenApplyHeadless
        local originalApplyKorblox = _G.RyzenApplyKorblox
        local originalApplyCharacterVisuals = _G.RyzenApplyCharacterVisuals

        if originalApplyHeadless then
            _G.RyzenApplyHeadless = function(char, enabled)
                originalApplyHeadless(char, enabled)

                local state = _G.RyzenAvatarChangerState
                local overlay = state and state.model
                if overlay and overlay.Parent and overlay ~= char then
                    pcall(function()
                        originalApplyHeadless(overlay, enabled)
                    end)
                end
            end
        end

        if originalApplyKorblox then
            _G.RyzenApplyKorblox = function(char, enabled)
                originalApplyKorblox(char, enabled)

                local state = _G.RyzenAvatarChangerState
                local overlay = state and state.model
                if overlay and overlay.Parent and overlay ~= char then
                    pcall(function()
                        originalApplyKorblox(overlay, enabled)
                    end)
                end
            end
        end

        if originalApplyCharacterVisuals then
            _G.RyzenApplyCharacterVisuals = function(char)
                originalApplyCharacterVisuals(char)

                local state = _G.RyzenAvatarChangerState
                local overlay = state and state.model
                if overlay and overlay.Parent and overlay ~= char then
                    pcall(function()
                        if originalApplyHeadless then
                            originalApplyHeadless(overlay, _G.RyzenHeadlessEnabled == true)
                        end
                        if originalApplyKorblox then
                            originalApplyKorblox(overlay, _G.RyzenKorbloxEnabled == true)
                        end
                    end)
                end
            end
        end
    end


    local shinyGraphicsBloom
    local shinyGraphicsCorrection
    local shinyGraphicsLightingCaptured = false
    local shinyGraphicsOriginalLighting = {}

    local function shinyGraphicsTween(object, properties, duration)
        TweenService:Create(
            object,
            TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            properties
        ):Play()
    end

    local function getShinyGraphicsEffects()
        shinyGraphicsBloom = shinyGraphicsBloom and shinyGraphicsBloom.Parent and shinyGraphicsBloom or Lighting:FindFirstChild("RyzenShinyBloom")
        shinyGraphicsCorrection = shinyGraphicsCorrection and shinyGraphicsCorrection.Parent and shinyGraphicsCorrection or Lighting:FindFirstChild("RyzenShinyCorrection")
        if not shinyGraphicsBloom then
            shinyGraphicsBloom = Instance.new("BloomEffect")
            shinyGraphicsBloom.Name = "RyzenShinyBloom"
            shinyGraphicsBloom.Intensity = 0
            shinyGraphicsBloom.Size = 24
            shinyGraphicsBloom.Threshold = 1.1
            shinyGraphicsBloom.Parent = Lighting
        end
        if not shinyGraphicsCorrection then
            shinyGraphicsCorrection = Instance.new("ColorCorrectionEffect")
            shinyGraphicsCorrection.Name = "RyzenShinyCorrection"
            shinyGraphicsCorrection.Brightness = 0
            shinyGraphicsCorrection.Contrast = 0
            shinyGraphicsCorrection.Saturation = 0
            shinyGraphicsCorrection.TintColor = Color3.fromRGB(255, 255, 255)
            shinyGraphicsCorrection.Parent = Lighting
        end
        return shinyGraphicsBloom, shinyGraphicsCorrection
    end

    function enableShinyGraphics()
        shinyGraphicsEnabled = true
        local bloom, correction = getShinyGraphicsEffects()
        if not shinyGraphicsLightingCaptured then
            shinyGraphicsOriginalLighting.GlobalShadows = Lighting.GlobalShadows
            shinyGraphicsOriginalLighting.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
            shinyGraphicsOriginalLighting.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
            shinyGraphicsLightingCaptured = true
        end
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.EnvironmentDiffuseScale = 0.75
            Lighting.EnvironmentSpecularScale = 0.75
        end)
        bloom.Enabled = true
        correction.Enabled = true
        shinyGraphicsTween(bloom, {Intensity = 0.5, Size = 30, Threshold = 0.78}, 0.7)
        shinyGraphicsTween(correction, {
            Brightness = 0.075,
            Contrast = 0.1,
            Saturation = 0.14,
            TintColor = Color3.fromRGB(255, 250, 238),
        }, 0.7)
    end

    function disableShinyGraphics()
        shinyGraphicsEnabled = false
        local bloom = shinyGraphicsBloom
        local correction = shinyGraphicsCorrection
        if not bloom or not bloom.Parent or not correction or not correction.Parent then return end
        shinyGraphicsTween(bloom, {Intensity = 0, Size = 24, Threshold = 1.1}, 0.55)
        shinyGraphicsTween(correction, {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255),
        }, 0.55)
        task.delay(0.6, function()
            if shinyGraphicsEnabled then return end
            if shinyGraphicsBloom then shinyGraphicsBloom.Enabled = false end
            if shinyGraphicsCorrection then shinyGraphicsCorrection.Enabled = false end
            if shinyGraphicsLightingCaptured then
                pcall(function()
                    Lighting.GlobalShadows = shinyGraphicsOriginalLighting.GlobalShadows
                    Lighting.EnvironmentDiffuseScale = shinyGraphicsOriginalLighting.EnvironmentDiffuseScale
                    Lighting.EnvironmentSpecularScale = shinyGraphicsOriginalLighting.EnvironmentSpecularScale
                end)
                shinyGraphicsLightingCaptured = false
                shinyGraphicsOriginalLighting = {}
            end
        end)
    end

    function __RyzenDuelsSetupVisualsUI()
    local Utility = pages.VISUALS
    local skyThemes = SKY_PRESETS_LIST or {"Off", "Night", "Aurora", "Sunset", "Galaxy", "Tech", "Sakura"}
    local skyIndex = 1
    for i, name in ipairs(skyThemes) do if name == skyTheme then skyIndex = i break end end
    function skyThemeSelectorRow(parent, order)
    local row = Instance.new("Frame")
    row.Name = "Sky Theme"
    row.ZIndex = 4
    row.Size = UDim2.new(1,-4,0,52)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.ZIndex = 5
    label.Position = UDim2.new(0,2,0,0)
    label.Size = UDim2.new(1,0,0,16)
    label.BackgroundTransparency = 1
    label.Text = "Sky Theme"
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBlack
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local left = Instance.new("TextButton")
    left.Name = "SkyLeft"
    left.ZIndex = 6
    left.Position = UDim2.new(0,0,0,22)
    left.Size = UDim2.new(0,44,0,25)
    left.BackgroundColor3 = Color3.fromRGB(8,8,12)
    left.BackgroundTransparency = 0.18
    left.BorderSizePixel = 0
    left.Text = "<"
    left.TextColor3 = Color3.fromRGB(255,255,255)
    left.TextSize = 12
    left.Font = Enum.Font.GothamMedium
    left.AutoButtonColor = false
    left.Parent = row
    corner(left,7)
    stroke(left,COLORS.strokeSoft,1,0.45)

    local value = Instance.new("TextButton")
    value.Name = "SkyValue"
    value.ZIndex = 6
    value.Position = UDim2.new(0,48,0,22)
    value.Size = UDim2.new(1,-96,0,28)
    value.BackgroundColor3 = Color3.fromRGB(8,8,12)
    value.BackgroundTransparency = 0.18
    value.BorderSizePixel = 0
    value.Text = skyThemes[skyIndex]
    value.TextColor3 = Color3.fromRGB(255,255,255)
    value.TextSize = 12
    value.Font = Enum.Font.GothamMedium
    value.AutoButtonColor = false
    value.Parent = row
    corner(value,7)
    stroke(value,COLORS.strokeSoft,1,0.45)
    skyValueLabel = value

    local right = Instance.new("TextButton")
    right.Name = "SkyRight"
    right.ZIndex = 6
    right.Position = UDim2.new(1,-44,0,22)
    right.Size = UDim2.new(0,44,0,25)
    right.BackgroundColor3 = Color3.fromRGB(8,8,12)
    right.BackgroundTransparency = 0.18
    right.BorderSizePixel = 0
    right.Text = ">"
    right.TextColor3 = Color3.fromRGB(255,255,255)
    right.TextSize = 12
    right.Font = Enum.Font.GothamMedium
    right.AutoButtonColor = false
    right.Parent = row
    corner(right,7)
    stroke(right,COLORS.strokeSoft,1,0.45)

    local function setSkyIndex(nextIndex)
    if nextIndex < 1 then nextIndex = #skyThemes end
    if nextIndex > #skyThemes then nextIndex = 1 end
    skyIndex = nextIndex
    skyTheme = skyThemes[skyIndex]
    if applyCustomSky then applyCustomSky(skyTheme) end
    if skyValueLabel then skyValueLabel.Text = skyTheme end
    end

    left.Activated:Connect(function() setSkyIndex(skyIndex - 1) end)
    right.Activated:Connect(function() setSkyIndex(skyIndex + 1) end)
    return row
    end

    -- Headless + Korblox (Pepsi engine) - rows live under the PLAYERS
    -- section of the VISUALS tab (shown via showNamed in the reorg below)
    _, _G.RyzenHeadlessVisual = toggleRow(Utility, "Headless", _G.RyzenHeadlessEnabled, 4.5)
    _G.RyzenHeadlessRow = Utility:FindFirstChild("Headless")
    _G.RyzenHeadlessButton = _G.RyzenHeadlessRow and _G.RyzenHeadlessRow:FindFirstChild("ToggleButton")
    if _G.RyzenHeadlessButton then
    _G.RyzenHeadlessButton.Activated:Connect(function()
    _G.RyzenHeadlessEnabled = not _G.RyzenHeadlessEnabled
    _G.RyzenApplyHeadless(LP.Character, _G.RyzenHeadlessEnabled)
    if _G.RyzenHeadlessVisual then _G.RyzenHeadlessVisual(_G.RyzenHeadlessEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end

    _, _G.RyzenKorbloxVisual = toggleRow(Utility, "Korblox", _G.RyzenKorbloxEnabled, 4.6)
    _G.RyzenKorbloxRow = Utility:FindFirstChild("Korblox")
    _G.RyzenKorbloxButton = _G.RyzenKorbloxRow and _G.RyzenKorbloxRow:FindFirstChild("ToggleButton")
    if _G.RyzenKorbloxButton then
    _G.RyzenKorbloxButton.Activated:Connect(function()
    _G.RyzenKorbloxEnabled = not _G.RyzenKorbloxEnabled
    _G.RyzenApplyKorblox(LP.Character, _G.RyzenKorbloxEnabled)
    if _G.RyzenKorbloxVisual then _G.RyzenKorbloxVisual(_G.RyzenKorbloxEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end

    task.defer(function()
    task.wait(0.8)
    _G.RyzenApplyCharacterVisuals(LP.Character)
    if _G.RyzenHeadlessVisual then _G.RyzenHeadlessVisual(_G.RyzenHeadlessEnabled) end
    if _G.RyzenKorbloxVisual then _G.RyzenKorbloxVisual(_G.RyzenKorbloxEnabled) end
    end)


    section(Utility, "ESP", 1)
    do
    local espRow, setESPVisual = toggleRow(Utility, "ESP", espEnabled, 2)
    setPlayerESPVisual = setESPVisual
    _aceBtn = espRow and espRow:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
    if startPlayerESP then startPlayerESP() end
    if BoxedESPOptions then BoxedESPOptions.box = false end
    else
    if stopPlayerESP then stopPlayerESP() end
    if BoxedESPOptions then BoxedESPOptions.box = false end
    end
    if refreshBoxedESP then refreshBoxedESP() end
    if setESPVisual then setESPVisual(espEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    section(Utility, "SKY THEME", 5)
    skyThemeSelectorRow(Utility, 6)


    animationPackRow(Utility, 7)

    section(Utility, "PERFORMANCE", 8)
    do
    local row, setVisual = toggleRow(Utility, "Stretch Rez", fpsBoostEnabled, 11)
    setFPSBoostVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    fpsBoostEnabled = not fpsBoostEnabled
    if fpsBoostEnabled then enableStretchRez() else disableStretchRez() end
    if setVisual then setVisual(fpsBoostEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end

    do
    local row, setVisual = toggleRow(Utility, "Anti Lag", antiLagVisualEnabled, 10)
    setAntiLagVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    if antiLagVisualEnabled then disableAntiLag() else enableAntiLag() end
    if setVisual then setVisual(antiLagVisualEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    do
    local row, setVisual, button = _G.RyzenActionToggleRow(Utility, "Anti Lag V2", antiLagV2Enabled, 9)
    setAntiLagV2Visual = setVisual
    local lastAntiLagV2Click = 0
    local function toggleAntiLagV2FromUI()
        local now = tick()
        if now - lastAntiLagV2Click < 0.25 then return end
        lastAntiLagV2Click = now
        local ok, err = pcall(function()
            if antiLagV2Enabled then
                disableAntiLagV2()
            else
                enableAntiLagV2()
            end
        end)
        if not ok then
            antiLagV2Enabled = false
            pcall(disableAntiLagV2)
            warn("[RYZEN] Anti Lag V2 failed: " .. tostring(err))
        end
        if setVisual then pcall(setVisual, antiLagV2Enabled == true) end
        if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    _G.RyzenToggleAntiLagV2 = toggleAntiLagV2FromUI
    if button then button.Activated:Connect(toggleAntiLagV2FromUI) end
    end
    do
    local row, setVisual = _G.RyzenActionToggleRow(Utility, "Nuke Optimiser", nukeOptimiserEnabled, 12)
    setNukeOptimiserVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    if nukeOptimiserEnabled then
    disableNukeOptimizer()
    else
    enableNukeOptimizer()
    end
    if setVisual then setVisual(nukeOptimiserEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    section(Utility, "CAMERA", 13)
    do
    local row, setVisual = toggleRow(Utility, "FOV", fovEnabled, 14)
    setFOVVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    if fovEnabled then disableCustomFov() else enableCustomFov() end
    if setVisual then setVisual(fovEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    do
    local _, box = textboxRow(Utility, "FOV Value", tostring(fovValue), 14)
    box.FocusLost:Connect(function()
    local v = tonumber(box.Text)
    if v and v >= 30 and v <= 120 then
    fovValue = v
    if fovEnabled and workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = fovValue end
    end
    box.Text = tostring(fovValue)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    do
    local row, setVisual = toggleRow(Utility, "Shiny Graphics", shinyGraphicsEnabled, 15)
    setShinyGraphicsVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    shinyGraphicsEnabled = not shinyGraphicsEnabled
    if shinyGraphicsEnabled then enableShinyGraphics() else disableShinyGraphics() end
    if setVisual then setVisual(shinyGraphicsEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    do
    local row, setVisual = toggleRow(Utility, "No Cam Collision", noCamCollisionEnabled, 16)
    setNoCamCollisionVisual = setVisual
    _aceBtn = row and row:FindFirstChild("ToggleButton")
    if _aceBtn then
    _aceBtn.Activated:Connect(function()
    if noCamCollisionEnabled then disableNoCamCollision() else enableNoCamCollision() end
    if setVisual then setVisual(noCamCollisionEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    end
    task.wait()
    __RyzenDuelsSetupVisualsUI()

    function _G.RyzenRestoreFonts()
        if _G.RyzenFontAddedConn then
            pcall(function() _G.RyzenFontAddedConn:Disconnect() end)
            _G.RyzenFontAddedConn = nil
        end
        if _G.RyzenFontBackup then
            for obj, oldFont in pairs(_G.RyzenFontBackup) do
                pcall(function()
                    if obj and obj.Parent then obj.Font = oldFont end
                end)
            end
        end
        _G.RyzenFontBackup = {}
    end

    function _G.RyzenFontEnum(name)
        if name == "Coding Font" then return Enum.Font.GothamMedium end
        if name == "Summer" then return Enum.Font.GothamMedium end
        if name == "Beachy" then return Enum.Font.GothamMedium end
        if name == "Scary" then return Enum.Font.GothamMedium end
        if name == "Bangers" then return Enum.Font.GothamMedium end
        return nil
    end

    function _G.RyzenApplyFontToObject(obj)
        if not obj then return end
        if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
        if not _G.RyzenFontBackup then _G.RyzenFontBackup = {} end
        if _G.RyzenFontBackup[obj] == nil then
            pcall(function() _G.RyzenFontBackup[obj] = obj.Font end)
        end
        local f = _G.RyzenFontEnum(_G.RyzenCustomFontSelected or "None")
        if f then pcall(function() obj.Font = f end) end
    end

    function _G.RyzenApplyCustomFont(name)
        _G.RyzenRestoreFonts()
        _G.RyzenCustomFontSelected = name or "None"
        customFontVisualEnabled = _G.RyzenCustomFontSelected ~= "None"

        if customFontVisualEnabled then
            for _, obj in ipairs(PlayerGui:GetDescendants()) do
                _G.RyzenApplyFontToObject(obj)
            end
            _G.RyzenFontAddedConn = PlayerGui.DescendantAdded:Connect(function(obj)
                if (_G.RyzenCustomFontSelected or "None") ~= "None" then
                    _G.RyzenApplyFontToObject(obj)
                end
            end)
        end

        pcall(function()
            if saveRyzenConfig then saveRyzenConfig() end
        end)
    end

    function _G.RyzenInstallFontRow()
        local targetPage = MenuCustomize or pages.MENU
        if not targetPage or not targetPage.Parent then return end
        local old = targetPage:FindFirstChild("Custom Font")
        if old then old:Destroy() end

        local row = Instance.new("Frame")
        row.Name = "Custom Font"
        row.BackgroundColor3 = COLORS.row
        row.BackgroundTransparency = 0.22
        row.Size = UDim2.new(1, -4, 0, 138)
        row.BorderSizePixel = 0
        row.LayoutOrder = 2
        row.ZIndex = 4
        row.Parent = targetPage
        corner(row,10)
        stroke(row,COLORS.strokeSoft,1.15,0.32)

        local title = Instance.new("TextLabel")
        title.Name = "Label"
        title.BackgroundTransparency = 1
        title.Text = "Custom Font"
        title.TextColor3 = COLORS.white
        title.TextSize = 11
        title.Font = Enum.Font.GothamMedium
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Position = UDim2.new(0,12,0,7)
        title.Size = UDim2.new(1,-24,0,20)
        title.ZIndex = 5
        title.Parent = row

        local names = {"None","Coding Font","Summer","Beachy","Scary","Bangers"}

        local function getPreviewFont(name)
            if name == "Coding Font" then return Enum.Font.GothamMedium end
            if name == "Summer" then return Enum.Font.GothamMedium end
            if name == "Beachy" then return Enum.Font.GothamMedium end
            if name == "Scary" then return Enum.Font.GothamMedium end
            if name == "Bangers" then return Enum.Font.GothamMedium end
            return Enum.Font.GothamMedium
        end

        local buttons = {}

        local function refreshSelected()
            for name, btn in pairs(buttons) do
                local selected = name == (_G.RyzenCustomFontSelected or "None")
                btn.BackgroundTransparency = selected and 0.03 or 0.18
                local st = btn:FindFirstChildOfClass("UIStroke")
                if st then
                    st.Transparency = selected and 0.05 or 0.5
                    st.Thickness = selected and 1.4 or 1
                end
            end
        end

        for i, name in ipairs(names) do
            local col = (i - 1) % 3
            local rowIndex = math.floor((i - 1) / 3)

            local btn = Instance.new("TextButton")
            btn.Name = "Font_" .. name
            btn.BackgroundColor3 = Color3.fromRGB(10,10,14)
            btn.BackgroundTransparency = 0.18
            btn.BorderSizePixel = 0
            btn.Text = name
            btn.TextColor3 = COLORS.white
            btn.TextSize = 18
            btn.Font = getPreviewFont(name)
            btn.AutoButtonColor = false
            btn.Size = UDim2.new(0, 92, 0, 42)
            btn.Position = UDim2.new(0, 12 + col * 98, 0, 34 + rowIndex * 48)
            btn.ZIndex = 6
            btn.Parent = row
            corner(btn,8)
            stroke(btn,COLORS.strokeSoft,1,0.5)

            local nameLabel = Instance.new("TextLabel")
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = name
            nameLabel.TextColor3 = COLORS.white
            nameLabel.TextTransparency = 0.22
            nameLabel.TextSize = 8
            nameLabel.Font = Enum.Font.GothamMedium
            nameLabel.Size = UDim2.new(1,0,0,12)
            nameLabel.Position = UDim2.new(0,0,1,-13)
            nameLabel.ZIndex = 7
            nameLabel.Parent = btn

            buttons[name] = btn

            btn.MouseButton1Click:Connect(function()
                pcall(function()
                    _G.RyzenApplyCustomFont(name)
                end)
                refreshSelected()
            end)
        end

        refreshSelected()
    end

    Settings = pages.SETTINGS

    aceGuiScaleValue = RyzenAutoMobile and 0.67 or 1.00
    aceGuiScaleValue = math.clamp(aceGuiScaleValue, 0.50, 1.50)
    _G.RyzenGuiScaleValue = aceGuiScaleValue
    aceProgressBarScaleValue = RyzenAutoMobile and 0.83 or 1.00
    aceMainScale = Main:FindFirstChild("RyzenMainScale") or Instance.new("UIScale")
    aceMainScale.Name = "RyzenMainScale"
    aceMainScale.Scale = aceGuiScaleValue
    aceMainScale.Parent = Main
    local function applyRyzenProgressBarScale()
    -- FIX: the steal bar can be parented under CoreGui / gethui (not only
    -- PlayerGui), which is why changing "Progress Bar Size" did nothing before.
    local stealBar = nil
    pcall(function()
        local sg = PlayerGui:FindFirstChild("StealBarGui")
        if sg then stealBar = sg:FindFirstChild("StealBar") end
    end)
    if not stealBar then
        pcall(function()
            local cg = game:GetService("CoreGui")
            local sg = cg and cg:FindFirstChild("StealBarGui")
            if sg then stealBar = sg:FindFirstChild("StealBar") end
        end)
    end
    if not stealBar and type(gethui) == "function" then
        pcall(function()
            local h = gethui()
            local sg = h and h:FindFirstChild("StealBarGui")
            if sg then stealBar = sg:FindFirstChild("StealBar") end
        end)
    end
    if not stealBar then return end
    -- remove duplicated UIScale instances from script re-runs so scaling never stacks
    for _, old in ipairs(stealBar:GetChildren()) do
        if old:IsA("UIScale") and old.Name == "RyzenProgressBarScale" then
            old:Destroy()
        end
    end
    local sc = Instance.new("UIScale")
    sc.Name = "RyzenProgressBarScale"
    sc.Scale = tonumber(aceProgressBarScaleValue) or 1
    sc.Parent = stealBar
    end
    _G.__RyzenDuelsSetupSettingsUI = function()
    section(MenuCustomize, "MENU CUSTOMIZE", 1)
    local bgRow = Instance.new("Frame")
    bgRow.Name = "Background Image Picker"
    bgRow.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bgRow.BackgroundTransparency = 0.3
    bgRow.Size = UDim2.new(1,-4,0,52)
    bgRow.BorderSizePixel = 0
    bgRow.LayoutOrder = 2
    bgRow.ZIndex = 4
    bgRow.Parent = MenuCustomize
    corner(bgRow,11)
    stroke(bgRow,Color3.fromRGB(255,255,255),1.25,0.45)

    local bgScroll = Instance.new("ScrollingFrame")
    bgScroll.Name = "BgScroll"
    bgScroll.ZIndex = 5
    bgScroll.Size = UDim2.new(1,-56,1,0)
    bgScroll.Position = UDim2.new(0.5,0,0,0)
    bgScroll.AnchorPoint = Vector2.new(0.5,0)
    bgScroll.BackgroundTransparency = 1
    bgScroll.BorderSizePixel = 0
    bgScroll.ScrollBarThickness = 0
    bgScroll.ScrollBarImageTransparency = 1
    bgScroll.ScrollingDirection = Enum.ScrollingDirection.X
    bgScroll.CanvasSize = UDim2.new(0,0,0,0)
    bgScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
    bgScroll.Parent = bgRow

    local bgList = Instance.new("UIListLayout")
    bgList.FillDirection = Enum.FillDirection.Horizontal
    bgList.Padding = UDim.new(0,4)
    bgList.SortOrder = Enum.SortOrder.LayoutOrder
    bgList.VerticalAlignment = Enum.VerticalAlignment.Center
    bgList.Parent = bgScroll

    local bgPadding = Instance.new("UIPadding")
    bgPadding.PaddingLeft = UDim.new(0,4)
    bgPadding.PaddingRight = UDim.new(0,4)
    bgPadding.Parent = bgScroll

    local bgButtons = {}

    function updateBackgroundButtons()
    for index,button in pairs(bgButtons) do
        local selected = index == currentBackground
        local st = button:FindFirstChildOfClass("UIStroke")
        if st then
            st.Color = selected and Color3.fromRGB(255,255,255) or Color3.fromRGB(80,80,90)
            st.Transparency = selected and 0 or 0.4
            st.Thickness = selected and 1.25 or 1
        end
        if button:IsA("ImageButton") then
            button.ImageTransparency = selected and 0 or 0.22
        end
    end
    end

    function makeNoneButton(index, x, y)
    local btn = Instance.new("ImageButton")
    btn.Name = "BgThumbNone"
    btn.ZIndex = 5
    btn.LayoutOrder = 1
    btn.Size = UDim2.new(0,42,0,34)
    btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    btn.BorderSizePixel = 0
    btn.Image = ""
    btn.ImageTransparency = 0.22
    btn.AutoButtonColor = false
    btn.Parent = bgScroll
    corner(btn,9)
    stroke(btn,Color3.fromRGB(80,80,90),1,0.4)

    local noneLabel = Instance.new("TextLabel")
    noneLabel.Name = "NoneLabel"
    noneLabel.ZIndex = 6
    noneLabel.Size = UDim2.new(1,0,1,0)
    noneLabel.BackgroundTransparency = 1
    noneLabel.Text = "NONE"
    noneLabel.TextColor3 = COLORS.white
    noneLabel.TextSize = 9
    noneLabel.Font = Enum.Font.GothamMedium
    noneLabel.Parent = btn

    bgButtons[index] = btn
    btn.MouseButton1Click:Connect(function()
        applyBackground(index)
        updateBackgroundButtons()
    end)
    end

    function makeImageButton(index, x, y)
    local thumb = Instance.new("ImageButton")
    thumb.Name = "BgThumb" .. tostring(index)
    thumb.ZIndex = 5
    thumb.LayoutOrder = index + 1
    thumb.Size = UDim2.new(0,42,0,34)
    thumb.BackgroundColor3 = Color3.fromRGB(0,0,0)
    thumb.BorderSizePixel = 0
    thumb.Image = "rbxassetid://" .. tostring(BackgroundIDs[index])
    thumb.ImageTransparency = 0.22
    thumb.ScaleType = Enum.ScaleType.Crop
    thumb.AutoButtonColor = false
    thumb.Parent = bgScroll
    corner(thumb,9)
    stroke(thumb,Color3.fromRGB(80,80,90),1,0.4)

    bgButtons[index] = thumb
    thumb.MouseButton1Click:Connect(function()
        applyBackground(index)
        updateBackgroundButtons()
    end)
    end

    local bgLeft = Instance.new("TextButton")
    bgLeft.Name = "BgArrowLeft"
    bgLeft.ZIndex = 8
    bgLeft.Position = UDim2.new(0,3,0.5,-17)
    bgLeft.Size = UDim2.new(0,22,0,34)
    bgLeft.BackgroundColor3 = Color3.fromRGB(18,18,23)
    bgLeft.BackgroundTransparency = 0.05
    bgLeft.BorderSizePixel = 0
    bgLeft.Text = "<"
    bgLeft.TextColor3 = COLORS.white
    bgLeft.TextSize = 18
    bgLeft.Font = Enum.Font.GothamMedium
    bgLeft.AutoButtonColor = false
    bgLeft.Parent = bgRow
    corner(bgLeft,7)

    local bgRight = Instance.new("TextButton")
    bgRight.Name = "BgArrowRight"
    bgRight.ZIndex = 8
    bgRight.Position = UDim2.new(1,-25,0.5,-17)
    bgRight.Size = UDim2.new(0,22,0,34)
    bgRight.BackgroundColor3 = Color3.fromRGB(18,18,23)
    bgRight.BackgroundTransparency = 0.05
    bgRight.BorderSizePixel = 0
    bgRight.Text = ">"
    bgRight.TextColor3 = COLORS.white
    bgRight.TextSize = 18
    bgRight.Font = Enum.Font.GothamMedium
    bgRight.AutoButtonColor = false
    bgRight.Parent = bgRow
    corner(bgRight,7)

    bgLeft.MouseButton1Click:Connect(function()
        local pos = bgScroll.CanvasPosition
        TweenService:Create(bgScroll,TweenInfo.new(0.2),{
            CanvasPosition = Vector2.new(math.max(0,pos.X-50),0)
        }):Play()
    end)

    bgRight.MouseButton1Click:Connect(function()
        local pos = bgScroll.CanvasPosition
        TweenService:Create(bgScroll,TweenInfo.new(0.2),{
            CanvasPosition = Vector2.new(pos.X+50,0)
        }):Play()
    end)

    function stepperRow(parent, labelText, defaultValue, order, callback, minValue, maxValue)
    local row = Instance.new("Frame")
    row.Name = labelText
    row.BackgroundColor3 = COLORS.row
    row.BackgroundTransparency = 0.22
    row.Size = UDim2.new(1, -4, 0, 42)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.ZIndex = 4
    row.Parent = parent
    corner(row, 10)
    stroke(row, COLORS.strokeSoft, 1.15, 0.32)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(245, 245, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 1
    label.TextSize = 11
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(1, -155, 1, 0)
    label.ZIndex = 5
    label.Parent = row
    local value = defaultValue
    local minus = Instance.new("TextButton")
    minus.Name = "Minus"
    minus.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    minus.BackgroundTransparency = 0.1
    minus.BorderSizePixel = 0
    minus.Text = "-"
    minus.TextColor3 = Color3.fromRGB(245, 245, 255)
    minus.TextSize = 14
    minus.Font = Enum.Font.GothamMedium
    minus.AutoButtonColor = false
    minus.Size = UDim2.new(0, 28, 0, 26)
    minus.Position = UDim2.new(1, -118, 0.5, -13)
    minus.ZIndex = 6
    minus.Parent = row
    corner(minus, 7)
    stroke(minus, COLORS.strokeSoft, 1, 0.5)
    local valueBox = Instance.new("TextLabel")
    valueBox.Name = "Value"
    valueBox.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    valueBox.BackgroundTransparency = 0.05
    valueBox.BorderSizePixel = 0
    valueBox.Text = string.format("%.2f", value)
    valueBox.TextColor3 = Color3.fromRGB(245, 245, 255)
    valueBox.TextSize = 13
    valueBox.Font = Enum.Font.GothamMedium
    valueBox.TextXAlignment = Enum.TextXAlignment.Center
    valueBox.Size = UDim2.new(0, 48, 0, 26)
    valueBox.Position = UDim2.new(1, -84, 0.5, -13)
    valueBox.ZIndex = 6
    valueBox.Parent = row
    corner(valueBox, 7)
    stroke(valueBox, COLORS.strokeSoft, 1, 0.5)
    local plus = Instance.new("TextButton")
    plus.Name = "Plus"
    plus.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    plus.BackgroundTransparency = 0.1
    plus.BorderSizePixel = 0
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(245, 245, 255)
    plus.TextSize = 14
    plus.Font = Enum.Font.GothamMedium
    plus.AutoButtonColor = false
    plus.Size = UDim2.new(0, 28, 0, 26)
    plus.Position = UDim2.new(1, -30, 0.5, -13)
    plus.ZIndex = 6
    plus.Parent = row
    corner(plus, 7)
    stroke(plus, COLORS.strokeSoft, 1, 0.5)
    local function setValue(nextValue)
    value = math.clamp(math.floor((nextValue * 100) + 0.5) / 100, minValue or 0.50, maxValue or 1.50)
    valueBox.Text = string.format("%.2f", value)
    if callback then callback(value) end
    end
    minus.MouseButton1Click:Connect(function()
    setValue(value - 0.05)
    end)
    plus.MouseButton1Click:Connect(function()
    setValue(value + 0.05)
    end)
    return row
    end
    makeNoneButton(0, 8, 8)
    for index = 1, #BackgroundIDs do
    local slot = index
    local column = slot % 5
    local rowIndex = math.floor(slot / 5)
    makeImageButton(index, 8 + (column * 61), 8 + (rowIndex * 48))
    end
    updateBackgroundButtons()


    do
    local colorRow = Instance.new("Frame")
    colorRow.Name = "ColorThemePicker"
    colorRow.BackgroundColor3 = COLORS.row
    colorRow.BackgroundTransparency = 0.3
    colorRow.BorderSizePixel = 0
    colorRow.Size = UDim2.new(1, -4, 0, 34)
    colorRow.LayoutOrder = 3
    colorRow.ZIndex = 4
    colorRow.Parent = MenuCustomize
    corner(colorRow, 9)
    stroke(colorRow, COLORS.strokeSoft, 1.15, 0.38)

    local colorOrder = {"PURPLE","BLUE","RED","PINK","YELLOW","GREY","WHITE","FOREST","BLACK"}
    local activeButton

    local function applyThemeColor()
    local tint = _G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE


    BgImage.ImageColor3 = tint
    if RyzenLogoAsset then
    if _G.RyzenSetWordmarkTint then _G.RyzenSetWordmarkTint(_G.RyzenLogoTint(tint)) end
    end
    if TitleSweepText then TitleSweepText.TextColor3 = tint end
    if _G.RyzenIntroTitleSweep and _G.RyzenIntroTitleSweep.Parent then
    _G.RyzenIntroTitleSweep.TextColor3 = tint
    end

    THEME_ACCENT = tint
    THEME_ACCENT_DIM = Color3.new(tint.R * 0.62, tint.G * 0.62, tint.B * 0.62)

    -- recolour the overhead speed numbers (yours + every other player)
    if _G.RyzenApplySpeedThemeColor then pcall(_G.RyzenApplySpeedThemeColor) end

    -- recolour every enabled toggle switch
    if _G.RyzenApplyToggleThemeColor then pcall(_G.RyzenApplyToggleThemeColor) end

    if PlayerESP and PlayerESP.playerData then
    for _, data in pairs(PlayerESP.playerData) do
    if data.highlight then
    data.highlight.FillColor = tint
    data.highlight.OutlineColor = tint
    end
    if data.billboard then
    for _, obj in ipairs(data.billboard:GetDescendants()) do
    if obj:IsA("TextLabel") then
    obj.TextColor3 = tint
    end
    end
    end
    end
    end

    if BoxedESPData then
    for _, data in pairs(BoxedESPData) do
    if data.box then data.box.Color = tint end
    if data.tracer then data.tracer.Color = tint end
    end
    end

    if _G.RyzenApplyMobileButtonImage then
    pcall(_G.RyzenApplyMobileButtonImage)
    end

    if _G.RyzenApplyStealUIImage then
    pcall(_G.RyzenApplyStealUIImage)
    end
    if _G.RyzenRefreshStealBarTheme then
    pcall(_G.RyzenRefreshStealBarTheme)
    end
    if _G.RyzenRefreshDontEnterTheme then
    pcall(_G.RyzenRefreshDontEnterTheme)
    end

    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end

    for i, colorName in ipairs(colorOrder) do
    local btn = Instance.new("TextButton")
    btn.Name = colorName
    btn.Size = UDim2.new(0, 30, 0, 14)
    btn.Position = UDim2.new(0, 8 + ((i - 1) * 36), 0.5, -7)
    btn.BackgroundColor3 = _G.RyzenThemeColors[colorName]
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 6
    btn.Parent = colorRow
    corner(btn, 4)

    local border = stroke(btn, COLORS.white, 1, 0.5)
    if colorName == _G.RyzenThemeName then
    activeButton = btn
    border.Transparency = 0
    border.Thickness = 2
    end

    btn.MouseButton1Click:Connect(function()
    if activeButton then
    local oldBorder = activeButton:FindFirstChildOfClass("UIStroke")
    if oldBorder then
    oldBorder.Transparency = 0.5
    oldBorder.Thickness = 1
    end
    end

    activeButton = btn
    _G.RyzenThemeName = colorName

    local newBorder = btn:FindFirstChildOfClass("UIStroke")
    if newBorder then
    newBorder.Transparency = 0
    newBorder.Thickness = 2
    end

    applyThemeColor()
    if _G.RyzenApplyMobileButtonImage then pcall(_G.RyzenApplyMobileButtonImage) end
    end)
    end
    end

    stepperRow(Settings, "GUI Scale", aceGuiScaleValue, 6, function(v)
    aceGuiScaleValue = v
    aceMainScale.Scale = v
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    section(MenuCustomize, "STEAL UI", 20)
    stepperRow(MenuCustomize, "Progress Bar Size", aceProgressBarScaleValue, 7, function(v)
    aceProgressBarScaleValue = v
    applyRyzenProgressBarScale()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    speedKeybindRow(Settings, "Toggle UI", "ToggleUI", 8)
    section(Settings, "MOBILE BUTTONS", 4)
    do
    local row, setVisual = _G.RyzenActionToggleRow(Settings, "Lock GUI", _G.RyzenGuiLocked == true, 9)
    setLockGuiVisual = setVisual
    local btn = row and row:FindFirstChild("ToggleButton")
    if btn then
    btn.Activated:Connect(function()
    _G.RyzenGuiLocked = not (_G.RyzenGuiLocked == true)
    if setVisual then setVisual(_G.RyzenGuiLocked == true) end
    if RyzenUpdateGuiLockVisual then RyzenUpdateGuiLockVisual() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    do
    local row, setVisual = _G.RyzenActionToggleRow(Settings, "Hide Mobile Buttons", _G.RyzenHideMobileButtons == true, 10)
    setHideMobileButtonsVisual = setVisual
    local btn = row and row:FindFirstChild("ToggleButton")
    if btn then
    btn.Activated:Connect(function()
    _G.RyzenHideMobileButtons = not (_G.RyzenHideMobileButtons == true)
    if setVisual then setVisual(_G.RyzenHideMobileButtons == true) end
    if _G.RyzenApplyMobileButtonsHidden then _G.RyzenApplyMobileButtonsHidden() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    end
    stepperRow(Settings, "Mobile Buttons Size", tonumber(_G.RyzenMobileButtonScale) or 1.00, 11, function(v)
    _G.RyzenMobileButtonScale = math.clamp(tonumber(v) or 0.35, 0.30, 1.35)
    if _G.RyzenApplyMobileButtonSize then _G.RyzenApplyMobileButtonSize() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end, 0.30, 1.35)
    -- Mobile Button Shape row removed (circle button feature)
    do
    function createHorizontalImagePicker(parent, name, layoutOrder, selectedGetter, selectedSetter, assetIds)
    assetIds = assetIds or BackgroundIDs

    local pickerRow = Instance.new("Frame")
    pickerRow.Name = name
    pickerRow.ZIndex = 4
    pickerRow.Size = UDim2.new(1,-4,0,52)
    pickerRow.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pickerRow.BackgroundTransparency = 0.3
    pickerRow.BorderSizePixel = 0
    pickerRow.LayoutOrder = layoutOrder
    pickerRow.Parent = parent
    corner(pickerRow,11)
    stroke(pickerRow,Color3.fromRGB(255,255,255),1.25,0.45)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "PickerScroll"
    scroll.ZIndex = 5
    scroll.Size = UDim2.new(1,-56,1,0)
    scroll.Position = UDim2.new(0.5,0,0,0)
    scroll.AnchorPoint = Vector2.new(0.5,0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 0
    scroll.ScrollBarImageTransparency = 1
    scroll.ScrollingDirection = Enum.ScrollingDirection.X
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.X
    scroll.Parent = pickerRow

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Horizontal
    list.Padding = UDim.new(0,4)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.VerticalAlignment = Enum.VerticalAlignment.Center
    list.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0,4)
    pad.PaddingRight = UDim.new(0,4)
    pad.Parent = scroll

    local buttons = {}

    local function selectedIndex()
        local current = tostring(selectedGetter() or "")
        local id = current:match("(%d+)")
        if not id then return 0 end
        for i,assetId in ipairs(assetIds) do
            if tostring(assetId) == tostring(id) then return i end
        end
        return 0
    end

    local function updateButtons()
        local selected = selectedIndex()
        for index,thumb in pairs(buttons) do
            local on = index == selected
            local st = thumb:FindFirstChildOfClass("UIStroke")
            if st then
                st.Color = on and Color3.fromRGB(255,255,255) or Color3.fromRGB(80,80,90)
                st.Transparency = on and 0 or 0.4
                st.Thickness = on and 1.25 or 1
            end
            thumb.ImageTransparency = on and 0 or 0.22
        end
    end

    local function choose(index)
        selectedSetter(index == 0 and "" or ("rbxassetid://" .. tostring(assetIds[index])))
        updateButtons()
    end

    local function makeThumb(index,assetId)
        local thumb = Instance.new("ImageButton")
        thumb.Name = "Thumb" .. tostring(index)
        thumb.ZIndex = 5
        thumb.LayoutOrder = index + 1
        thumb.Size = UDim2.new(0,42,0,34)
        thumb.BackgroundColor3 = Color3.fromRGB(0,0,0)
        thumb.BorderSizePixel = 0
        thumb.Image = assetId and ("rbxassetid://" .. tostring(assetId)) or ""
        thumb.ImageTransparency = 0.22
        thumb.ScaleType = Enum.ScaleType.Crop
        thumb.AutoButtonColor = false
        thumb.Parent = scroll
        corner(thumb,9)
        stroke(thumb,Color3.fromRGB(80,80,90),1,0.4)

        if index == 0 then
            local none = Instance.new("TextLabel")
            none.Name = "NoneLabel"
            none.ZIndex = 6
            none.Size = UDim2.new(1,0,1,0)
            none.BackgroundTransparency = 1
            none.Text = "NONE"
            none.TextColor3 = COLORS.white
            none.TextSize = 9
            none.Font = Enum.Font.GothamMedium
            none.Parent = thumb
        end

        buttons[index] = thumb
        thumb.MouseButton1Click:Connect(function() choose(index) end)
    end

    makeThumb(0,nil)
    for i,id in ipairs(assetIds) do
        makeThumb(i,id)
    end

    local left = Instance.new("TextButton")
    left.ZIndex = 8
    left.Position = UDim2.new(0,3,0.5,-17)
    left.Size = UDim2.new(0,22,0,34)
    left.BackgroundColor3 = Color3.fromRGB(18,18,23)
    left.BackgroundTransparency = 0.05
    left.BorderSizePixel = 0
    left.Text = "<"
    left.TextColor3 = COLORS.white
    left.TextSize = 18
    left.Font = Enum.Font.GothamMedium
    left.AutoButtonColor = false
    left.Parent = pickerRow
    corner(left,7)

    local right = Instance.new("TextButton")
    right.ZIndex = 8
    right.Position = UDim2.new(1,-25,0.5,-17)
    right.Size = UDim2.new(0,22,0,34)
    right.BackgroundColor3 = Color3.fromRGB(18,18,23)
    right.BackgroundTransparency = 0.05
    right.BorderSizePixel = 0
    right.Text = ">"
    right.TextColor3 = COLORS.white
    right.TextSize = 18
    right.Font = Enum.Font.GothamMedium
    right.AutoButtonColor = false
    right.Parent = pickerRow
    corner(right,7)

    left.MouseButton1Click:Connect(function()
        local pos = scroll.CanvasPosition
        TweenService:Create(scroll,TweenInfo.new(0.2),{
            CanvasPosition = Vector2.new(math.max(0,pos.X-50),0)
        }):Play()
    end)

    right.MouseButton1Click:Connect(function()
        local pos = scroll.CanvasPosition
        TweenService:Create(scroll,TweenInfo.new(0.2),{
            CanvasPosition = Vector2.new(pos.X+50,0)
        }):Play()
    end)

    updateButtons()
    return pickerRow
    end

    section(Settings, "STEAL UI BACKGROUND IMAGE", 48)
    createHorizontalImagePicker(MenuCustomize, "Steal UI Image", 49,
    function()
    return _G.RyzenStealUIImage
    end,
    function(value)
    _G.RyzenStealUIImage = value
    if _G.RyzenApplyStealUIImage then
    _G.RyzenApplyStealUIImage()
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)

    do
    local mobilePickerGap = Instance.new("Frame")
    mobilePickerGap.Name = "MobilePickerGap"
    mobilePickerGap.BackgroundTransparency = 1
    mobilePickerGap.BorderSizePixel = 0
    mobilePickerGap.Size = UDim2.new(1, 0, 0, 7)
    mobilePickerGap.LayoutOrder = 13
    mobilePickerGap.Parent = MenuCustomize
    end

    createHorizontalImagePicker(MenuCustomize, "Mobile Button Image Picker", 14,
    function() return _G.RyzenMobileButtonImage end,
    function(value)
    _G.RyzenMobileButtonImage = value
    if _G.RyzenApplyMobileButtonImage then _G.RyzenApplyMobileButtonImage() end
    end,
    ButtonImageIDs)

    end

    do
    local row = baseRow(Settings, "Reset Mobile Buttons", 15)
    local button = Instance.new("TextButton")
    button.Name = "ResetMobileButtons"
    button.BackgroundColor3 = Color3.fromRGB(232, 232, 238)
    button.BackgroundTransparency = 0
    button.BorderSizePixel = 0
    button.Text = "RESET"
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.TextSize = 11
    button.Font = Enum.Font.GothamMedium
    button.AutoButtonColor = false
    button.Size = UDim2.new(0, 78, 0, 26)
    button.Position = UDim2.new(1, -88, 0.5, -13)
    button.ZIndex = 7
    button.Parent = row
    corner(button, 8)
    stroke(button, Color3.fromRGB(255, 255, 255), 1, 0.18)
    button.Activated:Connect(function()
    if _G.RyzenResetMobileButtons then
    _G.RyzenResetMobileButtons()
    else
    _G.RyzenMobileButtonScale = RyzenAutoMobile and 0.90 or 1.00
    _G.RyzenHideMobileButtons = false
    if _G.RyzenApplyMobileButtonsHidden then _G.RyzenApplyMobileButtonsHidden() end
    if _G.RyzenApplyMobileButtonSize then _G.RyzenApplyMobileButtonSize() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    end)
    end

    section(Settings, "INTRO", 50)
    do
    local row, setVisual = toggleRow(Settings, "Intro", _introEnabled, 51)
    setIntroVisual = setVisual
    local btn = row and row:FindFirstChild("ToggleButton")
    if btn then
    btn.Activated:Connect(function()
    _introEnabled = not _introEnabled
    if not _introEnabled then stopIntroPlayback(); stopIntroPreview() end
    if setIntroVisual then setIntroVisual(_introEnabled) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    if setIntroVisual then setIntroVisual(_introEnabled) end
    end
    do
    local row = Instance.new("Frame")
    row.Name = "Intro Song"
    row.BackgroundColor3 = COLORS.row
    row.BackgroundTransparency = 0.22
    row.Size = UDim2.new(1, -4, 0, 42)
    row.BorderSizePixel = 0
    row.LayoutOrder = 52
    row.ZIndex = 4
    row.Parent = Settings
    corner(row, 10)
    stroke(row, COLORS.strokeSoft, 1.15, 0.32)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Text = "Intro Song"
    label.TextColor3 = Color3.fromRGB(245,245,255)
    label.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    label.TextStrokeTransparency = 0.25
    label.TextSize = 11
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(1, -145, 1, 0)
    label.ZIndex = 5
    label.Parent = row

    local btn = Instance.new("TextButton")
    btn.Name = "Intro Song Button"
    btn.BackgroundColor3 = Color3.fromRGB(232,232,238)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Text = getIntroSongName()
    btn.TextColor3 = Color3.fromRGB(0,0,0)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBlack
    btn.AutoButtonColor = false
    btn.Size = UDim2.new(0, 118, 0, 28)
    btn.Position = UDim2.new(1, -128, 0.5, -14)
    btn.ZIndex = 6
    btn.Parent = row
    corner(btn, 8)
    stroke(btn, Color3.fromRGB(255,255,255), 1, 0.15)

    setIntroSongVisual = function()
        if btn and btn.Parent then
            btn.Text = getIntroSongName()
            btn.TextColor3 = Color3.fromRGB(0,0,0)
        end
    end

    btn.MouseButton1Click:Connect(function()
        selectedIntroMusic = (tonumber(selectedIntroMusic) or 1) + 1
        if selectedIntroMusic > #RYZEN_INTRO_MUSIC_OPTIONS then
            selectedIntroMusic = 1
        end

        if setIntroSongVisual then setIntroSongVisual() end
        previewIntroMusic(selectedIntroMusic)
        if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end

    section(Settings, "SETTINGS", 999)
    local resetHolder = Instance.new("Frame")
    resetHolder.Name = "Reset All Settings Holder"
    resetHolder.BackgroundTransparency = 1
    resetHolder.BorderSizePixel = 0
    resetHolder.Size = UDim2.new(1,-4,0,34)
    resetHolder.LayoutOrder = 1000
    resetHolder.ZIndex = 5
    resetHolder.Parent = Settings
    local resetBtn = Instance.new("TextButton")
    resetBtn.Name = "Reset All Settings"
    resetBtn.BackgroundColor3 = COLORS.row
    resetBtn.BackgroundTransparency = 0.3
    resetBtn.BorderSizePixel = 0
    resetBtn.Text = "RESET ALL SETTINGS"
    resetBtn.TextColor3 = COLORS.white
    resetBtn.TextStrokeTransparency = 1
    resetBtn.TextSize = 12
    resetBtn.Font = Enum.Font.GothamMedium
    resetBtn.AutoButtonColor = false
    resetBtn.Size = UDim2.new(1,0,1,0)
    resetBtn.Position = UDim2.new(0,0,0,0)
    resetBtn.ZIndex = 6
    resetBtn.Parent = resetHolder
    corner(resetBtn,9)
    local resetStroke = Instance.new("UIStroke")
    resetStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    resetStroke.Color = Color3.fromRGB(255, 255, 255)
    resetStroke.Thickness = 1
    resetStroke.Transparency = 0.12
    resetStroke.Parent = resetBtn
    local resetDefaultBg = COLORS.row
    local resetHoverBg = COLORS.row
    local resetConfirmBg = COLORS.row
    local resetDoneBg = COLORS.row
    local resetDefaultText = COLORS.white
    local resetConfirmText = COLORS.white
    local resetDoneText = COLORS.white
    local confirmState = false
    local confirmTimer = nil
    function setResetDefaultTheme()
    confirmState = false
    resetBtn.Text = "RESET ALL SETTINGS"
    resetBtn.TextColor3 = resetDefaultText
    tween(resetBtn, {BackgroundColor3 = resetDefaultBg}, 0.18)
    tween(resetStroke, {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.12, Thickness = 1}, 0.18)
    end
    function setResetConfirmTheme()
    resetBtn.Text = "CLICK AGAIN TO CONFIRM"
    resetBtn.TextColor3 = resetConfirmText
    tween(resetBtn, {BackgroundColor3 = resetConfirmBg}, 0.18)
    tween(resetStroke, {Color = resetConfirmText, Transparency = 0.02, Thickness = 1.4}, 0.18)
    end
    function setResetDoneTheme()
    resetBtn.Text = "DONE - REJOINING..."
    resetBtn.TextColor3 = resetDoneText
    tween(resetBtn, {BackgroundColor3 = resetDoneBg}, 0.18)
    tween(resetStroke, {Color = resetDoneText, Transparency = 0.02, Thickness = 1.4}, 0.18)
    end
    resetBtn.Text = "RESET ALL SETTINGS"
    resetBtn.MouseEnter:Connect(function()
    if not confirmState then
    tween(resetBtn, {BackgroundColor3 = resetHoverBg}, 0.12)
    end
    end)



    local saveHolder = Instance.new("Frame")
    saveHolder.Name = "Save Config Holder"
    saveHolder.BackgroundTransparency = 1
    saveHolder.BorderSizePixel = 0
    saveHolder.Size = UDim2.new(1,-4,0,34)
    saveHolder.LayoutOrder = 1001
    saveHolder.ZIndex = 5
    saveHolder.Parent = Settings

    local saveBtn = Instance.new("TextButton")
    saveBtn.Name = "Save Config"
    saveBtn.BackgroundColor3 = COLORS.row
    saveBtn.BackgroundTransparency = 0.3
    saveBtn.BorderSizePixel = 0
    saveBtn.Text = "SAVE SETTINGS"
    saveBtn.TextColor3 = resetDefaultText
    saveBtn.TextStrokeTransparency = 1
    saveBtn.TextSize = 12
    saveBtn.Font = Enum.Font.GothamMedium
    saveBtn.AutoButtonColor = false
    saveBtn.Size = UDim2.new(1,0,1,0)
    saveBtn.Position = UDim2.new(0,0,0,0)
    saveBtn.ZIndex = 6
    saveBtn.Parent = saveHolder
    corner(saveBtn,9)

    local saveStroke = Instance.new("UIStroke")
    saveStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    saveStroke.Color = Color3.fromRGB(255, 255, 255)
    saveStroke.Thickness = 1
    saveStroke.Transparency = 0.12
    saveStroke.Parent = saveBtn

    saveBtn.MouseEnter:Connect(function()
    tween(saveBtn, {BackgroundColor3 = COLORS.row}, 0.12)
    end)

    saveBtn.MouseLeave:Connect(function()
    tween(saveBtn, {BackgroundColor3 = COLORS.row}, 0.12)
    end)

    saveBtn.MouseButton1Click:Connect(function()
    if _G.RyzenManualSaveConfig then
    local ok = pcall(_G.RyzenManualSaveConfig)
    if ok then
    saveBtn.Text = "SAVED"
    saveBtn.TextColor3 = resetDoneText
    tween(saveBtn, {BackgroundColor3 = resetDoneBg}, 0.18)
    tween(saveStroke, {Color = resetDoneText, Transparency = 0.02, Thickness = 1.4}, 0.18)
    task.delay(0.8, function()
    if saveBtn and saveBtn.Parent then
    saveBtn.Text = "SAVE SETTINGS"
    saveBtn.TextColor3 = resetDefaultText
    tween(saveBtn, {BackgroundColor3 = COLORS.row}, 0.18)
    tween(saveStroke, {Color = Color3.fromRGB(255,255,255), Transparency = 0.12, Thickness = 1}, 0.18)
    end
    end)
    else
    saveBtn.Text = "SAVE FAILED"
    task.delay(0.8, function()
    if saveBtn and saveBtn.Parent then
    saveBtn.Text = "SAVE SETTINGS"
    saveBtn.TextColor3 = resetDefaultText
    end
    end)
    end
    end
    end)

    resetBtn.MouseLeave:Connect(function()
    if not confirmState then
    tween(resetBtn, {BackgroundColor3 = resetDefaultBg}, 0.12)
    end
    end)
    resetBtn.MouseButton1Click:Connect(function()
    if not confirmState then
    confirmState = true
    setResetConfirmTheme()
    if confirmTimer then task.cancel(confirmTimer) end
    confirmTimer = task.delay(3, function()
    setResetDefaultTheme()
    end)
    return
    end
    if confirmTimer then
    task.cancel(confirmTimer)
    confirmTimer = nil
    end
    resetBtn.Text = "RESETTING..."
    pcall(function()
    local files = {
    CONFIG_FILE,
    KEYBINDS_CONFIG_FILE,
    "RyzenDuels_MainGUI_Config.json",
    "RyzenDuelsConfig.json",
    "RyzenDuels_Settings.json",
    "RyzenDuels_Keybinds.json",
    "RyzenDuels_GUI.json",
    }
    for _, fname in ipairs(files) do
    pcall(function()
    if fname and isfile and isfile(fname) and delfile then
    delfile(fname)
    end
    end)
    end
    end)
    pcall(function()
    aceGuiScaleValue = RyzenAutoMobile and 0.67 or 1.00
    aceProgressBarScaleValue = RyzenAutoMobile and 0.83 or 1.00
    NS = 60; CS = 30; LAGGER_SPEED = 29; LAGGER_CARRY_SPEED = 15
    currentSpeedMode = "Normal"
    autoCarrySpeedEnabled = false
    autoTPHeight = 20
    autoStealEnabled = false; selectedStealMode = "Auto Steal"; autoStealRadius = 63; _G.RyzenAutoStealPause = true
    _G.RyzenStealRadii = {Normal = 62, Semi = 9}
    selectedAnimationPack = "OFF"; selectedAimbotMode = "Normal"
    AIMBOT_SPEED = 58; LAGGER_AIMBOT_SPEED = 40
    _G.RyzenAntiBypassAimbotSpeed = 58; _G.RyzenAntiBypassLaggerAimbotSpeed = 40
    autoSwingEnabled = false; mirrorTPDownEnabled = false; antiDesyncAutoSwingEnabled = false
    _G.RyzenNormalAimbotOn = false; _G.RyzenAntiBypassAimbotOn = false
    antiRagdollEnabled = false; infJumpEnabled = false; autoTPEnabled = false
    batCounterEnabled = false; medCounterEnabled = false; antiKickEnabled = false; autoResetOnMedEnabled = false
    espEnabled = false; showTracerEnabled = false; ragdollCountdownEnabled = false
    fpsBoostEnabled = false; antiLagVisualEnabled = false; antiLagV2Enabled = false; nukeOptimiserEnabled = false
    fovEnabled = false; fovValue = 70; noCamCollisionEnabled = false; _G.RyzenNoPlayerCollisionEnabled = false
    skyTheme = "Off"; currentBackground = 0
    selectedIntroMusic = 1; _introEnabled = true
    if setIntroVisual then setIntroVisual(_introEnabled) end
    if setIntroSongVisual then setIntroSongVisual() end
    stopIntroPlayback(); stopIntroPreview()
    autoLeftEnabled = false; autoRightEnabled = false
    _G.RyzenGuiLocked = false; _G.RyzenHideMobileButtons = false; _G.RyzenMobileButtonScale = RyzenAutoMobile and 0.90 or 1.00; _G.RyzenMobileButtonShape = "ROUNDED"
    _G.RyzenMobileButtonImage = ""
    _G.RyzenStealUIImage = ""
    aceMainScale.Scale = aceGuiScaleValue
    applyRyzenProgressBarScale()
    applyBackground(0)
    updateBackgroundButtons()
    applyDefaultRyzenKeybinds()
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    do
    for slot, _ in pairs(controllerKeybinds) do controllerKeybinds[slot] = nil end
    controllerTPDownKeybind = nil
    if _G.RyzenResetGamepadEdgeState then _G.RyzenResetGamepadEdgeState() end
    if refreshAllControllerKeybinds then pcall(refreshAllControllerKeybinds) end
    end
    if stopAutoTP then stopAutoTP() end
    if stopAntiRagdoll then stopAntiRagdoll() end
    if normalSpeedBox then normalSpeedBox.Text = tostring(NS) end
    if carrySpeedBox then carrySpeedBox.Text = tostring(CS) end
    if laggerSpeedBox then laggerSpeedBox.Text = tostring(LAGGER_SPEED) end
    if laggerCarrySpeedBox then laggerCarrySpeedBox.Text = tostring(LAGGER_CARRY_SPEED) end
    if autoTPHeightBox then autoTPHeightBox.Text = tostring(autoTPHeight) end
    if radiusBox then radiusBox.Text = tostring(autoStealRadius) end
    if _G.RyzenRefreshAimbotSpeedBoxes then _G.RyzenRefreshAimbotSpeedBoxes() end
    if type(applyCustomSky) == "function" then applyCustomSky("Off") end
    if skyValueLabel then skyValueLabel.Text = "Off" end
    if _G.RyzenResetMobileButtons then _G.RyzenResetMobileButtons() end
    pcall(function() if _G.RyzenApplyMobileButtonImage then _G.RyzenApplyMobileButtonImage() end end)
    pcall(function() if _G.RyzenApplyStealUIImage then _G.RyzenApplyStealUIImage() end end)
    if _G.RyzenDuelsApplySavedGameplayStates then _G.RyzenDuelsApplySavedGameplayStates() end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    task.wait(0.35)
    setResetDoneTheme()
    task.wait(0.6)
    pcall(function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    end)
    end)
    end
    task.wait()
    _G.__RyzenDuelsSetupSettingsUI()
    pcall(function() _G.RyzenInstallFontRow() end)
    if (_G.RyzenCustomFontSelected or "None") ~= "None" then
        task.defer(function()
            task.wait(0.2)
            pcall(function() _G.RyzenApplyCustomFont(_G.RyzenCustomFontSelected) end)
        end)
    end
    if RyzenUpdateGuiLockVisual then RyzenUpdateGuiLockVisual() end
    if _G.RyzenApplyMobileButtonsHidden then _G.RyzenApplyMobileButtonsHidden() end

    task.defer(function()
    task.wait(0.05)
    pcall(function()
        local function hideAll(page)
            if not page then return end
            for _,o in ipairs(page:GetChildren()) do
                if not o:IsA("UIListLayout") and not o:IsA("UIPadding") then
                    o.Visible = false
                end
            end
        end
        local function showObj(o, order, labelText)
            if not o then return end
            o.Visible = true
            if order then o.LayoutOrder = order end
            if labelText then
                if o:IsA("TextLabel") then o.Text = labelText end
                local lbl = o:FindFirstChild("Label")
                if lbl then lbl.Text = labelText end
            end
        end
        local function byName(page, name)
            return page and page:FindFirstChild(name)
        end
        local function showNamed(page, name, order, labelText)
            showObj(byName(page,name), order, labelText)
        end

        
        
        
        if _G.RyzenDropModeMainRow then
            _G.RyzenDropModeMainRow.Parent = Movement
            _G.RyzenDropModeMainRow.LayoutOrder = 10
        end
        if _G.RyzenDropSelector then
            _G.RyzenDropSelector.Parent = Movement
            _G.RyzenDropSelector.LayoutOrder = 10.1
        end

        if not byName(Movement,"DROP BRAINROT") then section(Movement,"DROP BRAINROT",9) end

        if not byName(Movement,"TP Down") then
            local r,setV = _G.RyzenActionToggleRow(Movement,"TP Down",false,12)
            local b = r and r:FindFirstChild("ToggleButton")
            if b then
                b.Activated:Connect(function()
                    if runTPFloor then pcall(runTPFloor) end
                    if setV then
                        setV(true)
                        task.delay(0.12,function() pcall(setV,false) end)
                    end
                end)
            end
        end

        if not byName(Movement,"Unwalk") then
            local r,setV = toggleRow(Movement,"Unwalk",unwalkEnabled,18)
            local b = r and r:FindFirstChild("ToggleButton")
            if b then
                -- FIX: Unwalk could flip on "by itself": Roblox fires Activated
                -- even when the press turned into a drag (scrolling the tab or
                -- moving the menu) and the release happened back over the
                -- button. Only count it as a click when press and release are
                -- within a few pixels of each other.
                local downX, downY = nil, nil
                b.MouseButton1Down:Connect(function()
                    local m = UserInputService:GetMouseLocation()
                    downX, downY = m.X, m.Y
                end)
                b.Activated:Connect(function()
                    local m = UserInputService:GetMouseLocation()
                    if downX and m and (math.abs(m.X - downX) + math.abs(m.Y - downY)) > 8 then
                        return
                    end
                    unwalkEnabled = not unwalkEnabled
                    if unwalkEnabled then
                        if enableUnwalk then pcall(enableUnwalk) end
                    else
                        if disableUnwalk then pcall(disableUnwalk) end
                    end
                    if setV then setV(unwalkEnabled) end
                end)
            end
        end

        hideAll(Movement)
        showNamed(Movement,"AUTO SPEED",-2,"AUTO SPEED")
        showNamed(Movement,"Auto Carry Speed",-1)
        showNamed(Movement,"Auto Carry on Enemy Base",0)
        showNamed(Movement,"Enemy Base Range",0.1)
        showNamed(Movement,"NORMAL SPEED",1,"SPEED CONFIGURATION")
        showNamed(Movement,"Normal Speed",2)
        showNamed(Movement,"Carry Speed",3)

        local modeCount = 0
        for _,o in ipairs(Movement:GetChildren()) do
            if o.Name == "Mode" then
                modeCount = modeCount + 1
                showObj(o, modeCount == 1 and 4 or 8)
            end
        end

        showNamed(Movement,"LAGGER SPEED",5,"LAGGER CONFIGURATION")
        showNamed(Movement,"Lagger Speed",6,"Lagger Normal Speed")
        showNamed(Movement,"Lagger Carry Speed",7)
        showNamed(Movement,"DROP BRAINROT",9)
        showNamed(Movement,"Drop",10)
        if _G.RyzenDropSelector then _G.RyzenDropSelector.Visible = _G.RyzenDropExpanded == true end
        showNamed(Movement,"TELEPORT",11,"TP DOWN")
        showNamed(Movement,"TP Down",12)
        showNamed(Movement,"Auto TP Down",13)
        showNamed(Movement,"Auto TP Height",14)
        showNamed(Movement,"JUMP",15)
        showNamed(Movement,"Infinite Jump",16)
        if _G.RyzenInfJumpSelector then _G.RyzenInfJumpSelector.LayoutOrder=16.1 end
        showNamed(Movement,"Anti Ragdoll",17)
        if _G.RyzenAntiRagdollSelector then
            _G.RyzenAntiRagdollSelector.Visible = false
            _G.RyzenAntiRagdollSelector.Size = UDim2.new(1,-4,0,0)
        end
        if _G.RyzenAntiRagdollArrow then
            _G.RyzenAntiRagdollArrow.Visible = false
        end
        showNamed(Movement,"Unwalk",18)

        -- RYZEN ANTI DROP + AUTO PATH (Movement) visibility
        showNamed(Movement,"ANTI DROP",18.2,"ANTI DROP")
        showNamed(Movement,"Anti Drop",18.3)
        showNamed(Movement,"AUTO PATH",18.4,"AUTO PATH")
        showNamed(Movement,"Auto Left",18.5)
        showNamed(Movement,"Auto Right",18.6)

        
        
        
        if not byName(Combat,"SEMI Range") then
            local r,b = textboxRow(Combat,"SEMI Range",tostring((_G.RyzenStealRadii and _G.RyzenStealRadii.Semi) or 9),3)
            b.FocusLost:Connect(function()
                _G.RyzenStealRadii = _G.RyzenStealRadii or {}
                local n = tonumber(b.Text)
                if n then _G.RyzenStealRadii.Semi = math.clamp(n,1,500) end
                b.Text = tostring(_G.RyzenStealRadii.Semi or 9)
                if _G.RyzenSemiAutoStealSetRadius then
                    pcall(_G.RyzenSemiAutoStealSetRadius,_G.RyzenStealRadii.Semi or 9)
                end
            end)
        end

        if not byName(Combat,"BAT AIMBOT") then section(Combat,"BAT AIMBOT",5) end
        if aimbotMainRow then
            aimbotMainRow.LayoutOrder = 6
            local l = aimbotMainRow:FindFirstChild("Label")
            if l then l.Text = "Bat Aimbot" end
        end
        if aimbotSpeedRow then
            aimbotSpeedRow.LayoutOrder = 7
            local l = aimbotSpeedRow:FindFirstChild("Label")
            if l then l.Text = "Auto Bat Speed" end
        end
        if _G.RyzenNormalAutoSwingRow then _G.RyzenNormalAutoSwingRow.LayoutOrder = 8 end
        if _G.RyzenMirrorTPDownRow then
            _G.RyzenMirrorTPDownRow.LayoutOrder = 9
            local l = _G.RyzenMirrorTPDownRow:FindFirstChild("Label")
            if l then l.Text = "Mirror TP" end
        end

        if not byName(Combat,"AUTO PATH") then section(Combat,"AUTO PATH",12) end
        if not byName(Combat,"Auto Left") then
            local r,setV = _G.RyzenActionToggleRow(Combat,"Auto Left",autoLeftEnabled,13)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(not autoLeftEnabled) end
                if setV then setV(autoLeftEnabled) end
            end) end
        end
        if not byName(Combat,"Auto Right") then
            local r,setV = _G.RyzenActionToggleRow(Combat,"Auto Right",autoRightEnabled,14)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(not autoRightEnabled) end
                if setV then setV(autoRightEnabled) end
            end) end
        end

        if not byName(Combat,"BODY LOCK") then section(Combat,"BODY LOCK",19) end

        hideAll(Combat)
        showNamed(Combat,"AUTO STEAL",1,"STEAL CONFIGURATION")
        showNamed(Combat,"Radius",2)
        showNamed(Combat,"SEMI Range",3)
        showNamed(Combat,"Auto Steal",4)
        showNamed(Combat,"Auto Steal Pause",3.5)
        showNamed(Combat,"Steal Pause %",3.6)
        if _G.RyzenStealSelector then _G.RyzenStealSelector.LayoutOrder=4.1 end

        showNamed(Combat,"BAT AIMBOT",5)
        showObj(aimbotMainRow,6)
        if aimbotSelector then aimbotSelector.LayoutOrder=6.1 end
        showObj(aimbotSpeedRow,7)
        showNamed(Combat,"TP Bat Mode Header",7.5)
        if tpBatModeHolder then
            tpBatModeHolder.LayoutOrder = 7.6
            tpBatModeHolder.Visible = tpBatModeExpanded == true
            if not tpBatModeHolder.Visible then
                tpBatModeHolder.Size = UDim2.new(1,-4,0,0)
            end
        end
        showNamed(Combat,"TP Bat",7.7)
        showObj(_G.RyzenNormalAutoSwingRow,8)
        showObj(_G.RyzenMirrorTPDownRow,9)

        -- RYZEN LAGGER (Combat) visibility
        showNamed(Combat,"LAGGER",9.5)
        showNamed(Combat,"Lagger Mode",9.6)
        showNamed(Combat,"Lagger Speed",9.7,"Lagger Normal Speed")
        showNamed(Combat,"Lagger Carry Speed",9.8)
        showNamed(Combat,"AUTO PATH",12)
        showNamed(Combat,"Auto Left",13)
        showNamed(Combat,"Auto Right",14)
        showNamed(Combat,"COUNTERS",15)
        showNamed(Combat,"Bat Counter",16)
        showNamed(Combat,"Med Counter",17,"Medusa Counter")
        showNamed(Combat,"Auto Reset On Med Fling",18,"Reset After Med")
        showNamed(Combat,"Auto Instant Reset",18.5,"Insta Reset On Death")
        showNamed(Combat,"BODY LOCK",19)
        showNamed(Combat,"Body Lock",20)
        if _G.RyzenBodyLockSettings then
            _G.RyzenBodyLockSettings.LayoutOrder=21
            local l=_G.RyzenBodyLockSettings:FindFirstChild("Label")
            if l then l.Text="Lock Radius" end
        end

        
        showNamed(Combat,"HARD HIT",22)
        showNamed(Combat,"Hard Hit",23)
        showNamed(Combat,"Hard Hit Range",24)
        showNamed(Combat,"Hard Hit Stage+",25)
        showNamed(Combat,"Stage+ Impulse",26)

        showNamed(Combat,"PERFECT HIT",27)
        showNamed(Combat,"Perfect Hit",28)
        showNamed(Combat,"Perfect Hit Range",29)

        showNamed(Combat,"No Player Collision",30)
        showNamed(Combat,"Safe Mode",31)
        showNamed(Combat,"Anti Die",32)
        showNamed(Combat,"Anti Void",33)
        hideAll(Keybinds)
        showNamed(Keybinds,"MOVEMENT KEYBINDS",1)
        showNamed(Keybinds,"Speed Key",2)
        showNamed(Keybinds,"Lagger Mode Key",3)
        showNamed(Keybinds,"Drop Brainrot",4,"Drop Key")
        showNamed(Keybinds,"TP Down",5,"TP Down Key")
        showNamed(Keybinds,"COMBAT KEYBINDS",6)
        showNamed(Keybinds,"Normal Aimbot",7,"Bat Aimbot Key")
        showNamed(Keybinds,"TP Bat",7.5,"TP Bat Key")
        showNamed(Keybinds,"Auto Left",9,"Auto Left Key")
        showNamed(Keybinds,"Auto Right",10,"Auto Right Key")
        showNamed(Keybinds,"Instant Reset",11,"Insta Reset Key")

        if not byName(Keybinds,"INTERFACE KEYBINDS") then section(Keybinds,"INTERFACE KEYBINDS",12) end
        showNamed(Keybinds,"INTERFACE KEYBINDS",12)

        local uiToggleRow = byName(Settings,"Toggle UI")
        if uiToggleRow then
            uiToggleRow.Parent = Keybinds
            uiToggleRow.LayoutOrder = 13
            uiToggleRow.Visible = true
            local l=uiToggleRow:FindFirstChild("Label")
            if l then l.Text="UI Toggle Key" end
        end

        
        
        
        
        
        local bgPicker = byName(MenuCustomize,"Background Image Picker")
        local btnPicker = byName(MenuCustomize,"Mobile Button Image Picker")
        local colorPicker = byName(MenuCustomize,"ColorThemePicker")
        local barSize = byName(MenuCustomize,"Progress Bar Size")
        if bgPicker then bgPicker.Parent=Settings end
        if btnPicker then btnPicker.Parent=Settings end
        if colorPicker then colorPicker.Parent=Settings end
        if barSize then barSize.Parent=Settings end

        hideAll(MenuCustomize)

        local controllerBindButtons = {}
        local function ctrlBind(label, order, slot)
            local r=baseRow(MenuCustomize,label,order)

            local b=Instance.new("TextButton")
            b.Name="ControllerKeybindButton"
            b.BackgroundColor3=Color3.fromRGB(8,8,12)
            b.BackgroundTransparency=0.18
            b.BorderSizePixel=0
            b.Text="NONE"
            b.TextColor3=COLORS.white
            b.TextSize=11
            b.Font=Enum.Font.GothamMedium
            b.AutoButtonColor=false
            b.Size=UDim2.new(0,56,0,24)
            b.Position=UDim2.new(1,-64,0.5,-12)
            b.ZIndex=8
            b.Parent=r
            corner(b,14)
            stroke(b,COLORS.strokeSoft,1,0.45)

            
            -- mini "x" clear button, same as the keyboard keybind rows
            local clear=Instance.new("TextButton")
            clear.Name="ClearControllerKeybindButton"
            clear.BackgroundColor3=Color3.fromRGB(8,8,12)
            clear.BackgroundTransparency=0.18
            clear.BorderSizePixel=0
            clear.Text="X"
            clear.TextColor3=COLORS.white
            clear.TextSize=14
            clear.Font=Enum.Font.GothamMedium
            clear.AutoButtonColor=false
            clear.Size=UDim2.new(0,22,0,24)
            clear.Position=UDim2.new(1,-90,0.5,-12)
            clear.ZIndex=9
            clear.Parent=r
            corner(clear,7)
            stroke(clear,COLORS.strokeSoft,1,0.45)

            local function clearSlot()
                if slot == "TPDown" then
                    controllerTPDownKeybind = nil
                else
                    controllerKeybinds[slot] = nil
                end
                if _G.RyzenResetGamepadEdgeState then _G.RyzenResetGamepadEdgeState() end
                refreshAllControllerKeybinds()
                if saveRyzenConfig then pcall(saveRyzenConfig) end
            end

            clear.MouseButton1Click:Connect(clearSlot)

            -- Click the small button OR anywhere on the row (or press A on a
            -- focused row with the gamepad) to start capturing; then press any
            -- controller button to bind it. Capture auto-cancels after 3s so
            -- it can never get stuck.
            local function startCapture()
                listeningForSpeedKey = nil
                listeningForTPDownKey = false
                listeningForControllerKey = slot
                keybindListenStartedAt = tick()
                refreshAllControllerKeybinds()
                task.delay(3, function()
                    if listeningForControllerKey == slot then
                        listeningForControllerKey = nil
                        refreshAllControllerKeybinds()
                    end
                end)
            end

            b.Activated:Connect(startCapture)
            local rowHit = Instance.new("TextButton")
            rowHit.Name = "ControllerRowHit"
            rowHit.BackgroundTransparency = 1
            rowHit.BorderSizePixel = 0
            rowHit.Text = ""
            rowHit.Size = UDim2.new(1, 0, 1, 0)
            rowHit.Position = UDim2.new(0, 0, 0, 0)
            rowHit.ZIndex = 5
            rowHit.AutoButtonColor = false
            rowHit.Parent = r
            rowHit.Activated:Connect(startCapture)

            table.insert(controllerBindButtons,b)
            controllerKeybindButtons[slot] = b
            return r,b
        end

        local resetCtrl=baseRow(MenuCustomize,"RESET ALL CONTROLLER",1)
        resetCtrl:FindFirstChild("Label").Text="RESET ALL CONTROLLER"
        local resetCtrlClick=Instance.new("TextButton")
        resetCtrlClick.Size=UDim2.new(1,0,1,0)
        resetCtrlClick.BackgroundTransparency=1
        resetCtrlClick.Text=""
        resetCtrlClick.ZIndex=20
        resetCtrlClick.Parent=resetCtrl
        resetCtrlClick.MouseButton1Click:Connect(function()
            for slot, _ in pairs(controllerKeybinds) do controllerKeybinds[slot] = nil end
            controllerTPDownKeybind = nil
            if _G.RyzenResetGamepadEdgeState then _G.RyzenResetGamepadEdgeState() end
            for _,b in ipairs(controllerBindButtons) do b.Text="NONE" end
            if saveRyzenConfig then pcall(saveRyzenConfig) end
        end)

        section(MenuCustomize,"MOVEMENT CONTROLLER",2)
        ctrlBind("Speed Key",3,"SpeedToggle"); ctrlBind("Lagger Mode Key",4,"LaggerToggle"); ctrlBind("Drop Key",5,"DropBrainrot"); ctrlBind("TP Down Key",6,"TPDown")
        section(MenuCustomize,"COMBAT CONTROLLER",7)
        ctrlBind("Bat Aimbot Key",8,"Aimbot"); ctrlBind("TP Bat Key",9,"TPBat"); ctrlBind("Auto Left Key",10,"AutoLeft"); ctrlBind("Auto Right Key",11,"AutoRight"); ctrlBind("Insta Reset Key",12,"InstaReset")
        section(MenuCustomize,"INTERFACE CONTROLLER",13)
        ctrlBind("UI Toggle Key",14,"ToggleUI")
        -- FIX: this used to be a bare refreshAllControllerKeybinds() call, but
        -- that function is not defined until ~200 lines further down the chunk.
        -- At build time it was nil, the call threw, and the surrounding
        -- pcall(function() ... end) swallowed the error - which both left every
        -- controller button reading "NONE" (so saved binds looked lost) and
        -- silently skipped every row built after this point. Deferred + guarded.
        task.defer(function()
            if refreshAllControllerKeybinds then pcall(refreshAllControllerKeybinds) end
        end)

        -- FIX: `Utility` is a local of the VISUALS-page builder declared far
        -- above (`local Utility = pages.VISUALS`, ~line 11444). That local is
        -- scoped to *that* function, so inside this deferred block the name
        -- resolved to a nil GLOBAL. byName()/hideAll() happen to tolerate a nil
        -- page, so the rows above were silently orphaned - but the very next
        -- statement, `Utility:GetChildren()`, threw "attempt to index a nil
        -- value (global 'Utility')". The enclosing pcall swallowed it, so every
        -- line after that point was never executed: the VISUALS page visibility
        -- fix-ups, the "Modes gui" row, and the whole SETTINGS page
        -- re-organisation. Resolve the page locally here instead.
        local Utility = (pages and pages.VISUALS) or nil

        if not byName(Utility,"Animation Pack") then
            animationPackRow(Utility,7)
        end

        if not byName(Utility,"Show Tracer") then
            local r,setV=toggleRow(Utility,"Show Tracer",showTracerEnabled,3)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                showTracerEnabled=not showTracerEnabled
                if BoxedESPOptions then BoxedESPOptions.tracer=showTracerEnabled end
                if refreshBoxedESP then pcall(refreshBoxedESP) end
                if setV then setV(showTracerEnabled) end
            end) end
            setTracerESPVisual=setV
        end

        if not byName(Utility,"Ragdoll Countdown") then
            local r,setV=toggleRow(Utility,"Ragdoll Countdown",ragdollCountdownEnabled,4)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                ragdollCountdownEnabled=not ragdollCountdownEnabled
                if ragdollCountdownEnabled then
                    pcall(hookRagdollCountdown,LP.Character)
                    if _G.RyzenStartAllPlayerRagdoll then pcall(_G.RyzenStartAllPlayerRagdoll) end
                else
                    pcall(stopRagdollCountdown)
                    if _G.RyzenStopAllPlayerRagdoll then pcall(_G.RyzenStopAllPlayerRagdoll) end
                end
                if setV then setV(ragdollCountdownEnabled) end
            end) end
            setRagdollCountdownVisual=setV
        end

        if not byName(Utility,"Notifications") then
            local r,setV=toggleRow(Utility,"Notifications",_G.RyzenNotificationsEnabled ~= false,8.5)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                _G.RyzenNotificationsEnabled = not (_G.RyzenNotificationsEnabled ~= false)
                if setV then setV(_G.RyzenNotificationsEnabled) end
                if _G.RyzenNotificationsEnabled and showActionNotification then
                    showActionNotification("NOTIFICATIONS ON")
                end
                if saveRyzenConfig then pcall(saveRyzenConfig) end
            end) end
            _G.RyzenNotificationsVisual = setV
        end

        if not byName(Utility,"Try Hard Animation") then
            local r,setV=toggleRow(Utility,"Try Hard Animation",hitHarderAnimEnabled,8)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                hitHarderAnimEnabled=not hitHarderAnimEnabled
                if hitHarderAnimEnabled then pcall(enableHitHarderAnim) else pcall(disableHitHarderAnim) end
                if setV then setV(hitHarderAnimEnabled) end
            end) end
        end

        hideAll(Utility)
        showNamed(Utility,"ESP",1,"PLAYERS")
        
        for _,o in ipairs(Utility:GetChildren()) do
            if o.Name=="ESP" then o.Visible=true end
        end
        showNamed(Utility,"Show Tracer",3)
        showNamed(Utility,"Ragdoll Countdown",4)
        showNamed(Utility,"Headless",4.5)
        showNamed(Utility,"Korblox",4.6)
        if not byName(Utility,"VISUAL") then section(Utility,"VISUAL",5) end
        showNamed(Utility,"VISUAL",5)
        showNamed(Utility,"Sky Theme",6,"Custom Sky")
        showNamed(Utility,"Animation Pack",7,"Anim Pack")
        showNamed(Utility,"Try Hard Animation",8)
        showNamed(Utility,"Notifications",8.5)
        -- Modes gui toggle: show/hide the mode display pills
        do
            local row, setModesGuiVisual = toggleRow(Utility, "Modes gui", _G.RyzenModesGuiEnabled == true, 8.6)
            local btn = row and row:FindFirstChild("ToggleButton")
            if btn then
                btn.Activated:Connect(function()
                    _G.RyzenModesGuiEnabled = not (_G.RyzenModesGuiEnabled == true)
                    if setModesGuiVisual then setModesGuiVisual(_G.RyzenModesGuiEnabled == true) end
                    -- Update mode pills visibility
                    if _G.RyzenModePills then
                        for _, entry in pairs(_G.RyzenModePills) do
                            local pill = entry and entry.pill
                            if pill and pill.Parent then
                                pill.Visible = (_G.RyzenModesGuiEnabled == true)
                            end
                        end
                    end
                    if saveRyzenConfig then pcall(saveRyzenConfig) end
                end)
            end
            -- Apply initial visibility to existing pills
            if _G.RyzenModePills then
                for _, entry in pairs(_G.RyzenModePills) do
                    local pill = entry and entry.pill
                    if pill and pill.Parent then
                        pill.Visible = (_G.RyzenModesGuiEnabled == true)
                    end
                end
            end
        end
        showNamed(Utility,"PERFORMANCE",8)
        showNamed(Utility,"Anti Lag V2",9,"Anti-Lag V2")
        showNamed(Utility,"Anti Lag",10,"Anti-Lag")
        showNamed(Utility,"Stretch Rez",11,"Stretch Res")
        showNamed(Utility,"Nuke Optimiser",12)
        showNamed(Utility,"FOV",14,"FOV Change")
        showNamed(Utility,"FOV Value",15)
        showNamed(Utility,"Shiny Graphics",16)
        showNamed(Utility,"No Cam Collision",17)

        
        
        if not byName(Settings,"Move Buttons") then
            local r,setV=_G.RyzenActionToggleRow(Settings,"Move Buttons",_G.RyzenGuiLocked~=true,5)
            local b=r and r:FindFirstChild("ToggleButton")
            if b then b.Activated:Connect(function()
                _G.RyzenGuiLocked=not (_G.RyzenGuiLocked==true)
                if setV then setV(_G.RyzenGuiLocked~=true) end
            end) end
        end

        if not byName(Settings,"Intro Song") then
            toggleRow(Settings,"Intro Song",false,8)
        end
        hideAll(Settings)
        showNamed(Settings,"MOBILE BUTTONS",1)
        showNamed(Settings,"Hide Mobile Buttons",3,"Hide Mob Buttons")
        showNamed(Settings,"Mobile Buttons Size",4,"Button Size %")
        showNamed(Settings,"Move Buttons",5)
        showNamed(Settings,"Reset Mobile Buttons",6,"Reset Buttons")

        if not byName(Settings,"INTERFACE") then section(Settings,"INTERFACE",7) end
        showNamed(Settings,"INTERFACE",7)
        showNamed(Settings,"Intro Song",8)
        showNamed(Settings,"Intro",9)

        if not byName(Settings,"BACKGROUND") then section(Settings,"BACKGROUND",10) end
        showNamed(Settings,"BACKGROUND",10)
        if bgPicker then showObj(bgPicker,11) end

        if not byName(Settings,"BUTTONS IMAGE") then section(Settings,"BUTTONS IMAGE",12) end
        showNamed(Settings,"BUTTONS IMAGE",12)
        if btnPicker then showObj(btnPicker,13) end
        if colorPicker then showObj(colorPicker,14) end

        if not byName(Settings,"UI SCALE") then section(Settings,"UI SCALE",16) end
        showNamed(Settings,"UI SCALE",16)
        showNamed(Settings,"GUI Scale",17,"UI Scale")
        if barSize then
            showObj(barSize,18,"Steal Bar Size")
        end
        showNamed(Settings,"Save Config Holder",19)
        showNamed(Settings,"Reset All Settings Holder",20)
    end)
    end)

    -- ============================================================
    -- KEYBIND ACTION DISPATCH (shared by keyboard + controller paths)
    -- One place that runs an action for a keybind slot, so the event
    -- path and the controller poller can never drift apart.
    -- ============================================================
    function _G.RyzenDispatchKeybindAction(slotName)
    if slotName == "ToggleUI" then
    if Main.Visible then
    Main.Visible = false
    MiniFrame.Visible = true
    else
    Main.Visible = true
    MiniFrame.Visible = false
    Main.Size = FULL_MAIN_SIZE
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    if slotName == "SpeedToggle" then
    local fn = toggleCarryMode or _G.RyzenToggleCarryMode
    local ok, err = pcall(fn)
    if not ok then warn("[Ryzen] SpeedToggle failed: " .. tostring(err)) end
    if refreshSpeedModeRows then pcall(refreshSpeedModeRows) end
    if showActionNotification then
    showActionNotification("MODE - " .. string.upper(tostring(currentSpeedMode)))
    end
    return
    end
    if slotName == "LaggerToggle" then
    local fn = toggleLaggerMode or _G.RyzenToggleLaggerMode
    local ok, err = pcall(fn)
    if not ok then warn("[Ryzen] LaggerToggle failed: " .. tostring(err)) end
    if refreshSpeedModeRows then pcall(refreshSpeedModeRows) end
    if showActionNotification then
    showActionNotification("MODE - " .. string.upper(tostring(currentSpeedMode)))
    end
    return
    end
    if slotName == "Aimbot" then
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    if _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE LOCK") end
    return
    end
    if _G.RyzenToggleSelectedAimbot then
    _G.RyzenToggleSelectedAimbot()
    elseif selectedAimbotMode == "Anti Bypass" and _G.RyzenStartAntiBypassAimbot and _G.RyzenStopAntiBypassAimbot then
    if _G.RyzenAntiBypassAimbotOn then _G.RyzenStopAntiBypassAimbot() else _G.RyzenStartAntiBypassAimbot() end
    elseif _G.RyzenStartNormalAimbot and _G.RyzenStopNormalAimbot then
    if _G.RyzenNormalAimbotOn then _G.RyzenStopNormalAimbot() else _G.RyzenStartNormalAimbot() end
    end
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    return
    end
    if slotName == "TPBat" then
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    if _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE LOCK") end
    return
    end
    if _G.RyzenToggleTPBat then pcall(_G.RyzenToggleTPBat) end
    return
    end
    if slotName == "DropBrainrot" then
    runDropBrainrot()
    return
    end
    if slotName == "AutoLeft" then
    if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(not autoLeftEnabled) end
    return
    end
    if slotName == "AutoRight" then
    if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(not autoRightEnabled) end
    return
    end
    if slotName == "TPDown" then
    runTPFloor()
    return
    end
    if slotName == "InstaReset" then
    if _G.RyzenInstantReset then pcall(_G.RyzenInstantReset) end
    return
    end
    end

    function refreshAllControllerKeybinds()
    for slot, btn in pairs(controllerKeybindButtons) do
    if btn and btn.Parent then
    if listeningForControllerKey == slot then
    btn.Text = "Press..."
    else
    local k = (slot == "TPDown") and controllerTPDownKeybind or controllerKeybinds[slot]
    btn.Text = k and keyName(k) or "NONE"
    end
    end
    end
    end

    -- ============================================================
    -- CONTROLLER (GAMEPAD) INPUT
    -- Two independent detectors feed ONE dispatcher:
    --   1. UserInputService.InputBegan  (instant, but can be swallowed when
    --      the game / a focused GUI / another script consumes the press)
    --   2. a per-frame GetGamepadState edge poller (always runs)
    -- A shared "fired this press" flag guarantees a single physical press
    -- produces exactly one action, whichever detector notices it first.
    -- The old code only had #1, so on any setup where InputBegan never
    -- arrived the controller keybinds looked completely dead - including
    -- the Normal <-> Carry speed switch.
    -- ============================================================

    _xGamepadPrevState = {}
    -- set while a button is physically down and its action has already run;
    -- cleared on release. Shared by the event path and the poller.
    _xGamepadFiredThisPress = {}
    function _G.RyzenResetGamepadEdgeState()
    _xGamepadPrevState = {}
    _xGamepadFiredThisPress = {}
    end

    local function _xIsGamepadKeyCode(k)
    -- FIX: this used to test type(k) ~= "EnumItem". In Luau, type() on an
    -- Enum returns "userdata" - only typeof() returns "EnumItem" - so this
    -- always bailed and the catch-all branch never ran. Anything bound to
    -- L1 / R1 / DPad / Start / Select was silently dead.
    if typeof(k) ~= "EnumItem" then return false end
    local s = tostring(k)
    return (s:find("^Enum.KeyCode.Button") == 1) or (s:find("^Enum.KeyCode.DPad") == 1)
    end

    -- Fixed lookup orders. pairs() gives an unspecified order, so with the same
    -- button bound to two slots the winner was random and could change between
    -- presses. Controller binds always win over keyboard binds.
    _X_CONTROLLER_SLOT_ORDER = {
    "SpeedToggle", "LaggerToggle", "DropBrainrot", "Aimbot",
    "AutoLeft", "AutoRight", "InstaReset", "ToggleUI",
    }
    _X_KEYBOARD_SLOT_ORDER = {
    "SpeedToggle", "LaggerToggle", "DropBrainrot", "Aimbot",
    "AutoLeft", "AutoRight", "ToggleUI",
    }

    -- which Ryzen action is this controller button bound to?
    local function _xSlotForButton(keyCode)
    if not keyCode then return nil end
    for _, slot in ipairs(_X_CONTROLLER_SLOT_ORDER) do
    if controllerKeybinds[slot] == keyCode then return slot end
    end
    if controllerTPDownKeybind == keyCode then return "TPDown" end
    -- any controller slot added later that the whitelist does not list yet
    for slot, k in pairs(controllerKeybinds) do
    if k == keyCode then return slot end
    end
    for _, slot in ipairs(_X_KEYBOARD_SLOT_ORDER) do
    if speedKeybinds[slot] == keyCode then return slot end
    end
    if tpDownKeybind == keyCode then return "TPDown" end
    return nil
    end

    -- one press == one dispatch, no matter which detector saw it first.
    -- The flag also expires on its own: if a release is missed by BOTH the
    -- InputEnded event and the poller, the bind must not stay locked forever.
    _X_GAMEPAD_PRESS_LOCK_SECS = 0.35
    local function _xConsumeGamepadPress(keyCode)
    local key = tostring(keyCode)
    local now = tick()
    local at = _xGamepadFiredThisPress[key]
    if at and (now - at) < _X_GAMEPAD_PRESS_LOCK_SECS then return false end
    _xGamepadFiredThisPress[key] = now
    return true
    end

    local function _xReleaseGamepadPress(keyCode)
    _xGamepadFiredThisPress[tostring(keyCode)] = nil
    end

    local function _xFireGamepadKeybind(keyCode)
    local slot = _xSlotForButton(keyCode)
    if not slot then return false end
    pcall(_G.RyzenDispatchKeybindAction, slot)
    return true
    end

    local function _xIsGamepadInput(input)
    return tostring(input.UserInputType):find("Gamepad") ~= nil
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- FIX: `if gameProcessed then return end` killed half the buttons.
    -- Roblox flags most pad presses as processed - ButtonA is the default
    -- UI/jump button, and anything the game or a focused GUI consumes gets
    -- the same flag - so those binds silently never fired. Only honour
    -- gameProcessed for non-gamepad input.
    if gameProcessed and not _xIsGamepadInput(input) then return end

    -- a keybind row is waiting to capture this press: let the capture
    -- handler below take it, don't fire an action with it
    if listeningForControllerKey or listeningForSpeedKey or listeningForTPDownKey then return end

    -- every pad button goes through the same two steps: recognise it, then
    -- fire its bound action. The if/elseif ladder that used to be here only
    -- listed 8 buttons and dispatched each one separately.
    if not _xIsGamepadInput(input) and not _xIsGamepadKeyCode(input.KeyCode) then return end
    if input.KeyCode == Enum.KeyCode.Unknown then return end
    if _xConsumeGamepadPress(input.KeyCode) then
    _xFireGamepadKeybind(input.KeyCode)
    end
    end)

    -- Release bookkeeping. Only the "already fired" flag is cleared here; the
    -- poller owns _xGamepadPrevState so a late InputEnded can never make the
    -- poller re-fire a press that is still physically held.
    UserInputService.InputEnded:Connect(function(input)
    if not _xIsGamepadInput(input) then return end
    _xReleaseGamepadPress(input.KeyCode)
    end)

    -- ------------------------------------------------------------
    -- FALLBACK POLLER - the reason a bound button could still do nothing.
    -- InputBegan is an event other code can consume; GetGamepadState is a
    -- direct read nobody can take away. Poll the buttons that actually have
    -- a bind and fire on the rising edge. Cheap: it early-outs when nothing
    -- is bound and reads the pad state at most once per frame.
    -- ------------------------------------------------------------
    _X_POLL_BUTTONS = {
    Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2,
    Enum.KeyCode.ButtonL3, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonStart, Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.DPadUp, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight,
    }

    local function _xAnyControllerBind()
    for _, slot in ipairs(_X_CONTROLLER_SLOT_ORDER) do
    if controllerKeybinds[slot] ~= nil then return true end
    end
    for slot, k in pairs(controllerKeybinds) do
    if k ~= nil and slot ~= nil then return true end
    end
    return controllerTPDownKeybind ~= nil
    end

    local function _xGamepadDepthMap()
    local depths = {}
    local pad = Enum.UserInputType.Gamepad1
    local okPads, pads = pcall(function() return UserInputService:GetConnectedGamepads() end)
    if okPads and type(pads) == "table" and pads[1] then pad = pads[1] end
    local okState, st = pcall(function() return UserInputService:GetGamepadState(pad) end)
    if okState and type(st) == "table" then
    for _, inp in ipairs(st) do
    local kc = inp and inp.KeyCode
    if kc then
    local z = inp.Position and tonumber(inp.Position.Z) or 0
    depths[tostring(kc)] = z
    end
    end
    end
    return depths
    end

    RunService.RenderStepped:Connect(function()
    if not _xAnyControllerBind() then return end
    -- capturing a new bind: the capture handler owns input while it listens
    if listeningForControllerKey or listeningForSpeedKey or listeningForTPDownKey then return end

    local depths = _xGamepadDepthMap()
    for _, kc in ipairs(_X_POLL_BUTTONS) do
    local key = tostring(kc)
    local down = (depths[key] or 0) > 0.5
    if down then
    if not _xGamepadPrevState[key] then
    _xGamepadPrevState[key] = true
    if _xConsumeGamepadPress(kc) then
    _xFireGamepadKeybind(kc)
    end
    end
    elseif _xGamepadPrevState[key] then
    _xGamepadPrevState[key] = nil
    _xReleaseGamepadPress(kc)
    end
    end
    end)

    -- L2 / R2 are ANALOG triggers. On a lot of pads they never raise
    -- InputBegan, they only stream InputChanged with a 0..1 Position.Z, so a
    -- bind on either trigger looked dead. Fire on the rising edge instead.
    local _xTriggerHeld = {}
    UserInputService.InputChanged:Connect(function(input, gameProcessed)
    local kc = input.KeyCode
    if kc ~= Enum.KeyCode.ButtonL2 and kc ~= Enum.KeyCode.ButtonR2 then return end
    local depth = 0
    pcall(function() depth = input.Position.Z end)
    local held = depth > 0.5

    -- binding a trigger to a slot: same reason, the capture handler below
    -- only ever sees InputBegan, so triggers could not be bound at all
    if listeningForControllerKey then
    if held and not _xTriggerHeld[kc] then
    _xTriggerHeld[kc] = true
    local targetSlot = listeningForControllerKey
    for otherSlot, boundKey in pairs(controllerKeybinds) do
    if otherSlot ~= targetSlot and boundKey == kc then controllerKeybinds[otherSlot] = nil end
    end
    if controllerTPDownKeybind == kc then controllerTPDownKeybind = nil end
    if targetSlot == "TPDown" then
    controllerTPDownKeybind = kc
    else
    controllerKeybinds[targetSlot] = kc
    end
    listeningForControllerKey = nil
    if refreshAllControllerKeybinds then pcall(refreshAllControllerKeybinds) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    elseif not held and depth < 0.3 then
    _xTriggerHeld[kc] = nil
    end
    return
    end
    if listeningForSpeedKey or listeningForTPDownKey then return end

    if held and not _xTriggerHeld[kc] then
    _xTriggerHeld[kc] = true
    -- same shared edge-consume as the poller / InputBegan path: whichever
    -- detector notices the trigger pull first is the one that fires it
    if _xConsumeGamepadPress(kc) then
    _xFireGamepadKeybind(kc)
    end
    elseif not held and depth < 0.3 then
    _xTriggerHeld[kc] = nil
    _xReleaseGamepadPress(kc)
    end
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
    local isControllerInput = tostring(input.UserInputType):find("Gamepad") ~= nil
    if gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and not listeningForSpeedKey and not listeningForTPDownKey and not listeningForControllerKey then return end
    if not isControllerInput and UserInputService:GetFocusedTextBox() then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard and not isControllerInput then return end
    if input.KeyCode == Enum.KeyCode.Unknown then return end
    if not isControllerInput and speedKeybinds.ToggleUI and input.KeyCode == speedKeybinds.ToggleUI then
    if Main.Visible then
    Main.Visible = false
    MiniFrame.Visible = true
    else
    Main.Visible = true
    MiniFrame.Visible = false
    Main.Size = FULL_MAIN_SIZE
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    if listeningForSpeedKey then
    if tick() - (keybindListenStartedAt or 0) < 0.02 then return end
    local targetKey = listeningForSpeedKey
    if input.KeyCode == Enum.KeyCode.Escape then
    listeningForSpeedKey = nil
    refreshAllSpeedKeybinds()
    return
    end
    if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
    speedKeybinds[targetKey] = nil
    else
    for otherKeyId, boundKey in pairs(speedKeybinds) do
    if otherKeyId ~= targetKey and boundKey == input.KeyCode then
    speedKeybinds[otherKeyId] = nil
    end
    end
    if tpDownKeybind == input.KeyCode then
    tpDownKeybind = nil
    refreshTPDownKeybind()
    end
    speedKeybinds[targetKey] = input.KeyCode
    end
    listeningForSpeedKey = nil
    refreshAllSpeedKeybinds()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    if listeningForTPDownKey then
    if tick() - (keybindListenStartedAt or 0) < 0.18 then return end
    if input.KeyCode == Enum.KeyCode.Escape then
    listeningForTPDownKey = false
    refreshTPDownKeybind()
    return
    end
    if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
    tpDownKeybind = nil
    else
    for keyId, boundKey in pairs(speedKeybinds) do
    if boundKey == input.KeyCode then
    speedKeybinds[keyId] = nil
    end
    end
    tpDownKeybind = input.KeyCode
    end
    listeningForTPDownKey = false
    refreshAllSpeedKeybinds()
    refreshTPDownKeybind()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    if listeningForControllerKey then
    if not isControllerInput then
    if input.KeyCode == Enum.KeyCode.Escape then
    listeningForControllerKey = nil
    refreshAllControllerKeybinds()
    return
    end
    return
    end
    -- FIX: this was 0.05s. A pad press landing inside that window was
    -- dropped with no feedback, so the bind silently never happened. The
    -- guard is not actually needed here: a gamepad row opens capture from
    -- Activated (which fires on RELEASE, after that press's InputBegan has
    -- already gone by) and a mouse/touch tap is not controller input at all.
    -- One frame is enough to swallow a same-frame duplicate.
    if tick() - (keybindListenStartedAt or 0) < 0.016 then return end
    local targetSlot = listeningForControllerKey
    if input.KeyCode == Enum.KeyCode.Escape then
    listeningForControllerKey = nil
    refreshAllControllerKeybinds()
    return
    end
    if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
    if targetSlot == "TPDown" then
    controllerTPDownKeybind = nil
    else
    controllerKeybinds[targetSlot] = nil
    end
    else
    for otherSlot, boundKey in pairs(controllerKeybinds) do
    if otherSlot ~= targetSlot and boundKey == input.KeyCode then
    controllerKeybinds[otherSlot] = nil
    end
    end
    if controllerTPDownKeybind == input.KeyCode then
    controllerTPDownKeybind = nil
    end
    if targetSlot == "TPDown" then
    controllerTPDownKeybind = input.KeyCode
    else
    controllerKeybinds[targetSlot] = input.KeyCode
    end
    end
    listeningForControllerKey = nil
    if _G.RyzenResetGamepadEdgeState then _G.RyzenResetGamepadEdgeState() end
    refreshAllControllerKeybinds()
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    return
    end
    -- Gamepad keybind actions: fire from the event here AND from the
    -- per-frame poller above (covers delayed/blocked events). The shared
    -- edge-consume flag guarantees each physical press fires exactly once.
    -- Gamepad input is NOT blocked by a focused textbox (controller users
    -- don't type).
    if isControllerInput then
    -- dispatch is owned by the new InputBegan controller engine above;
    -- this handler only still runs for keybind CAPTURE (handled earlier)
    return
    end
    if speedKeybinds.SpeedToggle and input.KeyCode == speedKeybinds.SpeedToggle then
    toggleCarryMode()
    return
    end
    if speedKeybinds.LaggerToggle and input.KeyCode == speedKeybinds.LaggerToggle then
    toggleLaggerMode()
    return
    end
    if speedKeybinds.Aimbot and input.KeyCode == speedKeybinds.Aimbot then
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    if _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE LOCK") end
    return
    end
    if _G.RyzenToggleSelectedAimbot then
    _G.RyzenToggleSelectedAimbot()
    elseif selectedAimbotMode == "Anti Bypass" and _G.RyzenStartAntiBypassAimbot and _G.RyzenStopAntiBypassAimbot then
    if _G.RyzenAntiBypassAimbotOn then _G.RyzenStopAntiBypassAimbot() else _G.RyzenStartAntiBypassAimbot() end
    elseif _G.RyzenStartNormalAimbot and _G.RyzenStopNormalAimbot then
    if _G.RyzenNormalAimbotOn then _G.RyzenStopNormalAimbot() else _G.RyzenStartNormalAimbot() end
    end
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    return
    end
    if speedKeybinds.TPBat and input.KeyCode == speedKeybinds.TPBat then
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then
    if _G.RyzenSafeModeForceStop then _G.RyzenSafeModeForceStop("SAFE MODE LOCK") end
    return
    end
    if _G.RyzenToggleTPBat then pcall(_G.RyzenToggleTPBat) end
    return
    end
    if speedKeybinds.DropBrainrot and input.KeyCode == speedKeybinds.DropBrainrot then
    runDropBrainrot()
    return
    end
    if speedKeybinds.AutoLeft and input.KeyCode == speedKeybinds.AutoLeft then
    if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(not autoLeftEnabled) end
    return
    end
    if speedKeybinds.AutoRight and input.KeyCode == speedKeybinds.AutoRight then
    if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(not autoRightEnabled) end
    return
    end
    if tpDownKeybind and input.KeyCode == tpDownKeybind then
    runTPFloor()
    return
    end
    end)
    task.defer(function()
    task.wait(0.15)
    pcall(function()
    for _, pageName in ipairs({"MOVEMENT","COMBAT"}) do
    local page = pages[pageName]
    if page then
    for _, holder in ipairs(page:GetDescendants()) do
    if holder:IsA("Frame") and holder:FindFirstChild("SelectedSlide") then
    holder.Size = UDim2.new(1,-4,0,34)
    holder.BackgroundColor3 = Color3.fromRGB(0,0,0)
    holder.BackgroundTransparency = 0.3

    local slide = holder:FindFirstChild("SelectedSlide")
    if slide then
    slide.Size = UDim2.new(0.5,-4,1,-8)
    slide.BackgroundColor3 = Color3.fromRGB(255,255,255)
    slide.BackgroundTransparency = 0.85
    local s = slide:FindFirstChildOfClass("UIStroke")
    if s then
    s.Color = Color3.fromRGB(255,255,255)
    s.Thickness = 1
    s.Transparency = 0.2
    end
    end

    for _, child in ipairs(holder:GetChildren()) do
    if child:IsA("TextLabel") or child:IsA("TextButton") then
    child.Font = Enum.Font.GothamMedium
    child.TextSize = 12
    end
    end
    end
    end

    for _, obj in ipairs(page:GetDescendants()) do
    if obj:IsA("TextButton") and obj.Name == "ArrowButton" then
    obj.Position = UDim2.new(1,-100,0.5,-14)
    obj.Size = UDim2.new(0,36,0,28)
    obj.BackgroundColor3 = Color3.fromRGB(12,12,16)
    obj.BackgroundTransparency = 0.08
    obj.Text = "v"
    obj.TextColor3 = Color3.fromRGB(255,255,255)
    obj.TextSize = 12
    obj.Font = Enum.Font.GothamMedium
    local c = obj:FindFirstChildOfClass("UICorner")
    if c then c.CornerRadius = UDim.new(0,14) end
    local s = obj:FindFirstChildOfClass("UIStroke")
    if s then
    s.Color = Color3.fromRGB(255,255,255)
    s.Thickness = 1.1
    s.Transparency = 0.55
    end
    end
    end
    end
    end
    end)
    end)

    -- open on the tab the user last had selected (falls back to MOVEMENT
    -- for a fresh config or a stale tab name from an older build)
    local _bootTab = _G.RyzenLastActiveTab
    if type(_bootTab) ~= "string" or not table.find(tabNames, _bootTab) then
    _bootTab = "MOVEMENT"
    end
    setTab(_bootTab)
    _G.__RyzenDuelsSetupStealBar = function()
    local RunService   = game:GetService("RunService")
    local UIS = UserInputService
    local TS = TweenService
    local Stats        = game:GetService("Stats")
    local existingStealBar = LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("StealBarGui")
    if existingStealBar then existingStealBar:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "StealBarGui"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    safeParentGui(gui)
    function drag(frame)
    local dragging, dragStart, startPos = false, nil, nil
    frame.InputBegan:Connect(function(input)
    if _G.RyzenGuiLocked == true then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    dragging = true
    dragStart = input.Position
    startPos = frame.Position
    input.Changed:Connect(function()
    if input.UserInputState == Enum.UserInputState.End then
    dragging = false
    savedStealBarPositionTable = udim2ToTable(frame.Position)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    end)
    end
    end)
    UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    savedStealBarPositionTable = udim2ToTable(frame.Position)
    end
    end)
    end


    local pbFrame = Instance.new("Frame", gui)
    pbFrame.Name = "StealBar"
    pbFrame.Active = true
    pbFrame.AnchorPoint = Vector2.new(0.5, 1)
    pbFrame.Size = UDim2.new(0, 282, 0, 54)
    pbFrame.Position = tableToUDim2(savedStealBarPositionTable, UDim2.new(0.5, 0, 1, -76))
    pbFrame.BackgroundColor3 = Color3.fromRGB(7, 9, 9)
    pbFrame.BorderSizePixel = 0

    Instance.new("UICorner", pbFrame).CornerRadius = UDim.new(0, 6)

    local pbGrad = Instance.new("UIGradient")
    pbGrad.Color = ColorSequence.new(Color3.fromRGB(8, 20, 18), Color3.fromRGB(5, 6, 7))
    pbGrad.Rotation = 90
    pbGrad.Parent = pbFrame

    -- soft glow overlay (only visible while STEALING)
    local stealWhiteGlow = Instance.new("Frame")
    stealWhiteGlow.Name = "StealWhiteGlow"
    stealWhiteGlow.Size = UDim2.new(1, 0, 1, 0)
    stealWhiteGlow.Position = UDim2.new(0, 0, 0, 0)
    stealWhiteGlow.BackgroundColor3 = Color3.fromRGB(61, 255, 170)
    stealWhiteGlow.BackgroundTransparency = 1
    stealWhiteGlow.BorderSizePixel = 0
    stealWhiteGlow.ZIndex = 1
    stealWhiteGlow.Parent = pbFrame
    Instance.new("UICorner", stealWhiteGlow).CornerRadius = UDim.new(0, 6)

    -- optional custom background image (steal UI image feature)
    local stealBgImage = Instance.new("ImageLabel")
    stealBgImage.Name = "StealUIBackground"
    stealBgImage.BackgroundTransparency = 1
    stealBgImage.Size = UDim2.new(1, 0, 1, 0)
    stealBgImage.Position = UDim2.new(0, 0, 0, 0)
    stealBgImage.ScaleType = Enum.ScaleType.Crop
    stealBgImage.ImageTransparency = 0.28
    stealBgImage.ZIndex = 0
    stealBgImage.Parent = pbFrame
    Instance.new("UICorner", stealBgImage).CornerRadius = UDim.new(0, 6)
    local function normalizeStealUIImage(value)
    value = tostring(value or "")
    if value == "" then return "" end
    if value:match("^rbxassetid://%d+$") then return value end
    local id = value:match("(%d+)")
    return id and ("rbxassetid://" .. id) or ""
    end
    function _G.RyzenApplyStealUIImage()
    local image = normalizeStealUIImage(_G.RyzenStealUIImage)
    stealBgImage.Image = image
    stealBgImage.ImageColor3 = _G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE
    stealBgImage.Visible = image ~= ""
    end
    _G.RyzenApplyStealUIImage()

    drag(pbFrame)
    local pbScale = Instance.new("UIScale")
    pbScale.Name = "RyzenProgressBarScale"
    pbScale.Scale = aceProgressBarScaleValue or 1
    pbScale.Parent = pbFrame

    -- "0%" (top left)
    local progressPct = Instance.new("TextLabel", pbFrame)
    progressPct.Position = UDim2.new(0, 10, 0, 2)
    progressPct.Size = UDim2.new(0, 94, 0, 18)
    progressPct.BackgroundTransparency = 1
    progressPct.Text = "0%"
    progressPct.TextColor3 = Color3.fromRGB(247, 243, 255)
    progressPct.TextSize = 16
    progressPct.Font = Enum.Font.GothamBlack
    progressPct.TextXAlignment = Enum.TextXAlignment.Left
    progressPct.TextStrokeTransparency = 0.5

    -- "Radius: 9" (top right)
    local progressRadLbl = Instance.new("TextLabel", pbFrame)
    progressRadLbl.Position = UDim2.new(1, -130, 0, 2)
    progressRadLbl.Size = UDim2.new(0, 120, 0, 18)
    progressRadLbl.BackgroundTransparency = 1
    progressRadLbl.Text = string.format("Radius: %s", tostring(autoStealRadius))
    progressRadLbl.TextColor3 = Color3.fromRGB(247, 243, 255)
    progressRadLbl.TextSize = 12
    progressRadLbl.Font = Enum.Font.GothamBlack
    progressRadLbl.TextXAlignment = Enum.TextXAlignment.Right
    progressRadLbl.TextStrokeTransparency = 0.5

    -- FPS / PING line (Bootsware style - discord link removed)
    local pingBarLbl = Instance.new("TextLabel", pbFrame)
    pingBarLbl.Position = UDim2.new(0, 10, 0, 22)
    pingBarLbl.Size = UDim2.new(1, -20, 0, 13)
    pingBarLbl.BackgroundTransparency = 1
    pingBarLbl.Text = "FPS: 0 PING: 0ms"
    pingBarLbl.TextColor3 = Color3.fromRGB(247, 243, 255)
    pingBarLbl.TextSize = 10
    pingBarLbl.Font = Enum.Font.GothamMedium
    pingBarLbl.TextXAlignment = Enum.TextXAlignment.Left
    pingBarLbl.TextStrokeTransparency = 0.65

    -- power button removed (user request); toggle Auto Steal from the Combat tab

    -- progress track
    local pbg = Instance.new("Frame", pbFrame)
    pbg.Name = "Track"
    pbg.Position = UDim2.new(0, 10, 1, -14)
    pbg.Size = UDim2.new(1, -20, 0, 8)
    pbg.BackgroundColor3 = Color3.fromRGB(15, 24, 22)
    pbg.BorderSizePixel = 0
    pbg.ClipsDescendants = true
    Instance.new("UICorner", pbg).CornerRadius = UDim.new(1, 0)
    local pbgStroke = Instance.new("UIStroke", pbg)
    pbgStroke.Color = Color3.fromRGB(60, 60, 66)
    pbgStroke.Transparency = 0.4
    pbgStroke.Thickness = 1

    -- progress fill (white - user request; was the Bootsware blue gradient)
    local progressFill = Instance.new("Frame", pbg)
    progressFill.Name = "Fill"
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BorderSizePixel = 0
    Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)
    local progressFillGrad = Instance.new("UIGradient", progressFill)
    progressFillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(67, 255, 174)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(40, 213, 178)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 171, 255)),
    })
    progressFillGrad.Rotation = 90

    -- travelling shine band inside the fill
    local progressShine = Instance.new("Frame", progressFill)
    progressShine.Name = "Shine"
    progressShine.Position = UDim2.new(-0.35, 0, 0, 0)
    progressShine.Size = UDim2.new(0.35, 0, 1, 0)
    progressShine.BackgroundColor3 = Color3.fromRGB(196, 212, 232)
    progressShine.BackgroundTransparency = 0.35
    progressShine.BorderSizePixel = 0
    Instance.new("UICorner", progressShine).CornerRadius = UDim.new(1, 0)
    local shineGrad = Instance.new("UIGradient", progressShine)
    shineGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1, 0),
    NumberSequenceKeypoint.new(0.4, 0.85, 0),
    NumberSequenceKeypoint.new(0.5, 0.65, 0),
    NumberSequenceKeypoint.new(0.6, 0.85, 0),
    NumberSequenceKeypoint.new(1, 1, 0),
    })
    local function applyStealBarTheme()
    local green = Color3.fromRGB(61, 255, 170)
    local cyan = Color3.fromRGB(44, 171, 255)
    pbFrame.BackgroundColor3 = Color3.fromRGB(7, 9, 9)
    pbGrad.Color = ColorSequence.new(Color3.fromRGB(8, 20, 18), Color3.fromRGB(5, 6, 7))
    pbg.BackgroundColor3 = Color3.fromRGB(15, 24, 22)
    progressFill.BackgroundColor3 = green
    progressFillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, green),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(40, 213, 178)),
        ColorSequenceKeypoint.new(1, cyan),
    })
    progressShine.BackgroundColor3 = Color3.fromRGB(190, 255, 232)
    pbgStroke.Color = Color3.fromRGB(35, 91, 76)
    stealWhiteGlow.BackgroundColor3 = green
    end
    _G.RyzenRefreshStealBarTheme = applyStealBarTheme
    applyStealBarTheme()
    -- sweep the shine across the fill endlessly (clipped to the track)
    TS:Create(progressShine, TweenInfo.new(1.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, math.huge), {
    Position = UDim2.new(1, 0, 0, 0),
    }):Play()

    local barState = "IDLE"
    function setBarState(state)
    barState = state
    if state == "STEALING" then
    TS:Create(stealWhiteGlow, TweenInfo.new(0.28, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.82
    }):Play()
    TS:Create(progressRadLbl, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(230, 240, 255)}):Play()
    TS:Create(progressPct, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    elseif state == "READY" then
    TS:Create(stealWhiteGlow, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TS:Create(progressRadLbl, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(190, 200, 220)}):Play()
    else
    TS:Create(stealWhiteGlow, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TS:Create(progressRadLbl, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(247, 243, 255)}):Play()
    TS:Create(progressPct, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(247, 243, 255)}):Play()
    end
    end

    task.spawn(function()
    local lastFrame = tick()
    local fpsSamples = {}
    local fpsAvg = 60
    RunService.RenderStepped:Connect(function()
    local now = tick()
    local dt = now - lastFrame
    lastFrame = now
    if dt > 0 then
    table.insert(fpsSamples, 1 / dt)
    if #fpsSamples > 30 then table.remove(fpsSamples, 1) end
    local sum = 0
    for _, v in ipairs(fpsSamples) do sum = sum + v end
    fpsAvg = sum / #fpsSamples
    end
    end)
    while pbFrame and pbFrame.Parent do
    local ping = 0
    pcall(function()
    local stat = Stats.Network.ServerStatsItem["Data Ping"]
    if stat then ping = tonumber(stat:GetValue()) or 0 end
    end)
    pingBarLbl.Text = string.format("FPS: %d PING: %dms", math.floor(fpsAvg + 0.5), math.floor(ping + 0.5))
    pingBarLbl.TextColor3 = Color3.fromRGB(247, 243, 255)
    progressRadLbl.Text = string.format("Radius: %s", tostring(autoStealRadius))
    task.wait(0.5)
    end
    end)

    local StealBar = {}
    function StealBar.SetProgress(p)
    p = math.clamp(p, 0, 1)
    progressFill.Size = UDim2.new(p, 0, 1, 0)
    progressPct.Text = math.floor(p * 100 + 0.5) .. "%"

    if barState == "STEALING" then
        
        stealWhiteGlow.BackgroundTransparency = 0.84 - (p * 0.26)
        progressFill.BackgroundTransparency = 0.18 - (p * 0.12)
    end
    end
    function StealBar.Reset()
    StealBar.SetProgress(0)
    setBarState("IDLE")
    end
    function StealBar.SetState(state)
    setBarState(state)
    end
    setBarState("IDLE")
    _G.StealBar = StealBar
    end
    _G.__RyzenDuelsSetupStealBar()
    if _G.RyzenAutoStealSync then task.defer(_G.RyzenAutoStealSync) end
    _G.__RyzenDuelsSetupMinimizeToggle = function()
    _G.__RyzenDuelsMinimized = false
    Close.MouseButton1Click:Connect(function()
    _G.__RyzenDuelsMinimized = not _G.__RyzenDuelsMinimized
    if _G.__RyzenDuelsMinimized then
    Main.Visible = false
    MiniFrame.Visible = true
    else
    Main.Visible = true
    MiniFrame.Visible = false
    Main.Size = FULL_MAIN_SIZE
    end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end)
    end
    _G.__RyzenDuelsSetupMinimizeToggle()


    _G.__RyzenDuelsRunIntro = function()
        local introGuiParent = Gui and Gui.Parent or PlayerGui
        local origSize = FULL_MAIN_SIZE or Main.Size
        local wasMinimizedBeforeIntro = (_G.__RyzenDuelsMinimized == true)

        if not _introEnabled then
            stopIntroPlayback()
            stopIntroPreview()
            Main.Size = origSize
            Main.Visible = not wasMinimizedBeforeIntro
            MiniFrame.Visible = wasMinimizedBeforeIntro
            return
        end

        playIntroMusic()
        Main.Visible = false
        MiniFrame.Visible = false

        task.spawn(function()
            local TweenService = game:GetService("TweenService")
            local DARKER_BG = Color3.fromRGB(5,5,8)

            local function new(class, props)
                local inst = Instance.new(class)
                for k,v in pairs(props or {}) do
                    if k ~= "Parent" then inst[k] = v end
                end
                if props and props.Parent then inst.Parent = props.Parent end
                return inst
            end

            local function introTween(obj, duration, props, style, dir)
                local t = TweenService:Create(
                    obj,
                    TweenInfo.new(duration, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
                    props
                )
                t:Play()
                return t
            end

            local oldIntro = introGuiParent:FindFirstChild("RyzenIntro")
            if oldIntro then oldIntro:Destroy() end

            local introGui = new("ScreenGui", {
                Name = "RyzenIntro",
                IgnoreGuiInset = true,
                ResetOnSpawn = false,
                DisplayOrder = 1000,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                Parent = introGuiParent,
            })

            local intro = new("Frame", {
                Name = "RyzenIntro",
                ZIndex = 1000,
                Size = UDim2.new(1,0,1,0),
                BackgroundColor3 = DARKER_BG,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = introGui,
            })

            
            local introLogo = new("Frame", {
                Name="IntroBanner",
                ZIndex=1002,
                AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(0.5,0,0.50,0),
                Size=UDim2.new(0.34,0,0,70),
                BackgroundTransparency=1,
                Parent=intro,
            })
            _G.RyzenBuildRyzenWordmark(introLogo, 64, -3)

            local tapAnywhere = new("TextLabel", {
                Name="TapAnywhere",
                ZIndex=1003,
                AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(0.5,0,0.50,48),
                Size=UDim2.new(0.7,0,0,20),
                BackgroundTransparency=1,
                Text="TAP ANYWHERE TO SKIP",
                TextColor3=Color3.fromRGB(255,255,255),
                TextStrokeColor3=Color3.fromRGB(0,0,0),
                TextStrokeTransparency=0.2,
                TextSize=11,
                Font=Enum.Font.GothamBlack,
                Parent=intro,
            })

            local discordInvite = new("TextLabel", {
                Name="DiscordInvite",
                ZIndex=1003,
                AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(0.5,0,0.50,68),
                Size=UDim2.new(0.7,0,0,18),
                BackgroundTransparency=1,
                Text="",
                TextColor3=Color3.fromRGB(255,255,255),
                TextStrokeColor3=Color3.fromRGB(0,0,0),
                TextStrokeTransparency=0.25,
                TextSize=10,
                Font=Enum.Font.GothamBlack,
                Parent=intro,
            })

            local tapCatcher = new("TextButton", {
                Name="TapCatcher",
                ZIndex=1004,
                Size=UDim2.new(1,0,1,0),
                BackgroundTransparency=1,
                Text="",
                AutoButtonColor=false,
                Parent=intro,
            })

            local skipped = false

            local function finishIntro()
                if skipped then return end
                skipped = true

                stopIntroPlayback()
                stopIntroPreview()

                introTween(intro,0.3,{BackgroundTransparency=1})


                for _,l in ipairs(introLogo:GetChildren()) do
                    if l:IsA("TextLabel") then introTween(l,0.25,{TextTransparency=1}) end
                end
                introTween(tapAnywhere,0.25,{TextTransparency=1,TextStrokeTransparency=1})
                introTween(discordInvite,0.25,{TextTransparency=1,TextStrokeTransparency=1})

                task.delay(0.35,function()
                    if introGui then introGui:Destroy() end
                    Main.Size = origSize
                    Main.Visible = not wasMinimizedBeforeIntro
                    MiniFrame.Visible = wasMinimizedBeforeIntro
                end)
            end

            tapCatcher.MouseButton1Click:Connect(finishIntro)

            task.wait(0.15)
            if skipped then return end

            

            task.spawn(function()
                while not skipped and tapAnywhere.Parent do
                    introTween(tapAnywhere,0.65,{TextTransparency=0.48})
                    task.wait(0.65)
                    if skipped then break end
                    introTween(tapAnywhere,0.65,{TextTransparency=0})
                    task.wait(0.65)
                end
            end)

            
            
            task.wait(12.0)
            if not skipped then finishIntro() end
        end)
    end
    stopIntroPlayback()
    stopIntroPreview()
    _G.__RyzenDuelsMinimized = false
    Main.Size = FULL_MAIN_SIZE
    Main.Visible = true
    MiniFrame.Visible = false
    if _G.RxzFitMainToScreen then pcall(_G.RxzFitMainToScreen) end

    _G.RyzenDuelsForceSyncLoadedButtons = function()
    pcall(function()
    if setAutoTPVisual then setAutoTPVisual(autoTPEnabled) end
    if autoTPEnabled then startAutoTP() else stopAutoTP() end
    end)
    pcall(function()
    if setInfJumpVisual then setInfJumpVisual(infJumpEnabled) end
    if setInfJumpInternal then setInfJumpInternal(infJumpEnabled) end
    end)
    pcall(function()
    if setAntiRagdollVisual then setAntiRagdollVisual(antiRagdollEnabled) end
    setAntiRagdoll(antiRagdollEnabled)
    end)
    pcall(function()
    if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(autoLeftEnabled, true) end
    if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(autoRightEnabled, true) end
    end)
    pcall(function()
    if setAutoStealVisual then setAutoStealVisual(autoStealEnabled) end
    if _G.RyzenAutoStealSync then _G.RyzenAutoStealSync() end
    end)
    pcall(function()
    if _G.RyzenTPBatSetVisual then _G.RyzenTPBatSetVisual(_G.RyzenTPBatEnabled == true) end
    _G.RyzenSetTPBat(_G.RyzenTPBatEnabled == true)
    end)
    pcall(function()
    if _G.RyzenNormalAutoSwingSetVisual then _G.RyzenNormalAutoSwingSetVisual(autoSwingEnabled) end
    if _G.RyzenMirrorTPDownSetVisual then _G.RyzenMirrorTPDownSetVisual(mirrorTPDownEnabled) end
    if _G.RyzenAntiDesyncAutoSwingSetVisual then _G.RyzenAntiDesyncAutoSwingSetVisual(antiDesyncAutoSwingEnabled) end
    end)
    -- RYZEN ANTI DROP boot sync (always enabled; runtime starts below via deferred apply)
    _G.RyzenAntiDropEnabled = true
    pcall(function()
    if _G.RyzenAntiDropSetVisual then _G.RyzenAntiDropSetVisual(_G.RyzenAntiDropEnabled == true) end
    end)
    pcall(function()
    if selectedAimbotMode == "Anti Bypass" then
    if _G.RyzenNormalAimbotStop then _G.RyzenNormalAimbotStop() end
    if _G.RyzenAntiBypassAimbotOn and _G.RyzenAntiBypassStart then
    _G.RyzenAntiBypassStart()
    elseif _G.RyzenAntiBypassStop then
    _G.RyzenAntiBypassStop()
    end
    else
    if _G.RyzenAntiBypassStop then _G.RyzenAntiBypassStop() end
    if _G.RyzenNormalAimbotOn and _G.RyzenNormalAimbotStart then
    _G.RyzenNormalAimbotStart()
    elseif _G.RyzenNormalAimbotStop then
    _G.RyzenNormalAimbotStop()
    end
    end
    if _G.RyzenRefreshAimbotVisual then _G.RyzenRefreshAimbotVisual() end
    end)
    pcall(function()
    if setBatCounterVisual then setBatCounterVisual(batCounterEnabled) end
    if setMedCounterVisual then setMedCounterVisual(medCounterEnabled) end
    if setSafeModeVisual then setSafeModeVisual(antiKickEnabled) end
    if batCounterEnabled then
    if _G.RyzenStartBatCounter then _G.RyzenStartBatCounter() end
    else
    if _G.RyzenStopBatCounter then _G.RyzenStopBatCounter() end
    end
    if medCounterEnabled then
    if _G.RyzenStartMedCounter then _G.RyzenStartMedCounter(LP.Character) end
    else
    if _G.RyzenStopMedCounter then _G.RyzenStopMedCounter() end
    end
    if _G.RyzenSetNoPlayerCollisionVisual then _G.RyzenSetNoPlayerCollisionVisual(_G.RyzenNoPlayerCollisionEnabled) end
    if _G.RyzenNoPlayerCollisionEnabled then
    if enableNoPlayerCollision then enableNoPlayerCollision() end
    else
    if disableNoPlayerCollision then disableNoPlayerCollision() end
    end
    if _G.RyzenSetAutoResetOnMed then
    _G.RyzenSetAutoResetOnMed(autoResetOnMedEnabled, true)
    else
    if setAutoResetOnMedVisual then setAutoResetOnMedVisual(autoResetOnMedEnabled) end
    end
    end)
    pcall(function()
    if setPlayerESPVisual then setPlayerESPVisual(espEnabled) end
    if espEnabled then if startPlayerESP then startPlayerESP() end; if BoxedESPOptions then BoxedESPOptions.box = false end else if stopPlayerESP then stopPlayerESP() end; if BoxedESPOptions then BoxedESPOptions.box = false end end
    if setTracerESPVisual then setTracerESPVisual(showTracerEnabled) end
    if BoxedESPOptions then BoxedESPOptions.tracer = false end
    if refreshBoxedESP then refreshBoxedESP() end
    if setRagdollCountdownVisual then setRagdollCountdownVisual(ragdollCountdownEnabled) end
    -- make the controller bind buttons show what was just loaded from disk
    task.defer(function()
    if refreshAllControllerKeybinds then pcall(refreshAllControllerKeybinds) end
    end)
    if ragdollCountdownEnabled then
    hookRagdollCountdown(LP.Character)
    if _G.RyzenStartAllPlayerRagdoll then pcall(_G.RyzenStartAllPlayerRagdoll) end
    else
    stopRagdollCountdown()
    if _G.RyzenStopAllPlayerRagdoll then pcall(_G.RyzenStopAllPlayerRagdoll) end
    end
    if setFPSBoostVisual then setFPSBoostVisual(fpsBoostEnabled) end
    if fpsBoostEnabled then enableStretchRez() else disableStretchRez() end
    if setAntiLagVisual then setAntiLagVisual(antiLagVisualEnabled) end
    if antiLagVisualEnabled then enableAntiLag() else disableAntiLag() end
    if setAntiLagV2Visual then setAntiLagV2Visual(antiLagV2Enabled) end
    if antiLagV2Enabled then enableAntiLagV2() else disableAntiLagV2() end
    if setNukeOptimiserVisual then setNukeOptimiserVisual(nukeOptimiserEnabled) end
    if nukeOptimiserEnabled then enableNukeOptimizer() else disableNukeOptimizer() end
    if setFOVVisual then setFOVVisual(fovEnabled) end
    if fovEnabled then enableCustomFov() else disableCustomFov() end
    if setShinyGraphicsVisual then setShinyGraphicsVisual(shinyGraphicsEnabled) end
    if shinyGraphicsEnabled then enableShinyGraphics() else disableShinyGraphics() end
    if setNoCamCollisionVisual then setNoCamCollisionVisual(noCamCollisionEnabled) end
    if noCamCollisionEnabled then enableNoCamCollision() else disableNoCamCollision() end
    if type(applyCustomSky) == "function" then
    applyCustomSky((skyTheme and skyTheme ~= "") and skyTheme or "Off")
    end
    if skyValueLabel then skyValueLabel.Text = skyTheme or "Off" end
    end)
    pcall(function()
    if _G.RyzenSetAntiDrop then
    _G.RyzenSetAntiDrop(true)
    end
    end)
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    task.defer(function()
    task.wait(0.35)
    if type(applyCustomSky) == "function" then
    pcall(function() applyCustomSky((skyTheme and skyTheme ~= "") and skyTheme or "Off") end)
    end
    if skyValueLabel then skyValueLabel.Text = skyTheme or "Off" end
    end)
    task.defer(_G.RyzenDuelsForceSyncLoadedButtons)
    task.delay(1, function()
    if _G.RyzenDuelsForceSyncLoadedButtons then _G.RyzenDuelsForceSyncLoadedButtons() end
    end)
    task.defer(function()
    task.wait(0.2)
    if _G.RyzenSyncToggleVisuals then _G.RyzenSyncToggleVisuals() end
    end)
    customFontVisualEnabled = false
    if V then V.customFontEnabled = false end
    function enableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    function disableCustomFont() customFontVisualEnabled=false; if V then V.customFontEnabled=false end end
    _G.RyzenDuelsApplySavedGameplayStates = function()
    pcall(function()
    if setAutoTPVisual then setAutoTPVisual(autoTPEnabled == true) end
    if autoTPEnabled then startAutoTP() else stopAutoTP() end
    end)
    pcall(function()
    if setInfJumpVisual then setInfJumpVisual(infJumpEnabled == true) end
    if setInfJumpInternal then setInfJumpInternal(infJumpEnabled == true) end
    end)
    pcall(function()
    if setAntiRagdollVisual then setAntiRagdollVisual(antiRagdollEnabled == true) end
    if setAntiRagdoll then setAntiRagdoll(antiRagdollEnabled == true) end
    end)
    pcall(function()
    if _G.RyzenAntiVoidVisual then _G.RyzenAntiVoidVisual(_G.RyzenAntiVoidEnabled == true) end
    _G.RyzenAntiVoidSet(_G.RyzenAntiVoidEnabled == true)
    end)
    pcall(function()
    if _G.RyzenAntiResetVisual then _G.RyzenAntiResetVisual(_G.RyzenAntiResetEnabled == true) end
    _G.RyzenSetAntiReset(_G.RyzenAntiResetEnabled == true)
    end)
    pcall(function()
    if setAutoStealVisual then setAutoStealVisual(autoStealEnabled == true) end
    if _G.RyzenAutoStealSync then _G.RyzenAutoStealSync() end
    end)
    pcall(function()
    if setBatCounterVisual then setBatCounterVisual(batCounterEnabled == true) end
    if batCounterEnabled and _G.RyzenStartBatCounter then _G.RyzenStartBatCounter() elseif _G.RyzenStopBatCounter then _G.RyzenStopBatCounter() end
    end)
    pcall(function()
    if setMedCounterVisual then setMedCounterVisual(medCounterEnabled == true) end
    if medCounterEnabled and _G.RyzenStartMedCounter then _G.RyzenStartMedCounter(LP.Character) elseif _G.RyzenStopMedCounter then _G.RyzenStopMedCounter() end
    end)
    pcall(function()
    if setHardHitVisual then setHardHitVisual(hardHitEnabled == true) end
    if hardHitEnabled and _G.RyzenStartHardHit then _G.RyzenStartHardHit() elseif _G.RyzenStopHardHit then _G.RyzenStopHardHit() end
    end)
    pcall(function()
    if setPerfectHitVisual then setPerfectHitVisual(perfectHitEnabled == true) end
    if perfectHitEnabled and _G.RyzenStartPerfectHit then _G.RyzenStartPerfectHit() elseif _G.RyzenStopPerfectHit then _G.RyzenStopPerfectHit() end
    end)
    pcall(function()
    if _G.RyzenSetNoPlayerCollisionVisual then _G.RyzenSetNoPlayerCollisionVisual(_G.RyzenNoPlayerCollisionEnabled == true) end
    if _G.RyzenNoPlayerCollisionEnabled then enableNoPlayerCollision() else disableNoPlayerCollision() end
    end)
    pcall(function()
    if setSafeModeVisual then setSafeModeVisual(antiKickEnabled == true) end
    end)
    pcall(function()
    if _G.RyzenSetAutoResetOnMed then _G.RyzenSetAutoResetOnMed(autoResetOnMedEnabled == true, true) end
    end)
    pcall(function()
    if setPlayerESPVisual then setPlayerESPVisual(espEnabled == true) end
    if espEnabled then if startPlayerESP then startPlayerESP() end else if stopPlayerESP then stopPlayerESP() end end
    end)
    pcall(function()
    if setTracerESPVisual then setTracerESPVisual(showTracerEnabled == true) end
    if BoxedESPOptions then BoxedESPOptions.tracer = showTracerEnabled == true end
    if refreshBoxedESP then refreshBoxedESP() end
    end)
    pcall(function()
    if setRagdollCountdownVisual then setRagdollCountdownVisual(ragdollCountdownEnabled == true) end
    if ragdollCountdownEnabled then
    hookRagdollCountdown(LP.Character)
    if _G.RyzenStartAllPlayerRagdoll then pcall(_G.RyzenStartAllPlayerRagdoll) end
    else
    stopRagdollCountdown()
    if _G.RyzenStopAllPlayerRagdoll then pcall(_G.RyzenStopAllPlayerRagdoll) end
    end
    end)
    pcall(function()
    if setFPSBoostVisual then setFPSBoostVisual(fpsBoostEnabled == true) end
    if fpsBoostEnabled then enableStretchRez() else disableStretchRez() end
    end)
    pcall(function()
    if setAntiLagVisual then setAntiLagVisual(antiLagVisualEnabled == true) end
    if antiLagVisualEnabled then enableAntiLag() else disableAntiLag() end
    end)
    pcall(function()
    if setAntiLagV2Visual then setAntiLagV2Visual(antiLagV2Enabled == true) end
    if antiLagV2Enabled then enableAntiLagV2() else disableAntiLagV2() end
    end)
    pcall(function()
    if setNukeOptimiserVisual then setNukeOptimiserVisual(nukeOptimiserEnabled == true) end
    if nukeOptimiserEnabled then enableNukeOptimizer() else disableNukeOptimizer() end
    end)
    pcall(function()
    if setFOVVisual then setFOVVisual(fovEnabled == true) end
    if fovEnabled then enableCustomFov() else disableCustomFov() end
    if setShinyGraphicsVisual then setShinyGraphicsVisual(shinyGraphicsEnabled == true) end
    if shinyGraphicsEnabled then enableShinyGraphics() else disableShinyGraphics() end
    end)
    pcall(function()
    if setNoCamCollisionVisual then setNoCamCollisionVisual(noCamCollisionEnabled == true) end
    if noCamCollisionEnabled then enableNoCamCollision() else disableNoCamCollision() end
    end)
    pcall(function()
    if type(applyCustomSky) == "function" then applyCustomSky((skyTheme and skyTheme ~= "") and skyTheme or "Off") end
    if skyValueLabel then skyValueLabel.Text = skyTheme or "Off" end
    end)
    pcall(function()
    if syncAnimationPackIndex then syncAnimationPackIndex() end
    if refreshAnimationPackRow then refreshAnimationPackRow() end
    if applySavedAnimationPackToCharacter then applySavedAnimationPackToCharacter(LP.Character) end
    end)
    end
    task.defer(function()
    task.wait(0.25)
    if _G.RyzenDuelsApplySavedGameplayStates then _G.RyzenDuelsApplySavedGameplayStates() end
    end)
    task.delay(1.25, function()
    if _G.RyzenDuelsApplySavedGameplayStates then _G.RyzenDuelsApplySavedGameplayStates() end
    end)
    task.delay(3, function()
    if antiLagVisualEnabled and type(applyKTMOptimization) == "function" then pcall(applyKTMOptimization) end
    if nukeOptimiserEnabled and type(applyKTMOptimization) == "function" then pcall(applyKTMOptimization) end
    end)
    _G.RyzenAutoTPRestoreWanted = _G.RyzenAutoTPRestoreWanted or false
    _G.RyzenAutoTPRestoreBlockedUntil = _G.RyzenAutoTPRestoreBlockedUntil or 0
    function aceAnyAimbotActive()
    return (_G.RyzenNormalAimbotOn == true) or (_G.RyzenAntiBypassAimbotOn == true)
    end
    _G.RyzenStopAutoTPForAction = function()
    if autoTPEnabled then
    _G.RyzenAutoTPRestoreWanted = true
    _G.RyzenAutoTPRestoreBlockedUntil = tick() + 0.35
    stopAutoTP()
    if setAutoTPVisual then setAutoTPVisual(false) end
    end
    end
    function aceTryRestoreAutoTP()
    if not _G.RyzenAutoTPRestoreWanted then return end
    if tick() < (_G.RyzenAutoTPRestoreBlockedUntil or 0) then return end
    if aceAnyAimbotActive() then return end
    if dropBrainrotActive then return end
    _G.RyzenAutoTPRestoreWanted = false
    startAutoTP()
    if setAutoTPVisual then setAutoTPVisual(true) end
    if saveRyzenConfig then pcall(saveRyzenConfig) end
    end
    RunService.Heartbeat:Connect(aceTryRestoreAutoTP)
    _G._oldRyzenStopNormalAimbot = _G.RyzenStopNormalAimbot
    _G.RyzenStopNormalAimbot = function(...)
    local r = {_G._oldRyzenStopNormalAimbot(...)}
    _G.RyzenAutoTPRestoreBlockedUntil = tick() + 0.05
    task.delay(0.08, aceTryRestoreAutoTP)
    return unpack(r)
    end
    _G.RyzenNormalAimbotStop = _G.RyzenStopNormalAimbot
    _G._oldRyzenStopAntiBypassAimbot = _G.RyzenStopAntiBypassAimbot
    _G.RyzenStopAntiBypassAimbot = function(...)
    local r = {_G._oldRyzenStopAntiBypassAimbot(...)}
    _G.RyzenAutoTPRestoreBlockedUntil = tick() + 0.05
    task.delay(0.08, aceTryRestoreAutoTP)
    return unpack(r)
    end
    _G.RyzenAntiBypassStop = _G.RyzenStopAntiBypassAimbot
    task.spawn(function()
    local wasDropping = false
    while task.wait(0.05) do
    if dropBrainrotActive then
    wasDropping = true
    elseif wasDropping then
    wasDropping = false
    _G.RyzenAutoTPRestoreBlockedUntil = tick() + 0.05
    task.delay(0.08, aceTryRestoreAutoTP)
    end
    end
    end)
    function aceRepairKeybinds()
    for keyId, defaultKey in pairs(DEFAULT_SPEED_KEYBINDS) do
    if speedKeybinds[keyId] == nil or speedKeybinds[keyId] == Enum.KeyCode.Unknown then
    speedKeybinds[keyId] = defaultKey
    end
    end

    if tpDownKeybind == Enum.KeyCode.Unknown then tpDownKeybind = DEFAULT_TP_DOWN_KEYBIND end
    if refreshAllSpeedKeybinds then refreshAllSpeedKeybinds() end
    if refreshTPDownKeybind then refreshTPDownKeybind() end
    end
    _G._oldSaveRyzenConfigStable = saveRyzenConfig
    saveRyzenConfig = function()
    aceRepairKeybinds()
    return _G._oldSaveRyzenConfigStable()
    end
    aceRepairKeybinds()
    task.defer(function()
    task.wait(0.2)
    aceRepairKeybinds()
    do end
    end)
    task.defer(function()
    task.wait(0.35)
    local TS = game:GetService("TweenService")
    for _, oldName in ipairs({"RyzenMobileButtons", "RyzenMobileButtons"}) do
    local old = PlayerGui:FindFirstChild(oldName)
    if old then old:Destroy() end
    end
    local mobileGui = Instance.new("ScreenGui")
    mobileGui.Name = "RyzenMobileButtons"
    mobileGui.ResetOnSpawn = false
    mobileGui.IgnoreGuiInset = true
    mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mobileGui.DisplayOrder = 1000
    safeParentGui(mobileGui)
    mobileGui.Enabled = not (_G.RyzenHideMobileButtons == true)
    _G.RyzenMobileButtonRefs = {}
    local mobileButtons = _G.RyzenMobileButtonRefs
    function _G.RyzenApplyMobileButtonsHidden()
    local shouldHide = (_G.RyzenHideMobileButtons == true)

    local g = nil
    pcall(function()
        g = PlayerGui:FindFirstChild("RyzenMobileButtons")
    end)

    if not g then
        pcall(function()
            local cg = game:GetService("CoreGui")
            g = cg and cg:FindFirstChild("RyzenMobileButtons")
        end)
    end

    if not g and gethui then
        pcall(function()
            local hui = gethui()
            g = hui and hui:FindFirstChild("RyzenMobileButtons")
        end)
    end

    if not g and mobileGui and mobileGui.Parent then
        g = mobileGui
    end

    if g then
        g.Enabled = not shouldHide
    end

    if setHideMobileButtonsVisual then
        pcall(setHideMobileButtonsVisual, shouldHide)
    end
    end
    local function normalizeMobileImage(value)
    value = tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if value == "" then return "" end
    local id = value:match("^(%d+)$")
    if id then return "rbxassetid://" .. id end
    local embedded = value:match("[?&]id=(%d+)") or value:match("/(%d+)[/%?]?")
    if embedded then return "rbxassetid://" .. embedded end
    return value
    end
    function _G.RyzenApplyMobileButtonImage()
    local image = normalizeMobileImage(_G.RyzenMobileButtonImage)
    for _, entry in pairs(mobileButtons) do
    local btn = entry and entry.btn
    local img = btn and btn:FindFirstChild("MobileBackgroundImage")
    if img then
    img.Image = image
    img.ImageColor3 = _G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE
    img.Visible = image ~= ""
    end
    end
    end
    function _G.RyzenApplyMobileButtonShape()
    local shape = tostring(_G.RyzenMobileButtonShape or "ROUNDED"):upper()
    if shape ~= "CIRCLE" and shape ~= "SQUARE" and shape ~= "ROUNDED" then shape = "ROUNDED" end
    _G.RyzenMobileButtonShape = shape
    for key, entry in pairs(mobileButtons) do
    local btn = entry and entry.btn
    local holder = entry and entry.holder
    if btn and holder then
    local isSquare = shape == "SQUARE"
    holder.Size = UDim2.new(0,58,0,58)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 10
    local textOverlay = btn:FindFirstChild("MobileButtonText")
    if textOverlay then
    textOverlay.Font = btn.Font
    textOverlay.TextSize = btn.TextSize
    end
    local radius = UDim.new(0,10)
    if shape == "CIRCLE" then radius = UDim.new(1,0) end
    if isSquare then radius = UDim.new(0,10) end
    local c = btn:FindFirstChildOfClass("UICorner")
    if c then c.CornerRadius = radius end
    local img = btn:FindFirstChild("MobileBackgroundImage")
    local ic = img and img:FindFirstChildOfClass("UICorner")
    if ic then ic.CornerRadius = radius end
    local glow = holder:FindFirstChild("Glow")
    local gc = glow and glow:FindFirstChildOfClass("UICorner")
    if gc then gc.CornerRadius = radius end
    local dot = btn:FindFirstChild("Dot")
    if isSquare then
    if not dot then
    dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(1, -12, 0, 7)
    dot.BackgroundColor3 = Color3.fromRGB(80,80,95)
    dot.BorderSizePixel = 0
    dot.ZIndex = btn.ZIndex + 2
    dot.Parent = btn
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    end
    dot.Visible = true
    else
    if dot then dot.Visible = false end
    end
    end
    end
    end
    function _G.RyzenApplyMobileButtonSize()
    _G.RyzenMobileButtonScale = math.clamp(tonumber(_G.RyzenMobileButtonScale) or 1.00, 0.30, 1.35)
    for _, entry in pairs(mobileButtons) do
    local holder = entry and entry.holder
    if holder then
    local sc = holder:FindFirstChild("MobileButtonScale") or Instance.new("UIScale")
    sc.Name = "MobileButtonScale"
    sc.Scale = _G.RyzenMobileButtonScale
    sc.Parent = holder
    end
    end
    pcall(function()
    local gui = PlayerGui:FindFirstChild("RyzenDuelsRyzenReconstruct") or PlayerGui:FindFirstChild("RyzenHubPolished") or PlayerGui:FindFirstChild("RyzenHub")
    local root = gui or PlayerGui
    for _, obj in ipairs(root:GetDescendants()) do
    if obj.Name == "Mobile Buttons Size" then
    local valueBox = obj:FindFirstChild("Value")
    if valueBox and valueBox:IsA("TextLabel") then
    valueBox.Text = string.format("%.2f", _G.RyzenMobileButtonScale)
    end
    end
    end
    end)
    end
    local function setActive(btn, state)
    if not btn then return end
    local pressed = btn:GetAttribute("RyzenMobilePressed") == true
    state = (state == true) or pressed
    local visualState = state and "on" or "off"
    if btn:GetAttribute("RyzenMobileVisualState") == visualState then return end
    btn:SetAttribute("RyzenMobileVisualState", visualState)
    local holder = btn.Parent
    local glow = holder and holder:FindFirstChild("Glow")
    local st = btn:FindFirstChildOfClass("UIStroke")
    local textOverlay = btn:FindFirstChild("MobileButtonText")
    local noneBg = btn:FindFirstChild("ButtonNoneBackground")
    local noneGrad = noneBg and noneBg:FindFirstChild("ButtonNoneGradient")
    local dot = btn:FindFirstChild("Dot")
    if noneGrad then noneGrad.Enabled = not state end
    if noneBg then
    TS:Create(noneBg,TweenInfo.new(0.18),{
    BackgroundColor3 = state and Color3.fromRGB(220,220,220) or Color3.fromRGB(255,255,255)
    }):Play()
    end
    if textOverlay then
    TS:Create(textOverlay, TweenInfo.new(0.18), {
    TextColor3 = state and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255),
    }):Play()
    end
    if st then
    TS:Create(st, TweenInfo.new(0.18), {
    Color = Color3.fromRGB(0,0,0),
    Thickness = 1,
    Transparency = 0,
    }):Play()
    end
    if dot and dot.Visible then
    TS:Create(dot, TweenInfo.new(0.16), {
    BackgroundColor3 = state and Color3.fromRGB(0,0,0) or Color3.fromRGB(80,80,95),
    }):Play()
    end
    if glow then
    glow.Visible = false
    glow.BackgroundTransparency = 1
    local gs = glow:FindFirstChildOfClass("UIStroke")
    if gs then gs.Transparency = 1 end
    end
    end
    local function pulse(btn)
    if not btn then return end
    btn:SetAttribute("RyzenMobilePressed", true)
    setActive(btn, true)
    task.delay(0.18, function()
    if btn and btn.Parent then
    btn:SetAttribute("RyzenMobilePressed", false)
    setActive(btn, false)
    end
    end)
    end
    -- FIX: keep mobile buttons (especially the wide INSTANT RESET one) on screen.
    -- Dragging could push a button off the edge, then it could not be grabbed
    -- back. Every drag, restore and reset now clamps inside the viewport.
    local function _mobileButtonDims(key)
    return 58, 58
    end
    local function _mobileScreen()
    local ok, cam = pcall(function() return workspace.CurrentCamera end)
    if ok and cam and cam.ViewportSize then return cam.ViewportSize end
    return Vector2.new(1280, 720)
    end
    local function _clampMobilePosition(ud, ww, hh)
    local vp = _mobileScreen()
    ww = ww or 58
    hh = hh or 58
    local m = 8
    local ax = (ud and ud.X and (ud.X.Scale * vp.X + ud.X.Offset)) or 0
    local ay = (ud and ud.Y and (ud.Y.Scale * vp.Y + ud.Y.Offset)) or 0
    ax = math.clamp(ax, m, math.max(m + 1, vp.X - ww - m))
    ay = math.clamp(ay, m, math.max(m + 1, vp.Y - hh - m))
    return UDim2.new(0, ax, 0, ay)
    end
    local function makeButton(key, label, pos, onPress, customSize)
    local holder = Instance.new("Frame")
    holder.Name = "MBH_" .. key
    holder.Size = customSize or UDim2.new(0,58,0,58)
    local _mw, _mh = _mobileButtonDims(key)
    holder.Position = _clampMobilePosition(getSavedMobileButtonPosition(key, pos), _mw, _mh)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.ZIndex = 1000
    holder.Active = true
    holder.Parent = mobileGui
    local glow = Instance.new("Frame", holder)
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 4, 1, 4)
    glow.Position = UDim2.new(0, -2, 0, -2)
    glow.BackgroundColor3 = Color3.fromRGB(255,255,255)
    glow.BackgroundTransparency = 1
    glow.BorderSizePixel = 0
    glow.ZIndex = 1000
    Instance.new("UICorner", glow).CornerRadius = UDim.new(0, 13)
    local glowStroke = Instance.new("UIStroke", glow)
    glowStroke.Color = Color3.fromRGB(255,255,255)
    glowStroke.Thickness = 0.8
    glowStroke.Transparency = 1
    glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local btn = Instance.new("TextButton", holder)
    btn.Name = "MB_" .. key
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.TextWrapped = true
    btn.AutoButtonColor = false
    btn.ZIndex = 1002
    btn.Active = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local noneBg = Instance.new("ImageLabel", btn)
    noneBg.Name = "ButtonNoneBackground"
    noneBg.Size = UDim2.new(1,0,1,0)
    noneBg.Position = UDim2.new(0,0,0,0)
    noneBg.BackgroundColor3 = Color3.fromRGB(5,5,7)
    noneBg.BorderSizePixel = 0
    noneBg.ZIndex = btn.ZIndex
    noneBg.Parent = btn
    Instance.new("UICorner", noneBg).CornerRadius = UDim.new(0,10)

    local noneGrad = Instance.new("UIGradient", noneBg)
    noneGrad.Name = "ButtonNoneGradient"
    noneGrad.Rotation = 25
    noneGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(18,18,21)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(3,3,4)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(12,12,14))
    })

    local bgImage = Instance.new("ImageLabel", btn)
    bgImage.Name = "MobileBackgroundImage"
    bgImage.BackgroundTransparency = 1
    bgImage.BorderSizePixel = 0
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.Position = UDim2.new(0, 0, 0, 0)
    bgImage.Image = normalizeMobileImage(_G.RyzenMobileButtonImage)
    bgImage.ImageColor3 = _G.RyzenThemeColors[_G.RyzenThemeName] or _G.RyzenThemeColors.WHITE
    bgImage.ImageTransparency = 0.18
    bgImage.ScaleType = Enum.ScaleType.Crop
    bgImage.Visible = bgImage.Image ~= ""
    bgImage.ZIndex = btn.ZIndex
    local bgCorner = Instance.new("UICorner", bgImage)
    bgCorner.CornerRadius = UDim.new(0,10)
    local textOverlay = Instance.new("TextLabel", btn)
    textOverlay.Name = "MobileButtonText"
    textOverlay.BackgroundTransparency = 1
    textOverlay.Size = UDim2.new(1, -8, 1, -8)
    textOverlay.Position = UDim2.new(0, 4, 0, 4)
    textOverlay.Text = label
    textOverlay.TextColor3 = Color3.fromRGB(255,255,255)
    textOverlay.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    textOverlay.TextStrokeTransparency = 1
    textOverlay.Font = Enum.Font.GothamBlack
    textOverlay.TextSize = 11
    textOverlay.TextWrapped = true
    textOverlay.TextXAlignment = Enum.TextXAlignment.Center
    textOverlay.TextYAlignment = Enum.TextYAlignment.Center
    textOverlay.ZIndex = btn.ZIndex + 1
    local mobileTextStroke = Instance.new("UIStroke", textOverlay)
    mobileTextStroke.Thickness = 1.4
    mobileTextStroke.Transparency = 0
    btn.TextTransparency = 1
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0,0,0)
    stroke.Thickness = 1
    stroke.Transparency = 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local pressing, dragging = false, false
    local pressPos, holderStart = nil, nil
    btn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
    pressing = true
    dragging = false
    pressPos = i.Position
    holderStart = holder.Position
    btn:SetAttribute("RyzenMobilePressed", true)
    setActive(btn, true)
    pcall(function()
    TS:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0, 4),
    Size = UDim2.new(1, 0, 1, -4)
    }):Play()
    end)
    end
    end)
    btn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
    if pressing and not dragging then pcall(onPress, btn) end
    if dragging then do end end
    pressing = false
    dragging = false
    btn:SetAttribute("RyzenMobilePressed", false)
    pcall(function()
    TS:Create(btn, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0)
    }):Play()
    end)
    task.delay(0.08, function()
    if btn and btn.Parent then
    local keepOn = false
    if key == "autoLeft" then keepOn = autoLeftEnabled == true
    elseif key == "autoRight" then keepOn = autoRightEnabled == true
    elseif key == "aimbot" then keepOn = (_G.RyzenNormalAimbotOn == true) or (_G.RyzenAntiBypassAimbotOn == true)
    elseif key == "tpBat" then keepOn = _G.RyzenTPBatEnabled == true
    elseif key == "carry" then keepOn = currentSpeedMode == "Carry"
    elseif key == "laggerNormal" then keepOn = currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry"

    elseif key == "laggerCarry" then keepOn = currentSpeedMode == "Lagger Carry"
    end
    setActive(btn, keepOn)
    end
    end)
    end
    end)
    UserInputService.InputChanged:Connect(function(i)
    if _G.RyzenGuiLocked == true or not pressing then return end
    if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = i.Position - pressPos
    if not dragging and (math.abs(delta.X) > 6 or math.abs(delta.Y) > 6) then dragging = true end
    if dragging then
    local vp = _mobileScreen()
    local ww = holder.AbsoluteSize.X
    local hh = holder.AbsoluteSize.Y
    if ww <= 0 or hh <= 0 then ww, hh = _mobileButtonDims(key) end
    local ax = holderStart.X.Scale * vp.X + holderStart.X.Offset + delta.X
    local ay = holderStart.Y.Scale * vp.Y + holderStart.Y.Offset + delta.Y
    holder.Position = _clampMobilePosition(UDim2.new(0, ax, 0, ay), ww, hh)
    saveMobileButtonPosition(key, holder.Position)
    end
    end)
    mobileButtons[key] = {holder = holder, btn = btn, setActive = function(state) setActive(btn, state) end}
    return btn
    end

    local RyzenResetCooldown = false
    local RyzenResetThread = nil
    local RyzenResetCharacter = nil
    local RyzenResetSuccessful = false
    local RyzenStopResetSequence = false
    local RyzenCameraLocked = false
    local RyzenLockedCameraCFrame = nil
    local RyzenResetMaxDuration = 0.05

    function _G.RyzenInstantReset()
    if RyzenResetCooldown then return end
    RyzenResetCooldown = true
    RyzenResetSuccessful = false
    RyzenStopResetSequence = false
    RyzenCameraLocked = false

    local character = LP.Character
    if not character then
    RyzenResetCooldown = false
    return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
    RyzenResetCooldown = false
    return
    end

    local camera = workspace.CurrentCamera
    if camera then
    RyzenLockedCameraCFrame = camera.CFrame
    RyzenCameraLocked = true
    camera.CFrame = RyzenLockedCameraCFrame
    end

    RyzenResetCharacter = character
    local isRespawning = false

    RyzenResetThread = task.spawn(function()
    local attempts = 0
    local maxAttempts = 40
    local originalHipHeight = humanoid.HipHeight

    while character and character.Parent and humanoid and humanoid.Health > 0 and not isRespawning and not RyzenStopResetSequence do
    if LP.Character ~= character then
    isRespawning = true
    break
    end

    pcall(function()
    humanoid.HipHeight = 1e30
    humanoid.AutoRotate = true

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
    rootPart.CanCollide = false
    end

    for _, part in ipairs(character:GetChildren()) do
    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
    part.CanCollide = false
    end
    end
    end)

    if not character or not character.Parent or not humanoid or humanoid.Health <= 0 or LP.Character ~= character then
    RyzenResetSuccessful = true
    break
    end

    attempts += 1
    if attempts >= maxAttempts then break end
    task.wait(RyzenResetMaxDuration)
    end

    if not RyzenResetSuccessful and character and character.Parent and humanoid and humanoid.Health > 0 and not isRespawning then
    pcall(function()
    humanoid.Health = 0
    end)
    task.wait(0.1)
    if not character.Parent or humanoid.Health <= 0 then
    RyzenResetSuccessful = true
    end
    end

    if not RyzenResetSuccessful and character and character.Parent and humanoid then
    pcall(function()
    humanoid.HipHeight = originalHipHeight
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
    rootPart.CanCollide = true
    end
    for _, part in ipairs(character:GetChildren()) do
    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
    part.CanCollide = true
    end
    end
    end)
    end

    RyzenCameraLocked = false
    RyzenResetCooldown = false
    RyzenResetThread = nil
    RyzenResetCharacter = nil
    RyzenStopResetSequence = false
    end)
    end

    function _G.RyzenStopInstantReset()
    RyzenStopResetSequence = true
    if RyzenResetThread then
    pcall(task.cancel, RyzenResetThread)
    RyzenResetThread = nil
    end
    RyzenResetCooldown = false
    RyzenResetCharacter = nil
    RyzenCameraLocked = false
    end

    LP.CharacterAdded:Connect(function()
    _G.RyzenStopInstantReset()
    RyzenResetSuccessful = false
    RyzenStopResetSequence = false
    RyzenCameraLocked = false
    end)

    RunService.RenderStepped:Connect(function()
    if RyzenCameraLocked and RyzenLockedCameraCFrame and workspace.CurrentCamera then
    workspace.CurrentCamera.CFrame = RyzenLockedCameraCFrame
    end
    end)

    local defaults = {
    drop         = UDim2.new(1,-132,0.5,-161),
    autoRight    = UDim2.new(1,-66, 0.5,-161),
    aimbot       = UDim2.new(1,-132,0.5,-95),
    autoLeft     = UDim2.new(1,-66, 0.5,-95),
    tp           = UDim2.new(1,-132,0.5,-29),
    laggerNormal = UDim2.new(1,-66, 0.5,-29),
    carry        = UDim2.new(1,-66, 0.5,37),
    -- TP Bat uses the existing lower-left position.
    tpBat        = UDim2.new(1,-132,0.5,103),
    }

    function _G.RyzenResetMobileButtons()
    _G.RyzenMobileButtonScale = RyzenAutoMobile and 0.90 or 1.00
    _G.RyzenMobileButtonImage = ""
    _G.RyzenHideMobileButtons = false
    _G.RyzenMobileButtonShape = "ROUNDED"
    _G.RyzenMobileButtonPositions = {}
    for key, defaultPos in pairs(defaults) do
    local entry = mobileButtons[key]
    local holder = entry and entry.holder
    if holder then
    holder.Position = defaultPos
    end
    end
    _G.RyzenApplyMobileButtonSize()
    _G.RyzenApplyMobileButtonsHidden()
    _G.RyzenApplyMobileButtonShape()
    _G.RyzenApplyMobileButtonImage()
    _G.RyzenApplyMobileButtonShape()
    if type(saveRyzenConfig) == "function" then pcall(saveRyzenConfig) end
    end

    makeButton("drop", "DROP\nBRAINROT", defaults.drop, function(btn)
    if runDropBrainrot then runDropBrainrot() elseif runDrop then runDrop() end
    pulse(btn)
    end)

    makeButton("autoLeft", "AUTO LEFT", defaults.autoLeft, function()
    if _G.RyzenSetAutoLeft then _G.RyzenSetAutoLeft(not autoLeftEnabled) end
    end)

    makeButton("aimbot", "BAT AIMBOT", defaults.aimbot, function(btn)
    if _G.RyzenSafeModeIsLocked and _G.RyzenSafeModeIsLocked() then return end
    selectedAimbotMode = "Normal"
    if _G.RyzenToggleSelectedAimbot then _G.RyzenToggleSelectedAimbot() end
    task.delay(0.03, function()
    setActive(btn, _G.RyzenNormalAimbotOn == true)
    end)
    end)

    makeButton("autoRight", "AUTO RIGHT", defaults.autoRight, function()
    if _G.RyzenSetAutoRight then _G.RyzenSetAutoRight(not autoRightEnabled) end
    end)

    makeButton("laggerNormal", "LAGGER MODE", defaults.laggerNormal, function(btn)
    -- FIX: cycles exactly like the Lagger keybind (R key):
    -- Normal/Carry -> Lagger -> Lagger Carry -> Normal
    if _G.RyzenToggleLaggerMode then
    pcall(_G.RyzenToggleLaggerMode)
    elseif toggleLaggerMode then
    toggleLaggerMode()
    elseif setSpeedMode then
    if currentSpeedMode == "Lagger" then
    setSpeedMode("Lagger Carry")
    elseif currentSpeedMode == "Lagger Carry" then
    setSpeedMode("Normal")
    else
    setSpeedMode("Lagger")
    end
    end
    task.delay(0.03,function()
    setActive(btn,currentSpeedMode=="Lagger" or currentSpeedMode=="Lagger Carry")
    end)
    end)

    makeButton("tp", "TP DOWN", defaults.tp, function(btn)
    if runTPFloor then runTPFloor() end
    pulse(btn)
    end)

    makeButton("tpBat", "TP\nBAT", defaults.tpBat, function(btn)
    if _G.RyzenSetTPBat then
    _G.RyzenSetTPBat(not (_G.RyzenTPBatEnabled == true))
    end
    task.delay(0.03, function()
    setActive(btn, _G.RyzenTPBatEnabled == true)
    end)
    end)

    makeButton("carry", "CARRY SPEED", defaults.carry, function()
    if setSpeedMode then
    setSpeedMode(currentSpeedMode == "Carry" and "Normal" or "Carry")
    end
    end)

    _G.RyzenApplyMobileButtonSize()
    _G.RyzenApplyMobileButtonsHidden()

    task.spawn(function()
        while mobileGui and mobileGui.Parent do
            task.wait(8)
            if mobileGui and mobileGui.Parent and saveRyzenConfig then pcall(saveRyzenConfig) end
        end
    end)

    task.defer(function()
        task.wait(0.15)
        if mobileGui then
            mobileGui.Enabled = not (_G.RyzenHideMobileButtons == true)
        end
        pcall(_G.RyzenApplyMobileButtonsHidden)
    end)

    RunService.Heartbeat:Connect(function()
    if mobileButtons.autoLeft then mobileButtons.autoLeft.setActive(autoLeftEnabled == true) end
    if mobileButtons.autoRight then mobileButtons.autoRight.setActive(autoRightEnabled == true) end
    if mobileButtons.aimbot then mobileButtons.aimbot.setActive(_G.RyzenNormalAimbotOn == true) end
    if mobileButtons.carry then mobileButtons.carry.setActive(currentSpeedMode == "Carry") end
    if mobileButtons.laggerNormal then mobileButtons.laggerNormal.setActive(currentSpeedMode == "Lagger" or currentSpeedMode == "Lagger Carry") end
    end)
    end)


    task.defer(function()
    task.wait(1)
    pcall(function()
    _G.RyzenApplyMovingEdgeLights(PlayerGui)
    end)
    end)


    pcall(function()
    if hookfunction and newcclosure then
    local _xKickRemote = nil
    local _xOldFire
    _xOldFire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    if not _xKickRemote and typeof(self) == "Instance" and self:IsA("RemoteEvent") and self.Name:sub(1,3) == "RE/" then
    _xKickRemote = self
    end
    return _xOldFire(self, ...)
    end))
    end
    end)