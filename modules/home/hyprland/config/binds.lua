local mod = "SUPER"

local browser = "brave"
local terminal = "kitty"
local editor = "code -n"
local file_browser = "nautilus"
local webapp = browser .. "--new-window --app="

hl.config({
    binds = {
        drag_threshold = 10,
    },
})

-- Start programs
hl.bind(mod .. " + Q", 
    hl.dsp.exec_cmd(terminal)
)

hl.bind(mod .. " + SHIFT + O",
  hl.dsp.exec_cmd(browser)
)

hl.bind(mod .. " + SHIFT + P",
  hl.dsp.exec_cmd(browser .. " --incognito")
)

hl.bind(mod .. " + E",
  hl.dsp.exec_cmd(file_browser)
)

hl.bind(mod .. " + SHIFT + N",
  hl.dsp.exec_cmd(editor .. " ~/nix")
)

hl.bind(mod .. " + SHIFT + escape",
  hl.dsp.exec_cmd(
    terminal .. " --start-as=normal -- bash -ic 'btop'"
  )
)

hl.bind(mod .. " + ALT + P",
  hl.dsp.exec_cmd(
    [[eza -ld "$HOME"/projects/* --color=never |
      awk '{print $7}' |
      wofi --dmenu --prompt "Open project:" |
      xargs -I{} code {} -n]]
  )
)

hl.bind(mod .. " + RETURN",
  hl.dsp.exec_cmd(webapp .. "https://claude.ai")
)

-- Window navigation

hl.bind(mod .. " + H",
  hl.dsp.focus({ direction = "l" })
)

hl.bind(mod .. " + L",
  hl.dsp.focus({ direction = "r" })
)

hl.bind(mod .. " + K",
  hl.dsp.focus({ direction = "u" })
)

hl.bind(mod .. " + J",
  hl.dsp.focus({ direction = "d" })
)

hl.bind(mod .. " + C",
  hl.dsp.window.close()
)

-- Workspace movement

hl.bind(mod .. " + ALT + L",
  hl.dsp.window.move({
    workspace = "r+1",
    follow = true,
  })
)

hl.bind(mod .. " + ALT + H",
  hl.dsp.window.move({
    workspace = "r-1",
    follow = true,
  })
)

hl.bind(mod .. " + SHIFT + L",
  hl.dsp.focus({
    workspace = "r+1",
  })
)

hl.bind(mod .. " + SHIFT + H",
  hl.dsp.focus({
    workspace = "r-1",
  })
)

-- Window management

hl.bind(mod .. " + 0",
  hl.dsp.layout("rollnext")
)

hl.bind(mod .. " + F",
  hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
  })
)

hl.bind(mod .. " + V",
  hl.dsp.window.float({
    action = "toggle",
  })
)

-- Launcher

hl.bind(mod .. " + SPACE",
  hl.dsp.exec_cmd("waycast show")
)

hl.bind(mod .. " + SHIFT + SPACE",
  hl.dsp.exec_cmd(
    "/home/javi/projects/waycast/target/release/waycast"
  )
)

-- Screenshots

hl.bind(mod .. " + SHIFT + S",
  hl.dsp.exec_cmd("flameshot gui")
)

hl.bind("Print",
  hl.dsp.exec_cmd("hyprshot --mode output")
)

-- Special workspaces

hl.bind(mod .. " + SHIFT + C",
  hl.dsp.workspace.toggle_special("comms")
)

hl.bind(mod .. " + SHIFT + A",
  hl.dsp.workspace.toggle_special("research")
)

-- Session

hl.bind(mod .. " + SHIFT + ALT + X",
  hl.dsp.exit()
)

hl.bind(mod .. " + SHIFT + ALT + L",
  hl.dsp.exec_cmd("hyprlock")
)

-- Workspaces 1-9

for i = 1, 9 do
  local keycode = "code:" .. tostring(9 + i)
  local workspace = tostring(i)

  hl.bind(
    mod .. " + " .. keycode,
    hl.dsp.focus({
      workspace = workspace,
    })
  )

  hl.bind(
    mod .. " + SHIFT + " .. keycode,
    hl.dsp.window.move({
      workspace = workspace,
      follow = true,
    })
  )
end
