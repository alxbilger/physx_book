from typst_utils import typst_print

test_cases = [
    ("N[0]*X[0]", "N_x X_x"),
    ("N[1]*X[1]", "N_y X_y"),
    ("N[2]*X[2]", "N_z X_z"),
    ("N[0]*X[0] + N[1]*X[1] + N[2]*X[2]", "N_x X_x + N_y X_y + N_z X_z"),
    ("a*b*c", "a b c"),
]

for input_str, expected in test_cases:
    result = typst_print(input_str)
    print(f"Input:    {input_str}")
    print(f"Result:   {result}")
    print(f"Expected: {expected}")
    assert result == expected
    print("-" * 20)

print("All tests passed!")
