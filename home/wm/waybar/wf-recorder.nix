{ symlinkJoin, writeShellScriptBin }:
let
	status = writeShellScriptBin "wf-status" ''
		if pgrep wf-rec &> /dev/null; then
			echo "🔴"
		else
			echo ""
		fi
	'';
	toggle = writeShellScriptBin "wf-toggle" ''
		if pgrep wf-rec &> /dev/null; then
			pkill wf-rec
		else
			wf-recorder -c libx264 -r 25 -g "$(slurp)" -f $HOME/wf-records/$(date +"%F_%H-%M-%S").mp4 -p qp=0 &>/dev/null &
		fi
	'';
in
	symlinkJoin {
		name = "wf-scripts";
		paths = [ status toggle ];
	}
