#!/usr/bin/env python3

import asyncio
import iterm2

Dir = iterm2.tab.NavigationDirection
Key = iterm2.keyboard.Keycode
Modifier = iterm2.keyboard.Modifier

directions = {"h": Dir.LEFT, "j": Dir.BELOW, "k": Dir.ABOVE, "l": Dir.RIGHT}
reverse = {"h": "L", "j": "K", "k": "J", "l": "H"}


async def do_nav(tab, motion, force=False):
    if (
        not force
        and await tab.current_session.async_get_variable("user.nvim") == "true"
    ):
        await tab.current_session.async_send_text("\x1b" + motion)
    else:
        await tab.async_select_pane_in_direction(directions[motion])
        if await tab.current_session.async_get_variable("user.nvim") == "true":
            await tab.current_session.async_send_text("\x1b" + reverse[motion])


async def handle_nav_keys(app, connection):
    async with iterm2.KeystrokeMonitor(connection) as mon:
        while True:
            try:
                keystroke = await mon.async_get()
                if (
                    keystroke.modifiers == [Modifier.OPTION]
                    and keystroke.characters_ignoring_modifiers in directions
                ):
                    tab = app.current_window and app.current_window.current_tab
                    if tab:
                        await do_nav(tab, keystroke.characters_ignoring_modifiers)
            except iterm2.rpc.RPCException as e:
                print(e)


async def handle_force_nav(app, connection):
    async with iterm2.CustomControlSequenceMonitor(
        connection, "force_nav", r"^[hjkl]$"
    ) as mon:
        while True:
            try:
                tab = app.current_window and app.current_window.current_tab
                if tab:
                    await do_nav(tab, (await mon.async_get()).group(0), True)
            except iterm2.rpc.RPCException as e:
                print(e)


async def main(connection):
    app = await iterm2.async_get_app(connection)

    asyncio.create_task(handle_nav_keys(app, connection))
    asyncio.create_task(handle_force_nav(app, connection))

    pat = iterm2.KeystrokePattern()
    pat.required_modifiers = [Modifier.OPTION]
    pat.keycodes = [Key.ANSI_H, Key.ANSI_J, Key.ANSI_K, Key.ANSI_L]
    async with iterm2.KeystrokeFilter(connection, [pat]):
        await iterm2.async_wait_forever()


iterm2.run_forever(main)
