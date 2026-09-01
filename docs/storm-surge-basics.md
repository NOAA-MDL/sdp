---
layout: default
title: Storm Surge - Basics
---
<!-- docs/storm-surge-basics.md                      Last Change: 2026-09-01 -->

### Storm Surge vs. Storm Tide
* **Storm Surge:** Water that is pushed toward the shore by the force of winds
  swirling around a storm.
* **Storm Tide:** The combination of the normal tide and the storm surge to
  create the total increase in water level due to the storm. The tide level
  when a hurricane makes landfall can have a major impact on the total water
  surface elevation.

### How the SLOSH Model Works
Given a specific geographic region (a SLOSH Basin), the model takes a
hypothetical or historical hurricane track and calculates the resulting storm
surge.

#### Model Inputs:
* Hurricane Pressure.
* Forward Speed.
* Direction and Location.
* Radius of Maximum Winds.
* Basin Topography and Bathymetry (water depth relative to mean sea level).

#### Model Accuracy and Limitations:
* Accuracy is generally within +/- 20% of the peak storm surge for a known
  hurricane track, intensity, and size.
* The model accounts for astronomical tides by either (a) specifying the initial
  tide level, or (b) using a spatial and time varying tidal calculation based
  on ADCIRC's EC2015 tidal harmonics.
* The model **does not** include rainfall amounts, river flow, or wind-driven
  waves.

### Storm Surge Generalizations
When observing storm surge animations, several meteorological generalizations
apply:
1. More intense storms cause higher surges.
2. The highest surges usually occur to the right of the storm track.
3. Fast-moving storms cause high surges along the open coast and lower surges in
   sheltered bays and estuaries.
4. Slow-moving storms usually result in greater flooding inside bays and
   estuaries, with smaller values along the open coast.
5. Larger storms (greater radius of maximum wind) affect longer stretches of the
   coastline.
6. A shallow coastal slope will allow a greater storm surge with small waves,
   while areas with steep coastal slopes experience less surge but large
   breaking waves.

### Interpreting Rexfiles and Wind Data
A Rexfile contains SLOSH-generated water level heights at each grid cell and
hurricane wind parameters for specific time intervals. When animating a Rexfile
in the SDP, wind speeds and directions are displayed using standard
meteorological conventions:

#### Wind Barb Symbology:
* **Short Barb:** 5 knots.
* **Full Barb:** 10 knots.
* **Triangular Flag:** 50 knots.
* *Example:* A wind flag showing a triangle, two full barbs, and one half barb
  indicates a wind speed of 75 knots. Direction is indicated by the direction
  of the wind barb itself.

#### Wind Scale Colors:
* **Green:** Tropical storm force to hurricane force winds.
* **Red:** Hurricane force up to 100 knots (Category 3).
* **Black:** Categories 3, 4, and 5.

<!----------------------------------------------------------------------------->
<!-- vim: set norl fdm=marker fmr=[fd],[/fd] spell! -->
