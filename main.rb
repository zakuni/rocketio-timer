class TimerApp < Sinatra::Base
  register Sinatra::RocketIO
  io = Sinatra::RocketIO
  Slim::Engine.set_default_options :pretty => true

  get '/' do
    timer = EventMachine::PeriodicTimer.new(1) do
      ## push "tick" to client        
      io.push :tick, Time.now
    end
    slim :index
  end
end