require "io"

def exec_out(args : Array(String)) : String
    io = IO::Memory.new
    Process.run(args.join(" "), shell: true, output: io)
    io.to_s
end

def text(s : String, a : Array(String)) : String
    s
end

def date(s : String, a : Array(String)) : String
    outp = exec_out(["date", a.join(" ")])
    s.gsub("%s", outp).rstrip
end

module Config
    extend self
    struct Field
        getter function : String, Array(String) -> String
        getter format : String
        getter arguments : Array(String)

        def initialize(@function, @format, @arguments); end
    end
    Default = [
        Field.new(->text(String, Array(String)), "Pr4gu3", [""]),
        Field.new(->date(String, Array(String)), "%s", ["+%r"]),
    ]
end