update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	@echo "Packwiz has been Updated"
export:
	cd versions && pw batch mr export
	@for /r .\versions %%A in (*.mrpack) do move "%%A" ..\hammer\.done
update:
	cd versions && pw batch update --all
refresh:
	cd versions && pw batch refresh