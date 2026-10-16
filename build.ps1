# Packs mod/AutoSortInventory into dist/AutoSortInventory.pak.
#   -Install  also copies the pak into the game's Mods folder
#   -Release  also builds dist/AutoSortInventory-<version>.zip (pak + info.json for BG3 Mod Manager)
param([switch]$Install, [switch]$Release)
$ErrorActionPreference = "Stop"
$root   = $PSScriptRoot
$divine = "$root\tools\lslib\Packed\Tools\Divine.exe"
$src    = "$root\mod\AutoSortInventory"
$out    = "$root\dist\AutoSortInventory.pak"

# Fail early on malformed XAML/LSX
Get-ChildItem $src -Recurse -Include *.xaml,*.lsx | ForEach-Object { [xml](Get-Content $_.FullName -Raw) | Out-Null }

New-Item -ItemType Directory -Force "$root\dist" | Out-Null
& $divine -g bg3 -a create-package -s $src -d $out
if ($LASTEXITCODE -ne 0) { throw "Divine failed" }

if ($Install) {
    $mods = "$env:LOCALAPPDATA\Larian Studios\Baldur's Gate 3\Mods"
    New-Item -ItemType Directory -Force $mods | Out-Null
    Copy-Item $out $mods -Force
    "Installed to $mods"
}

if ($Release) {
    # Read module info from meta.lsx; Version64 = major<<55 | minor<<47 | revision<<31 | build
    $meta = [xml](Get-Content "$src\Mods\AutoSortInventory\meta.lsx" -Raw)
    $attr = @{}
    $meta.SelectNodes("//node[@id='ModuleInfo']/attribute") | ForEach-Object { $attr[$_.id] = $_.value }
    $v64 = [uint64]$attr.Version64
    $version = "{0}.{1}.{2}.{3}" -f ($v64 -shr 55), (($v64 -shr 47) -band 0xFF), (($v64 -shr 31) -band 0xFFFF), ($v64 -band 0x7FFFFFFF)

    $stage = "$root\dist\stage"
    Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $stage | Out-Null
    Copy-Item $out $stage
    $info = [ordered]@{
        Mods = @([ordered]@{
            Author       = $attr.Author
            Name         = $attr.Name
            Folder       = $attr.Folder
            Version      = $version
            Description  = $attr.Description
            UUID         = $attr.UUID
            Created      = (Get-Date).ToString("o")
            Dependencies = @()
            Group        = $attr.UUID
        })
        MD5 = (Get-FileHash $out -Algorithm MD5).Hash.ToLower()
    }
    $info | ConvertTo-Json -Depth 5 | Set-Content "$stage\info.json" -Encoding utf8NoBOM

    $zip = "$root\dist\AutoSortInventory-$version.zip"
    Remove-Item $zip -ErrorAction SilentlyContinue
    Compress-Archive -Path "$stage\*" -DestinationPath $zip
    Remove-Item $stage -Recurse -Force
    "Release: $zip"
}
