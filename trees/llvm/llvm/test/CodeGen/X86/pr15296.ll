; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-pc-linux -mcpu=corei7-avx | FileCheck %s

define <8 x i32> @shiftInput___vyuunu(<8 x i32> %input, i32 %shiftval, <8 x i32> %__mask) nounwind {
; CHECK-LABEL: shiftInput___vyuunu:
; CHECK:       # %bb.0: # %allocas
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vpsrld %xmm2, %xmm1, %xmm1
; CHECK-NEXT:    vpsrld %xmm2, %xmm0, %xmm0
; CHECK-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; CHECK-NEXT:    retl
allocas:
  %smear.0 = insertelement <8 x i32> undef, i32 %shiftval, i32 0
  %smear.1 = insertelement <8 x i32> %smear.0, i32 %shiftval, i32 1
  %smear.2 = insertelement <8 x i32> %smear.1, i32 %shiftval, i32 2
  %smear.3 = insertelement <8 x i32> %smear.2, i32 %shiftval, i32 3
  %smear.4 = insertelement <8 x i32> %smear.3, i32 %shiftval, i32 4
  %smear.5 = insertelement <8 x i32> %smear.4, i32 %shiftval, i32 5
  %smear.6 = insertelement <8 x i32> %smear.5, i32 %shiftval, i32 6
  %smear.7 = insertelement <8 x i32> %smear.6, i32 %shiftval, i32 7
  %bitop = lshr <8 x i32> %input, %smear.7
  ret <8 x i32> %bitop
}

define <8 x i32> @shiftInput___canonical(<8 x i32> %input, i32 %shiftval, <8 x i32> %__mask) nounwind {
; CHECK-LABEL: shiftInput___canonical:
; CHECK:       # %bb.0: # %allocas
; CHECK-NEXT:    vbroadcastss {{[0-9]+}}(%esp), %xmm1
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm2 = xmm1[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm3
; CHECK-NEXT:    vpsrld %xmm2, %xmm3, %xmm4
; CHECK-NEXT:    vpsrlq $32, %xmm1, %xmm5
; CHECK-NEXT:    vpsrld %xmm5, %xmm3, %xmm6
; CHECK-NEXT:    vpblendw {{.*#+}} xmm4 = xmm6[0,1,2,3],xmm4[4,5,6,7]
; CHECK-NEXT:    vpxor %xmm6, %xmm6, %xmm6
; CHECK-NEXT:    vpblendw {{.*#+}} xmm6 = xmm1[0,1],xmm6[2,3,4,5,6,7]
; CHECK-NEXT:    vpsrld %xmm6, %xmm3, %xmm7
; CHECK-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; CHECK-NEXT:    vpsrld %xmm1, %xmm3, %xmm3
; CHECK-NEXT:    vpblendw {{.*#+}} xmm3 = xmm3[0,1,2,3],xmm7[4,5,6,7]
; CHECK-NEXT:    vpblendw {{.*#+}} xmm3 = xmm3[0,1],xmm4[2,3],xmm3[4,5],xmm4[6,7]
; CHECK-NEXT:    vpsrld %xmm2, %xmm0, %xmm2
; CHECK-NEXT:    vpsrld %xmm5, %xmm0, %xmm4
; CHECK-NEXT:    vpsrld %xmm6, %xmm0, %xmm5
; CHECK-NEXT:    vpsrld %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpblendw {{.*#+}} xmm1 = xmm4[0,1,2,3],xmm2[4,5,6,7]
; CHECK-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm5[4,5,6,7]
; CHECK-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3],xmm0[4,5],xmm1[6,7]
; CHECK-NEXT:    vinsertf128 $1, %xmm3, %ymm0, %ymm0
; CHECK-NEXT:    retl
allocas:
  %smear.0 = insertelement <8 x i32> undef, i32 %shiftval, i32 0
  %smear.7 = shufflevector <8 x i32> %smear.0, <8 x i32> undef, <8 x i32> zeroinitializer
  %bitop = lshr <8 x i32> %input, %smear.7
  ret <8 x i32> %bitop
}

define <4 x i64> @shiftInput___64in32bitmode(<4 x i64> %input, i64 %shiftval, <4 x i64> %__mask) nounwind {
; CHECK-LABEL: shiftInput___64in32bitmode:
; CHECK:       # %bb.0: # %allocas
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vmovddup {{.*#+}} xmm2 = mem[0,0]
; CHECK-NEXT:    vpsrlq %xmm2, %xmm1, %xmm1
; CHECK-NEXT:    vpsrlq %xmm2, %xmm0, %xmm0
; CHECK-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; CHECK-NEXT:    retl
allocas:
  %smear.0 = insertelement <4 x i64> undef, i64 %shiftval, i32 0
  %smear.7 = shufflevector <4 x i64> %smear.0, <4 x i64> undef, <4 x i32> zeroinitializer
  %bitop = lshr <4 x i64> %input, %smear.7
  ret <4 x i64> %bitop
}