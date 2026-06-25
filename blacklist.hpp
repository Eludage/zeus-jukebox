class ZeusJukebox_Blacklist
{
	// Tracks with incorrect metadata (wrong name and/or duration) from mods
	// whose authors won't fix them upstream. Hidden from the Available
	// Music list when "Hiding blacklisted Music" is enabled in Music List
	// Settings.
	//
	// Each entry is "<className>|<soundFile>" - matched on BOTH so a
	// classname collision with an unrelated, correctly-tagged track from a
	// different mod doesn't get hidden by mistake. Source: TFC_Compat /
	// TFC Zeus Sounds (all sound paths share that prefix).
	entries[] = {
		"Action_Kickoff|TFC_Compat\TFC_Zeus_Sounds\music\Action_Kickoff.ogg",
		"Tension_High_3|TFC_Compat\TFC_Zeus_Sounds\music\Tension_High_3.ogg",
		"Tension_High3|TFC_Compat\TFC_Zeus_Sounds\music\Tension_High3.ogg",
		"corruption|TFC_Compat\TFC_Zeus_Sounds\music\corruption.ogg",
		"deceived|TFC_Compat\TFC_Zeus_Sounds\music\deceived.ogg",
		"defuse|TFC_Compat\TFC_Zeus_Sounds\music\defuse.ogg",
		"felin|TFC_Compat\TFC_Zeus_Sounds\music\felin.ogg",
		"incognito|TFC_Compat\TFC_Zeus_Sounds\music\incognito.ogg",
		"moonrise|TFC_Compat\TFC_Zeus_Sounds\music\moonrise.ogg",
		"nvg|TFC_Compat\TFC_Zeus_Sounds\music\nvg.ogg",
		"redacted|TFC_Compat\TFC_Zeus_Sounds\music\redacted.ogg",
		"scout|TFC_Compat\TFC_Zeus_Sounds\music\scout.ogg",
		"selenolatry|TFC_Compat\TFC_Zeus_Sounds\music\selenolatry.ogg",
		"shadow|TFC_Compat\TFC_Zeus_Sounds\music\shadow.ogg",
		"sharpshooter|TFC_Compat\TFC_Zeus_Sounds\music\sharpshooter.ogg",
		"subversion|TFC_Compat\TFC_Zeus_Sounds\music\subversion.ogg",
		"surveillance|TFC_Compat\TFC_Zeus_Sounds\music\surveillance.ogg",
		"titanfall|TFC_Compat\TFC_Zeus_Sounds\music\titanfall.ogg",
		"totality|TFC_Compat\TFC_Zeus_Sounds\music\totality.ogg",
		"tundra|TFC_Compat\TFC_Zeus_Sounds\music\tundra.ogg",
		"wetworks|TFC_Compat\TFC_Zeus_Sounds\music\wetworks.ogg",
		"OscarMike|TFC_Compat\TFC_Zeus_Sounds\music\OscarMike.ogg",
		"SCPTactical|TFC_Compat\TFC_Zeus_Sounds\music\SCPTactical.ogg",
		"Creep|TFC_Compat\TFC_Zeus_Sounds\music\Creep.ogg",
		"Escape|TFC_Compat\TFC_Zeus_Sounds\music\Escape.ogg",
		"ChoirVocals|TFC_Compat\TFC_Zeus_Sounds\music\ChoirVocals.ogg",
		"IceQueen|TFC_Compat\TFC_Zeus_Sounds\music\IceQueen.ogg",
		"F_624|TFC_Compat\TFC_Zeus_Sounds\music2\F_624.ogg",
		"F_arrabbiata|TFC_Compat\TFC_Zeus_Sounds\music2\F_arrabbiata.ogg",
		"F_ThroughStatic|TFC_Compat\TFC_Zeus_Sounds\music2\F_ThroughStatic.ogg",
		"T_LivingDark|TFC_Compat\TFC_Zeus_Sounds\music2\T_LivingDark.ogg"
	};
};
