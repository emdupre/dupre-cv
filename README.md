# dupre-cv

Code to construct my _curriculum vitae_ (CV) in LaTex.

If you'd like to read my CV because you're interested in me or my work, this is probably not the right repository for you.
Instead, please check out [my website](https://elizabeth-dupre.com), where you can find the rendered version of this CV and more information on my ongoing projects.

---

If, instead, you're interested in the _code to generate_ my CV, then you're in the right place.

### Standing on the shoulders of giants

The overall style I use here was inspired by [Olivia Guest](http://oliviaguest.com)'s CV,
who was in turn inspired by the [JTEppinette resume template](https://www.overleaf.com/articles/jteppinette-resume/wcsdpbkfmstz).

Something that neither of these templates have are macros to generate a reference list.
For this, I turned to the [Frigerri CV template](https://www.latextemplates.com/template/friggeri-resume-cv), but added a few important updates.
Namely, in addition to building the bibliography from a .bib file, this template will:

* Highlight your provided author name in each reference item, by displaying it in a contrasting color
* Link each reference title based on its provided DOI

### LaTeX Tips and tricks learned along the way

To do this, I had to learn a few LaTeX tricks.
I personally found the documentation for these slightly confusing, so I thought I'd explain them in more detail here.

* `\ifthenelse{}{}{}`

This can be read as "If {}, then {}. Else, {}"

To use this, you need to put a condition that will evaluate to True or False in the first set of brackets.
Then, in the second set of brackets, you put the action you would like to take if the condition is True.
In the third set of brackets, you can put the action you would like to take if the condition is False
(i.e., "else" if it is not true).

I use this [here](https://github.com/emdupre/cv/blob/30c75dc2f91b09232d999aea845f5d9b367bbbe6/dupre-cv.cls#L142), when checking to see if the author name should be followed by a comma or a period.

```
\ifthenelse{\value{listcount}<\value{liststop}}
  {\addcomma\space}
  {\adddot}
```

Following the above logic, this can be read as "If the value in my list count (a counter of the current author number) is less than the value of list stop (the length of the list), then add a comma and a space after the author name.
Else, if the list counter is not less than the value of list step, put a period after the author name."
