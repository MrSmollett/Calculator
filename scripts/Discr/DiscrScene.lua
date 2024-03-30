local composer = require( "composer" )
local mathCalc = require( "scripts.libs.mathCalc" )
local widget = require("widget")


_W = display.contentWidth
_H = display.contentHeight

_CX = display.contentCenterX
_CY = display.contentCenterY

Font = "assets/Fonts/Graffiti1CTT.ttf"

local scene = composer.newScene()


function scene:create( event )

	local sceneGroup = self.view

    local background = display.newImage( sceneGroup, "assets/background.png", _CX, _CY, _W, _H)
    local generalForm = display.newText( sceneGroup, " Общий вид: \naх^2+bx+c=0", _CX, _H/5, Font, 24 )
        generalForm:setFillColor(188/255, 188/255, 188/255)
    coefficientAVar = ""
    coefficientBVar = ""
    coefficientCVar = ""

    local solution = display.newText(sceneGroup, "D = ".."\nX1 = ".."\nХ2 = ", _CX, generalForm.y+180, Font, 20)
        solution:setFillColor(188/255, 188/255, 188/255)
        solution.isVisible = false

    CheckVar = false

 
    local function coefficientA( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (tonumber( text ) ~= "" and tonumber( text ) ~= nil) then
                coefficientAVar = tonumber( text )
            else
                coefficientAVar = ""
            end
        end
    end

    local function coefficientB( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (tonumber( text ) ~= "" or tonumber( text ) ~= nil ) then
                coefficientBVar = tonumber( text )
            else
                coefficientBVar = ""
            end
        end
    end

    local function coefficientC( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (tonumber( text ) ~= "" or tonumber( text ) ~= nil) then
                coefficientCVar = tonumber( text )
            else
                coefficientCVar = ""
            end
        end
    end



    local function BtnPress( event )
		local BtnName = event.target.id
			if (BtnName == "calculateBtn" and event.phase == "ended") then
                if ( coefficientAVar == (nil or "") or coefficientBVar == (nil or "") or coefficientCVar == (nil or "")) then
                    solution.text = "Вы не подтвердили значение.\n   Нажмите клавишу \"Ввод\""
                    solution.isVisible = true
                else
                    local D, x1, x2 = mathCalc.DiscrCalc(coefficientAVar, coefficientBVar, coefficientCVar)
                    if (D >= 0 ) then
                        solution.text = "D = "..D.."\nX1 = "..x1.."\nХ2 = "..x2
                        solution.isVisible = true
                    else
                        solution.text = "D = "..D.."\nКорней нет, т.к. D < 0"
                        solution.isVisible = true
                    end
                    CheckVar = true
                end
            elseif (BtnName == "exitBtn" and event.phase == "ended") then
                composer.gotoScene( "scripts.menu" )
            else
                CheckVar = false
            
			end
	end

    local calculateBtn = widget.newButton(
		{
			x=_CX,
			y=generalForm.y+110,
			id = "calculateBtn",
            width = 100,
            height = 50,
			defaultFile = "assets/Btn/calculateBtn.png",
			overFile = "assets/Btn/calculateBtn_.png",
			label = "Решить",
			labelColor = { default={ 0.73, 0.73, 0.73 }, over={ 0.63, 0.63, 0.63, 0.5 } },
            font = Font,
            fontSize=16,
			labelAlign=center,
			onEvent = BtnPress
		}
	)

    local exitBtn = widget.newButton(
		{
			x=_W-60,
			y=_CY - _H/2,
			id = "exitBtn",
            width = 100,
            height = 50,
			defaultFile = "assets/Btn/exitBtn.png",
			overFile = "assets/Btn/exitBtn_.png",
			label = "В меню",
			labelColor = { default={ 0.73, 0.73, 0.73 }, over={ 0.63, 0.63, 0.63, 0.5 } },
            font = Font,
            fontSize=16,
			labelAlign = center,
			onEvent = BtnPress
		}
	)
 

    local coefficientBField = native.newTextField( _CX, generalForm.y + 50, 30, 30 )
        coefficientBField.font = native.newFont( Font, 18 )
        coefficientBField.align = "center"
        coefficientBField.hasBackground = false
        coefficientBField.placeholder = "b"
        coefficientBField:addEventListener( "userInput", coefficientB )

    local coefficientAField = native.newTextField( coefficientBField.x - 75, coefficientBField.y, 30, 30 )
        coefficientAField.font = native.newFont( Font, 18 )
        coefficientAField.align = "center"
        coefficientAField.hasBackground = false
        coefficientAField.placeholder = "a"
        coefficientAField:addEventListener( "userInput", coefficientA )

    local coefficientCField = native.newTextField( coefficientBField.x + 75, coefficientBField.y, 30, 30 )
        coefficientCField.font = native.newFont( Font, 18 )
        coefficientCField.align = "center"
        coefficientCField.hasBackground = false
        coefficientCField.placeholder = "c"
        coefficientCField:addEventListener( "userInput", coefficientC )

        sceneGroup:insert(calculateBtn)
        sceneGroup:insert(exitBtn)
    function DEL()
        coefficientAField.isVisible = false
        coefficientBField.isVisible = false
        coefficientCField.isVisible = false
        
    end

    function SHOW()
        coefficientAField.isVisible = true
        coefficientBField.isVisible = true
        coefficientCField.isVisible = true

        solution.isVisible = false
    end
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
        SHOW()
	elseif ( phase == "did" ) then
	
	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
        DEL()
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
