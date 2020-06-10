# vmprotect.nim
Wrapper for VMProtect SDK

This module supports:
- Windows (not tested yet)
- MinGW
- Linux
- OSX (not tested yet)

## Usage
```nim
import vmprotect

proc toBeProtected() =
  VMProtectBeginUltra("MarkerName")
  # your code goes here
  VMProtectEnd()
```

Check out [VMProtect's SDK Functions](http://vmpsoft.com/support/user-manual/working-with-vmprotect/preparing-a-project/sdk-functions) for more details
