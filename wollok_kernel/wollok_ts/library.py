import pythonmonkey as pm

sha256 = pm.require("./sha256.js")


def fn_test(value: str) -> str:
    """Check if a given value is odd.

    Args:
        value: The input value

    Returns:
        str: conversion to SHA256.
    """
    try:
        result = sha256(value)
        return str(result)
    except (ValueError, TypeError):
        return "Invalid input"
