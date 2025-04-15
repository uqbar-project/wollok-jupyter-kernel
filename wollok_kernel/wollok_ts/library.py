# import pythonmonkey as pm

def fn_is_odd_python(value):
    try:
        return str(int(value) % 2 != 0)
    except (ValueError, TypeError):
        return "Invalid input"

# is_odd = pm.require("is-odd")
    
# def fn_is_odd(value):
#     try:
#         number = int(value)
#         return str(is_odd(number))
#     except (ValueError, TypeError):
#         return "Invalid input"
    
    