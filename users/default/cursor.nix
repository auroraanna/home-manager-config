{ config, pkgs, lib, ... }:

{
	xsession = {
		pointerCursor = {
			name = "Capitaine cursors";
			package =  pkgs.capitaine-cursors;
		};
	};
}