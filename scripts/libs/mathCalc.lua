T = {}


T.DiscrCalc = function(coefficientAVar, coefficientBVar, coefficientCVar)
    local D = coefficientBVar^2 - 4*coefficientAVar*coefficientCVar
    local x1 = (-coefficientBVar + math.sqrt(D))/2*coefficientAVar
    local x2 = (-coefficientBVar - math.sqrt(D))/2*coefficientAVar

    x1 = 0.0001*math.floor(10000*x1)
    x2 = 0.0001*math.floor(10000*x2)

    return D, x1, x2
end

T.PifCalc = function(legAVar, legBVar, hypCVar)
    if (hypCVar == "" or hypCVar == nil) then
        hypCVar = math.sqrt(legAVar^2 + legBVar^2)

    elseif (legAVar == "" or legAVar == nil) then
        legAVar = math.sqrt(hypCVar^2 - legBVar^2)

    elseif (legBVar == "" or legBVar == nil) then
        legBVar = math.sqrt(hypCVar^2 - legAVar^2)

    else
        return legAVar, legBVar, hypCVar
    end

    legAVar = 0.0001*math.floor(10000*legAVar)
    legBVar = 0.0001*math.floor(10000*legBVar)
    hypCVar = 0.0001*math.floor(10000*hypCVar)

    return legAVar, legBVar, hypCVar
end

T.CosCalc = function(legAVar, legBVar, legCVar, angAVar)
    if (legCVar == "" or legCVar == nil) then
        angAVar_rad = math.rad(angAVar)
        legCVar = math.sqrt((legAVar^2 + legBVar^2) - (2*legAVar*legBVar*math.cos(angAVar_rad)))
    elseif (legAVar == "" or legAVar == nil) then
        angAVar_rad = math.rad(angAVar)

        a = 1
        b = 2*legBVar*math.cos(angAVar_rad)
        c = legBVar^2 - legCVar^2

        D = b^2 - 4 * a * c

        x1 = (-b + math.sqrt(D))/2*a
        x2 = (-b - math.sqrt(D))/2*a

        legAVar = math.abs(x2)

    elseif (legBVar == "" or legBVar == nil) then

        angAVar_rad = math.rad(angAVar)

        a = 1
        b = 2*legAVar*math.cos(angAVar_rad)
        c = legAVar^2 - legCVar^2

        D = b^2 - 4 * a * c

        x1 = (-b + math.sqrt(D))/2*a
        x2 = (-b - math.sqrt(D))/2*a

        legBVar = math.abs(x2)

    elseif (angAVar == "" or angAVar == nil) then

        angAVar = math.deg(math.acos((legAVar^2+legBVar^2-legCVar^2)/(2*legAVar*legBVar)))
        cosAVar = (legAVar^2+legBVar^2-legCVar^2)/(2*legAVar*legBVar)
    else
        return legAVar, legBVar, legCVar
    end
    legAVar = 0.0001*math.floor(10000*legAVar)
    legBVar = 0.0001*math.floor(10000*legBVar)
    legCVar = 0.0001*math.floor(10000*legCVar)
    angAVar = 0.0001*math.floor(10000*angAVar)

    return legAVar, legBVar, legCVar, angAVar, cosAVar
end

return T