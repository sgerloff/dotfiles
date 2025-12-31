c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.editor = "nvim"
c.TerminalInteractiveShell.true_color = True
c.TerminalInteractiveShell.highlighting_style = "catppuccin-mocha"
c.TerminalInteractiveShell.shortcuts = [
    {
        "command": "IPython:auto_suggest.accept_or_jump_to_end",
        "new_keys": ["c-l"],
        "create": True,
    },
    {
        "command": "IPython:shortcuts.open_input_in_editor",
        "new_keys": ["c-x"],
        "create": True,
    },
]
