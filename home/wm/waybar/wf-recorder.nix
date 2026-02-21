{
  wf-recorder,
  slurp,
  symlinkJoin,
  writeShellScriptBin,
}: let
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
    	saves_dir=$HOME/wf-records/
    	save_file=$saves_dir/$(date +"%F_%H-%M-%S").mp4
    	mkdir -p $saves_dir
    	${wf-recorder}/bin/wf-recorder \
    		-c libx264 \
    		-r 25 \
    		-g "$(${slurp}/bin/slurp)" \
    		-f $save_file \
    		-p qp=0 &>/dev/null &
    fi
  '';
in
  symlinkJoin {
    name = "wf-scripts";
    paths = [status toggle];
  }
