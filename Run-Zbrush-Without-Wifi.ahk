#SingleInstance force


RunWait, % comspec  " /c netsh wlan disconnect",, hide

;RunWait, C:\Program Files\Pixologic\ZBrush 2022\ZBrush.exe

sleep 5000

RunWait, % comspec  " /c netsh wlan connect name=""vilbur-phone""",, hide