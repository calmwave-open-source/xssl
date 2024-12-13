#
# %CopyrightBegin%
#
# Copyright Ericsson AB 1999-2024. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# %CopyrightEnd%
#

#

include $(ERL_TOP)/make/target.mk
include $(ERL_TOP)/make/$(TARGET)/otp.mk

# ----------------------------------------------------
# Application version
# ----------------------------------------------------
include ../vsn.mk
VSN=$(SSL_VSN)

# ----------------------------------------------------
# Release directory specification
# ----------------------------------------------------
RELSYSDIR = $(RELEASE_PATH)/lib/ssl-$(VSN)

# ----------------------------------------------------
# Common Macros
# ----------------------------------------------------

BEHAVIOUR_MODULES= \
	ssl_trace \
	ssl_crl_cache_api \
	ssl_session_cache_api


MODULES= \
	xdtls_server_connection \
        xdtls_client_connection \
	xdtls_connection_sup \
	xdtls_handshake \
	xdxtls_gen_connection \
	xdtls_listener_sup \
	xdtls_packet_demux \
	xdtls_record \
	xdtls_server_sup\
	xdtls_server_session_cache_sup\
	xdtls_sup \
	xdtls_socket \
	xdtls_v1 \
	xinet_tls_dist \
	xinet6_tls_dist \
	xssl \
	xssl_admin_sup \
	xssl_alert \
	xssl_app \
	xssl_certificate \
	xssl_cipher \
	xssl_cipher_format \
	xssl_client_session_cache_db \
	xssl_config \
	xssl_connection_sup \
	xssl_crl \
	xssl_crl_cache \
	xssl_crl_hash_dir \
	xssl_dh_groups \
	xssl_dist_admin_sup \
	xssl_dist_connection_sup \
	xssl_dist_sup \
        xssl_gen_statem \
	xssl_handshake \
	xssl_listen_tracker_sup \
	xssl_logger \
	xssl_manager \
	xssl_pem_cache \
	xssl_pkix_db \
	xssl_record \
	xssl_server_session_cache \
	xssl_server_session_cache_db \
	xssl_server_session_cache_sup \
	xssl_upgrade_server_session_cache_sup \
	xssl_session \
	xssl_srp_primes \
	xssl_sup \
	xtls_bloom_filter \
	xtls_dtls_client_connection \
	xtls_dtls_server_connection \
	xtls_dxtls_gen_connection \
	xtls_server_connection \
	xtls_client_connection \
	xtls_connection_sup \
	xtls_server_connection_1_3 \
	xtls_client_connection_1_3 \
	xtls_gen_connection_1_3 \
        xtls_gen_connection \
	xtls_handshake \
	xtls_handshake_1_3 \
	xtls_record \
	xtls_record_1_3 \
	xtls_client_ticket_store \
	xtls_dist_sup \
	xtls_dist_server_sup \
	xtls_dyn_connection_sup\
	xtls_sender \
	xtls_server_session_ticket\
	xtls_server_session_ticket_sup\
	xtls_server_sup\
	xtls_socket \
	xtls_sup \
	tls_v1


INTERNAL_HRL_FILES = \
	xdtls_connection.hrl \
	xdtls_handshake.hrl \
	xdtls_record.hrl \
	xssl_alert.hrl \
	xssl_api.hrl \
	xssl_cipher.hrl \
	xssl_connection.hrl \
	xssl_handshake.hrl \
	xssl_internal.hrl \
	xssl_record.hrl \
	xssl_srp.hrl \
	xtls_connection.hrl \
	xtls_handshake.hrl \
	xtls_handshake_1_3.hrl \
	xtls_record.hrl \
	xtls_record_1_3.hrl


ERL_FILES= \
	$(MODULES:%=%.erl) \
	$(BEHAVIOUR_MODULES:%=%.erl)


TARGET_FILES= $(MODULES:%=$(EBIN)/%.$(EMULATOR))

