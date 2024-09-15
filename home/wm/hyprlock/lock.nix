{ pkgs, ... }:
pkgs.writeShellScriptBin "screenlock" ''
set -euo pipefail
if [ -f /tmp/locked ] ; then exit ; fi
touch /tmp/locked
(
until ${pkgs.fprintd}/bin/fprintd-verify | grep "verify-match"; do
    echo "Failed to verify fingerprint at $(date)"
done
echo "Unlocked at $(date)"
pkill -USR1 ${pkgs.hyprlock}/bin/hyprlock
) &
${pkgs.hyprlock}/bin/hyprlock
rm /tmp/locked
kill $(jobs -p)
pkill fprintd-verify
''
