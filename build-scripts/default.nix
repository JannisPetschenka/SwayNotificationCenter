{ lib
, stdenv
, fetchFromGitHub
, testers
, wrapGAppsHook
, bash-completion
, dbus
, dbus-glib
, fish
, gdk-pixbuf
, glib
, gobject-introspection
, gtk-layer-shell
, gtk3
, json-glib
, libgee
, libhandy
, libpulseaudio
, librsvg
, meson
, ninja
, pkg-config
, python3
, scdoc
, vala
, xvfb-run
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "swaync";
  name = "swaync";
  version = "0.9.0";

  src = ../.;

   nativeBuildInputs = [
      bash-completion
      # cmake # currently conflicts with meson
      fish
      glib
      gobject-introspection
      meson
      ninja
      pkg-config
      python3
      scdoc
      vala
      wrapGAppsHook
    ];

    buildInputs = [
      dbus
      dbus-glib
      gdk-pixbuf
      glib
      gtk-layer-shell
      gtk3
      json-glib
      libgee
      libhandy
      libpulseaudio
      librsvg
      # systemd # ends with broken permission
    ];

    postPatch = ''
      chmod +x build-aux/meson/postinstall.py
      patchShebangs build-aux/meson/postinstall.py
    '';

    passthru.tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "${xvfb-run}/bin/xvfb-run swaync --version";
    };

    meta = with lib; { };
})
