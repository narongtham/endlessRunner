local audio = require("audio")
local physics = require("physics")
physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,40)


display.setStatusBar(display.HiddenStatusBar)


local _W = display.viewableContentWidth
local _H = display.viewableContentHeight


 speed = 9  -- default = 9
 isPause = false



-- include bg --
--[[]]--


-- include flore --
local flore1 = display.newImageRect("Img/flore.jpg", 10589, 13)
flore1.x = flore1.width/2 
flore1.y = _H-147
flore1.type = "flore"

local flore2 = display.newImageRect("Img/flore.jpg", 10589, 13)
flore2.x = flore1.x + flore2.width
flore2.y = _H-147
flore2.type = "flore"

local bg1 = display.newImageRect("Img/bg.jpg", 10589, 768)
bg1.x = bg1.width/2 
bg1.y = _H/2

local bg2 = display.newImageRect("Img/bg.jpg", 10589, 768)
bg2.x = bg1.x + bg2.width
bg2.y = _H/2



-- include front_bg --
local frontbg1 = display.newImageRect("Img/front_bg.png", 10589, 768)
frontbg1.x = frontbg1.width/2 
frontbg1.y = _H/2

local frontbg2 = display.newImageRect("Img/front_bg.png", 10589, 768)
frontbg2.x = frontbg1.x + frontbg2.width
frontbg2.y = _H/2


-- include minror --
local minror1 = display.newImageRect("Img/minror.png", 10589, 768)
minror1.x = minror1.width/2 
minror1.y = _H/2

local minror2 = display.newImageRect("Img/minror.png", 10589, 768)
minror2.x = minror1.x + minror2.width
minror2.y = _H/2


-- end include bg --




-- include MMX --

local options = {width = 198, height = 300, numFrames = 76}
local imageSheet = graphics.newImageSheet( "img/sprite/MMX3.png", options )
local sequenceData = { 
	{name = "stand", start = 56, count = 5, time = 1000, loopDirection = "bounce"},
	{name = "prerun", start = 61, count = 2, time = 150 , loopCount = 1},
	{name = "run", start = 63, count = 14, time = 1000},
	{name = "enter", start = 40, count = 17, time = 1000, loopCount = 1},
	{name = "warp", start = 39, count = 1},
	{name = "jump", start = 28, count = 8, time = 800, loopCount = 1},
	{name = "jumpShoot" , start = 17, count = 8, time = 800, loopCount = 1},
	{name = "runShoot" , start = 3, count = 14, time = 1000}
}
MMX = display.newSprite( imageSheet, sequenceData )
MMXshoot = display.newSprite( imageSheet, sequenceData )
MMX.isJumpable = true
MMX.type = "MMX"
MMXshoot.type = "MMX"
MMXshoot.alpha = 0
MMX.alpha = 0
MMX.isShoot = false


local busterOption = {width = 80 , height = 80, numFrames = 10}
local busterImageSheet = graphics.newImageSheet( "img/sprite/buster.png", busterOption )
local busterSequenceData = {
	{name = "blast", start = 1, count = 5, time = 200, loopCount = 1},
	{name = "buster", start = 6, count = 5, time = 500}
}

local eOption = {width = 198, height = 300, numFrames = 25}
local enemyImageSheet = graphics.newImageSheet( "img/sprite/E_E.png", eOption )
local enemySequenceData = {
	{name = "enemyRun", start = 19 , count = 7 , time = 500},
	{name = "explote", start = 1 , count = 18 , time = 500, loopCount = 1}
}
enemy = display.newSprite( enemyImageSheet, enemySequenceData )
 enemy.alpha = 0
 enemyPeriod = 10
 lastEnemy = os.time()


-- end include MMX --

--[[
MMX2 = display.newSprite( imageSheet, sequenceData )
physics.addBody( MMX2, "kinematic", {bounce=0.0 , shape = MMXShape} )
MMX2.x = _W * 0.25
MMX2.y = (_H * 0.8) 
MMX2:setLinearVelocity(1600,0.0)
]]

txtPause = display.newText( "Pause", 0,0, "Helvetica", 24 )
txtPause.x = _W - 70
txtPause.y =  40 

txtJump = display.newText( "Jump", 0,0, "Helvetica" , 24 )
txtJump.x = _W - 70
txtJump.y =  100 

txtShoot = display.newText( "Shoot", 0,0, "Helvetica" , 24 )
txtShoot.x = _W - 70
txtShoot.y =  140 



-- bg to Front --
frontbg1:toFront( )
frontbg2:toFront( )
minror1:toFront( )
minror2:toFront( )
txtPause:toFront( )
txtShoot:toFront( )
txtJump:toFront( )


