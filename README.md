# vmprotect.nim
Wrapper for VMProtect SDK

This module supports:
- Windows (not tested yet)
- MinGW
- Linux
- OSX (not tested yet)

Notes:
- For Linux users, make sure you have libVMProjectXX.so in your LD_LIBRARY_PATH in development environent (its not needed when protected)

## Usage
```nim
import vmprotect

proc toBeProtected() =
  VMProtectBeginUltra("MarkerName")
  # your code goes here
  VMProtectEnd()
```

Check out [VMProtect's SDK Functions](http://vmpsoft.com/support/user-manual/working-with-vmprotect/preparing-a-project/sdk-functions) for more details
