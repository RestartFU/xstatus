## Configuration
You may edit the file located at `$HOME/.config/xstatus/config.toml`
```yaml
# default config

seperator: "|"
commands: [
    "Restart", 
    "$(date +%a) $(date +%b) $(date +%d)", 
    "$(date +%r)",
]
```
## Setup
To install this project, run:
```
git clone https://github.com/restartfu/xstatus
cd xstatus
sudo make install
```
Or one liner:
```
git clone https://github.com/restartfu/xstatus && cd xstatus && sudo make install
```
