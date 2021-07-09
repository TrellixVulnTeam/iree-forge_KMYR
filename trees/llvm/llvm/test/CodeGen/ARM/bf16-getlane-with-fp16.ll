; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=armv8.6a-arm-none-eabi -mattr=+bf16,+neon,+fullfp16 < %s | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv8.6a-arm-none-eabi"

define arm_aapcs_vfpcc bfloat @test_vgetq_lane_bf16_even(<8 x bfloat> %v) {
; CHECK-LABEL: test_vgetq_lane_bf16_even:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s0, s3
; CHECK-NEXT:    bx lr
entry:
  %0 = extractelement <8 x bfloat> %v, i32 6
  ret bfloat %0
}

define arm_aapcs_vfpcc bfloat @test_vgetq_lane_bf16_odd(<8 x bfloat> %v) {
; CHECK-LABEL: test_vgetq_lane_bf16_odd:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovx.f16 s0, s3
; CHECK-NEXT:    bx lr
entry:
  %0 = extractelement <8 x bfloat> %v, i32 7
  ret bfloat %0
}

define arm_aapcs_vfpcc bfloat @test_vget_lane_bf16_even(<4 x bfloat> %v) {
; CHECK-LABEL: test_vget_lane_bf16_even:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s0, s1
; CHECK-NEXT:    bx lr
entry:
  %0 = extractelement <4 x bfloat> %v, i32 2
  ret bfloat %0
}

define arm_aapcs_vfpcc bfloat @test_vget_lane_bf16_odd(<4 x bfloat> %v) {
; CHECK-LABEL: test_vget_lane_bf16_odd:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovx.f16 s0, s0
; CHECK-NEXT:    bx lr
entry:
  %0 = extractelement <4 x bfloat> %v, i32 1
  ret bfloat %0
}