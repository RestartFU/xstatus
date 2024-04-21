## Configuration
You may edit `src/config.cr` to configure xstatus as you see fit.
```crystal
module Config
    extend self
    def run(args : Array(String)) : String
        io = IO::Memory.new
        Process.run(args.join(" "), shell: true, output: io)
        io.to_s
    end
    
    def text(s : String, a : Array(String)) : String
        s
    end
    
    def date(s : String, a : Array(String)) : String
        outp = run(["date", a.join(" ")])
        s.gsub("%s", outp).rstrip
    end

    struct Field
        getter function : String, Array(String) -> String
        getter format : String
        getter arguments : Array(String)

        def initialize(@function, @format, @arguments); end
    end

    CONFIG = [
#                           FUNCTION                                 FORMAT                       ARGUMENTS        
        Field.new(->text(String, Array(String)),                     "Pr4gu3",                      [""]),
        Field.new(->date(String, Array(String)),                     "%s",                          ["+%r"]),
    ]
end
```
## Setup
To install this project, run:
```
$ git clone https://github.com/restartfu/xstatus
$ cd xstatus
$ sudo make install
```
Or one liner:
```
$ git clone https://github.com/restartfu/xstatus && cd xstatus && sudo make install
```
