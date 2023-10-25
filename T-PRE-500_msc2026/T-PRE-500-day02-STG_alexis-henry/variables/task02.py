def power(base, exponent):
    result = 1
    for _ in range(exponent):
        result *= base
    return result

print(power(17, 1024))