BEHAVIOUR_TARGET_FILES= $(BEHAVIOUR_MODULES:%=$(EBIN)/%.$(EMULATOR))

APP_FILE= ssl.app
APPUP_FILE= ssl.appup

APP_SRC= $(APP_FILE).src
APP_TARGET= $(EBIN)/$(APP_FILE)
APPUP_SRC= $(APPUP_FILE).src
APPUP_TARGET= $(EBIN)/$(APPUP_FILE)

DEPDIR=$(ERL_TOP)/lib/ssl/src/deps
DEP_FILE=$(DEPDIR)/ssl.d
$(shell mkdir -p $(dir $(DEP_FILE)) >/dev/null)

ifeq ($(TARGET), win32)
  # Native path without C: ignore driveletter case
  ERL_TOP_NATIVE = $(shell w32_path.sh -m $(ERL_TOP) | sed "s@[a-zA-Z]:@:@")
else
  ERL_TOP_NATIVE = $(ERL_TOP)
endif

# ----------------------------------------------------
# FLAGS
# ----------------------------------------------------
EXTRA_ERLC_FLAGS = +warn_unused_vars -Werror +nowarn_deprecated_callback
ERL_COMPILE_FLAGS += -I$(ERL_TOP)/lib/kernel/src \
	-pz $(EBIN) \
	-pz $(ERL_TOP)/lib/public_key/ebin \
	$(EXTRA_ERLC_FLAGS) -DVSN=\"$(VSN)\" 

# ----------------------------------------------------
# Targets
# ----------------------------------------------------

$(TYPES): $(TARGET_FILES) $(APP_TARGET) $(APPUP_TARGET) $(DEP_FILE)

deps: $(DEP_FILE)

$(TARGET_FILES): $(BEHAVIOUR_TARGET_FILES)

$(DEP_FILE): $(ERL_FILES)
	@echo SED $(TARGET) $(ERL_TOP_NATIVE)
	$(gen_verbose)erlc -M $(ERL_FILES) \
	| perl -pe "s@ [a-zA-Z]?$(ERL_TOP_NATIVE)/(?:bootstrap/)?lib/([^/]+)@ ../../\1@g" 2> /dev/null \
	| sed "s/\.$(EMULATOR)/\.$$\(EMULATOR\)/" \
	| sed 's@^dtls_@$$(EBIN)/dtls_@' \
	| sed 's@^inet_@$$(EBIN)/inet_@' \
	| sed 's@^ssl_@$$(EBIN)/ssl_@' \
	| sed 's@^tls_@$$(EBIN)/tls_@' \
	> $(DEP_FILE)


clean:
	rm -f $(TARGET_FILES) $(APP_TARGET) $(APPUP_TARGET) $(BEHAVIOUR_TARGET_FILES) 
	rm -f errs core *~
	rm -rf $(DEPDIR)

$(APP_TARGET):	$(APP_SRC) ../vsn.mk
	$(vsn_verbose)sed -e 's;%VSN%;$(VSN);' $< > $@

$(APPUP_TARGET):	$(APPUP_SRC) ../vsn.mk
	$(vsn_verbose)sed -e 's;%VSN%;$(VSN);' $< > $@

docs:

# ----------------------------------------------------
# Release Target
# ---------------------------------------------------- 
include $(ERL_TOP)/make/otp_release_targets.mk

release_spec: opt
	$(INSTALL_DIR) "$(RELSYSDIR)/src"
	$(INSTALL_DATA) $(ERL_FILES) $(INTERNAL_HRL_FILES) "$(RELSYSDIR)/src"
	$(INSTALL_DIR) "$(RELSYSDIR)/ebin"
	$(INSTALL_DATA) $(BEHAVIOUR_TARGET_FILES) $(TARGET_FILES) $(APP_TARGET) \
	$(APPUP_TARGET) "$(RELSYSDIR)/ebin"

release_docs_spec:

# ----------------------------------------------------
# Dependencies
# ----------------------------------------------------
-include $(DEP_FILE)