-- physic flore --
local floreShape = { -5294.5, -6.5, 1115294.5, 6.5, 5294.5, 100, -5294.5, 100 }

 
 physics.addBody(flore1,"static", {bounce=0.0, shape = floreShape})
 physics.addBody(flore2,"static", {bounce=0.0, shape = floreShape})




	-- sub function update bg and eliment -- 
	function updateBg()
		if bg1.x < bg2.x then
			bg1.x = bg1.x - speed
			bg2.x = bg1.x + bg2.width
			if bg1.x <= (-1 * bg1.width/2) then
				bg1.x = bg2.x + bg1.width
			end
		else
			bg2.x = bg2.x - speed
			bg1.x = bg2.x + bg1.width
			if bg2.x <= (-1 * bg2.width/2) then
				bg2.x = bg1.x + bg2.width
			end
		end
	end


	function updateFlore()
		if flore1.x < flore2.x then
			flore1.x = flore1.x - speed
			flore2.x = flore1.x + flore2.width

			if flore1.x <= (-1 * flore1.width/2) then
				flore1.x = flore2.x + flore1.width
			end
		else
			flore2.x = flore2.x - speed
			flore1.x = flore2.x + flore1.width
			if flore2.x <= (-1 * flore2.width/2) then
				flore2.x = flore1.x + flore2.width
			end
		end
	end

	function updateFront() 
		if frontbg1.x < frontbg2.x then
			frontbg1.x = frontbg1.x - speed
			frontbg2.x = frontbg1.x + frontbg2.width
			if frontbg1.x <= (-1 * frontbg1.width/2) then
				frontbg1.x = frontbg2.x + frontbg1.width
			end
		else
			frontbg2.x = frontbg2.x - speed
			frontbg1.x = frontbg2.x + frontbg1.width
			if frontbg2.x <= (-1 * frontbg2.width/2) then
				frontbg2.x = frontbg1.x + frontbg2.width
			end
		end
	end

	function  updateMinror()
		if minror1.x < minror2.x then
			minror1.x = minror1.x - speed
			minror2.x = minror1.x + minror2.width

			if minror1.x <= (-1 * minror1.width/2) then
				minror1.x = minror2.x + minror1.width
			end
		else
			minror2.x = minror2.x - speed
			minror1.x = minror2.x + minror1.width
			if minror2.x <= (-1 * minror2.width/2) then
				minror2.x = minror1.x + minror2.width
			end
		end
	end
	-- end sub function update bg and eliment -- 



-- animate MMX --

function  ready ( )
	readytxt = display.newEmbossedText( "Ready!!", 0,0, "Helvetica", 72 )
	readytxt:setFillColor( 0.2 , 0.2 ,0.9)
	readytxt.x = _W * 0.5
	readytxt.y = _H * 0.5
	readytxt.alpha = 0
	transition.to( readytxt, {time = 500, alpha = 1, onComplete = readyOut} )
	MMX.isJumpable = false
end

function readyOut( obj )
		transition.to( obj, {time = 200,delay = 1000, alpha = 0 , onComplete = MMXwarp} )
		MMX.isJumpable = false
end

function MMXwarp(obj)
	display.remove(readytxt)

	local MMXShape = { -59, -50, 39, -50, 39, 100, -59,  100}
	physics.addBody( MMX, "dynamic", {bounce=0.0 , density = 0.0 , shape = MMXShape } )

	MMX.isFixedRotation = true -- คำสั่งไม่ให้วัตถุหมุนไปตามแรงโน้มถ่วง
	MMX:addEventListener( "collision", MMXcollides )
	MMX.isJumpable = false
	MMX.alpha = 1


	MMX.x = _W * 0.4
	MMX.y = -200
	MMX:setSequence( "warp" )
	MMX:play( )
	transition.to( MMX , { time = 450, y = _H - 270, onComplete = MMXenter} ) --_H - 270,


end

function MMXenter( obj )
	MMX:setSequence( "enter" )
	MMX:play( )
	MMXanim = timer.performWithDelay( 1000, MMXstand )
end

function MMXstand(obj)
	MMX:setSequence( "stand" )
	MMX:play()
	MMXanim = timer.performWithDelay( 2000, MMXprerun )
end

function MMXprerun(obj)
	MMX:setSequence( "prerun" )
	MMX:play()
	MMX.isJumpable = true
	MMXanim = timer.performWithDelay( 200, MMXrun )
end

