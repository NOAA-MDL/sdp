**README.md**`          SLOSH Help Pages                Last Change: 2024-04-26`

--------------------------------------------------------------------------------
### INTRODUCTION

"Although SLOSH originated as a forecast model, it has recently [as of 1984]
been used as a tool to delineate areas of **potential hurricane flooding** along
the coast.  With this information, an evacuation planner can identify **areas
for evacuation**, determine which highways can be used for **evacuation
routes**, and **site shelters** in areas not flooded or cut off by a hurricane."
[Jelesnianski, et. al., 1984](https://slosh.nws.noaa.gov/docs/data/Jelesnianski_1984_SLOSH_HurcnFcstModel.pdf)

--------------------------------------------------------------------------------
### MEOW and MOM

To estimate the potential flooding, "The SLOSH model is used by the NWS to
create simulation studies to assist in the 'hazards analysis' portion of
hurricane evacuation planning by FEMA, the U.S. Army Corps of Engineers, and
state and local emergency managers.  Thousands of [hypothetical] hurricanes with
various combinations of categories (according to the Saffir-Simpson scale),
forward speeds, track directions, and landfall locations are simulated to
compute storm surge for each basin.  Two composite products, **Maximum Envelope
of Water (MEOW)** and **Maximum of the MEOWs (MOM)**, are created in order to
provide a manageable dataset for hurricane evacuation planners to access and display;"
[Glahn et al, 2009](https://slosh.nws.noaa.gov/docs/data/Vol-33-Nu1-Glahn.pdf)

The **MEOW** "lumps together a family of parallel track storms, all of the same
category[, tide level, direction of motion,] and speed along the tracks.  At
each SLOSH grid square, the **highest** value of surge from the family of storms is
displayed, giving a composite called the Maximum Envelope of Waters..."
[Shaffer, et al., 1986](https://slosh.nws.noaa.gov/docs/data/ShafferJelesnianskiChen1986HurricaneStorm.pdf)
"This product, then, displays the potential flooding for a hurricane of a given
**category**, **tide level**, and general track **direction** and **speed**."
[Glahn et al, 2009](https://slosh.nws.noaa.gov/docs/data/Vol-33-Nu1-Glahn.pdf)

"A MOM is a composite of the maximum storm surge heights for all simulated
hurricanes of a given category.  There are typically five MOMs per basin (one
per storm category), as results for forward speed, direction, and landfall
location are aggregated... Thus, the MOM depicts the potential flooding for a
given hurricane **category** [and **tide level**], regardless of landfall
approach direction and speed.  This product can be used by evacuation planners
to designate evacuation routes and emergency managers to make early decisions."
[Glahn et al, 2009](https://slosh.nws.noaa.gov/docs/data/Vol-33-Nu1-Glahn.pdf)

--------------------------------------------------------------------------------
### SLOSH DISPLAY PROGRAM (SDP)

With the development of the MEOWs and MOMs in the 1980's came a need to display
these results to NWS's users.  Since Geographical Information Systems (GIS) were
not readily available, NWS's Meteorological Development Lab developed the
SLOSH Display Program (SDP), a free GIS, to **display the MEOW and MOM
products**.  The SDP was first built for MS-DOS in the early 1990s and later
rebuilt for MS-Windows (and linux) in the late 1990s.

The SDP was also given the ability, via a "Rex-file", to **display animations of
individual storms**, whether they be historical, hypothetical, or predicted.
The "Rex-file" contains snapshots of surge elevations and wind information at
fixed time intervals (usually 10-15 minutes) as well as a final frame that holds
the maximum level each grid cell attained during the run.  The purpose of the
animations, particularly the historical ones, is to validate the model, teach
about the timing of surge and winds, and display historic storm surge levels.

--------------------------------------------------------------------------------
### SDP - DISCONTINUING MEOW and MOM

While the SDP has for over 25 years (1990's to early 2020's) enabled
interactions with MEOWs and MOMs, recent developments with online web services
has eliminated that need.  So the MEOWs and MOMs (which were last updated in the
SDP in 2016) are being removed from the SDP.

As the remaining capabilities of the SDP are focused on education (see Rex-file
above) and SLOSH model development, MDL has chosen to migrate the SDP to GitHub.

--------------------------------------------------------------------------------
> vim:norl:fdm=marker:fmr={fold},{/fold}:spell!
