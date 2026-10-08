---
layout: default
title: SLOSH Display Program
permalink: /
---
<!-- README.md                                       Last Change: 2026-10-08 -->

Welcome to the repository for the **SLOSH Display Program (SDP)**.

Please note if you make a copy of this repository, the following files are
required for defining the Intellectual Property (IP) protection:

1. [INTENT.md](./INTENT.md) describing the intent of the IP protection
2. [LICENSE.md](./LICENSE.md) providing the Apache 2.0 licensing information
3. [NOTICE.md](./NOTICE.md) providing required copyright attribution

<!----------------------------------------------------------------------------->
## What is the SLOSH Display Program (SDP)?

The Sea Lake and Overland Surges from Hurricanes (SLOSH) model is a hydrodynamic
model for diagnosing the resulting storm surge from a given wind field.  The
SLOSH Display Program (SDP) is a visualization tool developed by the NWS Office
of Modeling and Development (OMD). Its primary focus is education and SLOSH
model development. The SDP allows users to display animations of individual
storms, whether they are historical, hypothetical, or predicted. It does this
by reading **Rexfiles**, which contain snapshots of surge elevations and wind
information at fixed time intervals (usually 10-15 minutes), concluding with a
final frame showing the maximum level each grid cell attained during the run.

### Key Uses

* Validating the SLOSH model.
* Teaching about the timing of storm surge and winds.
* Displaying historic storm surge levels.

<!----------------------------------------------------------------------------->
## Installation and Usage

1. <a href="https://slosh.nws.noaa.gov/sdp/download.php" rel="noopener noreferrer">Download the latest SLOSH Display Installer for Windows</a> (`sloshdsp-install.exe`).
   > **Integrity Check:** To verify your download, you can compare the file
   > against the SHA-256 checksum automatically displayed next to the asset on
   > our <a href="https://github.com/NOAA-MDL/sdp/releases/latest" target="_blank" rel="noopener noreferrer">Latest Releases page</a>.
2. Run the installer on your Windows machine.
3. Launch the SDP program.
4. To **Download a Rexfile**:
   1. Go to the **Animate** menu and select **Download Rexfiles**.
   2. Press **Continue** to download the Rexfile catalog.
   3. Highlight one or more desired Rexfile(s) and press **Install**.
5. To **Animate a Rexfile**:
   1. Go to the **Animate** menu and select **Animate .rex file**.
   2. Select one of the installed Rexfiles and press **Start**.

<!----------------------------------------------------------------------------->
## Understanding Storm Surge & SLOSH Model Basics

To better understand how storm surge differs from storm tide, how the SLOSH
model calculates water levels, and how to read the wind barbs and color scales
inside the SDP animations, please refer to our
[Storm Surge & SLOSH Basics Guide](./docs/storm-surge-basics.md).

<!----------------------------------------------------------------------------->
## Project History and Legacy Data

For over 25 years (1990s to 2020s), the SDP was also used to display Maximum
Envelope of Water (MEOW) and Maximum of the MEOWs (MOM) products for hurricane
evacuation planning. With the rise of online web services, MEOWs and MOMs are
now handled via web portals and have been removed from the SDP.

For a detailed look at the meteorological origins of SLOSH, MEOWs, MOMs, and the
legacy MS-DOS/Windows history of this program, please see the
[SDP Historical Background](./docs/history.md).

<!----------------------------------------------------------------------------->
## DISCLAIMER

**Emergency Management Authority:** Pay attention to your local emergency
manager, particularly during an evacuation. **DO NOT use the SLOSH Display
program as an excuse to ignore your local emergency manager!** The SLOSH
Display program is only one of several tools used by emergency management
agencies to determine who is at risk and may be asked to evacuate.

**"As Is" Software & No Technical Support:** The SDP software, code, and
visualization tools are provided **"as is"** without warranties of any
kind. In no event will NWS/OMD be liable to you or to any third party for
any damages resulting from any use or misuse of the software. NWS/OMD
does not provide technical support, bug fixes, or custom development
assistance to external developers who choose to utilize or adapt this code.

**Recommended Training:** We recommend people have training before a hurricane
impacts their lives. The key ideas to learn are:

* What is storm surge?
* There is inaccuracy in any model.
* There is more inaccuracy in the input wind parameters to surge models than in
  the models themselves.

<!----------------------------------------------------------------------------->
<!-- vim: set norl fdm=marker fmr=[fd],[/fd] spell! -->