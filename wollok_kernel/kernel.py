from ipykernel.kernelbase import Kernel
from .wollok_ts import fn_is_odd

class WollokKernel(Kernel):
    implementation = 'Wollok'
    implementation_version = '1.0'
    language = 'no-op'
    language_version = '0.1'
    language_info = {
        'name': 'wollok',
        'mimetype': 'text/plain',
        'file_extension': '.wlk',
    }
    banner = "Wollok >>> kernel"

    def do_execute(self, code, silent, store_history=True, user_expressions=None,
                   allow_stdin=False):
        if not silent:
            stream_content = {'name': 'stdout', 'text': fn_is_odd(code)}
            self.send_response(self.iopub_socket, 'stream', stream_content)

        return {'status': 'ok',
                # The base class increments the execution count
                'execution_count': self.execution_count,
                'payload': [],
                'user_expressions': {},
               }