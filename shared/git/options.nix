{lib}:
with lib; {
  enable = mkEnableOption "Shared git";

  policyOwners = mkOption {
    type = types.listOf types.str;
    default = [];
    description = "Remote owners whose repos run the pre/post-commit policy hooks. Empty runs them everywhere.";
  };

  user = {
    name = mkOption {
      type = types.str;
      description = "Git user.name";
    };
    email = mkOption {
      type = types.str;
      description = "Git user.email";
    };
  };
}
