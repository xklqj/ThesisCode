#------------------------------------------------------------------------------#
#                                                                              #
#                               DEFAULT TARGET                                 #
#                                                                              #
#------------------------------------------------------------------------------#
.SUFFIXES:
.DEFAULT: help
.PHONY: help
help:
	$(help_text)


#------------------------------------------------------------------------------#
#                                                                              #
#                                CONFIGURATION                                 #
#                                                                              #
#------------------------------------------------------------------------------#
BUILD_TYPES    := binary matlab
TARGETS        := TopN_Outlier_Pruning_Block_SORTED \
                  TopN_Outlier_Pruning_Block_UNSORTED \
                  TopN_Outlier_Pruning_Block_NO_BLOCKING

DATA_DIR       := data
SOURCE_DIR     := source
INCLUDE_DIRS   := data include include/autoesl

TopN_Outlier_Pruning_Block_SORTED_CFLAGS        = $(call flags,DINSERT=SORTED DBLOCKING=ENABLED)
TopN_Outlier_Pruning_Block_SORTED_CXXFLAGS      = $(call flags,DINSERT=SORTED DBLOCKING=ENABLED)
TopN_Outlier_Pruning_Block_SORTED_MXXFLAGS      = $(call flags,DINSERT=SORTED DBLOCKING=ENABLED)

TopN_Outlier_Pruning_Block_UNSORTED_CFLAGS      = $(call flags,DINSERT=UNSORTED DBLOCKING=ENABLED)
TopN_Outlier_Pruning_Block_UNSORTED_CXXFLAGS    = $(call flags,DINSERT=UNSORTED DBLOCKING=ENABLED)
TopN_Outlier_Pruning_Block_UNSORTED_MXXFLAGS    = $(call flags,DINSERT=UNSORTED DBLOCKING=ENABLED)

TopN_Outlier_Pruning_Block_NO_BLOCKING_CFLAGS   = $(call flags,DINSERT=SORTED DBLOCKING=DISABLED)
TopN_Outlier_Pruning_Block_NO_BLOCKING_CXXFLAGS = $(call flags,DINSERT=SORTED DBLOCKING=DISABLED)
TopN_Outlier_Pruning_Block_NO_BLOCKING_MXXFLAGS = $(call flags,DINSERT=SORTED DBLOCKING=DISABLED)

COMMON_SOURCES       := $(SOURCE_DIR)/top_n_outlier_pruning_block.cpp \
                        $(SOURCE_DIR)/vardump.cpp \
                        $(SOURCE_DIR)/sw_functions.cpp

binary_OUTPUT_DIR    := bin
binary_EXT           := bin
binary_CFLAGS         = $(call flags,D__C__)
binary_CXXFLAGS       = $(call flags,D__C__)
binary_SOURCES       := $(SOURCE_DIR)/wrapper.cpp \
                        $(SOURCE_DIR)/test.cpp

matlab_OUTPUT_DIR    := bin
matlab_EXT            = $(MEXEXT)
matlab_CFLAGS         = $(call flags,D__MEX__)
matlab_CXXFLAGS       = $(call flags,D__MEX__)
matlab_SOURCES       := $(SOURCE_DIR)/matlab_wrapper.cpp


#------------------------------------------------------------------------------#
#                                                                              #
#                                 PROGRAMS                                     #
#                                                                              #
#------------------------------------------------------------------------------#
DELETE   := rm
DIRNAME  := dirname
ECHO     := echo
EXPR     := expr
GREP     := egrep
MAKEDIR  := mkdir -p
PERL     := perl
PRINTF   := printf
PYTHON   := python
READLINK := readlink -f
SED      := sed
TEST     := test
UNAME    := uname


#------------------------------------------------------------------------------#
#                                                                              #
#                              UTILITY MACROS                                  #
#                                                                              #
#------------------------------------------------------------------------------#

# $(call add-flags,CURRENT_FLAGS,FLAG FLAG ...)
# Add flags to a CFLAG-style string.
add-flags = $(filter-out $(foreach FLAG,$(2),-$(FLAG:-%=%)),$(1))$(foreach FLAG,$(2), -$(FLAG:-%=%))

