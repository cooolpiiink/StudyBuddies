_W = display.viewableContentWidth
_H = display.viewableContentHeight

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
-- local labelUsername
-- local labelPassword
-- local labelFeedback
-- local textUsername
-- local textPassword

-- local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
-- 	background:setFillColor( 1 )

local function gotoSendMsg()
	composer.removeScene("sendmsg")
    composer.gotoScene( "sendmsg", { time=500, effect="crossFade" })
end

function scene:create( event )

	local sceneGroup = self.view


	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local groupName = display.newText(sceneGroup, "Study Groups", 500, 80, native.systemFont, 60)
	groupName.x = display.contentCenterX
	groupName.y = _H * 0.1


background:addEventListener("tap", background)
	
	-- local loginButton = display.newText( sceneGroup, "Login", display.contentCenterX, 700, native.systemFont, 44 )
	-- loginButton:setFillColor( 0.82, 0.86, 1 )
	local loc = _H * 0.2;
	local gap = 60;
	local sg1 = display.newText( sceneGroup, "Study Group 1", display.contentCenterX, loc, native.systemFont, 44 )
	sg1:setFillColor( 0.75, 0.78, 1 )
	sg1:addEventListener("tap", gotoSendMsg)

	local sg2 = display.newText( sceneGroup, "Study Group 2", display.contentCenterX, loc + gap, native.systemFont, 44 )
	sg2:setFillColor( 0.75, 0.78, 1 )
	sg2:addEventListener("tap", gotoSendMsg)
	--loginButton:addEventListener("tap", gotoLogin)
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
