@rem %windir%\system32\cmd.exe
@rem
@rem (c) 2019, maxohm [ at ] gmail.com
@rem
@%windir%\System32\netsh interface ip set dns name="Local0" source="static" address="192.168.1.254"
@%windir%\System32\route.exe add 0.0.0.0 mask 0.0.0.0 192.168.1.254

