; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mattr=-vsx -mtriple=ppc32-- | FileCheck %s

define double @foo(double %X) nounwind {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis 3, .LCPI0_0@ha
; CHECK-NEXT:    lfd 0, .LCPI0_0@l(3)
; CHECK-NEXT:    lis 3, .LCPI0_1@ha
; CHECK-NEXT:    lfd 2, .LCPI0_1@l(3)
; CHECK-NEXT:    fmul 0, 1, 0
; CHECK-NEXT:    fmul 1, 0, 2
; CHECK-NEXT:    blr
  %tmp1 = fmul double %X, 1.23
  %tmp2 = fmul double %tmp1, 4.124
  ret double %tmp2
}

define double @foo_reassoc(double %X) nounwind {
; CHECK-LABEL: foo_reassoc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis 3, .LCPI1_0@ha
; CHECK-NEXT:    lfd 0, .LCPI1_0@l(3)
; CHECK-NEXT:    fmul 1, 1, 0
; CHECK-NEXT:    blr
  %tmp1 = fmul reassoc double %X, 1.23
  %tmp2 = fmul reassoc double %tmp1, 4.124
  ret double %tmp2
}