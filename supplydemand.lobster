import gl
import color
import vec

def drawGraph():
    gl.color(color_black)
    //draw xy axis
    gl.line(float2{350.0, 150.0}, float2{350.0, 700.0}, 5.0)
    gl.line(float2{350.0, 700.0}, float2{1000.0, 700.0}, 5.0)
    //draw 4 number indicators on each axis (y)
    gl.line(float2{350.0, 151.0}, float2{340.0, 151.0}, 3.0)
    gl.line(float2{350.0, 287.5}, float2{340.0, 287.5}, 3.0)
    gl.line(float2{350.0, 425.0}, float2{340.0, 425.0}, 3.0)
    gl.line(float2{350.0, 562.5}, float2{340.0, 562.5}, 3.0)
    //x axis
    gl.line(float2{512.5, 700.0}, float2{512.5, 710.0}, 3.0)
    gl.line(float2{675.0, 700.0}, float2{675.0, 710.0}, 3.0)
    gl.line(float2{837.5, 700.0}, float2{837.5, 710.0}, 3.0)
    gl.line(float2{999.0, 700.0}, float2{999.0, 710.0}, 3.0)
    //Price and Quantity indicators
    gl.set_font_size(48)
    gl.translate (int2{350, 75}):
        gl.text("P")
    gl.translate (int2{1025, 700}):
        gl.text("D")

def findborders(slope, intercept, xScale, yScale):
    /*
    xmax = xScale
    xmin = 0.0
    ymax = yScale
    ymin = 0.0
    */
    //return 2x2 matrix in form of x1 y1 x2 y2
    let results = []
    //check line x = 0.0
    if intercept < yScale and intercept >= 0.0:
        results.push([0.0, intercept])
    //check line y = 0.0
    if slope != 0.0 and (-intercept / slope) <= xScale and (-intercept / slope) > 0.0:
        results.push([-intercept/slope, 0.0])
    //check line y = yScale
    if slope != 0.0 and ((yScale - intercept) / slope) < xScale and ((yScale - intercept) / slope) >= 0.0:
        results.push([((yScale - intercept) / slope), yScale])
    //check line x = xScale
    if(slope * xScale + intercept) <= yScale and (slope * xScale + intercept) > 0.0:
        results.push([xScale, slope * xScale + intercept])

    if results.length() != 2:
        //line not in graph
        return [[-2000.0, -2000.0], [-2000.0, -2000.0]]
    
    // make sure point 2 is rightmost, swap if not
    if results[0][0] > results[1][0]:
        let temp = results[0]
        results[0] = results[1]
        results[1] = temp

    return results




def drawLines(Dslope, Dinter, Sslope, Sinter, xScale, yScale):
    //find points for demand line
    let DemandPoints = findborders(Dslope, Dinter, xScale, yScale)
    let Dpoint1 = float2{350.0 + DemandPoints[0][0] * (650.0/xScale), 150.0 + (yScale - DemandPoints[0][1]) * (550.0 / float(yScale))}
    let Dpoint2 = float2{350.0 + DemandPoints[1][0] * (650.0/xScale), 150.0 + (yScale - DemandPoints[1][1]) * (550.0 / float(yScale))}
    gl.color(color_red)
    gl.line(Dpoint1, Dpoint2, 5.0)
    //indicate Demand curve
    gl.set_font_size(48)
    gl.translate (int2{int(Dpoint2[0]), int(Dpoint2[1]) - 100}):
        gl.text("D")


    //find points for suply line
    let SupplyPoints = findborders(Sslope, Sinter, xScale, yScale)
    let Spoint1 = float2{350.0 + SupplyPoints[0][0] * (650.0/xScale), 150.0 + (yScale - SupplyPoints[0][1]) * (550.0 / float(yScale))}
    let Spoint2 = float2{350.0 + SupplyPoints[1][0] * (650.0/xScale), 150.0 + (yScale - SupplyPoints[1][1]) * (550.0 / float(yScale))}
    gl.color(color_blue)
    gl.line(Spoint1, Spoint2, 5.0)
    //indicate Suply curve
    gl.translate (int2{int(Spoint2[0]), int(Spoint2[1]) - 100}):
        gl.text("S")


