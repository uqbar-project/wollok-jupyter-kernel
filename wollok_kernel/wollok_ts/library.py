import pythonmonkey as pm

# ===================================================================
# Polyfills

with open("wollok_kernel/wollok_ts/polyfills/module.js") as module_file:
    module_code = module_file.read()

pm.eval(module_code)

with open("wollok_kernel/wollok_ts/polyfills/crypto.js") as crypto_file:
    crypto_code = crypto_file.read()

pm.eval(r'defineModule("crypto", "{crypto_code}")')

# ===================================================================

wollok = pm.require("./wollok.js")

def execute_repl(expression: str) -> str:
    """Call Wollok REPL with the given value.

    Args:
        expression: executable code in Wollok.

    Returns:
        str: Wollok interpreter output.
    """
    try:
        print(f"Executing: {expression}")
        result = wollok.repl(expression)
        return str(result)
    except (ValueError, TypeError):
        return "Invalid input"
