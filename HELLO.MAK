#===================================================================
#
#   HELLO.MAK - Standard Window Application Make file
#   Copyright   IBM Corporation 1996
#
#===================================================================
#===================================================================
# Include the file ibmsamp.inc which defines the various macros
# depending on the target specified.
#
# The following macros are defined in ibmsamp.inc:
#
#       OBJDIR   - Directory where object files are created
#       EXEDIR   - Directory where executable files are created
#       RC       - Resource compiler
#       RCFLAGS  - Resource compiler flags
#       LINK     - Linker
#       LFLAGS   - Linker flags
#       MTLIBS   - Multithreaded versions of the runtime libraries
#===================================================================

!include ..\..\ibmsamp.inc

HEADERS = hello.h
#-------------------------------------------------------------------
#
#   A list of all of the object files
#
#-------------------------------------------------------------------

OBJS = $(OBJDIR)\hello.obj

#-------------------------------------------------------------------
#   This section lists all files to be built by  make.  The
#   makefile builds the executable as well as its associated help
#   file.
#-------------------------------------------------------------------
all: $(EXEDIR)\hello.exe

#-------------------------------------------------------------------
#   Dependencies
#     This section lists all object files needed to be built for the
#     application, along with the files it is dependent upon (e.g.
#     its source and any header files).
#-------------------------------------------------------------------

$(OBJDIR)\hello.res: $(HEADERS) hello.rc hello.ico prodinfo.bmp
                $(RC) $(RCFLAGS) $(@B).rc $@
                @del prodinfo.bmp

prodinfo.bmp :
           copy ..\..\prodinfo.bmp $@

$(OBJDIR)\hello.obj: hello.c $(HEADERS)

$(EXEDIR)\hello.exe: $(OBJS) $(@B).def $(OBJDIR)\$(@B).res
   -$(CREATE_PATH)
   $(LINK) $@ $(@B).def $(MTLIBS) $(OBJS)
   $(RC) -p -x $(OBJDIR)\$(@B).res $@

clean :
        @if exist *.obj del *.obj
        @if exist *.dll del *.dll
        @if exist *.exe del *.exe
