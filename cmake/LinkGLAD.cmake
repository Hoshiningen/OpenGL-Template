include(FetchContent)

macro(LinkGLAD TARGET ACCESS)
    FetchContent_Declare(
        glad
        GIT_REPOSITORY https://github.com/Dav1dde/glad
        GIT_TAG v0.1.33
    )

    FetchContent_GetProperties(glad)

    if (NOT glad_POPULATED)
        FetchContent_Populate(glad)

        # Edit these values to generate the desired loader-generator
        set(GLAD_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}" CACHE STRING "Output directory")
        set(GLAD_PROFILE "core" CACHE STRING "OpenGL profile")
        set(GLAD_API "gl=3.3" CACHE STRING "API type/version pairs, like \"gl=3.2,gles=\", no version means latest")
        set(GLAD_GENERATOR "c" CACHE STRING "Language to generate the binding for")
        set(GLAD_EXTENSIONS "" CACHE STRING "Path to extensions file or comma separated list of extensions, if missing all extensions are included")
        set(GLAD_SPEC "gl" CACHE STRING "Name of the spec")
        option(GLAD_ALL_EXTENSIONS "Include all extensions instead of those specified by GLAD_EXTENSIONS" OFF)
        option(GLAD_NO_LOADER "No loader" OFF)
        option(GLAD_REPRODUCIBLE "Reproducible build" OFF)

        # This excludes glad from being rebuilt when ALL_BUILD is built
        # it will only be built when a target is built that has a dependency on glad
        add_subdirectory(${glad_SOURCE_DIR} ${glad_BINARY_DIR} EXCLUDE_FROM_ALL)

        # Set the target's folders
        set_target_properties(glad PROPERTIES FOLDER ${PROJECT_NAME}/thirdparty)
        set_target_properties(glad-generate-files PROPERTIES FOLDER ${PROJECT_NAME}/thirdparty)
    endif()

    target_include_directories(${TARGET} ${ACCESS} ${glad_SOURCE_DIR}/include)
    target_link_libraries(${TARGET} ${ACCESS} glad)

    add_dependencies(${TARGET} glad)
endmacro()