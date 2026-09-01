---
layout: default
title: SLOSH Display Program
permalink: /
---
<!-- README.md                                       Last Change: 2025-08-24 -->

### What is the SLOSH Display Program (SDP)?
The Sea Lake and Overland Surges from Hurricanes (SLOSH) model is a hydrodynamic
model for diagnosing the resulting storm surge from a given wind field.  The
SLOSH Display Program (SDP) is a visualization tool developed by the NWS Office
of Modeling and Development (OMD). Its primary focus is education and SLOSH
model development. The SDP allows users to display animations of individual
storms, whether they are historical, hypothetical, or predicted. It does this
by reading **Rexfiles**, which contain snapshots of surge elevations and wind
information at fixed time intervals (usually 10-15 minutes), concluding with a
final frame showing the maximum level each grid cell attained during the run.

#### Key Uses:
* Validating the SLOSH model.
* Teaching about the timing of storm surge and winds.
* Displaying historic storm surge levels.

### "As Is"
The SDP software, code, and visualization tools are provided **"as is"** without
warranties of any kind. In no event will NWS/OMD be liable to you or to any
third party for any direct, indirect, incidental, consequential, special or
exemplary damages or lost profit resulting from any use or misuse of the
software.  NWS/OMD does not provide technical support, bug fixes, or custom
development assistance to external developers who choose to utilize or adapt
this code.

### Installation and Usage
1. [Download the latest SLOSH Display Installer for Windows](https://github.com/NOAA-MDL/sdp/releases/latest/download/sloshdsp-install.exe) (`sloshdsp-install.exe`).
   > **Integrity Check:** To verify your download, you can compare the file
   > against the SHA-256 checksum automatically displayed next to the asset on
   > our [Latest Releases page](https://github.com/NOAA-MDL/sdp/releases/latest).
2. Run the installer on your Windows machine.
3. Launch the SDP program.
4. To **Download a Rexfile**:
   1. Go to the **Animate** menu and select **Download Rexfiles**.
   2. Press **Continue** to download the Rexfile catalog.
   3. Highlight one or more desired Rexfile(s) and press **Install**.
5. To **Animate a Rexfile**:
   1. Go to the **Animate** menu and select **Animate .rex file**.
   2. Select one of the installed Rexfiles and press **Start**.

### Understanding Storm Surge & SLOSH Model Basics
To better understand how storm surge differs from storm tide, how the SLOSH
model calculates water levels, and how to read the wind barbs and color scales
inside the SDP animations, please refer to our
[Storm Surge & SLOSH Basics Guide](docs/storm-surge-basics.md).

### Project History and Legacy Data
For over 25 years (1990s to 2020s), the SDP was also used to display Maximum
Envelope of Water (MEOW) and Maximum of the MEOWs (MOM) products for hurricane
evacuation planning. With the rise of online web services, MEOWs and MOMs are
now handled via web portals and have been removed from the SDP.

For a detailed look at the meteorological origins of SLOSH, MEOWs, MOMs, and the
legacy MS-DOS/Windows history of this program, please see the
[SDP Historical Background](docs/history.md).

<!----------------------------------------------------------------------------->
<!-- vim: set norl fdm=marker fmr=[fd],[/fd] spell! -->
