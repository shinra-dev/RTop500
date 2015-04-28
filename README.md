# RTop500

[Top 500](http://www.top500.org) is a project that has been ranking
the performance of supercomputers since 1993.  New rankings are
released every June 
(at [ISC](www.isc-events.com/)) 
and November 
(at [SC](http://supercomputing.org/)).
The RTop500 package encapsulates these lists into an easy to use R package.



## Package Usage

For information about the Top500 datasets, including naming 
conventions, see `?Top500`.  If you're impatient, see
`RTop500:::.__TOP500_datafiles`.

You can easily generate some historical plots (looking at trends
over time) using the function `plot_top500()`.  There is also a
Shiny app wrapping this plotter, which you can view live
[here,](https://wrathematics.shinyapps.io/RTop500)
or locally by running the `runapp.sh` script from the source tree,
or after having installed the package you can run:

```r
library(RTop500)
shiny::runApp(RTop500_shinydir())
```



## Installation

```r
devtools::install_github("wrathematics/RTop500")
```



## License

Note that RTop500 is not officially affiliated with the Top 500 project.

The software for this package is distributed under a 2-Clause BSD
license.

    Copyright (c) 2014-2015, Drew Schmidt
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
    
    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.

