**docs/history.md**`                                    Last Change: 2026-08-24`

### INTRODUCTION TO POTENTIAL HURRICANE FLOODING
"Although [the Sea Lake and Overland Surges from Hurricane] SLOSH [model]
originated as a forecast model, it has recently [as of 1984] been used as a tool
to delineate areas of **potential hurricane flooding** along the coast. With
this information, an evacuation planner can identify **areas for evacuation**,
determine which highways can be used for **evacuation routes**, and **site
shelters** in areas not flooded or cut off by a hurricane."
[Jelesnianski, et. al., 1984](https://slosh.nws.noaa.gov/docs/data/Jelesnianski_1984_SLOSH_HurcnFcstModel.pdf)

### WHAT ARE MEOWs AND MOMs?
To estimate potential flooding, as part of the National Hurricane Program, the
SLOSH model is used by the NWS to compute storm surge impacts from thousands of
hypothetical hurricanes in various computational domains (aka basins). Each
model run produces an **envelope** which is the maximum water level attained in
each grid cell at any time during the run.  The envelopes are then combined into
**MEOWs** and **MOMs** which are provided to the Army Corps of Engineers as the
**hazards analysis** portion of hurricane evacuation planning.  The Army Corps
then combines the information with population and roadway information to create
the evacuation plans that are provided to FEMA and local emergency managers.

**Maximum Envelope of Water (MEOW)**
The MEOW "lumps together a family of parallel track storms, all of the same
category, tide level, direction of motion, and speed along the tracks. At each
SLOSH grid square, the highest value of surge from the family of storms is
displayed..."
[Shaffer, et al., 1986](https://slosh.nws.noaa.gov/docs/data/ShafferJelesnianskiChen1986HurricaneStorm.pdf).
"This product, then, displays the potential flooding for a hurricane of a given
**category**, **tide level**, and general track **direction** and **speed**."
[Glahn et al, 2009](https://slosh.nws.noaa.gov/docs/data/Vol-33-Nu1-Glahn.pdf)

**Maximum of the MEOWs (MOM)**
"A MOM is a composite of the maximum storm surge heights for all simulated
hurricanes of a given category... Thus, the MOM depicts the potential flooding
for a given hurricane category and tide level, regardless of landfall approach
direction and speed."
[Glahn et al, 2009](https://slosh.nws.noaa.gov/docs/data/Vol-33-Nu1-Glahn.pdf).

### SDP's ORIGINAL PURPOSE
Because Geographical Information Systems (GIS) were not readily available in the
1980s and early 1990s, NWS's Meteorological Development Lab created the SLOSH
Display Program (SDP) as a free GIS tool to display the MEOW and MOM products.
Originally built for MS-DOS, it was later rebuilt for MS-Windows and Linux in
the late 1990s.

By the early 2020s, modern web services replaced the need for an offline MEOW
and MOM viewer. In 2026, the MEOW and MOM products (last updated in the SDP in
2016) were discontinued from the software, and the project migrated to GitHub to
focus purely on model development and historical animations.

--------------------------------------------------------------------------------
> vim:norl:fdm=marker:fmr=[fd],[/fd]:spell!
