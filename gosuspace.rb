# Require ruby gosu library
require 'gosu'

# Class Toturial with inheritance from Gosu
class Tutorial < Gosu::Window
	def initialize
		# Fullscreen: super 640, 480, :fullscreen => true
		super 800, 600 # How big window game is: 640 px wide & 480px high
		self.caption = "The Badass Spacegame" # Puts title on the pop window
	end
	#updates the game when playing
	def update
	end
	# Rendrer game on to gamewindow
	def draw
	end
end

# Show game window
Tutorial.new.show 