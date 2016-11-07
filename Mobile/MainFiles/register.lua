
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

local backGroup
local labelFirstname
local labelLastname
local labelEmail
local labelPasswords
local textLastname
local textFirstname
local textPasswords
local textEmail
local registerButton 

local unameni
local fnameni
local lnameni
local passni
local url

local function gotoWelcome()
	local function networkListener( event )
		if ( event.isError ) then
			print( "Network error: ", event.response )
		else
			print ( "RESPONSE: " .. event.response )
		end
	end
	
	-- network.request( "http://192.168.43.114:8080/studybuddies/buddy/insert/"..unameni.."/"..passni.."/"..fnameni.."/"..lnameni, "GET", networkListener)
	network.request( "http://localhost:8080/studybuddies/buddy/insert/"..unameni.."/"..passni.."/"..fnameni.."/"..lnameni, "GET", networkListener)

	composer.gotoScene("menu", { time=800, effect="crossFade" })
end

local myRegister = widget.newButton
{
	left = 230,
	top = 900,
	width = 300,
	height = 50,
	defaultFile = "default.png",
	overFile = "over.png",
	label = "REGISTER",
	onEvent = handleButtonEvent,
}

local myCheck = widget.newButton
{
	left = 230,
	top = 835,
	width = 300,
	height = 50,
	defaultFile = "default.png",
	overFile = "over.png",
	label = "CHECK",
	onEvent = handleButtonEvent,
}

local function gotoCheck()
	print("Check")
	-- body
end

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			
		elseif ( "editing" == event.phase ) then
		
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

	local register = display.newImageRect( backGroup, "create.png", 550, 80 )
	register.x = display.contentCenterX
	register.y = 200
	

	labelFirstname = display.newText( sceneGroup, "Firstname:", 217, 300, native.systemFont, 40)
	sceneGroup:insert( labelFirstname )
	labelLastname = display.newText( sceneGroup, "Lastname:", 217, 440, native.systemFont, 40)
	sceneGroup:insert( labelLastname )
	labelEmail = display.newText( sceneGroup, "Username:", 221, 580, native.systemFont, 40)
	sceneGroup:insert( labelEmail )
	labelPasswords = display.newText( sceneGroup, "Password:", 217, 720, native.systemFont, 40)
	sceneGroup:insert( labelPasswords )
	
	sceneGroup:insert( myCheck )
	sceneGroup:insert( myRegister )
	myRegister:addEventListener("tap", gotoWelcome)
	myCheck:addEventListener("tap", gotoCheck)


	function  background:tap(event)
		native.setKeyboardFocus( nil )
	end

	background:addEventListener("tap", background)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)


	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		textFirstname = native.newTextField(375, 370, 500, 60)
		textFirstname:addEventListener("userInput", fieldHandler(function() return textFirstname end))
		sceneGroup:insert( textFirstname )
		textFirstname.size = 38
		textFirstname.placeHolder = "First name"

		textLastname= native.newTextField(375, 510, 500, 60)
		textLastname:addEventListener("userInput", fieldHandler(function() return textLastname end))
		sceneGroup:insert( textLastname )
		textLastname.size = 38
		textLastname.placeHolder = "Last name"

		textEmail = native.newTextField(375, 650, 500, 60)
		textEmail:addEventListener("userInput", fieldHandler(function() return textEmail end))
		sceneGroup:insert( textEmail )
		textEmail.size = 38
		textEmail.placeHolder = "Username"

		textPasswords = native.newTextField(375, 790, 500, 60)
		textPasswords:addEventListener("userInput", fieldHandler(function() return textPasswords end))
		sceneGroup:insert( textPasswords )
		textPasswords.size = 38
		textPasswords.isSecure = true
		textPasswords.placeHolder = "Password"

		function textFirstname:userInput(event)
			if event.phase == "began" then
				event.target.text = ''
			elseif event.phase == "ended" then
				local path = system.pathForFile( "Firstname.txt", system.DocumentsDirectory )
				local file = io.open( path, "w" )
				file:write( event.target.text )
				io.close( file )
				file = nil
				fnameni = event.target.text
			elseif event.phase == "Submitted" then
			end
		end

		function textLastname:userInput(event)
			if event.phase == "began" then
				event.target.text = ''
			elseif event.phase == "ended" then
				local path = system.pathForFile( "Lastname.txt", system.DocumentsDirectory )
				local file = io.open( path, "w" )
				file:write( event.target.text )
				io.close( file )
				file = nil
				lnameni = event.target.text
			elseif event.phase == "Submitted" then
			end
		end

		function textEmail:userInput(event)
			if event.phase == "began" then
				event.target.text = ''
			elseif event.phase == "ended" then
				local path = system.pathForFile( "Username.txt", system.DocumentsDirectory )
				local file = io.open( path, "w" )
				file:write( event.target.text )
				io.close( file )
				file = nil
				unameni = event.target.text
			elseif event.phase == "Submitted" then
			end
		end

		function textPasswords:userInput(event)
			if event.phase == "began" then
				event.target.text = ''
			elseif event.phase == "ended" then
				local path = system.pathForFile( "Password.txt", system.DocumentsDirectory )
				local file = io.open( path, "w" )
				file:write( event.target.text )
				io.close( file )
				file = nil
				passni = event.target.text
			elseif event.phase == "Submitted" then
			end
		end
		textFirstname:addEventListener("userInput", textFirstname)
		textEmail:addEventListener("userInput", textEmail)
		textPasswords:addEventListener("userInput", textPasswords)
		textLastname:addEventListener("userInput", textLastname)
	end
end


-- hide()
function scene:hide( event )


	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		textEmail:removeSelf()
		textEmail = nil
		textPasswords:removeSelf()
		textPasswords = nil
		textFirstname:removeSelf()
		textFirstname = nil
		textLastname:removeSelf()
		textLastname = nil
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
