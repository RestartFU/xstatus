require "x11"
require "logger"
require "./config"

class Program
    getter dpy : X11::Display

    def initialize
        @dpy = X11::Display.new
    end

    def set_status(status)
        @dpy.store_name dpy.default_root_window, status
        @dpy.flush
    end

    def terminate(code)
        set_status ""
        exit 0
    end

    def trap_signals(signals : Array) 
        signals.each do |s|
            s.trap do
                terminate 0
            end
        end
    end

    include Config
    def run
    # This makes sure the status is set back to an empty String when
    # The program is terminated.
    trap_signals [Signal::INT, Signal::TERM, Signal::KILL, Signal::HUP]

    while true
        begin
            status = [] of String
            CONFIG.each do |c|
                status << c.function.call(c.format, c.arguments)
            end

            set_status status.join(" | ")
        rescue ex
            Logger.errorln ex; exit -1
        end
        sleep 1.second
    end
    end
end

p = Program.new
p.run