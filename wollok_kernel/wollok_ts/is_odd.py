import pythonmonkey as pm

is_odd = pm.require("is-odd")

def fn_is_odd(value):
    print('Calling is odd!')
    return is_odd(2)