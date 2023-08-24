import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics
local geo <const> = pd.geometry
local point <const> = geo.point
local vector <const> = geo.vector2D
local timer <const> = pd.timer

function runSplashScreen()

	class("SplashScreen").extends(gfx.sprite)

	function SplashScreen:init()
		SplashScreen.super.init(self)
		local image <const> = gfx.image.new("images/blue-looking-regal")

		gfx.pushContext(image)
			gfx.setColor(gfx.kColorWhite)
			gfx.fillRoundRect(263, 9, 89, 25, 3)
			gfx.drawRoundRect(259, 5, 97, 33, 7)
			gfx.drawText("Blue's Balls", 267, 12)
		gfx.popContext()	

		self:setImage(image)
		self:setCenter(0, 0)
		self:moveTo(0, 0)
		self:add()
	end

	SplashScreen()

end

function runStandardTimer()
	local callback <const> = function (caller)
		print ("Tick!")
		print(caller)
	end

	local myTimer <const> = timer.new(2000, callback)
	myTimer.repeats = true
end

function runPointAndVectorTests()
	local a, b <const> = 10, 20
	local vectors <const> = {
		v1 = vector.new(a, a),
		v2 = vector.new(a, a),
		v3 = vector.new(a, b)
	}

	local points <const> = {
		p1 = point.new(a, a),
		p2 = point.new(a, a),
		p3 = point.new(a, b)
	}

	printTable("=== Vectors ===", vectors)
	print(string.format("%s == %s = %s", vectors.v1, vectors.v2, vectors.v1 == vectors.v2))
	print(string.format("%s == %s = %s", vectors.v2, vectors.v3, vectors.v2 == vectors.v3))
	print(string.format("%s == %s = %s", vectors.v3, vectors.v1, vectors.v3 == vectors.v1))
	print(string.format("%s == %s = %s", vectors.v2, vectors.v1, vectors.v2 == vectors.v1))
	print(string.format("%s == %s = %s", vectors.v3, vectors.v2, vectors.v3 == vectors.v2))
	print(string.format("%s == %s = %s", vectors.v1, vectors.v3, vectors.v1 == vectors.v3))

	printTable("=== Points ===", points)
	print(string.format("%s == %s = %s", points.p1, points.p2, points.p1 == points.p2))
	print(string.format("%s == %s = %s", points.p2, points.p3, points.p2 == points.p3))
	print(string.format("%s == %s = %s", points.p3, points.p1, points.p3 == points.p1))
	print(string.format("%s == %s = %s", points.p2, points.p1, points.p2 == points.p1))
	print(string.format("%s == %s = %s", points.p3, points.p2, points.p3 == points.p2))
	print(string.format("%s == %s = %s", points.p1, points.p3, points.p1 == points.p3))

	print("=== Point + vector ===")
	print(string.format("%s + %s = %s", points.p2, vectors.v1, points.p2 + vectors.v1))
end


function runTableManipulation()
	local myArray <const> = {1, 2, 3}
	printTable(myArray)
	table.remove(myArray)
	printTable(myArray)
end

local EXAMPLES <const> = {
	SplashScreen = runSplashScreen,
	VectorTests = runPointAndVectorTests,
	TableManipulation = runTableManipulation,
	Timers = {
		StandardTimer = runStandardTimer
	}
}

EXAMPLES.TableManipulation()

function playdate.update()
	gfx.sprite.update()
	timer.updateTimers()
end