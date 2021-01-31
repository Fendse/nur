{ pkgs, i3, stdenv, lib, ... }:
let iconPatch = pkgs.fetchgit {
  url = "https://aur.archlinux.org/i3-wm-iconpatch.git";
  rev = "695e3ad65c0579ddbc7bf71e3f4678bf3f2273f3";
  sha256 = "0b8h4ris0igbcchj1my4p854myaz7fpg84iq2ssg5qhi0nyyqczq";
};
in
  i3.overrideAttrs ( oldAttrs : rec {
    pname = "i3-icons";

    version = "4.18.3";

    src = pkgs.fetchurl {
      url = "https://i3wm.org/downloads/i3-${version}.tar.bz2";
      sha256 = "03dijnwv2n8ak9jq59fhq0rc80m5wjc9d54fslqaivnnz81pkbjk";
    };

    patches = (lib.attrsets.attrByPath [ "patches" ] [] oldAttrs)
      ++ [
        "${iconPatch}/iconsupport.patch"
      ];

    meta = {
      description = "The i3 tiling window manager, patched to show icons in titlebars.";
      homepage = "https://aur.archlinux.org/packages/i3-wm-iconpatch/";
      maintainers = with lib.maintainers; [ ];
      license = with lib.licenses; [ bsd3 ]; 
      platforms = oldAttrs.meta.platforms;
    };
  })
