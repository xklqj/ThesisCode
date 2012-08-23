#------------------------------------------------------------------------------#
#                                                                              #
#                                MAKE OPTIONS                                  #
#                                                                              #
#------------------------------------------------------------------------------#
ALL_TARGETS :=

.SUFFIXES:
.DEFAULT: release
release:


#------------------------------------------------------------------------------#
#                                                                              #
#                                CONFIGURATION                                 #
#                                                                              #
#------------------------------------------------------------------------------#
AUTOESL_DIR := AutoESL
OUTPUT_DIR  := bin
SOURCE_DIR  := source

BINARY_EXT  := bin
AUTOESL_EXT := autoesl


#------------------------------------------------------------------------------#
#                                                                              #
#                                 PROGRAMS                                     #
#                                                                              #
#------------------------------------------------------------------------------#
DELETE := rm
ECHO   := echo
GREP   := egrep
TEST   := test

#------------------------------------------------------------------------------#
#                                                                              #
#                              UTILITY MACROS                                  #
#                                                                              #
#------------------------------------------------------------------------------#

# $(call parse-mex-options,OPTION_NAME)
# Parse options from the mex compiler.
define parse-mex-options
$(shell $(MXX) -v 2>/dev/null | sed -n 's/\s*$1\s*=\s*\(\(-.\+\s\+\)\+\)/\1/p')
endef

# $(call pretty,STRING)
# Remove duplicate whitespace from a string. Removes the following:
#     - Repeated whitespace
#     - Leading whitespace
#     - Trailing whitespace
define pretty
$(shell echo -n "$1" | sed \
-e 's/\s\s\+/ /' \
-e 's/^\s\+//' \
-e 's/\s\+$$//'
)
endef

# $(call print-variable,var)
# Print the name and value of a variable.
print-variable = $(info $1=$($1))

# $(call print-variables)
# Print all makefile variables
define print-variables
$(foreach V,$(sort $(filter-out print-variable%,$(.VARIABLES))), 
	$(if $(filter file,$(origin $V)),
		$(call print-variable,$V)))
endef

# $(call remove-flag,FLAGS,FLAG)
# Remove a flag from a CFLAG-style string.
define remove-flag
$(shell echo -n $1 | sed 's/-$2\s\+//')
endef

# $(call autoesl-ready)
# Check that AutoESL can communicate with the licensing server correctly.
define autoesl-ready
$(shell echo 'exit' | $(AUTOESL) | egrep -q 'FLEXnet Licensing error')
endef

#-------------------------------------------------------------------------------

# $(eval $(call target-template,TARGET))
define target-template
ALL_TARGETS += $$(OUTPUT_DIR)/$(1).$$(BINARY_EXT)
$$(OUTPUT_DIR)/$(1).$$(BINARY_EXT): $$(COMMON_SOURCES) $$(BINARY_SOURCES)
	-@echo "Compiling: $$@"
	$$(call pretty,$$(CC) -D__C__ $$(CFLAGS) $$($(1)_CFLAGS) -o $$@ $$^)
	-@echo

ALL_TARGETS += $$(OUTPUT_DIR)/$(1).$$(AUTOESL_EXT)
$$(OUTPUT_DIR)/$(1).$$(AUTOESL_EXT): $$(COMMON_SOURCES) $$(AUTOESL_SOURCES)
	-@echo "Compiling: $$@"
	$$(if $$(call autoesl-ready),$$(call pretty,$$(CC) -D__AUTOESL__ $$(CFLAGS) $$($(1)_CFLAGS) -o $$@ $$^),-@$$(ECHO) "AutoESL not ready.")
	-@echo

ALL_TARGETS += $$(OUTPUT_DIR)/$(1).$$(MEX_EXT)
$$(OUTPUT_DIR)/$(1).$$(MEX_EXT): $$(COMMON_SOURCES) $$(MATLAB_SOURCES)
	-@echo "Compiling: $$@"
	$$(call pretty,$$(MXX) -D__MEX__ $$(MXXFLAGS) $$($(1)_MXXFLAGS) CFLAGS='$$(CFLAGS) $$($(1)_CFLAGS)' CXXFLAGS='$$(CXXFLAGS) $$($(1)_CXXFLAGS)' LDFLAGS='$$(LDFLAGS)' -o $$@ $$^)
	-@echo
