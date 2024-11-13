require "io"
require "toml"
require "yaml"

class Config
    include YAML::Serializable

    getter default : String = %(refresh_delay: 1
seperator: "|"
commands: [
        "Restart",
        "$(date +%a) $(date +%b) $(date +%d)",
        "$(date +%r)",
    ]
)
    @[YAML::Field(key: "refresh_delay")]
    property refresh_delay : Int64 = 1

    @[YAML::Field(key: "seperator")]
    property seperator : String = "|"

    @[YAML::Field(key: "commands")]
    property commands : Array(String) = [""]

    def initialize()
        ENV["XSTATUS_CONFIG_PATH"] ||= ENV["HOME"] + "/.config/xstatus/config.toml"
        path = ENV["XSTATUS_CONFIG_PATH"]
        Dir.mkdir_p(File.dirname(path))

        if !File.exists?(path)
            File.touch(path)
            File.write(path, @default)
        end

        content = File.read(path)
        config = Config.from_yaml(content)

        @seperator = config.seperator
        @commands = config.commands
    end
end
