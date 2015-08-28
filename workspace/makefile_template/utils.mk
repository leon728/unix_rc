####################################
# function for auto directory creation
#-----------------------------------

# Coloring code.
COL_NONE                := \033[00m
COL_RED                 := \033[01;31m
COL_GREEN               := \033[01;32m
COL_YELLOW              := \033[01;33m
COL_BLUE                := \033[01;34m
COL_PINK                := \033[01;35m
COL_CYAN                := \033[01;36m

define depend_on_dir
$(1): | $(dir $(1))
ifndef $(dir $(1))_DIRECTORY_RULE_IS_DEFINED
$(dir $(1)):
	mkdir -p $$@
$(dir $(1))_DIRECTORY_RULE_IS_DEFINED := 1
endif
endef

define target_so
$(1)_obj := $$($(1):%.c=$(OBJ_DIR)/%.o)
$($(1)_out): $$($(1)_obj)
	@echo -e "$(COL_CYAN) == $$@ $(COL_NONE)"
	$(CC) -o $$@ $(LDFLAGS) $(LDLIBS) $$($(1)_obj) -Wl,-z,defs -shared
$$($(1)_obj): $(OBJ_DIR)/%.o: %.c
	@echo -e "$(COL_BLUE) >> $$< $(COL_NONE)"
	$(CC) -o $$@ $(CFLAGS) $(INCFLAGS) $$< -fPIC
$$(foreach file,$$($(1)_obj),$$(eval $$(call depend_on_dir,$$(file))))
-include $$($(1)_obj:.o=.d)
endef

define target_exe
$(1)_obj := $$($(1):%.c=$(OBJ_DIR)/%.o)
$($(1)_out): $$($(1)_obj)
	@echo -e "$(COL_CYAN) == $$@ $(COL_NONE)"
	$(CC) -o $$@ $(LDFLAGS) $(LDLIBS) $$($(1)_obj)
$$($(1)_obj): $(OBJ_DIR)/%.o: %.c
	@echo -e "$(COL_BLUE) >> $$< $(COL_NONE)"
	$(CC) -o $$@ $(CFLAGS) $(INCFLAGS) $$<
$$(foreach file,$$($(1)_obj),$$(eval $$(call depend_on_dir,$$(file))))
-include $$($(1)_obj:.o=.d)
endef
