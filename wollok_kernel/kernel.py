from ipykernel.kernelbase import Kernel
from wollok_kernel.wollok_ts.library import fn_test


class WollokKernel(Kernel):
    implementation = "Wollok"
    implementation_version = "1.2"
    language = "wollok"
    language_version = "3.3.1"
    language_info = {
        "name": "wollok",
        "mimetype": "text/plain",
        "file_extension": ".wlk",
    }
    banner = "Wollok >>> kernel"

    def do_execute(
        self, code, silent, store_history=True, user_expressions=None, allow_stdin=False
    ):
        if not silent:
            result = fn_test(code)
            stream_content = {"name": "stdout", "text": result, "data": result}
            self.send_response(self.iopub_socket, "stream", stream_content)

        return {
            "status": "ok",
            # The base class increments the execution count
            "execution_count": self.execution_count,
            "payload": [],
            "user_expressions": {},
        }

    def do_apply(self, content, bufs, msg_id, reply_metadata):
        return {"status": "ok", "started": True}
