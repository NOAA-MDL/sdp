#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# @file         distrib.sh                               Last Change: 2026-08-12
# @author       Arthur.Taylor (NWS/OMD/MDSD)
# @description  Packages the SLOSH Display Program by calling slosh_nsi.tcl.
#-------------------------------------------------------------------------------
set -Eeuo pipefail
base="${0##*/}"

# @description Prints usage instructions for CLI argument parsing.
# @noargs
usage() {
  cat << EOF >&2
Package the SLOSH Display Program by calling slosh_nsi.tcl.

Usage:
  ${base} <cmd>

Commands:
  help  : Display this message and exit
  go    : Call slosh_nsi.tcl to build the installer

Example:
  $ ${base} go
EOF
}

# @description Trap function for ERR to log failure information to stderr.
# @arg $1 string Line number where the command failed.
# @arg $2 string Failed command execution string.
errorHandler() {
  local exitCode="$?"   # The exit status of the failed command
  local lineNumber="$1" # The line number where the failure occurred
  local failedCmd="$2"  # The literal command that failed
  echo "Error on line ${lineNumber}: command '${failedCmd}' " \
       "failed with status ${exitCode}" >&2
  exit "${exitCode}"
}
trap 'errorHandler "${LINENO}" "${BASH_COMMAND}"' ERR

# @description Resolves the full path to the makensis executable.
# @noargs
# @stdout Prints path to makensis executable.
findMakensis() {
  local path           # Iterator for candidate paths
  local candidatePaths # Array of common NSIS install locations
  if command -v makensis &>/dev/null; then
    echo "makensis"
    return 0
  fi

  candidatePaths=(
    "/c/Program Files (x86)/NSIS/makensis.exe"
    "/c/Program Files/NSIS/makensis.exe"
  )

  for path in "${candidatePaths[@]}"; do
    if [[ -x "${path}" || -f "${path}" ]]; then
      echo "${path}"
      return 0
    fi
  done

  echo "Error: makensis executable not found in PATH or standard dirs." >&2
  return 1
}

# ===== MAIN EXECUTION =====

# @description Main execution logic for packaging SDP.
# @arg $@ Command line arguments passed to the script.
main() {
  local cmd="${1:-}" # Command passed to the script
  local scriptDir    # Absolute path to the distrib folder
  local rootDir      # Top level directory of the SDP repo
  local tclkit       # Path to tclkit executable
  local tclkitsh     # Path to tclkitsh executable
  local makensis     # Path to the makensis compiler
  local version      # version output from sloshdsp.kit and then parsed
  local dateStr      # Parsed SDP date
  if [[ $# -eq 0 || "${cmd}" == "help" || "${cmd}" == "-h" || \
        "${cmd}" == "--help" ]]; then
    usage; exit 0
  fi
  if [[ "${cmd}" != "go" ]]; then
    echo "Error: Unknown '${cmd}'" >&2; usage; exit 1
  fi

  scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
  rootDir=$(cd "${scriptDir}/.." && pwd)
  cd "${scriptDir}"

  echo "Validating prerequisite files in ${rootDir}..."
  tclkit="${rootDir}/bin/tclkit854"
  if [[ ! -f "${tclkit}" && -f "${tclkit}.exe" ]]; then
    tclkit="${tclkit}.exe"
  fi
  if [[ ! -f "${tclkit}" ]]; then
    echo "Error: ${tclkit} not found" >&2; exit 1
  fi
  tclkitsh="${rootDir}/bin/tclkitsh854"
  if [[ ! -f "${tclkitsh}" && -f "${tclkitsh}.exe" ]]; then
    tclkitsh="${tclkitsh}.exe"
  fi

  # --- Get version information ---
  version=$("${tclkit}" "${rootDir}/sloshdsp.kit" -V \
            | grep "Version" || true)
  if [[ -z "${version}" ]]; then
    echo "Error: No Version extracted." >&2; exit 1
  fi
  version="${version:8}"

  # --- Get date string information ---
  dateStr=$("${tclkit}" "${rootDir}/sloshdsp.kit" -V \
            | grep "Date" | grep -v "Revision" || true)
  if [[ -z "${dateStr}" ]]; then
    echo "Error: No Date extracted." >&2; exit 1
  fi
  dateStr="${dateStr:5}"

  echo "Detected Version: ${version}"
  echo "Detected Date:    ${dateStr}"

  # --- Convert the template to something NSIS can use ---
  if [[ -f "${tclkitsh}" ]]; then
    "${tclkitsh}" "slosh_nsi.tcl" "${version}" "${dateStr}"
  else
    "${tclkit}" "slosh_nsi.tcl" "${version}" "${dateStr}"
  fi

  # --- Call makensis ---
  makensis=$(findMakensis)
  echo "Using NSIS compiler: ${makensis}"
  "${makensis}" "sloshdsp.nsi"

  echo "Packaging complete: ${scriptDir}/sloshdsp-install.exe generated."
}

main "$@"
