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

  get %r{/([\d]+)} do
    sec = params[:captures].first.to_i
    timer = EventMachine::PeriodicTimer.new(1) do
      timer.cancel if sec <= 0      
      io.push :tick, sec
      sec = sec - 1
    end
    slim :index
  end
end