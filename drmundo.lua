class "Mundo1"
 require 'DamageLib'
require 'Collision'
local QSpell = Collision:SetSpell(1000, 1500, .25, 75, true)
--local name_as_you_wish = Collision:SetSpell(range, speed, delay, width, hitBox)
function Mundo1:__init()
	if myHero.charName ~= "DrMundo" then return end
PrintChat("welcome")
self:LoadSpells()
PrintChat("spells loaded")
self:LoadMenu()
PrintChat("chat loaded")
Callback.Add("Tick", function() self:Tick() end)
Callback.Add("Draw", function() self:Draw() end)
end


local Icon = {
["icon"] = ""https://puu.sh/tq0A8/5b42557aa9.png"",
}

function Mundo1.LoadSpells()

	Q = { range = myHero:GetSpellData(_Q).range, delay = myHero:GetSpellData(_Q).delay, speed = myHero:GetSpellData(_Q).speed, width = myHero:GetSpellData(_Q).width }
	W = { range = myHero:GetSpellData(_W).range, delay = myHero:GetSpellData(_W).delay, speed = myHero:GetSpellData(_W).speed, width = myHero:GetSpellData(_W).width }
	E = { range = myHero:GetSpellData(_E).range, delay = myHero:GetSpellData(_E).delay, speed = myHero:GetSpellData(_E).speed, width = myHero:GetSpellData(_E).width }
	R = { range = myHero:GetSpellData(_R).range, delay = myHero:GetSpellData(_R).delay, speed = myHero:GetSpellData(_R).speed, width = myHero:GetSpellData(_R).width }
end

function Mundo1:LoadMenu()

--Main Menu

	self.Menu = MenuElement({type = MENU, id = "Mundo1", name = "Mundo1", leftIcon = Icons["icon"]})

--Combo Settings Menu

	self.Menu:MenuElement({type = MENU, id = "Combo", name = "Combo Settings"})
	self.Menu.Combo:MenuElement({id = "UseQ", name = "Use Q", value = true, leftIcon = Icons.Q})
	self.Menu.Combo:MenuElement({id = "UseW", name = "Use W", value = true, leftIcon = Icons.W})
	self.Menu.Combo:MenuElement({id = "UseE", name = "Use E", value = true, leftIcon = Icons.E})
	self.Menu.Combo:MenuElement({id = "UseR", name = "Use R", value = true, leftIcon = Icons.R})
	self.Menu.Combo:MenuElement({id = "ER", name = "Min enemies to use R", value = 1, min = 1, max = 5})
--Harass Settings Menu

	self.Menu:MenuElement({type = MENU, id = "Harass", name = "Harass Settings"})
	self.Menu.Harass:MenuElement({id = "UseQ", name = "Use Q", value = true, leftIcon = Icons.Q})
	self.Menu.Harass:MenuElement({id = "UseW", name = "Use W", value = true, leftIcon = Icons.W})
	self.Menu.Harass:MenuElement({id = "UseE", name = "Use E", value = true, leftIcon = Icons.E})

--LastHit 

	self.Menu:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
	self.Menu.LastHit:MenuElement({id = "UseQ", name = "Use Q", value = true, leftIcon = Icons.Q})
	

--misc
	self.Menu:MenuElement({type = MENU, id = "Misc", name = "Misc"})
		if myHero:GetSpellData(4).name == "SummonerDot" or myHero:GetSpellData(5).name == "SummonerDot" then
			self.Menu.Misc:MenuElement({id = "UseIgnite", name = "Use Ignite", value = true})
		end

--Drawings Settings Menu

	self.Menu:MenuElement({type = MENU, id = "Drawings", name = "Drawing Settings"})
	self.Menu.Drawings:MenuElement({id = "drawW", name = "Draw W Range", value = true})
	self.Menu.Drawings:MenuElement({id = "drawQ", name = "Draw Q Range", value = true})
end

function Mundo1:Tick()
	if myHero.dead then return end
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] then
			self:Combo()
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] then
			self:Harass()
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] then
    		self:LastHit()
		end
	self:Misc()
end

function Mundo1:Draw()
	if myHero.dead then return end
	if(self.Menu.Drawings.drawW:Value())then
		Draw.Circle(myHero, W.range, 3, Draw.Color(255, 225, 255, 10))
	end
	if(self.Menu.Drawings.drawQ:Value())then
		Draw.Circle(myHero, 1000, 3, Draw.Color(225, 225, 0, 100))
	end
end
--Combo 
function Mundo1:Combo()
	--if _G.SDK.TargetSelector:GetTarget(1000) == false then return end
	if self.Menu.Combo.UseQ:Value() and self:CanCast(_Q) then
    	self:CastQ(qtarg)
    end

	if self.Menu.Combo.UseE:Value() and self:CanCast(_E) then
		self:CastE(etarg)
	end

	if self.Menu.Combo.UseW:Value() and self:CanCast(_W) then
		self:CastW(wtarg)
	end

	if self.Menu.Combo.UseR:Value() and self:CanCast(_R) then
    	self:CastR(rtarg)
    end
end
