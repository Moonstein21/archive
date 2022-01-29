$path = @()
$zipdate = (Get-Date).Date.AddDays(-2)
$deletedate = (Get-Date).Date.AddDays(-14)

#архив

foreach($i in $path){

Get-ChildItem $i -Exclude archive | Where {$_.LastWriteTime -lt $zipdate} | Foreach {
    if($_.FullName -like "*txt*"){
        &"C:\Program Files\7-Zip\7z.exe" a ("$i\" + $_.LastWriteTime.ToString("yyyy.MM.dd") + ".7z") $_.FullName
        Remove-Item $_.FullName -Force -Recurse
	 }
}
 Get-ChildItem -Recurse -Path $i -Filter "*.7z" | Where-Object -Property CreationTime -LT $deletedate | Remove-Item
}
