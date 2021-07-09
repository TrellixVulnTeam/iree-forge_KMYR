// RUN: iree-opt -split-input-file -pass-pipeline='vm.module(iree-convert-vm-to-emitc)' %s | IreeFileCheck %s

// CHECK-LABEL: @add_f32
vm.module @my_module {
  vm.func @add_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_add_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.add.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @sub_f32
vm.module @my_module {
  vm.func @sub_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_sub_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.sub.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @mul_f32
vm.module @my_module {
  vm.func @mul_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_mul_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.mul.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @div_f32
vm.module @my_module {
  vm.func @div_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_div_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.div.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @rem_f32
vm.module @my_module {
  vm.func @rem_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_rem_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.rem.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @fma_f32
vm.module @my_module {
  vm.func @fma_f32(%arg0: f32, %arg1: f32, %arg2: f32) {
    // CHECK: %0 = emitc.call "vm_fma_f32"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    %0 = vm.fma.f32 %arg0, %arg1, %arg2 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @abs_f32
vm.module @my_module {
  vm.func @abs_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_abs_f32"(%arg0) : (f32) -> f32
    %0 = vm.abs.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @neg_f32
vm.module @my_module {
  vm.func @neg_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_neg_f32"(%arg0) : (f32) -> f32
    %0 = vm.neg.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @ceil_f32
vm.module @my_module {
  vm.func @ceil_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_ceil_f32"(%arg0) : (f32) -> f32
    %0 = vm.ceil.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @floor_f32
vm.module @my_module {
  vm.func @floor_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_floor_f32"(%arg0) : (f32) -> f32
    %0 = vm.floor.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @atan_f32
vm.module @my_module {
  vm.func @atan_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_atan_f32"(%arg0) : (f32) -> f32
    %0 = vm.atan.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @atan2_f32
vm.module @my_module {
  vm.func @atan2_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_atan2_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.atan2.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @cos_f32
vm.module @my_module {
  vm.func @cos_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_cos_f32"(%arg0) : (f32) -> f32
    %0 = vm.cos.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @sin_f32
vm.module @my_module {
  vm.func @sin_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_sin_f32"(%arg0) : (f32) -> f32
    %0 = vm.sin.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @exp_f32
vm.module @my_module {
  vm.func @exp_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_exp_f32"(%arg0) : (f32) -> f32
    %0 = vm.exp.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @exp2_f32
vm.module @my_module {
  vm.func @exp2_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_exp2_f32"(%arg0) : (f32) -> f32
    %0 = vm.exp2.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @expm1_f32
vm.module @my_module {
  vm.func @expm1_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_expm1_f32"(%arg0) : (f32) -> f32
    %0 = vm.expm1.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @log_f32
vm.module @my_module {
  vm.func @log_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_log_f32"(%arg0) : (f32) -> f32
    %0 = vm.log.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @log10_f32
vm.module @my_module {
  vm.func @log10_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_log10_f32"(%arg0) : (f32) -> f32
    %0 = vm.log10.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @log1p_f32
vm.module @my_module {
  vm.func @log1p_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_log1p_f32"(%arg0) : (f32) -> f32
    %0 = vm.log1p.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @log2_f32
vm.module @my_module {
  vm.func @log2_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_log2_f32"(%arg0) : (f32) -> f32
    %0 = vm.log2.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @pow_f32
vm.module @my_module {
  vm.func @pow_f32(%arg0 : f32, %arg1 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_pow_f32"(%arg0, %arg1) : (f32, f32) -> f32
    %0 = vm.pow.f32 %arg0, %arg1 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @rsqrt_f32
vm.module @my_module {
  vm.func @rsqrt_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_rsqrt_f32"(%arg0) : (f32) -> f32
    %0 = vm.rsqrt.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @sqrt_f32
vm.module @my_module {
  vm.func @sqrt_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_sqrt_f32"(%arg0) : (f32) -> f32
    %0 = vm.sqrt.f32 %arg0 : f32
    vm.return %0 : f32
  }
}

// -----

// CHECK-LABEL: @tanh_f32
vm.module @my_module {
  vm.func @tanh_f32(%arg0 : f32) -> f32 {
    // CHECK-NEXT: %0 = emitc.call "vm_tanh_f32"(%arg0) : (f32) -> f32
    %0 = vm.tanh.f32 %arg0 : f32
    vm.return %0 : f32
  }
}
