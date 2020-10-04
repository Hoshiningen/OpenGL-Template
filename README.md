<div align="center">
<img src="images/OpenGLTemplateLogo.png">
</div>

<br>

This repository is a template OpenGL project configured using CMake. It supports cross-platform builds, and provides a good starting point to begin OpenGL development.

## Usage

The intended usage for this repository is to be a template for future Github repositories. See [this](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template) guide for more information.

## Building

To configure and build the project, do the following from the root directory of the repository:

```bash
mkdir build
cd build
cmake ..
```

This will configure the CMake and will generate platform-specific build files. To build, execute the following from within the build directory:

```bash
cmake --build .
```

Or build using whatever generated build system CMake produced.

## Third Party Library Support

By default, the CMake project will automatically link with GLAD, GLFW, and OpenGL. There is optional built-in support for a few other ubiquitous libraries. Create an [issue](https://github.com/Hoshiningen/OpenGL-Template/issues) to request default support for additional libraries, or make a pull request with your addition.

### GLAD

GLAD loader files will be generated based on the CMake cache variables set in [CMakeLists.txt](CMakeLists.txt). Setting these variables allows one to specify the parameters for the loader similar to what the corresponding [webservice](https://glad.dav1d.de/) allows you to do.

### GLFW

GLFW is linked automatically against the main project. This works without requiring any additional dependencies to be installed on Windows, but Linux may require some additional steps depending on your environment:

1. Make sure you have a working compiler (GCC / CLANG) and build system, and that they're accessible to CMake. Stable versions of GCC (note: this project supports C++17 by default) and Make can be pulled down through:
   
    ```bash
    sudo apt-get install build-essential
    ```

2. X11 may need to be installed for OpenGL window creation:

    ```bash
    sudo apt-get install libx11-dev
    ```

3. RandR headers (dependency of X11) may need to be installed as well:
   
   ```bash
   sudo apt-get install xorg-dev libglu1-mesa-dev
   ```

### Optional Libraries

There is built-in support for linking with a few other libraries that are well-known in the OpenGL community. These libraries are supported through the `LinkXXXX.cmake` scripts found in the `cmake` directory.

Some of these are configured to be optionally added as sub-projects, such as [ASSIMP](https://github.com/assimp/assimp):

```cmake
set(ENABLE_ASSIMP   OFF CACHE BOOL "Add Open Asset Import Library (assimp) to the project" FORCE)
```

Setting these flags to `ON` will add them to the project and will link them with the main executable. Depending on how you extend the project structure after the template is used, you may have to manually link with these libraries again with your sub-projects.

This can be accomplished by adding the following lines:

```cmake
include(${CMAKE_DIR}/<Linking Script>.cmake)
<Linking Script>(<Target> <Access>)
```

Where `<Linking Script>` is the name of the CMake script and linking macro, `<Target>` is the build target to link against, and `<Access>` is the access specifier for the linkage / header inclusion.
