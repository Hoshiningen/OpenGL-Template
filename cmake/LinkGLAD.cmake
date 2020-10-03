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