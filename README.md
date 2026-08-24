**README.md**`                                          Last Change: 2026-08-24`

### WHAT IS THE SDP?
The SLOSH Display Program (SDP) is a visualization tool developed by the NWS
Office of Modeling and Development (OMD). Its primary focus is education and
SLOSH model development.

The SDP allows users to display animations of individual storms, whether they
are historical, hypothetical, or predicted. It does this by reading Rexfiles,
which contain snapshots of surge elevations and wind information at fixed time
intervals (usually 10-15 minutes), concluding with a final frame showing the
maximum level each grid cell attained during the run.

**Key Uses:**
* Validating the SLOSH model.
* Teaching about the timing of storm surge and winds.
* Displaying historic storm surge levels.

### INSTALLATION & USAGE

1. Navigate to the **Releases** page on this GitHub repository.
2. Download the latest `sloshdsp-install.exe` file.
3. Run the installer on your Windows machine.
4. Launch the SDP.
5. Download one or more Rexfile(s)
   * Go to the **Animate** menu and select **Download Rexfiles**.
   * Press **Continue** to download the Rexfile catalog.
   * Highlight one or more desired Rexfile(s) and press **Install**.
6. Animate a Rexfile
   * Go to the **Animate** menu and select **Animate .rex file**.
   * Select one of the installed Rexfiles and press **Start**.

### PROJECT HISTORY & LEGACY DATA
For over 25 years (1990's to 2020's), the SDP was also used to display Maximum
Envelope of Water (MEOW) and Maximum of the MEOWs (MOM) products for hurricane
evacuation planning. With the rise of online web services, MEOWs and MOMs are
now handled via web portals and have been removed from the SDP.

For a detailed look at the meteorological origins of SLOSH, MEOWs, MOMs, and the
legacy MS-DOS/Windows history of this program, please see the
[SDP Historical Background](docs/history.md).

--------------------------------------------------------------------------------
> vim:norl:fdm=marker:fmr=[fd],[/fd]:spell!
