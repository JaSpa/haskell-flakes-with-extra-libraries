#!/bin/sh

set -ex

nix build -o nix-graphviz nixpkgs#graphviz
cabal run --extra-lib-dirs ./nix-graphviz/lib
