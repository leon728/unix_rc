
SRCDIR := src
OBJDIR := obj
#SRC := $(wildcard *.c $(SRCDIR)/*.c $(SRCDIR)/*/*.c $(SRCDIR)/*/*/*.c $(SRCDIR)/*/*/*/*.c)
SRC := $(shell find $(SRCDIR) -type f -name '*.c')
OBJ := $(SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
#$(warning $(SRC))
#$(warning $(OBJ))

####################################

all: $(OBJ)

$(OBJDIR)/%.o: $(SRCDIR)/%.c 
	gcc -c -o $@ $<

clean:
	rm -rf $(OBJDIR)

####################################
# auto directory creation

define depend_on_dir
$(1): | $(dir $(1))
#----
ifndef $(dir $(1))_DIRECTORY_RULE_IS_DEFINED
$(dir $(1)):
	mkdir -p $$@
$(dir $(1))_DIRECTORY_RULE_IS_DEFINED := 1
endif
#----
endef

$(foreach file,$(OBJ),$(eval $(call depend_on_dir,$(file))))

####################################