endef


#------------------------------------------------------------------------------#
#                                                                              #
#                             MATLAB CONFIGURATION                             #
#                                                                              #
#------------------------------------------------------------------------------#
MATLAB_DIR := $(shell matlab -e 2>/dev/null | sed -n 's/MATLAB=\(.\+\)/\1/p')
ARCH       := $(shell matlab -e 2>/dev/null | sed -n 's/ARCH=\(.\+\)/\1/p')

ifndef MXX
	ifeq ($(shell uname),Darwin)
		MXX      := $(call pretty,$(MATLAB_DIR)/bin/mex -$(ARCH))
		MEX_EXT  := $(shell $(MATLAB_DIR)/bin/mexext)
		MXXFLAGS := -I$(MATLAB_DIR)/extern/include
	endif
	ifeq ($(shell uname),Linux)
		MXX      := $(call pretty,$(MATLAB_DIR)/bin/mex -$(ARCH))
		MEX_EXT  := $(shell $(MATLAB_DIR)/bin/mexext)
		MXXFLAGS := -I$(MATLAB_DIR)/extern/include
	endif
else
	MEX_EXT := $(shell mexext)
endif

ifeq ($(ARCH),glnx86)
	MEX_EXT   := mexglx
	ARCH_TYPE := x86
endif
ifeq ($(ARCH),glnxa64)
	MEX_EXT   := mexa64
	ARCH_TYPE := x64
endif
ifeq ($(ARCH),mac)
	MEX_EXT   := mexmac
	ARCH_TYPE := x86
endif
ifeq ($(ARCH),maci)
	MEX_EXT   := mexmaci
	ARCH_TYPE := x86
 endif
ifeq ($(ARCH),maci64)
	MEX_EXT   := mexmaci64
	ARCH_TYPE := x64
endif
ifeq ($(ARCH),sol2)
	MEX_EXT   := mexsol
	ARCH_TYPE := x86
endif
ifeq ($(ARCH),sol64)
	MEX_EXT   := mexs64
	ARCH_TYPE := x64
endif
ifeq ($(ARCH),win64)
	MEX_EXT   := mexw64
	ARCH_TYPE := x64
endif
ifeq ($(ARCH),win32)
	MEX_EXT   := mexw32
	ARCH_TYPE := x86
endif


#------------------------------------------------------------------------------#
#                                                                              #
#                            AUTOESL CONFIGURATION                             #
#                                                                              #
#------------------------------------------------------------------------------#
AUTOESL := autoesl -i

#------------------------------------------------------------------------------#
#                                                                              #
#                              COMPILER FLAGS                                  #
#                                                                              #
#------------------------------------------------------------------------------#

# C compiler
CC       := gcc

# Default flags (these will be overridden)
CFLAGS   := $(call parse-mex-options,CFLAGS)
CXXFLAGS := $(call parse-mex-options,CXXFLAGS)
LDFLAGS  := $(call parse-mex-options,LDFLAGS)

# Remove 'ANSI standard' flags
CFLAGS   := $(call remove-flag,$(CFLAGS),ansi)
CXXFLAGS := $(call remove-flag,$(CXXFLAGS),ansi)

# Additional flags
CFLAGS   += -std=c99 -W -Wall -pedantic -fmessage-length=0
CXXFLAGS += -std=c++0x -W -Wall -pedantic -fmessage-length=0
MXXFLAGS += -DVARDUMP
LDFLAGS  +=

# Architecture specific
ifeq ($(ARCH_TYPE), x86)
CFLAGS   +=
CXXFLAGS +=
MXXFLAGS += -compatibleArrayDims
LDFLAGS  +=
endif
ifeq ($(ARCH_TYPE), x64)
CFLAGS   +=
CXXFLAGS +=
MXXFLAGS += -largeArrayDims
LDFLAGS  +=
endif

