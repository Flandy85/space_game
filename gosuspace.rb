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
	end

	def turn_left
	end

	def turn_right
	end

	def accelerate
	end

	def move
	end

	def draw
	end

# Show game window
Tutorial.new.show 