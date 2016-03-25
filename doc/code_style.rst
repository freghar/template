Basic rules
===========

Indent style
------------

- K&R style braces and block indent for SQF

  - brackets for 'else' on the same line, eg. '} else {'
  - no space between parentheses and content, eg. 'if (a) {'
  - at least one whitespace between braces and content, eg. '{ 0 }'

    - unless empty, in which case use no whitespace, eg. '{}'

- Allman braces for class-defining files

  - space-separated inheritance delimiter, eg. 'class one : two {'

- one level is 4 spaces, don't use tabs

  - 'case' in a 'switch' is not considered a special case

Rationale:
Most existing Arma code follows these, the last point is the safest indent
option for a project without strict submission guidelines, considering the code
is likely to be copied from/to terminal windows and pastebins where tabs would
get lost.

Identifier naming
-----------------

- function names are in camelCase (first letter lowercase)
- variables are in snake_case and all lowercase
- class names are in CamelCase (first letter uppercase)

Rationale:
Again, all of these are de-facto Arma code standards, reference BI code or any
major addon.

Whitespace
----------

- no spaces/tabs on empty lines
- no spaces/tabs at the end of any line
- line length should generally be within 80 characters
- line breaks in the repository are unix-style LF
- last line in a file ends with LF

Rationale:
The 80 character is not a limit, but a guide. It is the only existing
pseudo-standard and while an analogy to a terminal width doesn't make
sense nowadays, keeping the code narrow significantly helps the reader
keep track of lines and thus improves readability.

Line breaks match standard Git practices, Windows users should
use core.autocrlf=true or rely on gitattributes.

Usage of an editor or editor plugin that supports .editorconfig is highly
recommended, if only for inserting the line break at EOF.

Comments
--------

- both block /* */ and line // comments are allowed::

    /* this is an example
     * of a block comment
     */

    // this is an example
    // of a line comment

- generally, for multiline text, use block /* */ comments

- for debugging purposes and disabled code, prefer line comments or block
  comments with as little added text as possible::

    //disabled = 0
    //code = 1

    /*disabled = 0
    code = 1*/

    /*
    disabled = 0
    code = 1
    */

- for larger blocks of disabled code, which may or may not already contain
  block comments, consider using the preprocessor::

    #ifdef undefined
    more = 0
    of = 1

    /* block comment
     * preventing outside
     * block-commenting-out
     */
    disabled = 2
    code = 3
    #endif

Rationale:
These techniques seem to be prevalent in most large Arma addons, except the
preprocessor one, which is a neat trick from C. Aside from this, there's no
right or wrong way, just consistent and inconsistent.

Variable / object scope
-----------------------

- always, if possible, keep variables local to the scope, use 'private'

  - the keyword version of 'private' is allowed

- for global function names, use the conventional TAG

  - eg. A3MT_fnc_myFunc

- for global and publicVariables, prefix the conventional TAG, followed by '_'

  - eg. A3MT_my_global_var

Rationale:
Variable locality allows code re-use and re-entrance. Consistent prefixes on
global members help quickly localize relevant variables and reduce conflicts.

Scripting commands and BIS functions
-----------------------------------

- don't use BIS function for what a scripting command can do

  - many scripting commands started as, now deprecated, BIS functions

- use 'forEach' instead of 'count'

  - the latter is insignificantly faster, but less intuitive / common

- use 'param' instead of BIS_fnc_param

Rationale:
Newer code has no reason to use deprecated BIS functions if a faster scripting
command was created to do the same or similar job.
Additionally, many BIS functions are, in fact, of inferior quality to most code
out there, don't presume BIS functions are optimized.

Other
-----

- don't check argument correctness in functions

  - it's the function user's responsibility to meet the function's API


Generic principles
==================

At the end of the day, no rules or policies should have the final word on what
gets used in the code. Always use what is appropriate where it is appropriate.
Think of what helps readability of the code in question and if you have
a **serious** reason to break the code style rules, do it.

Always read your code after you write it. At least once. Seriously. Not joking.

Always test your code after you read it. Arma has a habit of throwing errors
on what seems to be perfectly fine code.

Be mindful of code performance, Arma SQF is incredibly slow in general, every
scripting command is a performance hit, keep your code compact, but without
sacrificing code clarity.
If unsure, measure performance using the in-game clock icon or directly using
BIS_fnc_codePerformance.

Don't over-comment. Comment only the non-obvious things that might confuse
even people skilled in the language.

Don't over-de-duplicate code. Some limited copy-pasting is okay, separating
eeevery tiny thing into a function, just to reuse as much code a possible,
is not a good practice.