def populateGraph(xScale, yScale):
    gl.color(color_black)
    gl.set_font_size(24)
    //put respective price on each nub
    gl.translate (int2{276, 140}):
        gl.text(string(round(yScale * 1.0)))
    gl.translate (int2{276, 280}):
        gl.text(string(round(yScale * 0.75)))
    gl.translate (int2{276, 420}):
        gl.text(string(round(yScale * 0.5)))
    gl.translate (int2{276, 555}):
        gl.text(string(round(yScale * 0.25)))
    //now for quantity
    gl.translate (int2{980, 720}):
        gl.text(string(round(xScale * 1.0)))
    gl.translate (int2{825, 720}):
        gl.text(string(round(xScale * 0.75)))
    gl.translate (int2{660, 720}):
        gl.text(string(round(xScale * 0.5)))
    gl.translate (int2{495, 720}):
        gl.text(string(round(xScale * 0.25)))

def drawBoxes(selected):
    for(6) i:
        if i == selected:
            gl.color(color_yellow)
        else:
            gl.color(color_light_grey)
        gl.translate(int2{50, 50 + (140 * i)}):
            gl.rounded_rectangle(float2{150.0, 100.0}, 50, 0.2)

def populateInputs(Dslope, Dinter, Sslope, Sinter, xScale, yScale):
    gl.color(color_black)
    gl.set_font_size(24)
    //populate each input box with titles and curent values
    gl.translate (int2{50, 26}):
        gl.text("Demand Slope")
    gl.translate (int2{90, 88}):
        gl.text(string(int(Dslope)))
    gl.translate (int2{50, 166}):
        gl.text("Demand Intercept")
    gl.translate (int2{75, 228}):
        gl.text(string(int(Dinter)))
    gl.translate (int2{50, 306}):
        gl.text("Supply Slope")
    gl.translate (int2{90, 368}):
        gl.text(string(int(Sslope)))
    gl.translate (int2{50, 446}):
        gl.text("Supply Intercept")
    gl.translate (int2{90, 504}):
        gl.text(string(int(Sinter)))
    gl.translate (int2{50, 586}):
        gl.text("X Scale")
    gl.translate (int2{90, 648}):
        gl.text(string(xScale))
    gl.translate (int2{50, 726}):
        gl.text("Y Scale")
    gl.translate (int2{90, 788}):
        gl.text(string(yScale))

def getDigit():
    //returns digit if pressed, returns 10 if backspace, returns -1 otherwise
    for(10) i:
        if gl.button(string(i)) == 1 or gl.button("keypad " + i) == 1:
            return i
    if gl.button("backspace") == 1:
        return 10
    return -1

def populateOutputs(Dslope, Dinter, Sslope, Sinter):
    //calculate values and record if they can be calculated (cant divide by 0)
    var equilibriumExists = true
    var SelacityExists = true
    var DelacicityExists = true
    var eqP = 0.0
    var eqQ = 0.0
    var sEla = 0.0
    var dEla = 0.0
    if (Dslope - Sslope) == 0.0:
        equilibriumExists = false
    else:
        eqQ = (Sinter - Dinter) / (Dslope - Sslope)
        eqP = (Dslope * eqQ) + Dinter
    if (not equilibriumExists) or (eqQ == 0.0 or Sslope == 0.0):
        SelacityExists = false
    else:
        sEla = eqP / (Sslope * eqQ)
    if (not equilibriumExists) or (eqQ == 0.0 or Dslope == 0.0):
        DelacicityExists = false
    else:
        dEla = eqP / (Dslope * eqQ)
    //display values if can be displayed
    gl.color(color_black)
    gl.set_font_size(24)
    gl.translate (int2{1100, 250}):
        gl.text("Equilibrium Price")
    gl.translate (int2{1100, 275}):
        if equilibriumExists:
            gl.text(string(eqP))
        else:
            gl.text(string("Not Computable"))
    gl.translate (int2{1100, 325}):
        gl.text("Equilibrium Quantity")
    gl.translate (int2{1100, 350}):
        if equilibriumExists:
            gl.text(string(eqQ))
        else:
            gl.text(string("Not Computable"))
    gl.translate (int2{1100, 400}):
        gl.text("At Equilibrium:")
    gl.translate (int2{1100, 450}):
        gl.text("Supply Elasticity")
    gl.translate (int2{1100, 475}):
        if SelacityExists:
            gl.text(string(sEla))
        else:
            gl.text(string("Not Computable"))
    gl.translate (int2{1100, 525}):
        gl.text("Demand Elasticity")
    gl.translate (int2{1100, 575}):
        if DelacicityExists:
            gl.text(string(dEla))
        else:
            gl.text(string("Not Computable"))
    
    

