include(FetchContent)

macro(LinkSTB TARGET ACCESS)
    FetchContent_Declare(
        stb
        GIT_REPOSITORY https://github.com/nothings/stb
        GIT_TAG b42009b3b9d4ca35bc703f5310eedc74f584be58
    )

    FetchContent_GetProperties(stb)

    if (NOT stb_POPULATED)
        FetchContent_Populate(stb)
    endif()

    target_include_directories(${TARGET} ${ACCESS} ${stb_SOURCE_DIR})
endmacro()