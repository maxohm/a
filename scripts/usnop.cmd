@rem %windir%\system32\cmd.exe
@rem
@rem (c) 2020, maxohm [ at ] gmail.com
@rem
fsutil usn queryjournal %1
fsutil usn deletejournal /D %1
fsutil usn createjournal m=134217728 a=1 %1