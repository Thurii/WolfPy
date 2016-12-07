# WolfPy
## Python module for evaluating Wolfram Language code

The "relay" class allows one to send code to a Wolfram kernel running wolfpy.
Once the Wolfram code has been evaluated wolfpy will do its best to port it to Python.
In the event that Python's side isn't able to "eval" the result then it's returned as a string.

### What's working:
1. Numbers (Integers, fractions, floats, complex numbers)
2. Lists
3. Exponention, Multiplication, Division, Addition, Subtraction