# Debug flags
CFLAGS_DEBUG   := -g -O0 -DDEBUG -DSTATS
CXXFLAGS_DEBUG := -g -O0 -DDEBUG -DSTATS
MXXFLAGS_DEBUG := -DDEBUG -DSTATS
LDFLAGS_DEBUG  := -g

# Optimization flags
CFLAGS_OPT   := -O3 -DNDEBUG
CXXFLAGS_OPT := -O3 -DNDEBUG
MXXFLAGS_OPT := -O -DNDEBUG
LDFLAGS_OPT  := -O3


#------------------------------------------------------------------------------#
#                                                                              #
#                              DEPENDENCY RULES                                #
#                                                                              #
#------------------------------------------------------------------------------#

TARGETS := TopN_Outlier_Pruning_Block_C_SORTED \
           TopN_Outlier_Pruning_Block_C_UNSORTED \
           TopN_Outlier_Pruning_Block_C_NO_BLOCKING

COMMON_SOURCES := $(SOURCE_DIR)/top_n_outlier_pruning_block.c \
                  $(SOURCE_DIR)/stats.c \
                  $(SOURCE_DIR)/vardump.c
MATLAB_SOURCES := $(SOURCE_DIR)/matlab_wrapper.c
BINARY_SOURCES := $(SOURCE_DIR)/wrapper.c \
                  $(SOURCE_DIR)/test.c

TopN_Outlier_Pruning_Block_C_SORTED_CFLAGS        := -DSORTED_INSERT
TopN_Outlier_Pruning_Block_C_SORTED_CXXFLAGS      := -DSORTED_INSERT
TopN_Outlier_Pruning_Block_C_SORTED_MXXFLAGS      := -DSORTED_INSERT

TopN_Outlier_Pruning_Block_C_UNSORTED_CFLAGS      := -DUNSORTED_INSERT
TopN_Outlier_Pruning_Block_C_UNSORTED_CXXFLAGS    := -DUNSORTED_INSERT
TopN_Outlier_Pruning_Block_C_UNSORTED_MXXFLAGS    := -DUNSORTED_INSERT

TopN_Outlier_Pruning_Block_C_NO_BLOCKING_CFLAGS   := -DNO_BLOCKING -DSORTED_INSERT
TopN_Outlier_Pruning_Block_C_NO_BLOCKING_CXXFLAGS := -DNO_BLOCKING -DSORTED_INSERT
TopN_Outlier_Pruning_Block_C_NO_BLOCKING_MXXFLAGS := -DNO_BLOCKING -DSORTED_INSERT

# Compile the MEX functions
$(foreach t,$(TARGETS),$(eval $(call target-template,$t)))


#------------------------------------------------------------------------------#
#                                                                              #
#                                  TARGETS                                     #
#                                                                              #
#------------------------------------------------------------------------------#

# Release build
release: CFLAGS   += $(CFLAGS_OPT)
release: CXXFLAGS += $(CXXFLAGS_OPT)
release: MXXFLAGS += $(MXXFLAGS_OPT)
release: LDFLAGS  += $(LDFLAGS_OPT)
release: all

# Debug build
debug:   CFLAGS   += $(CFLAGS_DEBUG)
debug:   CXXFLAGS += $(CXXFLAGS_DEBUG)
debug:   MXXFLAGS += $(MXXFLAGS_DEBUG)
debug:   LDFLAGS  += $(LDFLAGS_DEBUG)
debug:   all

.PHONY: all
all: $(ALL_TARGETS)
	-@$(ECHO) "Done."

.PHONY: test
test:
	$(call try-autoesl)

#------------------------------------------------------------------------------#
#                                                                              #
#                               CLEAN TARGETS                                  #
#                                                                              #
#------------------------------------------------------------------------------#
.PHONY: clean
clean:
	-@$(ECHO) "Cleaning..."
	$(call pretty,$(DELETE) -f $(ALL_TARGETS))
	-@$(ECHO) "Clean completed."

.PHONY: distclean
distclean: clean


#------------------------------------------------------------------------------#
#                                                                              #
#                                INFO TARGET                                   #
#                                                                              #
#------------------------------------------------------------------------------#
.PHONY: info
info:
	$(call print-variables)