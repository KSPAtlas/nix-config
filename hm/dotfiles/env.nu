# Nushell Environment Config File
#
# version = "0.94.2"

def create_left_prompt [] {
    let dir = match (do --ignore-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"
    let ps_colour = $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
    let is_nix_shell = if (($env.PATH | find /nix/store | length) != 0) { '📦 ' } else { '' }
    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
        " "
    ] | str join)
    } else { "" }

    $"($is_nix_shell)(ansi green)(whoami)(ansi reset)@((sys host).hostname) ($last_exit_code)($ps_colour)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add "/home/ksp/.local/share/coursier/bin"
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# Display an XKCD comic using the Kitty image protocol
def xkcd [
    number = "" # The number of the comic to display
    --random(-r) # Pick a random comic
    ] {
    let num = if $random {
        random int 1..(http get "https://xkcd.com/info.0.json").num
    } else { $number }
    let xkcd = (http get $"https://xkcd.com/($num)/info.0.json")
    print {title: $xkcd.title, date: ($"($xkcd.year)-($xkcd.month)-($xkcd.day)" | into datetime), num: $xkcd.num, alt: $xkcd.alt}
    http get $xkcd.img | img2sixel
}

let nix_config_path = $"($env.HOME)/nixcfg"

# Rebuild the Nix system
def "qnix r" [] {
    nixos-rebuild switch --use-remote-sudo --flake $nix_config_path
}

# Rebuild the Nix system quickly for iterative dev
def "qnix f" [] {
    nixos-rebuild switch --use-remote-sudo --fast --flake $nix_config_path
}

# List packages in a nix shell
def "qnix ls" [] {
    $env.PATH
    | filter {|it| $it starts-with '/nix/store' }
    | parse --regex '[a-z0-9]{32}-(?<package>.*)-(?<version>.*)/'
}

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

alias edit = hx # emacs best editor fr
$env.EDITOR = 'hx'

$env.LS_COLORS = (vivid generate molokai | str trim)
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
