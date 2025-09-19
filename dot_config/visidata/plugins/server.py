from visidata.vdobj import VisiData
from visidata import BaseSheet, vd


def send_status(msg: str, vd: VisiData = vd) -> None:
    vd.status(msg)


def get_env(var: str) -> str | None:
    import os

    return os.environ.get(var)


def recv_until_terminator(
    conn, recv: int = 4096, terminator: str = b"\n"
) -> str | None:
    buffer = b""
    while True:
        chunk = conn.recv(recv)
        if not chunk:
            break
        buffer += chunk
        if terminator in buffer:
            line, _, _ = buffer.partition(terminator)
            return line.decode("utf-8").strip()
    return None


def parse_message(data: str) -> dict():
    import json

    return json.loads(data)


def handle(data: dict, vd=vd, logger=None):
    from visidata import Path
    import logging
    logger = logger if logger else logging.getLogger()

    cmd = data.get("cmd")
    if cmd == "open":
        logger.debug("Start open cmd:")
        path_str = data.get("path")
        if not path_str:
            return
        logger.debug(f"Request for raw {path_str}")
        path = Path(path_str)
        logger.info(f"Request for {path}")

        requested_sheet = None
        for sheet in vd.sheets:
            try:
                source_path = str(sheet.source._path.absolute())
                logger.debug(f"Existing sheet: {sheet}, {source_path}")
            except Exception as e:
                logger.warning(f"Failed to infer path from existing sheet: {e}")
                continue
            if str(path) == source_path:
                logger.info(f"Found exising sheet for {path}.")
                sheet.reload()
                requested_sheet = sheet
                break
                
        if not requested_sheet:
            logger.info(f"Open new sheet for {path}")
            requested_sheet = vd.openPath(path)

        logger.debug(f"Push {requested_sheet}")
        vd.push(requested_sheet)
        return
    if cmd == "test":
        return
    return


def server(vd: VisiData = vd) -> None:
    import os
    import socket
    import logging

    logging.basicConfig(filename="/tmp/vd_server.log", level=logging.INFO)
    LOGGER = logging.getLogger("vd-server")

    SOCK_PATH = get_env("VD_SOCK_PATH")
    if not SOCK_PATH:
        send_status("No VD_SOCK_PATH, skip server", vd=vd)
        return

    if os.path.exists(SOCK_PATH):
        os.unlink(SOCK_PATH)

    send_status(f"Info: Setup socket: {SOCK_PATH}", vd=vd)
    SOCK = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    SOCK.bind(SOCK_PATH)
    SOCK.listen(1)
    SOCK.settimeout(1)
    send_status("Info: Setup done!", vd=vd)

    while True:
        try:
            CONN, _ = SOCK.accept()
        except socket.timeout:
            continue
        except Exception as e:
            send_status(f"Warning: Connection error {e}", vd=vd)
            continue

        with CONN:
            try:
                data = recv_until_terminator(CONN)
                LOGGER.info(f"{data=}")
                parsed_data = parse_message(data)
                handle(parsed_data, vd=vd, logger=LOGGER)
            except Exception as e:
                LOGGER.exception(e)
                send_status(f"Warning: Connection handling error {e}", vd=vd)
