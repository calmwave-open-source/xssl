%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2013-2023. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%%
%%----------------------------------------------------------------------
%% Purpose: Record and constant definitions for the TLS-record protocol
%% see RFC 5246
%%----------------------------------------------------------------------

-ifndef(xtls_record).
-define(xtls_record, true).

-include("xssl_record.hrl"). %% Common TLS and DTLS records and Constantes

%% Used to handle xtls_plain_text, xtls_compressed and xtls_cipher_text
-record(ssl_tls, {
                  type,
                  version :: xtls_record:tls_version() | undefined,
                  fragment,
                  early_data = false % TLS-1.3
                 }).

-endif. % -ifdef(xtls_record).
