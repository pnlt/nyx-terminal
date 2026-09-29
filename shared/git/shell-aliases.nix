rec {
  g = "git";
  ga = "git add";
  gap = "${ga} --patch";
  gaa = "${ga} --all";

  gb = "git branch";

  gcp = "git cherry-pick";

  gc = "git commit -v";
  gca = "${gc} --amend";
  gcm = "${gc} --message";

  gd = "git diff";
  gds = "${gd} --staged";

  gl = "git log --oneline";
  gls = "${gl} | head -n 10";
  gl1 = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
  gl2 = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";

  gck = "git checkout";
  ggc = "git gc --aggressive";

  gf = "git fetch";
  gfa = "${gf} --all";

  gmgc = "find . -maxdepth 1 -type d | xargs -I {} bash -c 'if git -C {} rev-parse --git-dir > /dev/null 2>&1; then git -C {} gc --aggressive; fi'";

  gp = "git pull origin $(git branch --show-current)";
  gprb = "git pull --rebase origin $(git branch --show-current)";

  ggpull = gp;
  ggpullrb = gprb;

  gmb = ''find . -maxdepth 1 -type d | xargs -I {} bash -c 'if git -C {} rev-parse --git-dir > /dev/null 2>&1; then printf " ~ \033[0;94m{}\033[0m:"; git -C {} branch --show-current; fi' '';
  gmpull = "find . -maxdepth 1 -type d | xargs -I {} bash -c 'if git -C {} rev-parse --git-dir > /dev/null 2>&1; then git -C {} pull; fi'";
  gmpush = "find . -maxdepth 1 -type d | xargs -I {} bash -c 'if git -C {} rev-parse --git-dir > /dev/null 2>&1; then git -C {} push; fi'";
  ggpush = "git push origin $(git branch --show-current)";

  gundo = "git log --format=%B -n 1 HEAD | head -n 1 && git undo";

  gr = "git reset -q";
  grv = "git revert";

  gauthors = "git shortlog -n -s -- ";
  gss = "git status -s";
  grb = "git rebase";

  gs = "git stash";
  gsiu = "${gs} --include-untracked";
  gsp = "${gs} pop";

  gt = "git tag";
  gtd = "${gt} --delete";
  gts = "${gt} --sort=v:refname | tac | head -n 5";
  gcl = "git clone";
}
