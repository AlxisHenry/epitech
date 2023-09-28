import math

def reducef(numerator, denominator):
    gcd = math.gcd(numerator, denominator)
    reduced_numerator = numerator // gcd
    reduced_denominator = denominator // gcd
    return reduced_numerator, reduced_denominator

numerator = int(input("Enter the numerator: "))
denominator = int(input("Enter the denominator: "))

print(reducef(numerator, denominator))
