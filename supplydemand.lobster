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

def drawLines(Dslope, Dinter, Sslope, Sinter):
    //find points for demand line
    let Dpoint1 = float2{350.0, 700.0 - Dinter}
    let Dpoint2 = float2{1000.0, 700.0 - Dinter - (100.0 * Dslope)}
    gl.color(color_red)
    gl.line(Dpoint1, Dpoint2, 5.0)
    //indicate Demand curve
    gl.set_font_size(48)
    gl.translate (int2{int(Dpoint2[0]), int(Dpoint2[1]) - 100}):
        gl.text("D")


    //find points for suply line
    let Spoint1 = float2{350.0, 700.0 - Sinter}
    let Spoint2 = float2{1000.0, 700.0 - Sinter - (100.0 * Sslope)}
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
    
/*
so i want some variables to be changeable but i need to code that in later

Demand slope = -5.0
Demand Intercept = 500.0
Suply slope = 5.0
Suply Intercept = 0.0
X scale = 100
Y scale = 550
*/

fatal(gl.window("Supply-Demand Simulation", 1324, 868))
gl.set_font_name("Roboto-Regular.ttf")

var cur_box = 0

while gl.frame() and gl.button("escape") != 1:

    gl.clear(color_white)

    drawGraph()
    drawLines(-5.0, 500.0, 5.0, 0.0)
    populateGraph(100, 550)
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
    //adjust inputs (0-9 + backspace)
    populateInputs(-5.0, 500.0, 5.0, 0.0, 100, 550)
    //display outputs (equilibriums, surplus)