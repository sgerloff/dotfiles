from visidata import vd

from plugins.server import server


vd.status("Initialize custom config")
vd.execAsync(server)
vd.status("Initialization done!")
