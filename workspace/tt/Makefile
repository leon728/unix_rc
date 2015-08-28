
OBJDIR = objdir

#df = $(OBJDIR)/$(*F)

SRCS = b.c f.c

OBJS := $(SRCS:%.c=$(OBJDIR)/%.o)
#OBJS := $(SRCS:.c=.o)
#$(warning $(OBJS))

all: $(OBJS)

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir -p $@

#%.o : %.c
#	$(COMPILE.c) -MD -o $@ $<
#	@cp $(df).d $(df).P; \
#	sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
#	    -e '/^$$/ d' -e 's/$$/ :/' < $(df).d >> $(df).P; \
#	rm -f $(df).d
	
#%.o : %.c
#	$(COMPILE.c) -MMD -o $@ $<
#	@cp $*.d $*.P; \
#	sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
#	    -e '/^$$/ d' -e 's/$$/ :/' < $*.d >> $*.P; \
#	rm -f $*.d

#%.o : %.c
#	$(COMPILE.c) -MMD -MP -o $@ $<

$(OBJDIR)/%.o : %.c
	$(COMPILE.c) -MMD -MP -o $@ $<

clean:
#	rm -f *.o *.d *.P
#	rm -f *.o *.d
#	rm -f $(OBJDIR)/*
	rm -rf $(OBJDIR)

#-include $(SRCS:%.c=$(DEPDIR)/%.P)
#-include $(SRCS:.c=.P)
#-include $(SRCS:.c=.d)
-include $(SRCS:%.c=$(OBJDIR)/%.d)
