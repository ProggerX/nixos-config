{
  pkgs,
  lib,
  ...
}: {
  services.mopidy = {
    enable = false;
    extensionPackages = with pkgs; [mopidy-mpd mopidy-subidy mopidy-mpris];
    extraConfigFiles = ["/mopidy.conf"];
  };
  systemd.services.mopidy = {
    serviceConfig.User = lib.mkForce "proggerx";
    environment.XDG_RUNTIME_DIR = "/run/user/1000";
  };
  services.mpd = {
    enable = true;
    musicDirectory = "http://10.7.0.6:5000/";
    extraConfig = ''
      audio_output {
      	type "pipewire"
      	name "My PipeWire Output"
      }
      audio_output {
      	type "alsa"
      	name "alsa"
      	mixer_control "Master"
      }
      audio_output {
      	type            "fifo"
      	name            "Visualizer feed"
      	path            "/tmp/mpd.fifo"
      	format          "44100:16:2"
      }
      audio_output {
      	type "httpd"
      	name "online yeah"
      	port "8989"
      	bind_to_address "0.0.0.0"
      }
    '';

    network.listenAddress = "any";
    startWhenNeeded = true;
  };
  systemd.services.mpd = {
    serviceConfig.User = lib.mkForce "proggerx";
    environment.XDG_RUNTIME_DIR = "/run/user/1000";
  };
}
