display.setStatusBar( display.DefaultStatusBar )
_W = display.viewableContentWidth
_H = display.viewableContentHeight
font = _W * 0.13;

local composer = require( "composer" )
local scene = composer.newScene()


local function gotoSendMsg()
	composer.removeScene("sendmsg")
	composer.gotoScene("sendmsg", { time = 300, effect = "crossFade" })
end

local function searchResults()
end

local function fieldHandler( textFields )
	return function ( event )
		if ("began" == event.phase) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		elseif ("ended" == event.phase) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
		elseif ("editing" == event.phase) then
			--
		elseif ("submitted" == event.phase) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			--print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end



function scene:create (event)

	sceneGroup = self.view

	local background = display.newImageRect (sceneGroup, "b3.jpg", _W, _H)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:addEventListener("tap", background)

	local title = display.newText("Study Buddies", _W * 0.5, _H * 0.165, "amazon.ttf", font)
	title:setTextColor(0,0,0)

	local logout = display.newImageRect ("logout-png-hi.png", _W * 0.2, _H * 0.05)
	logout.x = _W * 0.85
	logout.y = _H * 0.08
	logout.alpha = 0.80
	--logout:addEventListener("tap", goOut)
 
 	local gap = 5;

	local 
	bg1 = display.newImageRect(sceneGroup, "1.jpg", _W * 0.375, _H * 0.25)
	bg1.x = _W * 0.30
	bg1.y = _H * 0.38
	bg1:addEventListener ("tap", gotoSendMsg)

	local txt1 = display.newText(sceneGroup, "List of \nGroups", bg1.x, bg1.y, "Calligrapher font.ttf", font * 0.5)
	txt1:setTextColor(0,0,0)

	local bg2 = display.newImageRect(sceneGroup, "2.jpg", _W * 0.375, _H * 0.25)
	bg2.x = (_W * 0.70) + gap;
	bg2.y = bg1.y
	-- bg2:addEventListener ("touch", textListener)
	local txt2 = display.newText(sceneGroup, "Join \nGroups", bg2.x, bg2.y, "Calligrapher font.ttf", font * 0.5)
	txt2:setTextColor(0,0,0)


	local bg3 = display.newImageRect(sceneGroup, "3.jpg", _W * 0.375, _H * 0.25)
	bg3.x = _W * 0.30
	bg3.y = (_H * 0.65) + gap
	-- bg3:addEventListener ("touch", textListener)
	local txt3 = display.newText(sceneGroup, "Create \nGroup", bg3.x, bg3.y, "Calligrapher font.ttf", font * 0.5)
	txt3:setTextColor(0,0,0)

	local bg4 = display.newImageRect(sceneGroup, "4.jpg", _W * 0.375, _H * 0.25)
	bg4.x = (_W * 0.70) + gap;
	bg4.y = bg3.y
	-- bg4.addEventListener ("touch", textListener)
	local txt4 = display.newText(sceneGroup, "Manage \nGroups", bg4.x, bg4.y, "Calligrapher font.ttf", font * 0.5)
	txt4:setTextColor(0,0,0)

	search = native.newTextField(_W * 0.43, _H * 0.9, _W * 0.64, _H * 0.065)
	search:addEventListener("userInput", fieldHandler(function() return search end))
	sceneGroup:insert(search)
	search.placeholder = "Search Groups"
	search.size = 63;

	function search:userInput(e)
		if e.phase == "began" then
			e.target.text = ''
		
		elseif e.phase == "ended" then
			
		elseif event.phase == "Submitted" then
			--	labelFeedback.text = "Hello".. " " .. event.target.text
			--  elseif event.phase == "editing" then
			--	labelFeedback.text = event.startPosition 
		file = nil
	end
	end

	--txtMessage:addEventListener("userInput", txtMessage)

	local button = display.newImageRect(sceneGroup, "search.png", _W * 0.1, _H * 0.07 )
	button.x = _W * 0.82
	button.y = _H * 0.9
	button:addEventListener("touch", searchResults)	
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase


end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	
end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -----------------------------------------------------------------------------------

return scene
