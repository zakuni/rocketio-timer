class TimerApp < Sinatra::Base
  register Sinatra::RocketIO
  io = Sinatra::RocketIO
  Slim::Engine.set_default_options :pretty => true

  get '/' do
    EM.run do
      n = 0
      timer = EventMachine::PeriodicTimer.new(1) do
        ## push "tick" to client        
        io.push :tick, Time.now
        # timer.cancel if (n+=1) > 5
      end
    end
    slim :index
  end
end