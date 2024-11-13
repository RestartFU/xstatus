require "x11"
require "logger"
require "./config"

class XStatus
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

    def run
    # This makes sure the status is set back to an empty String when
    # The program is terminated.
    trap_signals [Signal::INT, Signal::TERM, Signal::KILL, Signal::HUP]

    while true
        begin
            conf = Config.new()
            status = [] of String
            conf.commands.each do |c|
                status << cmd("echo " + c).strip()
            end

            set_status status.join(" #{conf.seperator} ")
        rescue ex
            Logger.fatalln ex
        end
        sleep conf.refresh_delay.millisecond
    end
    end

    def cmd(str : String) : String
        io = IO::Memory.new
        Process.run(str, shell: true, output: io)
        io.to_s
    end
end

p = XStatus.new
p.run
