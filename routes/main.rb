# encoding: utf-8

class Podding < Sinatra::Application

	get "/" do
		@title = "Welcome to Podding"
		slim :main
	end

end
