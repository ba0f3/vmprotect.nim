import vmprotect


proc add(a, b: int): int {.exportc, dynlib.} =
  VMProtectBeginUltra("2")
  result = a + b
  VMProtectEnd()
