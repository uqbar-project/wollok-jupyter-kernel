import pythonmonkey as pm

sha256 = pm.require("./sha256.js")


def fn_test(value):
    """Check if a given value is odd.

    Args:
        value: The input value to check, should be convertible to an integer.

    Returns:
        str: 'true' if the number is odd, 'false' if even, or 'Invalid input' if the
            value cannot be converted to an integer.
    """
    try:
        result = sha256(value)
        return str(result)
    except (ValueError, TypeError):
        return "Invalid input"
