## Configuration
You may edit `src/config.cr` to configure xstatus as you see fit.
```crystal
module Config
    extend self
    struct Field
        getter function : String, Array(String) -> String
        getter format : String
        getter arguments : Array(String)

        def initialize(@function, @format, @arguments); end
    end
    Default = [
#                 FUNCION                        FORMAT   ARGUMENTS       
        Field.new(->text(String, Array(String)), "Pr4gu3", [""]),
        Field.new(->date(String, Array(String)), "%s", ["+%r"]),
    ]
end
```
I recommend you only edit `Default` and not create a new constant.
## Setup
To install this project, run:
```
$ git clone https://github.com/Pr4gu3/xstatus
$ cd xstatus
$ sudo make install
```
