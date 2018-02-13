# Require ruby gosu library
require 'gosu'

# Class Toturial with inheritance from Gosu
class Tutorial < Gosu::Window
	def initialize
		# Fullscreen: super 640, 480, :fullscreen => true
		super 800, 600 # How big window game is: 640 px wide & 480px high
		self.caption = "The Badass Spacegame" # Puts title on the pop window
		# Fetch and show background image in game window
		@background_image = Gosu::Image.new("images/space.png", :tileable => true)
	end
	#updates the game when playing
	def update
	end
	# Rendrer game on to gamewindow
	def draw
		# Calls instance variable and draws it, the numbers its location where in the gamewindow shall space image be drawn
		@background_image.draw(0, 0, 0)
	end
end

# Class Player
class Player
	def initialize
		#instance variables
		@image = Gosu::Image.new("images/starfighter.bmp")
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= 4.5 
	end

	def turn_right
		@angle += 4.5
	end

	def accelerate
		@vel_x += Gosu.offset_x(@angle, 0.5)
		@vel_y += Gosu.offset_y(@angle, 0.5)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end

# Show game window
Tutorial.new.show 