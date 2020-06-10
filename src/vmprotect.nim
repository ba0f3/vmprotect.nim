import os
const PATH = currentSourcePath.splitPath.head

when defined(mingw):
  const
    platform = "Windows/MinGW"
    suffix = ".a"
elif defined(windows):
  import winlean
  const
    platform = "Windows"
    suffix = ".dll"
elif defined(darwin):
  const
    platform = "OSX"
    suffix = ".dylib"
else:
  const
    platform = "Linux"
    suffix = ".so"

when defined(darwin):
  const arch = ""
elif hostCPU == "i386":
  const arch = "32"
else:
  const arch = "64"

when defined(mingw):
  {.push importc, stdcall.}
  {.passL: "-L" & PATH & "/private/lib/" & platform & " -l" & "VMProtectSDK" & arch.}
elif defined(windows):
  {.push importc, stdcall, dynlib: PATH & "/private/lib/" & platform & "/VMProtectSDK" & arch & suffix.}
else:
  {.push importc, cdecl, dynlib: PATH & "/private/lib/" & platform & "/libVMProtectSDK" & arch & suffix.}



proc VMProtectBegin*(MarkerName: cstring)
proc VMProtectBeginVirtualization*(MarkerName: cstring)
proc VMProtectBeginMutation*(MarkerName: cstring)
proc VMProtectBeginUltra*(MarkerName: cstring)
proc VMProtectBeginVirtualizationLockByKey*(MarkerName: cstring)
proc VMProtectBeginUltraLockByKey*(MarkerName: cstring)
proc VMProtectEnd*()
proc VMProtectIsProtected*(): bool
proc VMProtectIsDebuggerPresent*(CheckKernelMode: bool): bool
proc VMProtectIsVirtualMachinePresent*(): bool
proc VMProtectIsValidImageCRC*(): bool
proc VMProtectDecryptStringA*(Value: cstring): cstring

when defined(windows):
  proc VMProtectDecryptStringW*(Value: WideCString): WideCString

proc VMProtectFreeString*(Value: pointer): bool
{.pop.}