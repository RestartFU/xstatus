require "x11"
require "logger"
require "./config"

def set_status(dpy, status)
    dpy.store_name dpy.default_root_window, status
    dpy.flush
end

def terminate(dpy, code)
    set_status dpy, ""
    exit 0
end

begin
    dpy = X11::Display.new
rescue ex
    Logger.errorln ex; exit -1
end

# This makes sure the status is set back to an empty String when
# The program is terminated.
Signal::INT.trap do
    terminate dpy, 0
end

while true
    begin
        status = [] of String
        Config::Default.each do |c|
            status << c.function.call(c.format, c.arguments)
        end

        set_status dpy, status.join(" | ")
    rescue ex
        Logger.errorln ex; exit -1
    end
    sleep 1.second
end