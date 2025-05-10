from IPython.core.magic import register_line_magic

@register_line_magic
def debugpy_start(port: str):
    try:
        import debugpy
    except ImportError:
        print("Debugpy is not installed!")
        return
    try:
        port = int(line.strip())
    except:
        port = 5678

    try:
        debugpy.listen(("0.0.0.0", port))
        print(f"✅ debugpy listening on port {port}. Waiting for client to attach...")
        if not debugpy.is_client_connected():
            debugpy.wait_for_client()
            print("✅ client attached!")
    except:
        print(f"Failed to connect debugpy")


