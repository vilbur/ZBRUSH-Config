#SingleInstance force


RunWait, % comspec  " /c netsh wlan disconnect",, hide

;RunWait, C:\Program Files\Pixologic\ZBrush 2022\ZBrush.exe

sleep 10000


RunWait, % comspec  " /c netsh wlan connect name=""vilbur-phone""",, hide

MsgBox,262144,Wi-Fi Supspended, Wi-Fi Supspended,1