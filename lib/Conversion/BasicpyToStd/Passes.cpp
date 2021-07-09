//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "npcomp/Conversion/BasicpyToStd/Passes.h"
#include "npcomp/Conversion/BasicpyToStd/Patterns.h"

#include "../PassDetail.h"
#include "mlir/Dialect/Traits.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

using namespace mlir;
using namespace mlir::NPCOMP;

namespace {

class ConvertBasicpyToStd
    : public ConvertBasicpyToStdBase<ConvertBasicpyToStd> {
public:
  void runOnOperation() override {
    FuncOp func = getOperation();
    (void)applyPatternsAndFoldGreedily(func, getPatterns());
  }

  FrozenRewritePatternSet getPatterns() {
    auto *context = &getContext();
    RewritePatternSet patterns(context);
    populateBasicpyToStdPrimitiveOpPatterns(patterns);
    return std::move(patterns);
  }
};

} // namespace

std::unique_ptr<OperationPass<FuncOp>>
mlir::NPCOMP::createConvertBasicpyToStdPass() {
  return std::make_unique<ConvertBasicpyToStd>();
}
