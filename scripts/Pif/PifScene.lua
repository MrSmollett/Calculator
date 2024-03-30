local composer = require( "composer" )
local mathCalc = require( "scripts.libs.mathCalc" )
local widget = require("widget")
local json = require("json")


_W = display.contentWidth
_H = display.contentHeight

_CX = display.contentCenterX
_CY = display.contentCenterY


local scene = composer.newScene()


function scene:create( event )

	local sceneGroup = self.view

    local background = display.newImage( sceneGroup, "assets/background.png", _CX, _CY, _W, _H)


	legAVar = ""
	legBVar = ""
    hypCVar = ""

    CheckVar = false

 
    function legA( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (type(tonumber(text)) == 'number') then
                legAVar = tonumber( text )
                print("A")
            else
                legAVar = ""
            end
        end
    end

    function legB( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (type(tonumber(text)) == 'number') then
                legBVar = tonumber( text )
                print("B")
            else
                legBVar = ""
            end
        end
    end

    function hypC( event )
        local text = event.target.text
        if ( event.phase == "ended" or event.phase == "submitted" or CheckVar == true) then
            if (type(tonumber(text)) == 'number') then
                hypCVar = tonumber( text )
                print("C")
            else
                hypCVar = ""
            end
        end
    end



    function BtnPress( event )
		local BtnName = event.target.id
			if (BtnName == "calculateBtn" and event.phase == "ended") then
                if ( legBVar == (nil or "") and hypCVar == (nil or "") or legAVar == (nil or "") and hypCVar == (nil or "") or legAVar == (nil or "") and legBVar == (nil or "")) then
                    t = "Вы не подтвердили значение.\n   Нажмите клавишу \"Ввод\""
                    out(a, b, c, t)
                else
                    CheckVar = true

                    a, b, c = mathCalc.PifCalc(legAVar, legBVar, hypCVar)
                
                if (c-a<0 or c-b<0) then
                    t = "Катет больше гипотенузы"
                    out(a, b, c, t)

                else
                    t = nil
                    out(a, b, c, t)
                end
            end

            elseif (BtnName == "exitBtn" and event.phase == "ended") then
                composer.gotoScene( "scripts.menu" )
            else
                CheckVar = false
            
			end
	end
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

        local generalForm = display.newImageRect( sceneGroup, "assets/Materials/rightTriangle.png", 150, 150 )
		    generalForm.x, generalForm.y = _CX, _H/5

        solution = display.newText(sceneGroup, "a = ".."\nb = ".."\nc = ", _CX, generalForm.y+230, system.nativeFont, 20)
            solution:setFillColor(188/255, 188/255, 188/255)
            solution.isVisible = false

            function out(a, b, c, t)
                if ( t == nil ) then
                solution.text = "a = "..a.."\nb = "..b.."\nc = "..c
                else
                    solution.text = t
                end
                solution.isVisible = true
            end

        local calculateBtn = widget.newButton(
		    {
			    x=_CX,
			    y=generalForm.y+155,
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


        legBField = native.newTextField( _CX, generalForm.y + 100, 30, 30 )
            legBField.font = native.newFont( Font, 18 )
            legBField.align = "center"
            legBField.hasBackground = false
            legBField.placeholder = "b"
		    legBField:addEventListener( "userInput", legB )

        legAField = native.newTextField( legBField.x - 75, legBField.y, 30, 30 )
            legAField.font = native.newFont( Font, 18 )
            legAField.align = "center"
            legAField.hasBackground = false
            legAField.placeholder = "a"
		    legAField:addEventListener( "userInput", legA )

        hypCField = native.newTextField( legBField.x + 75, legBField.y, 30, 30 )
            hypCField.font = native.newFont( Font, 18 )
            hypCField.align = "center"
            hypCField.hasBackground = false
            hypCField.placeholder = "c"
            hypCField:addEventListener( "userInput", hypC )


        sceneGroup:insert(calculateBtn)
        sceneGroup:insert(exitBtn)




	elseif ( phase == "did" ) then

	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
        legAField:removeSelf()
            legAField = nil
        legBField:removeSelf()
            legBField = nil
        hypCField:removeSelf()
            legCField = nil
        solution.isVisible = false
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