function MMXrun(obj)
	MMX.alpha = 1
	MMX:setSequence( "run" )
	MMX:play()
	--MMX:setLinearVelocity(100,-800) -- คำสั่งเคลื่อนที่ วัตถุ


	MMXshoot.x = MMX.x
	MMXshoot.y = MMX.y
	MMXshoot:setSequence( "runShoot" )
	MMXshoot:play( )
	MMXshoot.alpha = 0
	MMX.isShoot = true

	--transition.to( "blast", {time = 10 , alpha = 0 })
	blast = timer.performWithDelay( 10, killObj(blast))
	xBuster = timer.performWithDelay( 10, killObj(xBuster) )
	timer.performWithDelay( 10, killObj(eExplote))

	update()
end



--  action function btn

function updateEnemies()
 local cur = os.time()
	 if((cur - lastEnemy) >= enemyPeriod) then
		 local r = math.random(100)
				 if (r >= 0 and r <= 100) then --r >= 40
					 enemy = display.newSprite( enemyImageSheet, enemySequenceData )
					 eShape = { -59, -50, 39, -50, 39, 100, -59,  100}
					 enemy.x = _W + enemy.width/2 
					 enemy.y = MMX.y
					 enemy.type = "enemy"
					 enemy.alpha = 1
					 physics.addBody( enemy, "dynamic", {bounce = 0.0 , density = 1.0, shape = eShape })  -- density คือ ความหนาแน่น  หมายความว่า  อยากให้ enemy ดัน rockman จะต้องให้  emeny มีมวลมากกว่า rockman ถึงจะดันไปได้  *defualt = 0.0
					 enemy:setLinearVelocity(-600,0)
					 enemy:play() 
				 end 
		 lastEnemy = os.time()
	 end
 end

function explote( )
	eExplote = display.newSprite( enemyImageSheet, enemySequenceData )
	eExplote:setSequence( "explote" )
	eExplote:play( )
	eExplote.x = enemy.x
	eExplote.y = enemy.y
	eExplote.type = "eExplote"

	timer.performWithDelay( 10, killObj(enemy))
	timer.performWithDelay( 10, killObj(xBuster))
end


function MMXrunShoot( )
	if (MMX.isShoot) then
		if (MMX.sequence == "run") then
			MMXshoot.alpha = 1
			MMX.alpha = 0
			timer.performWithDelay( 500, MMXrun)

			
			blast = display.newSprite( busterImageSheet, busterSequenceData )
			blast:setSequence( "blast" )
			blast:play( )
			blast.x = MMX.x + 87
			blast.y = MMX.y

			xBuster = display.newSprite( busterImageSheet, busterSequenceData )
			xBuster:setSequence( "buster" )
			xBuster:play( )
			xBuster.x = MMX.x + 87
			xBuster.y = MMX.y

			busterShape = { -10, -10, 10, -10, 10, 10, -10,  10}
			physics.addBody( xBuster, "kinematic", {density=0, friction=0, bounce=0 , shape = busterShape, isSensor = true } )
			xBuster:setLinearVelocity( _W + 100, 0.0 )
			xBuster:addEventListener( "collision", busterCollides )


		end
	end
end

function MMXjump()
	if (MMX.isJumpable) then
		MMX:setSequence( "jump" )
		MMX:play( )
		MMX:setLinearVelocity(0,-800)
		MMX.isJumpable = false
	end
end

function MMXcollides (event)
	if (event.phase == "began") then
		if (event.other.type == "flore" and MMX.sequence == "jump") then
			MMX:setSequence( "run" )
			MMX:play( )
			MMX.isJumpable = true
			print("landding")
		end
	elseif (event.phase == "ended") then
		print( "jump off" )
	end
end

function busterCollides( event )
	if (event.phase == "began") then
		if (event.other.type == "enemy") then
			explote()
			print( "hit" )
		end
	end
end

function gamePause( )
	if (isPause == false) then
		MMX:pause( )
		enemy:pause( )
		speed = 0
		isPause = true
		transition.pause( )
		physics.pause( )
		--timer.pause( mtimer )
		print( "is pause" )
	else
		MMX:play( )
		enemy:play( )
		speed = 9
		isPause = false
		transition.resume( )
		physics.start( )
		--timer.resume(  mtimer )
		print( "is resume" )
	end
end

function update()
	delay = 5200
	mtimer = timer.performWithDelay( delay, updateBg )
	mtimer = timer.performWithDelay( delay, updateFlore)
	mtimer = timer.performWithDelay( delay, updateFront)
	mtimer = timer.performWithDelay( delay, updateMinror)
	mtimer = timer.performWithDelay( delay, updateEnemies)
end

function killObj(obj)
	display.remove( obj )
	obj = nil
	--killObj (...)
end



ready()

Runtime:addEventListener("enterFrame", update)
txtPause:addEventListener("tap", gamePause)
txtJump:addEventListener("tap", MMXjump)
txtShoot:addEventListener( "tap", MMXrunShoot )
