{ config, pkgs, lib, ... }:

{
	xsession = {
		pointerCursor = {
			name = "capitaine-cursors-white";
			package =  pkgs.capitaine-cursors;
		};
	};
}