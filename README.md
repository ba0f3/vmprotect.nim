# vmprotect.nim
Wrapper for VMProtect SDK

## Usage
```nim
import vmprotect

proc toBeProtected() =
  VMProtectBeginUltra("2")
  # your code goes here
  VMProtectEnd()
```

Check out [VMProtect's SDK Functions](http://vmpsoft.com/support/user-manual/working-with-vmprotect/preparing-a-project/sdk-functions) for more details
