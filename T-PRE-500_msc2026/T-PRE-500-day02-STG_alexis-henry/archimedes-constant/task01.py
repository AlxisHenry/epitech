def pi(terms):
    estimation = 0.0
    sign = 1.0
    for i in range(terms):
        denominator = 2 * i + 1
        estimation += sign * (4.0 / denominator)
        sign *= -1.0
    return round(estimation, 6)

print(pi(1000000))
