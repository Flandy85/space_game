# Require ruby gosu library
require 'gosu'

# ZOrder module for background, stars, player
module ZOrder
	BACKGROUND, STARS, PLAYER, UI = *0..3
end

# Class Toturial with inheritance from Gosu
class Tutorial < Gosu::Window
	def initialize
		# Fullscreen: super 640, 480, :fullscreen => true
		super 800, 600 # How big window game is: 640 px wide & 480px high
		self.caption = "The Badass Spacegame" # Puts title on the pop window
		# Fetch and show background image in game window
		@background_image = Gosu::Image.new("images/space.png", :tileable => true)

		# Instance variables for player and stars
		@player = Player.new
		@player.warp(320, 240)

		@star_anim = Gosu::Image.load_tiles("images/star.png", 25, 25)
    	@stars = Array.new

    	@font = Gosu::Font.new(25)
	end

	#updates the game when playing user movment
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
		@player.collect_stars(@stars)

	    if rand(100) < 4 and @stars.size < 25
	      @stars.push(Star.new(@star_anim))
	    end
	end
	

	# Rendrer game on to gamewindow
	def draw
		# Calls instance variable and draws it, the numbers its location where in the gamewindow shall space image be drawn
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@stars.each { |star| star.draw }
		@font.draw("Your Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
	end

	# Close game window if escape button is pressed
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
	attr_reader :score

	def initialize
		#instance variables
		@image = Gosu::Image.new("images/starfighter.bmp")
		@beep = Gosu::Sample.new("images/beep.wav")
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

	def score
		@score
	end

	def collect_stars(stars)
		stars.reject! { |star| Gosu.distance(@x, @y, star.x, star.y) < 35 }
	end
end


# Star animation class
class Star
	attr_reader :x, :y

	def initialize(animation)
		@animation = animation
	    @color = Gosu::Color::BLACK.dup
	    @color.red = rand(256 - 40) + 40 # Generate random color with red basis
	    @color.green = rand(256 - 40) + 40 # Generate random color with green basis
	    @color.blue = rand(256 - 40) + 40 # Generate random color with blue basis
	    @x = rand * 640
	    @y = rand * 480
	end

	def draw
		img = @animation[Gosu.milliseconds / 100 % @animation.size]
	    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
	        ZOrder::STARS, 1, 1, @color, :add)
	end
end


# Show game window
Tutorial.new.show 