import os
import datetime

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    # Append private mode indicator
    if is_fish_private_mode(tab):
        tab = tab._replace(title=tab.title + " 💼")

    #if timer_id is None:
    #    timer_id = add_timer(_redraw_tab_bar, 2.0, True)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        draw_right_status(draw_data, screen)

    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    separator = " | "
    cells = create_cells()

    # Drop cells that wont fit
    while True:
        right_margin_size = sum(len(c) for c in cells) + len(separator) * (len(cells) - 1)
        padding = screen.columns - screen.cursor.x - right_margin_size
        if padding >= 0:
            break
        cells = cells[1:]
        if not cells:
            break

    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)

    screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # Draw the separator
        if cell != cells[0]:
            screen.cursor.fg = tab_fg
            screen.cursor.bg = default_bg
            screen.draw(separator)

        screen.cursor.fg = tab_fg
        screen.cursor.bg = default_bg
        screen.draw(f"{cell}")


def _parent_pid(pid: int) -> int | None:
    try:
        with open(f'/proc/{pid}/status', 'rb') as f:
            for line in f:
                if line.startswith(b'PPid:'):
                    return int(line.split()[1])
    except OSError:
        pass
    return None


def _is_fish_process(pid: int) -> bool:
    try:
        with open(f'/proc/{pid}/cmdline', 'rb') as f:
            exe = f.read().split(b'\x00')[0]
        return exe == b'fish' or exe.endswith(b'/fish')
    except OSError:
        return False


def is_fish_private_mode(tab_data: TabBarData) -> bool:
    boss = get_boss()
    tab = boss.tab_for_id(tab_data.tab_id)
    if not tab or not tab.active_window:
        return False

    child = tab.active_window.child
    shell_pid = child.pid
    if shell_pid is None:
        return False

    # Walk up process tree and find first fish process
    pid = child.pid_for_cwd or shell_pid
    for _ in range(32):
        if _is_fish_process(pid):
            # Check if fish process marked as private: requires custom fish config
            return os.path.exists(f'/tmp/fish-private-{pid}')
        if pid == shell_pid:
            break
        pid = _parent_pid(pid)
        if pid is None:
            break
    return False


def get_shell_var_for_tab(tab_data: TabBarData, var: str) -> str | None:
    boss = get_boss()
    tab = boss.tab_for_id(tab_data.tab_id)
    if not tab or not tab.active_window:
        return None
    return tab.active_window.child.foreground_environ.get(var)


def get_cwd():
    win = get_boss().active_tab_manager.active_window
    if win:
        home = os.getenv('HOME')
        return win.cwd_of_child.replace(home, '~')
    else:
        return '?'


def create_cells() -> list[str]:
    now = datetime.datetime.now()
    return [
        '  ' + get_cwd(),
        now.strftime("%d %b"),
        now.strftime("%H:%M"),
    ]


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
