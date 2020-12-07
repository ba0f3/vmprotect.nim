import os
const PATH = currentSourcePath.splitPath.head

when defined(mingw):
  const
    platform = "Windows/MinGW"
    suffix = ""
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
    suffix = ""

when defined(darwin):
  const arch = ""
elif hostCPU == "i386":
  const arch = "32"
else:
  const arch = "64"

when defined(windows):
  type VMP_WCHAR = WideCString
else:
  type VMP_WCHAR = uint16

type
  VMProtectSerialStateFlags* = enum
    SERIAL_STATE_SUCCESS = 0x0
    SERIAL_STATE_FLAG_CORRUPTED = 0x1
    SERIAL_STATE_FLAG_INVALID = 0x2
    SERIAL_STATE_FLAG_BLACKLISTED = 0x4
    SERIAL_STATE_FLAG_DATE_EXPIRED = 0x8
    SERIAL_STATE_FLAG_RUNNING_TIME_OVER = 0x10
    SERIAL_STATE_FLAG_BAD_HWID = 0x20
    SERIAL_STATE_FLAG_MAX_BUILD_EXPIRED = 0x40

  VMProtectActivationFlags* = enum
    ACTIVATION_OK = 0,
    ACTIVATION_SMALL_BUFFER,
    ACTIVATION_NO_CONNECTION,
    ACTIVATION_BAD_REPLY,
    ACTIVATION_BANNED,
    ACTIVATION_CORRUPTED,
    ACTIVATION_BAD_CODE,
    ACTIVATION_ALREADY_USED,
    ACTIVATION_SERIAL_UNKNOWN,
    ACTIVATION_EXPIRED,
    ACTIVATION_NOT_AVAILABLE

  VMProtectDate* {.packed.} = object
    wYear: uint16
    bMonth: uint8
    bDay: uint8

  VMProtectSerialNumberData* {.packed.} = object
    nState: int32
    wUserName: array[256, VMP_WCHAR]
    wEMail: array[256, VMP_WCHAR]
    dtExpire: VMProtectDate
    bRunningTime: int32
    dtMaxBuild: VMProtectDate
    nUserDataLength: uint8
    bUserData: array[255, char]

{.push importc, stdcall.}
{.passL: "-L" & PATH & "/private/lib/" & platform & " -l" & "VMProtectSDK" & arch & suffix.}

# protection
proc VMProtectBegin*(MarkerName: cstring = "")
proc VMProtectBeginVirtualization*(MarkerName: cstring = "")
proc VMProtectBeginMutation*(MarkerName: cstring = "")
proc VMProtectBeginUltra*(MarkerName: cstring = "")
proc VMProtectBeginVirtualizationLockByKey*(MarkerName: cstring = "")
proc VMProtectBeginUltraLockByKey*(MarkerName: cstring = "")
proc VMProtectEnd*()

# utils
proc VMProtectIsProtected*(): bool
proc VMProtectIsDebuggerPresent*(CheckKernelMode = false): bool
proc VMProtectIsVirtualMachinePresent*(): bool
proc VMProtectIsValidImageCRC*(): bool
proc VMProtectDecryptStringA*(Value: cstring): cstring
when defined(windows):
  proc VMProtectDecryptStringW*(Value: WideCString): WideCString
proc VMProtectFreeString*(Value: pointer): bool

# licensing
proc VMProtectSetSerialNumber*(serial: cstring)
proc VMProtectGetSerialNumberState*(): int32
proc VMProtectGetSerialNumberData*(data: VMProtectSerialNumberData, size: int32): bool
proc VMProtectGetCurrentHWID*(hwid: cstring, size: int32): int32

# activation
proc VMProtectActivateLicense*(code: cstring, serial: cstring, size: int32): int32
proc VMProtectDeactivateLicense*(serial: cstring): int32
proc VMProtectGetOfflineActivationString*(code: cstring, buf: cstring, size: int32): int32
proc VMProtectGetOfflineDeactivationString*(serial: cstring, buf: cstring, size: int32): int32

{.pop.}