{
  description = "nyx-terminal";
  outputs = {...}: {
    homeModules.default.imports = [./hm];
    nixosModules.default.imports = [./nixos];
  };
}
