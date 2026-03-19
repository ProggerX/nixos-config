{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      cursor_trail = 3;
      close_on_child_death = "yes";
      enable_audio_bell = "no";
    };
  };
}
