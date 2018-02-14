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

		@player = Player.new
		@player.warp(320, 240)
	end

	#updates the game when playing
	def update
		if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
		  @player.turn_left
		end
		if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
		  @player.turn_right
		end
		if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
		  @player.accelerate
		end
		@player.move
		end
	end

	# Rendrer game on to gamewindow
	def draw
		# Calls instance variable and draws it, the numbers its location where in the gamewindow shall space image be drawn
		@player.draw
		@background_image.draw(0, 0, 0)
	end

	def button_down(id)
	    if id == Gosu::KB_ESCAPE
	      close
	    else
	      super
	    end
	end
end

# Main Class Player
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
end

# Star animation class
class Star
	attr_reader :x, :y

	def initialize
		@animation = animation
	    @color = Gosu::Color::BLACK.dup
	    @color.red = rand(256 - 40) + 40 # Generate random color with red basis
	    @color.green = rand(256 - 40) + 40 # Generate random color with green basis
	    @color.blue = rand(256 - 40) + 40 # Generate random color with blue basis
	    @x = rand * 640
	    @y = rand * 480
	end

	def draw
	end
end

module ZOrder
	BACKGROUND, STARS, PLAYER, UI = *0..3
end
# Show game window
Tutorial.new.show 