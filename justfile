alias e := export
alias r := refresh
alias u := update

set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

default:
    @just --list

[private]
[windows]
_batchcmd cmd loader:
    Get-ChildItem -Path versions\{{ loader }} -Directory | % { \
      Set-Location $_.FullName; \
      Write-Host "running {{ cmd }} in $_"; \
      Invoke-Expression "{{ cmd }}"; \
      Pop-Location; \
    }

[linux]
[macos]
[private]
_batchcmd cmd loader:
    for d in versions/{{ loader }}/*/; do \
      cd "$d"; \
      echo "running {{ cmd }} in $d..."; \
      {{ cmd }}; \
      cd {{ invocation_directory() }}; \
    done

# all versions of <loader> will be exported as a modrinth modpack
[linux]
[macos]
export loader: && (_batchcmd "packwiz modrinth export; mv *.mrpack ../../../.done/" loader)
    -mkdir -p .done/{{ loader }}

# all versions of <loader> will be exported as a modrinth modpack
[windows]
export loader: && (_batchcmd "packwiz modrinth export; Move-Item -Path *.mrpack -Destination ../../../.done" loader)

# all versions of <loader> will have pack.toml refreshed
refresh loader: && (_batchcmd "packwiz refresh" loader)

# all versions of <loader> will be updated
update loader: && (_batchcmd "packwiz update --all" loader)