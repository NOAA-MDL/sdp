#!./bin/tclkitsh854.exe
#-------------------------------------------------------------------------------
# setup.tcl                                              Last Change: 2024-04-25
#                                                         Arthur.Taylor@noaa.gov
#                                                               NWS/OSTI/MDL/DSD
#-------------------------------------------------------------------------------
proc Usage {} {
   global argv0
   set base [file tail $argv0]
   puts "Download and install assets (dd3.kit, shpfiles.tar.gz) from GitHub"
   puts ""
   puts "Usage: $base <cmd> <method>, where:"
   puts "  <cmd> is:"
   puts "    help         = Display this message and exit"
   puts "    all          = Download basin, storm, and GUI data"
   puts "  <method> is:"
   puts "    manual       = Use tarballs in ./tar"
   puts "    PAT(=<file>) = Use GitHub Personal Access Token (PAT) in <file>"
   puts "                   if (=<file>) is omitted use ~/.gitHub_pat"
   puts ""
   puts "Example:"
   puts "  1) ./$base all PAT"
   puts "   Use PAT (~/.gitHub_pat) to install all assests"
}
if {($argc != 2) || ([lindex $argv 0] == "help")} { Usage ; exit 0 }

set Cmd [lindex $argv 0]
if {$Cmd != "all"} { Usage ; exit 0 }

set Method [lindex $argv 1]
if {$Method == "manual"} { set TOKEN "manual"
} elseif {[string range $Method 0 2] == "PAT"} {
   set PAT_FILE [string range $Method 4 end]
   if {[string length $PAT_FILE] == 0} {
      set PAT_FILE $env(HOME)/.gitHub_pat
   }
   set fp [open $PAT_FILE r]
   gets $fp TOKEN
   close $fp
} else {
   Usage ; exit 0
}

#-------------------------------------------------------------------------------
# @brief  One line JSON parser
#
# @param JSONtext[in]  JSON: text to parse
# @return  List of (dict (or list) containing objects) represented by $JSONtext
#
# @author  Antender (https://wiki.tcl-lang.org/page/JSON)
# @date  Dec 2010: Antender - Created
# @remark  This will corrupt URLs
#-------------------------------------------------------------------------------
proc json2dict JSONtext {
  string range [
    string trim [
      string trimleft [
        string map {\t {} \n {} \r {} , { } : { } \[ \{ \] \}} $JSONtext
      ] {\uFEFF}
    ]
  ] 1 end-1
}

#-------------------------------------------------------------------------------
# @brief  Download a file (asset) from GitHub
#
# @param Token:  Private Access Token for private repositories
# @param url:    URL for the GitHub repo releases
# @param Ver:    Name of release that this is an asset of
# @param Name:   Name of asset.
# @return 0, or -1 on error.
#
# @author  Arthur.Taylor@noaa.gov (NWS/OSTI/MDL/DSD)
# @date  Mar 2023: AAT - Created
#-------------------------------------------------------------------------------
proc getGitHubAsset {curl Token url Ver Name dstName} {
   # This call to curl could be done in Tcl via:
   #   geturl https://$url -binary true \
   #      -progress ::http::Progress -blocksize $chunk \
   #      -headers [list "Authorization" "token $Token" "Accept" "application/vnd.github.v3.raw"]
   catch {exec $curl -s -L \
               -H "Authorization: Bearer $Token" \
               -H "Accept: application/vnd.github+json" \
               -H "X-GitHub-Api-Version: 2022-11-28" \
               https://$url} ans
   set ID -1
   foreach d2 [json2dict $ans] {
      if {[dict get $d2 "name"] == $Ver} {
         foreach a2 [dict get $d2 "assets"] {
            if {[dict get $a2 "name"] == $Name} {
               set ID [dict get $a2 "id"]
            }
         }
      }
   }
   if {$ID == -1} {
      puts "Didn't find the asset ID for $Ver $Name"
      return -1
   }
   if {[file exists $Name]} {
      file delete $Name
   }
   catch {exec $curl -s -L \
               -H "Authorization: Bearer $Token" \
               -H "Accept: application/octet-stream" \
               -H "X-GitHub-Api-Version: 2022-11-28" \
               https://$Token:@$url/assets/$ID > $dstName} ans
   return 0
}

#=================================================================== START =====
set srcDir [file dirname [info script]]
set CURL $srcDir/bin/curl.exe
set UNZIP $srcDir/bin/unzip.exe
set BASE "api.github.com/repos"

puts "Getting dd3.kit"
getGitHubAsset $CURL $TOKEN $BASE/ArthurTaylorNWS/sdp/releases Assets \
               dd3.kit dd3.kit

puts "Getting shpfiles.zip"
getGitHubAsset $CURL $TOKEN $BASE/ArthurTaylorNWS/sdp/releases Assets \
               shpfiles.zip shpfiles.zip

# Unpack the shpfiles.zip file
set mount [file join $srcDir mount]
set srcName shpfiles.zip
package require vfs::zip
if {[catch {set fd [vfs::zip::Mount $srcName $mount]; } reason opt] == 1} {
   puts "Problems mounting the file $srcName: -options $opt $reason"
   exit 0
}
file mkdir $srcDir/shpfiles
foreach f [glob $mount/shpfiles/*] {
   puts "Updating $srcDir/shpfiles/$f"
   file copy -force $f $srcDir/shpfiles
}
vfs::zip::Unmount $fd $mount

file delete $srcName