# $(call count,VAR1 VAR2 ...)
count = $(shell $(EXPR) 0 $(foreach VAR,$(1),+ 1 ))

# $(call create-directory,DIRECTORY)
# Create a directory, if it does not yet exist
define create-directory
-@if $$(TEST) ! -d $(1); then \
	$(call trace-message,"Creating directory: $(1)"); \
	$$(MAKEDIR) $(1); \
fi
endef

# $(call evaluate,EVAL_CMD)
# An alternative to $(eval) that will call $(info) as well as $(eval), if DEBUG
# is defined.
ifdef DEBUG
evaluate = $(info $(1))$(eval $(1))
else
evaluate = $(eval $(1))
endif

# $(call flags,FLAG FLAG ...)
# Create a gcc-style CFLAG string.
flags = $(foreach FLAG,$(1), -$(FLAG:-%=%))

# $(call get-relative-path,FROM,TO)
# Get the relative file path between two directories.
get-relative-path = $(shell \
	source="$$($(READLINK) $1)"; \
	target="$$($(READLINK) $2)"; \
	\
	common_part="$$source"; \
	back="."; \
	while [ "$${target\#$$common_part}" = "$${target}" ]; do \
		common_part="$$($(DIRNAME) $$common_part)"; \
		back="$${back}/.."; \
	done; \
	\
	back=$$($(ECHO) $$back | $(SED) 's/\.\///'); \
	\
	$(ECHO) $${back}$${target\#$$common_part}; \
)

# $(help-text)
# The text to be displayed when make is run without any targets.
define help_text
-@$(ECHO) "/==================================================================================================\\"
-@$(ECHO) "|                                    TopN_Outlier_Pruning_Block                                    |"
-@$(ECHO) "\\==================================================================================================/"
-@$(ECHO)
-@$(ECHO) " USAGE:"
-@$(ECHO) "     make [DEBUG=1] \\"
-@$(ECHO) "          [mode=<BUILD_MODE>] \\"
-@$(ECHO) "          [gprof=<on|off>] \\"
-@$(ECHO) "          [test-type=<disabled|embedded|file>] \\"
-@$(ECHO) "          (<TASKS>|<BUILD_TYPE>|<HELPER_TARGET>|<TARGET>)"
-@$(ECHO)
-@$(ECHO) " BUILD_MODES:"
-@$(ECHO) "     debug"
-@$(ECHO) "     debugopt"
-@$(ECHO) "     release (default)"
-@$(ECHO)
-@$(ECHO) " OPTIONS:"
-@$(ECHO) "     gprof       Enables/disables compilation flags for gprof (default=off)."
-@$(ECHO) "     inline      Enables/disables/forces the inlining of functions (default=on)."
-@$(ECHO) "     test-type   The type of testing to allow (default=disabled)."
-@$(ECHO) "                   disabled: Do not allow testing with data sets."
-@$(ECHO) "                   embedded: Datasets for testing will be embedded in the binary"
-@$(ECHO) "                             binary executable."
-@$(ECHO) "                   file:     Datasets will be read from the filesystem."
-@$(ECHO)
-@$(ECHO) " TASKS:"
-@$(ECHO) "     clean"
-@$(ECHO) "     clean-<BUILD_TYPE>"
-@$(ECHO) "     distclean"
-@$(ECHO) "     distclean-<BUILD_TYPE>"
-@$(ECHO) "     buildtest"
-@$(ECHO) "     buildtest-<BUILD_TYPE>"
-@$(ECHO) "     help"
-@$(ECHO) "     info"
-@$(ECHO)
-@$(ECHO) " BUILD_TYPES:"
-@$(ECHO) "     all"
-@$(foreach BUILD_TYPE,$(sort $(BUILD_TYPES)),$(ECHO) "     $(BUILD_TYPE)";)
-@$(ECHO)
-@$(ECHO) " HELPER_TARGETS:"
-@$(foreach TARGET,$(sort $(HELPER_TARGETS)),$(ECHO) "     $(TARGET)";)
-@$(ECHO) ""
-@$(ECHO) " TARGETS:"
-@$(foreach TARGET,$(sort $(foreach BUILD_TYPE,$(BUILD_TYPES),$($(BUILD_TYPE)_TARGETS))),$(ECHO) "     $(TARGET)";)
-@$(ECHO)
endef

# $(call include-flags,INC1 INC2 ...)
# Create gcc-style include flags.
define include-flags
$(foreach INC_DIR,$(1), -I$(INC_DIR))
endef

# $(call parse-mex-options,OPTION_NAME)
# Parse options from the mex compiler.
define parse-mex-options
$(if $(MXX),
	$(shell \
		$(MXX) -v 2>/dev/null | \
		$(SED) -n -e 's/\s*$(1)\s*=\s*\(\(-.\+\s\+\)\+\)/\1/p'
	),
)
endef

# $(call pretty,STRING)
# Remove duplicate whitespace from a string. Removes the following:
#     - Repeated whitespace
#     - Leading whitespace
#     - Trailing whitespace
define pretty
$(shell \
	$(ECHO) -n "$(1)" |
	$(SED) \
		-e 's/\s\s\+/ /'
		-e 's/^\s\+//'
		-e 's/\s\+$$//'
)
endef

# $(call print-variable,var)
# Print the name and value of a variable.
print-variable = $(info $(1)=$($(1)))

# $(call print-variables)
# Print all makefile variables.
define print-variables
$(foreach VAR,$(sort $(filter-out print-variable%,$(.VARIABLES))),
	$(if $(filter file,$(origin $(VAR))),
		$(call print-variable,$(VAR))))
endef

# $(call product,VAR1 VAR2 ...)
product = $(shell $(EXPR) 1 $(foreach VAR,$(1),\* $(VAR) ))

# $(call remove-flag,CURRENT_FLAGS,FLAG FLAG ...)
# Remove a flag from a CFLAG-style string.
remove-flags = $(filter-out $(foreach FLAG,$(2),-$(FLAG:-%=%)),$(1))

# $(call run-tests,TARGETS,MODES,GPROF_OPTIONS,TESTTYPE_OPTIONS)
# Any options that get added to the Makefile (such as
# [mode=<debug|debugopt|release]), should be included in the test sequence
# below.
define run-build-tests
FAILURES="";\
NUM_FAILURES=0;\
NUM_PASSES=0;\
NUM_TOTAL=$(call product,$(call count,$(1)) $(call count,$(2)) $(call count,$(3)) $(call count,$(4)));\
\
for TARGET in $(1); do\
for MODE in $(2); do\
for GPROF_OPT in $(3); do\
for TESTTYPE_OPT in $(4); do\
MAKE_STRING=$$($(PRINTF) "mode=%s gprof=%s test-type=%s" $$MODE $$GPROF_OPT $$TESTTYPE_OPT);\
$(ECHO) "================================================================================";\
$(ECHO) "Test:    $$($(EXPR) $$NUM_PASSES + $$NUM_FAILURES + 1) of $$NUM_TOTAL";\
$(ECHO) "Target:  $$TARGET";\
$(ECHO) "Options: $$MAKE_STRING";\
$(ECHO) "================================================================================";\
make --no-print-directory clean >/dev/null;\
make --no-print-directory $$MAKE_STRING $$TARGET;\
if [ $$? -ne 0 ]; then\
	NUM_FAILURES=$$($(EXPR) $$NUM_FAILURES + 1);\
	if [ -n "$$FAILURES" ]; then\
		FAILURES="$$FAILURES;";\
	fi;\
	FAILURES="$${FAILURES}make $$MAKE_STRING $$TARGET";\
else\
	NUM_PASSES=$$($(EXPR) $$NUM_PASSES + 1);\
fi;\
$(ECHO) "--------------------------------------------------------------------------------";\
$(ECHO) "";\
done;\
done;\
done;\
done;\
make --no-print-directory clean >/dev/null;\
\
$(ECHO) "================================================================================";\
$(ECHO) "                                    SUMMARY                                     ";\
$(ECHO) "================================================================================";\
$(ECHO) "Passes:   $$NUM_PASSES";\
$(ECHO) "Failures: $$NUM_FAILURES";\
if [ $$NUM_FAILURES -gt 0 ]; then\
    $(ECHO) "";\
    $(ECHO) "FAILED TESTS:";\
    IFS=";";\
    for FAILURE in $$FAILURES; do\
        $(ECHO) "$$FAILURE";\
    done;\
fi;\
$(ECHO) "--------------------------------------------------------------------------------";
endef

# $(call trace-message,msg)
# Print a message to STDOUT.
trace-message = -@$(ECHO) $1

# Characters that are hard to specify in certain places
empty :=
space := $(empty) $(empty)
colon := \:
comma := ,

# Useful shell definitions
sh_true	 := :
sh_false := ! :

#-------------------------------------------------------------------------------

# $(eval $(call build-type-template,BUILD_TYPE))
define build-type-template
################################################################################
# BUILD_TYPE = $(1)
################################################################################
.PHONY: $(1)
$(1): $$($(1)_TARGETS)

.PHONY: clean-$(1)
clean-$(1):
	$(call trace-message,"Cleaning $(1)...")
	$$(DELETE) -r -f $$($(1)_CLEAN)
	$(call trace-message,"Clean completed.")
	$(call trace-message,)

.PHONY: distclean-$(1)
distclean-$(1):
	$(call trace-message,"Cleaning $(1)...")
	$$(DELETE) -r -f $$($(1)_CLEAN) $$($(1)_DISTCLEAN)
	$(call trace-message,"Clean completed.")
	$(call trace-message,)


endef

# $(eval $(call target-template,TARGET,ADDITIONAL_DEPENDENCIES))
define target-template
################################################################################
# TARGET = $(1)
################################################################################
# Binary
$(1)_BINARY    := $$(binary_OUTPUT_DIR)/$(1).$$(binary_EXT)
binary_TARGETS += $$($(1)_BINARY)
binary_CLEAN   += $$($(1)_BINARY)

HELPER_TARGETS += $(1)-binary
.PHONY: $(1)-binary
$(1)-binary: $$($(1)_BINARY)

$$($(1)_BINARY): $$($(1)_DEPS)
$$($(1)_BINARY): $$(binary_SOURCES) $$(COMMON_SOURCES)
	$(call create-directory,$$(binary_OUTPUT_DIR))
	$(call trace-message,"Compiling: $$@")
	$$(if $$(filter %.cpp,$$^), \
		$$(if $$(CXX), \
			$$(call pretty,$$(CXX) \
				$$(binary_CXXFLAGS) \
				$$(CXXFLAGS) \
				$$(call include-flags,$$(INCLUDE_DIRS)) \
				$$($(1)_CXXFLAGS) \
				-o $$@ \
				$$(filter %.cpp,$$^) $$(filter %.c,$$^) \
			), \
			$$(error No C++ compiler was found) \
	    ), \
    	$$(if $$(CC), \
			$$(call pretty,$$(CC) \
				$$(binary_CFLAGS) \
				$$(CFLAGS) \
				$$(call include-flags,$$(INCLUDE_DIRS)) \
				$$($(1)_CFLAGS) \
				-o $$@ \
				$$(filter-out $$($(1)_DEPS),$$^) \
			) \
		), \
		$$(error No C compiler was found) \
	)
	$(call trace-message,)

# Matlab
$(1)_MATLAB    := $$(matlab_OUTPUT_DIR)/$(1).$$(matlab_EXT)
matlab_TARGETS += $$($(1)_MATLAB)
matlab_CLEAN   += $$($(1)_MATLAB)

HELPER_TARGETS += $(1)-matlab
.PHONY: $(1)-matlab
$(1)-matlab: $$($(1)_MATLAB)
$$($(1)_MATLAB): $$($(1)_DEPS)
$$($(1)_MATLAB): $$(matlab_SOURCES) $$(COMMON_SOURCES)
	$(call create-directory,$$(matlab_OUTPUT_DIR))
	$(call trace-message,"Compiling: $$@")
	$$(if $$(MXX), \
		$$(call pretty,$$(MXX) \
			$$(matlab_CFLAGS) \
			$$(MXXFLAGS) \
			$$($(1)_MXXFLAGS) \
			$$(call include-flags,$$(INCLUDE_DIRS)) \
			CFLAGS='$$(CFLAGS) $$($(1)_CFLAGS)' \
			CXXFLAGS='$$(CXXFLAGS) $$($(1)_CXXFLAGS)' \
			LDFLAGS='$$(LDFLAGS)' \
			-o $$@ \
			$$(filter-out $$($(1)_DEPS),$$^) \
		), \
		$$(error MATLAB compiler executable not found) \
	)
	$(call trace-message,)

endef


#------------------------------------------------------------------------------#
#                                                                              #
#                             MATLAB CONFIGURATION                             #
#                                                                              #
#------------------------------------------------------------------------------#
MATLAB_DIR  := $(shell matlab -e 2>/dev/null | $(SED) -n -e 's/MATLAB=\(.\+\)/\1/p')
MATLAB_ARCH := $(shell matlab -e 2>/dev/null | $(SED) -n -e 's/ARCH=\(.\+\)/\1/p')

ifndef MXX
	ifeq ($(shell $(UNAME)),Darwin)
		MXX      := $(call pretty,$(MATLAB_DIR)/bin/mex -$(MATLAB_ARCH))
		MEXEXT   := $(shell $(MATLAB_DIR)/bin/mexext)
		MXXFLAGS := -I$(MATLAB_DIR)/extern/include
	endif
	ifeq ($(shell $(UNAME)),Linux)
		MXX      := $(call pretty,$(MATLAB_DIR)/bin/mex -$(MATLAB_ARCH))
		MEXEXT   := $(shell $(MATLAB_DIR)/bin/mexext)
		MXXFLAGS := -I$(MATLAB_DIR)/extern/include
	endif
else
	MEXEXT := $(shell mexext)
endif

ifeq ($(MATLAB_ARCH),glnx86)
	MEXEXT          := mexglx
	MATLAB_ARCHTYPE := x86
endif
ifeq ($(MATLAB_ARCH),glnxa64)
	MEXEXT          := mexa64
	MATLAB_ARCHTYPE := x64
endif
ifeq ($(MATLAB_ARCH),mac)
	MEXEXT      := mexmac
	MATLAB_ARCH := x86
endif
ifeq ($(MATLAB_ARCH),maci)
	MEXEXT          := mexmaci
	MATLAB_ARCHTYPE := x86
endif
ifeq ($(MATLAB_ARCH),maci64)
	MEXEXT          := mexmaci64
	MATLAB_ARCHTYPE := x64
endif
ifeq ($(MATLAB_ARCH),sol2)
	MEXEXT          := mexsol
	MATLAB_ARCHTYPE := x86
endif
ifeq ($(MATLAB_ARCH),sol64)
	MEXEXT          := mexs64
	MATLAB_ARCHTYPE := x64
endif
ifeq ($(MATLAB_ARCH),win64)
	MEXEXT          := mexw64
	MATLAB_ARCHTYPE := x64
endif
ifeq ($(MATLAB_ARCH),win32)
	MEXEXT          := mexw32
	MATLAB_ARCHTYPE := x86
endif


#------------------------------------------------------------------------------#
#                                                                              #
#                              COMPILER FLAGS                                  #
#                                                                              #
#------------------------------------------------------------------------------#

# C compiler
CC       := gcc
CXX      := g++

# Default flags (these will be overridden)
CFLAGS   := $(call parse-mex-options,CFLAGS)
CXXFLAGS := $(call parse-mex-options,CXXFLAGS)
LDFLAGS  := $(call parse-mex-options,LDFLAGS)

# Remove 'ANSI standard' flags
CFLAGS   := $(call remove-flags,$(CFLAGS),ansi)
CXXFLAGS := $(call remove-flags,$(CXXFLAGS),ansi)

# Additional flags
CFLAGS   := $(call add-flags,$(CFLAGS),std=c99 W Wall Wextra pedantic fmessage-length=0 Wno-unused-label)
CXXFLAGS := $(call add-flags,$(CXXFLAGS),std=c++0x W Wall Wextra pedantic fmessage-length=0 Wno-unused-label Wno-vla)

# Architecture specific flags
ifeq ($(MATLAB_ARCHTYPE), x86)
MXXFLAGS := $(call add-flags,$(MXXFLAGS),compatibleArrayDims)
endif
ifeq ($(MATLAB_ARCHTYPE), x64)
MXXFLAGS := $(call add-flags,$(MXXFLAGS),largeArrayDims)
endif

# Debug flags
CFLAGS_DEBUG      := $(call flags,g O0 DDEBUG)
CXXFLAGS_DEBUG    := $(call flags,g O0 DDEBUG)
MXXFLAGS_DEBUG    := $(call flags,DDEBUG)
LDFLAGS_DEBUG     := $(call flags,g)

# Optimized debug flags
CFLAGS_DEBUGOPT   := $(call flags,g O3 DDEBUG)
CXXFLAGS_DEBUGOPT := $(call flags,g O3 DDEBUG)
MXXFLAGS_DEBUGOPT := $(call flags,O DDEBUG)
LDFLAGS_DEBUGOPT  := $(call flags,g)

# Optimization flags
CFLAGS_OPT        := $(call flags,O3 DNDEBUG)
CXXFLAGS_OPT      := $(call flags,O3 DNDEBUG)
MXXFLAGS_OPT      := $(call flags,O DNDEBUG)
LDFLAGS_OPT       := $(call flags,O3)

# mode options
ifeq ($(mode),)
# Default mode is release
CFLAGS   := $(call add-flags,$(CFLAGS),$(CFLAGS_OPT))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(CXXFLAGS_OPT))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(MXXFLAGS_OPT))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(LDFLAGS_OPT))
else
ifeq ($(mode),debug)
CFLAGS   := $(call add-flags,$(CFLAGS),$(CFLAGS_DEBUG))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(CXXFLAGS_DEBUG))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(MXXFLAGS_DEBUG))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(LDFLAGS_DEBUG))
else
ifeq ($(mode),debugopt)
CFLAGS   := $(call add-flags,$(CFLAGS),$(CFLAGS_DEBUGOPT))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(CXXFLAGS_DEBUGOPT))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(MXXFLAGS_DEBUGOPT))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(LDFLAGS_DEBUGOPT))
else
ifeq ($(mode),release)
CFLAGS   := $(call add-flags,$(CFLAGS),$(CFLAGS_OPT))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(CXXFLAGS_OPT))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(MXXFLAGS_OPT))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(LDFLAGS_OPT))
else
$(error Invalid mode specified. Valid modes are 'debug', 'debugopt' and 'release')
endif
endif
endif
endif

