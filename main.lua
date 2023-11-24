PIX = require "PIX"
map={{1,2},{3,4}}
resolution = 768
function love.load()
    love.window.setMode(1366, resolution, {resizable=true, vsync=true, minwidth=256, minheight=144})
	love.window.setFullscreen(true)
    -- how to use: PIX.init(minimum width,minimum height, scaling mode)

    PIX.init(256,144,"floor") -- tries most optimal amount of pixels for the aspect ratio, pixels will all be equal size
    --PIX.init(128,128,"stretch") -- steches the pixels to fill the screen, pixels could be differnt size
    --PIX.init(256,144,resolution/144) -- fixed mode, set the amount the pixels will scale, in this case 3x
    test = PIX.newImage("index.png") -- helper for images drawn inside PIX

	tileset=love.graphics.newSpriteBatch(test,16*16)

end

function DrawPixelated()
    love.graphics.circle("fill",0,0,50)
    love.graphics.circle("fill",PIX.width,PIX.height,50)

    love.graphics.draw(test,250,140,0,1/16,1/16)
end

function love.draw()
    -- pass function to draw in pixelated mode
    PIX.draw(DrawPixelated)
end

function love.resize(w, h)
    -- resize to fill the screen
    PIX.resize()
end
  