fatal(gl.window("Supply-Demand Simulation", 1324, 868))
gl.set_font_name("Roboto-Regular.ttf")

var DemandSlope = -1.0
var DemandIntercept = 100.0
var SupplySlope = 1.0
var SupplyIntercept = 0.0

var xScale = 100
var yScale = 100

var cur_box = 0
var num = -1

while gl.frame() and gl.button("escape") != 1:

    gl.clear(color_white)

    drawGraph()
    drawLines(DemandSlope, DemandIntercept, SupplySlope, SupplyIntercept, xScale, yScale)
    populateGraph(xScale, yScale)
    if gl.button("mouse1") == 1 and gl.mouse_pos(0)[0] > 50 and gl.mouse_pos(0)[0] < 200:
        //change currently selected box based on
        if gl.mouse_pos(0)[1] > 50 and gl.mouse_pos(0)[1] < 150:
            cur_box = 0
        if gl.mouse_pos(0)[1] > 190 and gl.mouse_pos(0)[1] < 290:
            cur_box = 1
        if gl.mouse_pos(0)[1] > 330 and gl.mouse_pos(0)[1] < 430:
            cur_box = 2
        if gl.mouse_pos(0)[1] > 470 and gl.mouse_pos(0)[1] < 570:
            cur_box = 3
        if gl.mouse_pos(0)[1] > 610 and gl.mouse_pos(0)[1] < 710:
            cur_box = 4
        if gl.mouse_pos(0)[1] > 740 and gl.mouse_pos(0)[1] < 840:
            cur_box = 5
    drawBoxes(cur_box)
    //check for digit press and act on currently selected box
    num = getDigit()
    if num != -1:
        if cur_box == 0:
            //a little different because demand slope is always 0 or negetive (in simulation not always in real world)
            if num < 10:
                DemandSlope = (DemandSlope * 10.0) - num
            else:
                DemandSlope = float(ceiling(DemandSlope / 10.0))
        if cur_box == 1:
            if num < 10:
                DemandIntercept = (DemandIntercept * 10.0) + num
            else:
                DemandIntercept = float(floor(DemandIntercept / 10.0))
        if cur_box == 2:
            if num < 10:
                SupplySlope = (SupplySlope * 10.0) + num
            else:
                SupplySlope = float(floor(SupplySlope / 10.0))
        if cur_box == 3:
            if num < 10:
                SupplyIntercept = (SupplyIntercept * 10.0) + num
            else:
                SupplyIntercept = float(floor(SupplyIntercept / 10.0))
        // scales use int values
        if cur_box == 4:
            if num < 10:
                xScale = (xScale * 10) + num
            else:
                xScale = floor(xScale / 10.0)
        if cur_box == 5:
            if num < 10:
                yScale = (yScale * 10) + num
            else:
                yScale = floor(yScale / 10.0)
    populateInputs(DemandSlope, DemandIntercept, SupplySlope, SupplyIntercept, xScale, yScale)
    populateOutputs(DemandSlope, DemandIntercept, SupplySlope, SupplyIntercept)
    //display outputs (equilibriums, surplus, elacity)

    /*TODO:
    output display
    */