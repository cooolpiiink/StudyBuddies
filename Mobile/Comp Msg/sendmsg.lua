
_W = display.viewableContentWidth
_H = display.viewableContentHeight
x = 100
y = 200
gap = 30
size = 40
tw = 0.8


local composer = require( "composer" )

local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )


--local userName
local txtMessage
local sendButton


local function printUserName()

	local path = system.pathForFile( "Username.txt", system.DocumentsDirectory )
	local file, errorString = io.open( path, "r" )

	if not file then
    -- Error occurred; output the cause
    	print( "File error: " .. errorString )
	else
    -- Read data from file

    	local contents = file:read( "*a" )

    	local uname = display.newText (contents .. ": ", 0, 0, native.systemFont, size)
		uname.anchorX = 0;
		uname.x = _W * 0.25;
		uname.y = _H * 0.15 + gap;
		uname:setTextColor(255, 255, 255);

		 print( "Contents of " .. path .. "\n" .. contents )

    -- Close the file handle
    	io.close( file )
    	file = nil
    	gap = gap + 55;
	end

	local path = system.pathForFile( "txtMessage.txt", system.DocumentsDirectory )
	local file, errorString = io.open( path, "r" )

	if not file then
    -- Error occurred; output the cause
    	print( "File error: " .. errorString )
	else
    -- Read data from file
    

    	local contents = file:read( "*a" )

    	local message = display.newText (contents, 0, 0, native.systemFont, size)
		message.anchorX = 0;
		message.x = _W * 0.40;
		message.y = _H * 0.15 + gap;
		message:setTextColor(255, 255, 255);

		-- local background = display.newRect( _W * 0.68, _H * 0.19, _W * tw, _H * 0.05 )
		-- background:setFillColor( 1 )
    -- Output the file contents
    --local contents = display.newText(print ("Contents of " .. path .. "\n" .. contents )))
    print( "Contents of " .. path .. "\n" .. contents )

    -- Close the file handle
    	io.close( file )
    	file = nil
    	gap = gap + 50;
	end


	file = nil
	
	--end
end

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
local labelLastname
local labelEmail
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			--print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	physics.pause()

	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )

	local background = display.newImageRect( backGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local groupName = display.newText(sceneGroup, "Study Group 1", 500, 80, native.systemFont, 60)
	groupName.x = display.contentCenterX
	groupName.y = _H * 0.1
	
	sendButton = display.newText(sceneGroup, "Send Message", display.contentCenterX, 910, native.systemFont,40)
	sendButton:setFillColor( 0.75, 0.78, 1 )	
	sendButton:addEventListener("tap", printUserName)
end



-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)


	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	
	txtMessage = native.newTextField(375, 840, 500, 60)
	txtMessage:addEventListener("userInput", fieldHandler(function() return txtMessage end))
	sceneGroup:insert (txtMessage)
	txtMessage.size = 35
	txtMessage.placeholder = "Text Message"


	function txtMessage:userInput(e)
		if e.phase == "began" then
			e.target.text = ''
		
		elseif e.phase == "ended" then
			local path = system.pathForFile( "txtMessage.txt", system.DocumentsDirectory )

       		local file = io.open( path, "w" )
       		file:write( e.target.text )
	       		io.close( file )
	       		file = nil 
			--labelFeedback.text = "Thank you" .. " " .. event.target.text
		elseif event.phase == "Submitted" then
			--	labelFeedback.text = "Hello".. " " .. event.target.text
			--  elseif event.phase == "editing" then
			--	labelFeedback.text = event.startPosition 
		file = nil
	end
	end

	txtMessage:addEventListener("userInput", txtMessage)

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		txtMessage:removeSelf()
		txtMessage = nil
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
