local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

_W = display.viewableContentWidth
_H = display.viewableContentHeight

gap = _H * 0.65;
size = _W * 0.0375;

local uid

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			--print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- local path = system.pathForFile( "Message.txt", system.DocumentsDirectory )
-- local upath = system.pathForFile("Username.txt", system.DocumentsDirectory)

-- local ufile = io.open(upath, "r")
-- if not ufile then
-- 	print("File Error: " .. errorString)
-- else
-- 	local ucon = ufile:read("*a")

-- local gap = _H * 0.05 
-- msgy = _H * 0.3

-- for line in io.lines( path ) do

--     print( line )
--     local msg = display.newText(ucon .. ": ".. line, 0, 0, "unicode.arialr.ttf", _W*0.05)
-- 	msg.anchorX = 0
-- 	msg.x = _W * 0.150
-- 	msg.y = msgy
-- 	msg:setTextColor(0,0,0)
-- 	msgy = msgy + gap
-- end 
-- end

local function printMsg()
	
-----------send msg

end

function scene:create (event)
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	physics.pause()

	uid = event.params.uid

	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )

	local background = display.newImageRect(backGroup, "b3.jpg", _W, _H)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local minibg = display.newRect(backGroup, display.contentCenterX, display.contentCenterY * 1.09, _W*0.9, _H*0.60)
	minibg:setFillColor(1,0,0)	
	minibg.alpha = 0

	local sendmsg = native.newTextField(_W * 0.43, _H * 0.9, _W * 0.64, _H * 0.065)
	sendmsg:addEventListener("userInput", fieldHandler(function() return sendmsg end))
	sceneGroup:insert(sendmsg)
	sendmsg.placeholder = "Message"
	sendmsg.size = 63;

	local send = display.newImageRect(sceneGroup, "send.png", _W * 0.1, _H * 0.063 )
	send.x = _W * 0.82
	send.y = _H * 0.9
	send:addEventListener("tap", printMsg)	

	function sendmsg:userInput(event)
		if event.phase == "began" then
			event.target.text =''
		elseif event.phase == "ended" then

		elseif event.phase == "Submitted" then
			file = nil
		end
	end
end

function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	local scrollView = widget.newScrollView(
    	{
        	top = 100,
	        left = 10,
	        width = 600,
	        height = 775,
	        scrollWidth = 600,
	        scrollHeight = 800,
	        listener = scrollListener
    	}
	)

	local function scrollListener( event )
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    end

	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end

	    return true
	end

	if ( phase == "will" ) then
		local bground = display.newText("Halloo",0,0, "unicode.arialr.ttf",32)
		scrollView:insert(bground)
	elseif ( phase == "did" ) then

	end
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		-- txtMessage:removeSelf()
		-- txtMessage = nil
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
	end
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