"""
First smoke test for Wollok. TODO: develop
"""

import unittest

import jupyter_kernel_test as jkt


class WollokKernelTests(jkt.KernelTests):

    # REQUIRED

    # the kernel to be tested
    # this is the normally the name of the directory containing the
    # kernel.json file - you should be able to do
    # `jupyter console --kernel KERNEL_NAME`
    kernel_name = "wollok"

    # Everything else is OPTIONAL

    # the name of the language the kernel executes
    # checked against language_info.name in kernel_info_reply
    language_name = "wollok"

    # the normal file extension (including the leading dot) for this language
    # checked against language_info.file_extension in kernel_info_reply
    file_extension = ".wlk"

    # code which should write the exact string `hello, world` to STDOUT
    code_hello_world = "hello, world"


if __name__ == "__main__":
    unittest.main()
