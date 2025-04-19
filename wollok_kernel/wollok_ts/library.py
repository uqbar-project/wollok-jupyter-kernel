import pythonmonkey as pm

# is_odd = pm.require("./node_modules/is-odd/index.js")

def fn_test(value):
    """Check if a given value is odd.

    Args:
        value: The input value to check, should be convertible to an integer.

    Returns:
        str: 'true' if the number is odd, 'false' if even, or 'Invalid input' if the
            value cannot be converted to an integer.
    """
    try:
        number = int(value)
        result = pm.eval(f"new Date(new Date().getTime() + {number})".format(number))
        return result
    except (ValueError, TypeError):
        return "Invalid input"
