# NpcompFindPyTorch
# Calls find_package on Torch and does any needed post-processing.
# The enable_pytorch flag can be OFF, ON or OPTIONAL.
macro(NpcompFindPyTorch enable_pytorch)
  if(${enable_pytorch} OR ${enable_pytorch} STREQUAL "OPTIONAL")
    NpcompProbeForPyTorchInstall()
    if(${enable_pytorch} STREQUAL "OPTIONAL")
      find_package(Torch 1.8)
    else()
      find_package(Torch 1.8 REQUIRED)
    endif()

    if(${TORCH_FOUND})
      NpcompConfigurePyTorch()
    endif()
  else()
    message(STATUS "Not configuring PyTorch (disabled)")
  endif()
endmacro()

# NpcompProbeForPyTorchInstall
# Attempts to find a Torch installation and set the Torch_ROOT variable
# based on introspecting the python environment. This allows a subsequent
# call to find_package(Torch) to work.
function(NpcompProbeForPyTorchInstall)
  if(Torch_ROOT)
    message(STATUS "Using cached Torch root = ${Torch_ROOT}")
  else()
    message(STATUS "Checking for PyTorch using ${PYTHON_EXECUTABLE} ...")
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE}
      -c "import os;import torch;print(torch.utils.cmake_prefix_path, end='')"
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      RESULT_VARIABLE PYTORCH_STATUS
      OUTPUT_VARIABLE PYTORCH_PACKAGE_DIR)
    if(NOT PYTORCH_STATUS EQUAL "0")
      message(STATUS "Unable to 'import torch' with ${PYTHON_EXECUTABLE} (fallback to explicit config)")
      return()
    endif()
    message(STATUS "Found PyTorch installation at ${PYTORCH_PACKAGE_DIR}")

    set(Torch_ROOT "${PYTORCH_PACKAGE_DIR}" CACHE STRING
        "Torch configure directory" FORCE)
  endif()
endfunction()

# NpcompConfigurePyTorch
# Performs configuration of PyTorch flags after CMake has found it to be
# present. Most of this comes down to detecting whether building against a
# source or official binary and adjusting compiler options in the latter case
# (in the former, we assume that it was built with system defaults). We do this
# conservatively and assume non-binary builds by default.
#
# In the future, we may want to switch away from custom building these
# extensions and instead rely on the Torch machinery directly (definitely want
# to do that for official builds).
function(NpcompConfigurePyTorch)
  if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    # Linux specific libstdcpp ABI checking.
    message(STATUS "Checking if Torch is an official binary ...")
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE}
      -c "from torch.utils import cpp_extension as c; import sys; sys.exit(0 if c._is_binary_build() else 1)"
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      RESULT_VARIABLE _is_binary_build)
    if(${_is_binary_build} EQUAL 0)
      set(TORCH_CXXFLAGS "")
      if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
        set(TORCH_CXXFLAGS "-D_GLIBCXX_USE_CXX11_ABI=0 -fabi-version=11")
      elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
        set(TORCH_CXXFLAGS "-D_GLIBCXX_USE_CXX11_ABI=0 -U__GXX_ABI_VERSION -D__GXX_ABI_VERSION=1011 '-DPYBIND11_COMPILER_TYPE=\"_gcc\"'")
      else()
        message(WARNING "Unrecognized compiler. Cannot determine ABI flags.")
        return()
      endif()
      message(STATUS "Detected Torch official binary build. Setting ABI flags: ${TORCH_CXXFLAGS}")
      set(TORCH_CXXFLAGS "${TORCH_CXXFLAGS}" PARENT_SCOPE)
    endif()
  endif()
endfunction()
