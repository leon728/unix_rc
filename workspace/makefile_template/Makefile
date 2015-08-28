include $(BUILD_DIR)/buildroot/utils.mk

OBJ_DIR := ../output/cmapi


####################################
# flags
#-----------------------------------
LDFLAGS := \
	-L$(LIB_DIR) \

LDLIBS := \
	-lcmdb \

INCFLAGS := \
	-I../svc \
	-I$(INC_DIR) \

CFLAGS = -Wall -MMD -MP -c -g

default: all


####################################
# libcmapi_loopguard.so
#-----------------------------------
lgSrc     := cmapi_loopguard.c cmapi_loopguard_callback.c ../svc/bytebuf.c
lgSrc_out := $(OBJ_DIR)/libcmapi_loopguard.so
$(eval $(call target_so,lgSrc))


####################################
# libcmapi_leon.so
#-----------------------------------
leon     := cmapi_leon.c
leon_out := $(OBJ_DIR)/libcmapi_leon.so
$(eval $(call target_so,leon))


####################################
# targets
#-----------------------------------
all: codegen $(lgSrc_out) $(leon_out)

SCRIPT := $(wildcard *.dsc)
CG_SRC := $(SCRIPT:%.dsc=cmapi_%.c)
#SRC := $(CG_SRC) $(wildcard *.c)
# 'sort' will sort and remove duplicate words, we use it here merely to remove duplicate words
#SRC := $(sort $(CG_SRC) $(wildcard *.c)) ../svc/bytebuf.c
#OBJ := $(SRC:%.c=$(OBJ_DIR)/%.o)
codegen: $(CG_SRC)
	@echo -e "$(COL_CYAN) == $@ $(COL_NONE)"

cmapi_%.c: %.dsc
	@echo -e "$(COL_BLUE) >> $< $(COL_NONE)"
	$(CODEGEN) $<
