--------------------------------------------------------------------------------------------
-------------------------------- Girls mod ver:1.0-A :D ------------------------------------
--------------------------------------------------------------------------------------------
--Mod by Pinkysnowman                                                                     --
--(c)2015 WTFPL                                                                           --
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

local mod_ver = "1.0-A"
local print_out ={}
local girls_names = {"Kandy","Jenna","Lexus"}

minetest.register_privilege("get_girls", {
	description = "Girls privilege!", 
	give_to_singleplayer = true
})

for i=1,3 do
	girls_def = {
		physical = true,
		collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
		visual = "mesh",
		mesh = "characterf.b3d",
		textures = {"girls_"..i..".png"},
		girls_anim = 0,
		timer = 0,
		rotate_timer = 0,
		vec = 0,
		yaw = 0,
		follow = 0
	}
	girls_def.on_activate = function(self)
		self.anim = {
			stand_START = 0,
			stand_END = 79,
			sit_START = 81,
			sit_END = 160,
			lay_START = 162,
			lay_END = 166,
			walk_START = 168,
			walk_END = 187,
			mine_START = 189,
			mine_END = 198,
			walk_mine_START = 200,
			walk_mine_END = 219
		}
		self.object:set_animation({x=self.anim.stand_START,y=self.anim.stand_END}, 30, 0)
		self.girls_anim = 1
		self.object:setacceleration({x=0,y=-10,z=0})
		self.object:set_hp(20)
	end
	girls_def.on_punch = function(self, puncher)
		if self.object:get_hp() == 0 then
		    local obj = minetest.add_item(self.object:getpos(), "girls:girl_caller")
		end
	end
	girls_def.on_step = function(self, dtime)
		self.timer = self.timer + 0.01
		self.rotate_timer = self.rotate_timer + 0.01
		if 1 == 1 then
			self.follow = true
			for  _,object in ipairs(minetest.get_objects_inside_radius(self.object:getpos(), 7)) do
				if object:is_player() then
					self.follow = false
					girls = self.object:getpos()
					PLAYER = object:getpos()
					self.vec = {x=PLAYER.x-girls.x, y=PLAYER.y-girls.y, z=PLAYER.z-girls.z}
					self.lookdir = math.atan(self.vec.z/self.vec.x)+math.pi^2
					if PLAYER.x > girls.x then
						self.lookdir = self.lookdir + math.pi
					end
					self.lookdir = self.lookdir - 2
					self.object:setyaw(self.lookdir)
				end
			end
			if self.rotate_timer > math.random(1,4) and follow == true then
				self.lookdir = 360 * math.random()
				self.object:setyaw(self.lookdir)
				self.rotate_timer = 0
			end
			self.object:setvelocity({x=0,y=self.object:getvelocity().y,z=0})
		end
	end
	table.insert(print_out, "*"..girls_names[i].." will be at the party!")
	minetest.register_entity("girls:girl_"..i, girls_def)
end

minetest.register_alias("girl", "girls:girl_caller")

minetest.register_node("girls:girl_caller", {
	description = "Default NPC Summoner",
	image = "girls_caller.png",
	inventory_image = "girls_caller.png",
	wield_image = "girls_caller.png",
	paramtype = "light",
	tiles = {"girls_box.png"},
	is_ground_content = true,
	drawtype = "glasslike",
	groups = {crumbly=3},
	selection_box = {
		type = "fixed",
		fixed = {0,0,0,0,0,0}
	},
	--sounds = default.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed)
		local name = placer:get_player_name()
		if (minetest.check_player_privs(name, {get_girls=true})) then
            pos = pointed.above
            pos.y = pos.y + 1
        minetest.add_entity(pointed.above,"girls:girl_"..math.random(1,3))
        itemstack:take_item(1)
	else
		minetest.chat_send_player(name, "Nope! You don't have the get_girls priv!!!")
	end
	return itemstack
end})

print("\n[MOD] [Girsl] [ver:"..mod_ver.."] loading......"..
	  "\n[MOD] [Girsl]		\\    //  \\    //  \\    //	"..
	  "\n[MOD] [Girls]		 \\  //    \\  //    \\  // 	"..
	  "\n[MOD] [Girls]		  \\//      \\//      \\//  	"..
	  "\n[MOD] [Girls]		  //\\      //\\      //\\   	"..
	  "\n[MOD] [Girls]		 //  \\    //  \\    //  \\ 	"..
	  "\n[MOD] [Girls]		//    \\  //    \\  //    \\	"..
	  "\n[MOD] [Girls] A mod by PinkySnowman "..
	  "\n[MOD] [Girls] Rated T (for teen)"..
	  "\n[MOD] [Girls] "..table.concat(print_out,"\n[MOD] [Girsl] ").."\n")