update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	clear
	@echo "Packwiz has been Updated"
export:
	cd versions/forge && pw batch mr export
	-mv versions/forge/*/*.mrpack .done/forge
update:
	cd versions/forge && pw batch update --all
refresh:
	cd versions/forge && pw batch refresh