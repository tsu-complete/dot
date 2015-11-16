
Help (tsu)
===

Set
---
 
```viml
:set            - shows vars different from defaults
:set all        - shows all values
:set foo?       - shows the value of foo
:set foo+=opt   - add opt to the value w/o changing others
:set foo-=opt   - remove opt from value
:set foo&       - reset foo to default value
:setlocal foo   - only the current buffer
```

Modeline
---

Modelines allow file specific variables. By default, the first
and last five lines are read by vim for variable settings. For
example, if you put the following in the last line of a C
program, you would get a textwidth of 60 chars when editing that
file:

```c
/* vim: tw=60 ts=2: */
```

The modelines variable sets the number of lines (at the beginning
and end of each file) vim checks for initializations.

