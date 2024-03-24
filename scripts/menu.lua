local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")

local scene = composer.newScene()


function scene:create( event )
    _W = display.contentWidth
    _H = display.contentHeight

    _CX = display.contentCenterX
    _CY = display.contentCenterY

	Font = "assets/Fonts/Graffiti1CTT.ttf"

	local sceneGroup = self.view

    local background = display.newImage( sceneGroup, "assets/background.png", _CX, _CY, _W, _H)
	
    local appName = display.newText( sceneGroup, "Калькулятор", _CX, _CY - _W+80, "assets/Fonts/MTR49__C.TTF", 96 )
        appName:setFillColor(255/255, 238/255, 168/255)
        

	local function BtnPress( event )
		local BtnName = event.target.id
		if (event.phase == "ended") then
			if (BtnName == "DiscrBtn") then
				composer.gotoScene( "scripts.Discr.DiscrScene" )
			elseif (BtnName == "PifBtn") then 
				composer.gotoScene( "scripts.Pif.PifScene" )
			else
				composer.gotoScene( "scripts.Cos.CosScene" )
			end
		end
	end



	local DiscrBtn = widget.newButton(
		{
			x=_CX,
			y=_CY-120,
			id = "DiscrBtn",
			width = 200,
            height = 70,
			defaultFile = "assets/Btn/menuBtn.png",
			overFile = "assets/Btn/menuBtn_.png",
			label = "         Решение\nквадратных уравнений",
			labelColor = { default={ 1, 250/255, 250/255 }, over={ 250/255, 235/255, 235/255, 0.5 } },
			font = Font,
			fontSize=16,
			labelAlign=center,
			onEvent = BtnPress
		}
	)

	local PifBtn = widget.newButton(
		{
			x=_CX,
			y=DiscrBtn.y + 75,
			id = "PifBtn",
			width = 200,
            height = 70,
			defaultFile = "assets/Btn/menuBtn.png",
			overFile = "assets/Btn/menuBtn_.png",
			label = "      Нахождение\nпо теореме Пифагора",
			labelColor = { default={ 1, 250/255, 250/255 }, over={ 250/255, 235/255, 235/255, 0.5 } },
			font = Font,
			fontSize=16,
			labelAlign=center,
			onEvent = BtnPress
		}
	)

	local CosBtn = widget.newButton(
		{
			x=_CX,
			y=PifBtn.y + 75,
			id = "CosBtn",
			width = 200,
            height = 70,
			defaultFile = "assets/Btn/menuBtn.png",
			overFile = "assets/Btn/menuBtn_.png",
			label = "      Нахождение\nпо теореме косинусов",
			labelColor = { default={ 1, 250/255, 250/255 }, over={ 250/255, 235/255, 235/255, 0.5 } },
			font = Font,
			fontSize=16,
			labelAlign=center,
			onEvent = BtnPress
		}
	)

	sceneGroup:insert(DiscrBtn)
	sceneGroup:insert(PifBtn)
	sceneGroup:insert(CosBtn)


	 
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	
	elseif ( phase == "did" ) then
	
	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end


function scene:destroy( event )

	local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
