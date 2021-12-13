ALL: ..\lib\$(PROJ).lib ..\dll\$(PROJ)calls.dll ..\lib\$(PROJ)calls.lib

..\dll\$(PROJ)calls.dll: ..\lib\$(PROJ).lib $(OBJS) makefile
	@echo LINK $@
	@wlink.exe  op q,nod libpath ..\lib @<<
#     system   os2_dll
    option osname='OS/2 16-bit'
    format os2 dll ^
     option   map,nod, MANYAUTODATA
     name     ..\dll\$(PROJ)calls
     export $(EXPORT)
     file     ..\lib\$(PROJ).lib 
     lib	core.lib
!ifdef IMPORT
     lib $(IMPORT) 
!endif
<<

..\lib\$(PROJ)calls.lib: ..\dll\$(PROJ)calls.dll makefile
	@echo LIB $@
	@wlib -q -fo $@ ..\dll\$(PROJ)calls.dll

..\lib\$(PROJ).lib: $(OBJS) makefile
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -Fl -q -I..\include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map