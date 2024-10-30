{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; } }:
let
  strings = pkgs.lib.strings;
  match = pkgs.lib.match;
  parse-line = line:
    let
      without-comment = builtins.head (strings.split "#" line);
      parseresult = match "[ 	]*(.*):([0-9a-f]*)[ 	]*" without-comment;
    in if parseresult == null then
      null
    else
      let
        url = let
          repo = builtins.head parseresult;
          isGithubRepo = match "([A-Za-z0-9_-]+)/([A-Za-z0-9_.-]+)" repo
            != null;
        in if isGithubRepo then "https://github.com/${repo}" else repo;
        rev = builtins.head (builtins.tail parseresult);

      in pkgs.vimUtils.buildVimPlugin {
        pname = builtins.head (match ".*/([^/]+)" url);
        version = rev;
        src = builtins.fetchGit { inherit url rev; };
      };
  parse-lines = lines:
    builtins.foldl' (acc: cur: acc // { "${cur.pname}" = cur; }) { }
    (builtins.filter (x: x != null) (builtins.map parse-line lines));
  parse-file = file:
    parse-lines (strings.splitString "\n" (builtins.readFile file));
in parse-file

