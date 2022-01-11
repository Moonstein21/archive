$path = @()
$zipdate = (Get-Date).Date.AddDays(-2)
$deletedate = (Get-Date).Date.AddDays(-14)

#архив

foreach($i in $path){

Get-ChildItem $i -Exclude archive | Where {$_.LastWriteTime -lt $zipdate} | Foreach {

	$date = 0

	if([DateTime]::TryParseExact($_.Name.SubString(0,8),"yyyyMMdd",[Globalization.CultureInfo]::Custom,"None",[ref]$date))
	{
		&"C:\Program Files\7-Zip\7z.exe" a ("$i\" + $date.ToString("yyyy.MM.dd") + ".7z") $_.FullName
	}
	else {
		&"C:\Program Files\7-Zip\7z.exe" a ("$i\" + $_.LastWriteTime.ToString("yyyy.MM.dd") + ".7z") $_.FullName
	}
	
	Remove-Item $_.FullName -Force -Recurse
    
}
 Get-ChildItem -Recurse -Path $i -Filter "*.7z" | Where-Object -Property CreationTime -LT $deletedate | Remove-Item

}

