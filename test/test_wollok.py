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

    # code samples
    code_execute_result = [
        {"code": "6", "result": "6"}
        ]

    def test_execute_result(self) -> None:
        if not self.code_execute_result:
            raise SkipTest("No code execute result")

        for sample in self.code_execute_result:
            with self.subTest(code=sample["code"]):
                self.flush_channels()
                reply, output_msgs = self.execute_helper(sample["code"])
                self.assertEqual(reply["content"]["status"], "ok")
                self.assertGreaterEqual(len(output_msgs), 1)
                for msg in output_msgs:
                    print(" result ****** " + str(msg))
                    self.assertIsNotNone(msg["content"]["text"], "No content.text received")
                    if "result" in sample:
                        self.assertEqual(msg["content"]["text"], sample["result"])


if __name__ == "__main__":
    unittest.main()
