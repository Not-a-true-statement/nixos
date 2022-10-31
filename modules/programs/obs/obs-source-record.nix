{ lib, stdenv, fetchFromGitHub, cmake, obs-studio }:

stdenv.mkDerivation rec {
  pname = "obs-source-record";
  version = "unstable-2022-08-01";

  src = fetchFromGitHub {
    owner = "exeldro";
    repo = "obs-source-record";
    rev = "10a9b15c6fd83ba56ffd0e2f5e44b6fba23d772c";
    sha256 = "sha256-AQBg3MOoSQ04eBrKUIxlAMxp/RFi3q2Xe/pz88zbz8o=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    obs-studio
  ];

  cmakeFlags = [
    "-DBUILD_OUT_OF_TREE=On"
    "-DLIBOBS_INCLUDE_DIR=${obs-studio.src}/libobs"
  ];

  meta = with lib; {
    description = "OBS Studio plugin to make sources available to record via a filter";
    homepage = "https://github.com/exeldro/obs-source-record";
    maintainers = with maintainers; [ robbins ];
    license = licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
  };
}