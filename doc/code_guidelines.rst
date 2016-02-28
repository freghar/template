These are more free-form and general coding guidelines, for a more formal style
specification, see code_style.txt.

Function API specification
==========================

BIS functions use a semi-formal block comment with parameters/return of the
function, similarly to how ie. Doxygen does it. However, as BIS functions are
a proof of, this style is hard to maintain consistently across complex data
types (ie. list), their nesting and index specifications.

A more relaxed description not only yields better understanding behind the
intentions of the function and its parameters, but allows to, more naturally,
split explanation of complex nested types according to what best suits the
specific case.
This relaxed description is more widely known as 'manpage' style.

Consider::

    /*
        Description:
        Prepares dinner using exactly 4 ingredients.

        Parameters:
            0: NUMBER - How many meals to make
            1: ARRAY
                0:
                    0: OBJECT - First ingredient type
                    1: OBJECT - First ingredient amount
                1:
                    0: OBJECT - Second ingredient type
                    1: OBJECT - Second ingredient amount
                2:
                    0: OBJECT - Third ingredient type
                    1: OBJECT - Third ingredient amount
                3:
                    0: OBJECT - Fourth ingredient type
                    1: OBJECT - Fourth ingredient amount

        Returns:
        ARRAY - N: Number of meals specified
            N: OBJECT - Finished meal to serve
    */

    params ["_meals", "_ingreds"];

Versus::

    /* Prepares dinner using exactly 4 ingredients, given as a 4-member
     * '_ingreds' array, each ingredient specifying [type, amount],
     * making '_meals' dishes in total.
     * Returns a total of '_meals' finished meals as an array.
     */

    params ["_meals", "_ingreds"];

This is indeed an extreme case, but it showcases how a free-form description
can be more flexible and easier to understand, if written correctly.

Both specifications are allowed within this template, however the latter
is preferred. Care should be taken to provide as clear and as exact description
as possible, avoiding any double meanings or potential misrepresentations.

Both specifications allow and recommend being extra verbose where needed, such
as when the function has special requirements on properties of the arguments,
atypical to what the programmer would expect.
