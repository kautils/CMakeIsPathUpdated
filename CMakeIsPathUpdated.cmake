
macro(CMakeIsPathUpdated CMakeIsPathUpdated_res)
    set(${PROJECT_NAME}_CMakeIsPathUpdated_m_evacu ${m})
    set(m CMakePullLocalRepositoryAsSymLink)
    
    cmake_parse_arguments(${m} "" "DIRECTORY" "" ${ARGN})
    list(APPEND ${m}_unsetter ${m}_DIRECTORY CMakeIsPathUpdated_res)
    list(APPEND ${m}_unsetter ${m}_DIRECTORY CMakeIsPathUpdated_res)
    list(APPEND ${m}_unsetter ${m}_buf ${m}_files ${m}_path CMakeIsPathUpdated_res)
    
    set(${m}_path "${${m}_DIRECTORY}")
    if(IS_DIRECTORY ${${m}_DIRECTORY}) # directory 
        file(GLOB_RECURSE ${m}_files ${${m}_path}/*)
        string(REPLACE  ":" "" ${m}_path "${${m}_path}")
        foreach(__var ${${m}_files})
            if(NOT IS_DIRECTORY "${__var}")
                file(TIMESTAMP "${__var}" __var)
                string(APPEND ${m}_buf ${__var})
            endif()
        endforeach()
        string(MD5 ${m}_buf "${${m}_buf}")
    else() # file
        file(TIMESTAMP "${${m}_path}" ${m}_buf)
        string(REPLACE  ":" "" ${m}_path "${${m}_path}")
    endif()
    
    if(NOT "${update_t_${${m}_path}}" STREQUAL "${${m}_buf}")
        set(${CMakeIsPathUpdated_res} TRUE)
        set(update_t_${${m}_path} "${${m}_buf}" CACHE STRING "" FORCE)
    else()
        set(${CMakeIsPathUpdated_res} FALSE)
    endif()
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_CMakeIsPathUpdated_m_evacu})
    unset(${PROJECT_NAME}_CMakeIsPathUpdated_m_evacu)
endmacro()

