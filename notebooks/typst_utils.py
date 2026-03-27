def typst_print(s):
    """
    Transforms a string for Typst printing by applying the following replacements:
    - [0] -> _x
    - [1] -> _y
    - [2] -> _z
    - *   -> (space)
    
    Args:
        s (str or object): The input string or object to transform.
    
    Returns:
        str: The transformed string.
    """
    s_str = str(s)
    s_str = s_str.replace("[0]", "_x")
    s_str = s_str.replace("[1]", "_y")
    s_str = s_str.replace("[2]", "_z")
    s_str = s_str.replace("*", " ")
    return s_str