# gprof options
GPROF_FLAGS_OFF :=
GPROF_FLAGS_ON  := $(call flags,pg)
ifeq ($(gprof),)
# Default is off
CFLAGS   := $(call add-flags,$(CFLAGS),$(GPROF_FLAGS_OFF))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(GPROF_FLAGS_OFF))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(GPROF_FLAGS_OFF))
else
ifeq ($(gprof),off)
CFLAGS   := $(call add-flags,$(CFLAGS),$(GPROF_FLAGS_OFF))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(GPROF_FLAGS_OFF))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(GPROF_FLAGS_OFF))
else
ifeq ($(gprof),on)
CFLAGS   := $(call add-flags,$(CFLAGS),$(GPROF_FLAGS_ON))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(GPROF_FLAGS_ON))
LDFLAGS  := $(call add-flags,$(LDFLAGS),$(GPROF_FLAGS_ON))
else
$(error Invalid gprof option specified. Valid values are 'on' and 'off')
endif
endif
endif

# test-type options
TEST_TYPE_FLAGS_DISABLED := DTEST_TYPE=TEST_TYPE_DISABLED
TEST_TYPE_FLAGS_EMBEDDED := DTEST_TYPE=TEST_TYPE_EMBEDDED
TEST_TYPE_FLAGS_FILE     := DTEST_TYPE=TEST_TYPE_FILE
ifeq ($(test-type),)
# Default is disabled
CFLAGS   := $(call add-flags,$(CFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
else
ifeq ($(test-type),disabled)
CFLAGS   := $(call add-flags,$(CFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(TEST_TYPE_FLAGS_DISABLED))
else
ifeq ($(test-type),embedded)
CFLAGS   := $(call add-flags,$(CFLAGS),$(TEST_TYPE_FLAGS_EMBEDDED))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(TEST_TYPE_FLAGS_EMBEDDED))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(TEST_TYPE_FLAGS_EMBEDDED))

# Additional dependencies
$(foreach TARGET,$(TARGETS),$(eval $(TARGET)_DEPS += datasets))
else
ifeq ($(test-type),file)
CFLAGS   := $(call add-flags,$(CFLAGS),$(TEST_TYPE_FLAGS_FILE))
CXXFLAGS := $(call add-flags,$(CXXFLAGS),$(TEST_TYPE_FLAGS_FILE))
MXXFLAGS := $(call add-flags,$(MXXFLAGS),$(TEST_TYPE_FLAGS_FILE))
else
$(error Invalid test-type option specified. Valid options are 'disabled', 'embedded' and 'file')
endif
endif
endif
endif


#------------------------------------------------------------------------------#
#                                                                              #
#                                   DATASETS                                   #
#                                                                              #
#------------------------------------------------------------------------------#
ALL_DATASETS_H     := $(DATA_DIR)/all_datasets.h
DATASETS           := $(wildcard $(DATA_DIR)/*.dat)
DATASETS_HEX       := $(DATASETS:%=%.h)

datasets_TARGETS   := $(ALL_DATASETS_H) $(DATASETS_HEX)
datasets_CLEAN     :=
datasets_DISTCLEAN := $(ALL_DATASETS_H) $(DATASETS_HEX)
ALL_CLEAN          += $(datasets_CLEAN)
ALL_DISTCLEAN      += $(datasets_DISTCLEAN)
HELPER_TARGETS     += datasets

# Convert a binary data file into a hexadecimal C header file.
$(DATA_DIR)/%.dat.h: $(DATA_DIR)/%.dat
	$(PYTHON) lib/scripts/data.py "$<" dataset_$* "$@"

# Create the main datasets header file.
$(DATA_DIR)/%.h: $(DATA_DIR)/%.h.pl
	$(PERL) "$<" "$@"

# Create clean-datasets and distclean-datasets targets
$(eval $(call build-type-template,datasets))


#------------------------------------------------------------------------------#
#                                                                              #
#                               MACRO EXPANSION                                #
#                                                                              #
#------------------------------------------------------------------------------#
$(foreach t,$(TARGETS),$(call evaluate,$(call target-template,$t)))

$(foreach BUILD_TYPE,$(BUILD_TYPES),$(call evaluate,$(call build-type-template,$(BUILD_TYPE))))

################################################################################
# All targets
################################################################################
.PHONY: all
all: $(foreach BUILD_TYPE,$(BUILD_TYPES),$($(BUILD_TYPE)_TARGETS))

################################################################################
# Clean targets
################################################################################
.PHONY: clean clean-all
clean clean-all:
	$(call trace-message,"Cleaning $(1)...")
	$(DELETE) -r -f $(ALL_CLEAN) $(foreach BUILD_TYPE,$(BUILD_TYPES),$($(BUILD_TYPE)_CLEAN))
	$(call trace-message,"Clean completed.")
	$(call trace-message,)

.PHONY: distclean distclean-all
distclean distclean-all:
	$(call trace-message,"Cleaning $(1)...")
	$(DELETE) -r -f $(ALL_CLEAN) $(ALL_DISTCLEAN) $(foreach BUILD_TYPE,$(BUILD_TYPES),$($(BUILD_TYPE)_CLEAN) $($(BUILD_TYPE)_DISTCLEAN))
	$(call trace-message,"Clean completed.")
	$(call trace-message,)


#------------------------------------------------------------------------------#
#                                                                              #
#                                INFO TARGET                                   #
#                                                                              #
#------------------------------------------------------------------------------#
.PHONY: info
info:
	$(print-variables)
	@$(sh_true)

#------------------------------------------------------------------------------#
#                                                                              #
#                                TEST TARGETS                                  #
#                                                                              #
#------------------------------------------------------------------------------#
.PHONY: buildtest
buildtest: buildtest-binary buildtest-matlab

.PHONY: buildtest-binary
buildtest-binary:
	@$(call run-build-tests,\
		binary,\
		debug debugopt release,\
		off on,\
		embedded file,\
		off on\
	)

.PHONY: buildtest-matlab
buildtest-matlab:
	@$(call run-build-tests,\
		matlab,\
		debug debugopt release,\
		off on,\
		disabled embedded file,\
		off on\
	)