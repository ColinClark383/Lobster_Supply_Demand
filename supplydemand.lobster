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
/*
so i want some variables to be changeable but i need to code that in later

Demand slope = -5.0
Demand Intercept = 500.0
Suply slope = 5.0
Suply Intercept = 0.0
X scale = 100
Y scale = 550
selected box = 0
*/

fatal(gl.window("Supply-Demand Simulation", 1324, 868))
gl.set_font_name("Roboto-Regular.ttf")

while gl.frame() and gl.button("escape") != 1:

    gl.clear(color_white)

    drawGraph()
    drawLines(-5.0, 500.0, 5.0, 0.0)
    populateGraph(100, 550)
    //mouse logic (changes boxes)
    //adjust inputs
    //display outputs