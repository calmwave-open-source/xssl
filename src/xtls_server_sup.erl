%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2019-2024. All Rights Reserved.
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

-module(xtls_server_sup).
-moduledoc false.

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callback
-export([init/1]).

%%%=========================================================================
%%%  API
%%%=========================================================================

-spec start_link() -> {ok, pid()} | ignore | {error, term()}.
			
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%=========================================================================
%%%  Supervisor callback
%%%=========================================================================

init([]) ->  
    ChildSpecs = [xlisten_options_tracker_child_spec(),
                xtls_server_session_child_spec(), %% TLS-1.3 Session ticket handling
                xssl_server_session_child_spec(), %% PRE TLS-1.3 session handling
                xssl_upgrade_server_session_child_spec() %% PRE TLS-1.3 session handling for upgrade servers
               ], 
    SupFlags = #{strategy  => one_for_all,
                 intensity =>   10,
                 period    => 3600
                },
    {ok, {SupFlags, ChildSpecs}}.

   

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

%% Handles emulated options so that they inherited by the accept
%% socket, even when setopts is performed on the listen socket
xlisten_options_tracker_child_spec() ->
    #{id       => xssl_listen_tracker_sup,
      start    => {xssl_listen_tracker_sup, start_link, []},
      restart  => permanent, 
      shutdown => 4000,
      modules  => [xssl_listen_tracker_sup],
      type     => supervisor
     }.

xtls_server_session_child_spec() ->
    #{id       => xtls_server_session_ticket,
      start    => {xtls_server_session_ticket_sup, start_link, []},
      restart  => permanent, 
      shutdown => 4000,
      modules  => [xtls_server_session_ticket_sup],
      type     => supervisor
     }.

xssl_server_session_child_spec() ->
    #{id       => xssl_server_session_cache_sup,
      start    => {xssl_server_session_cache_sup, start_link, []},
      restart  => permanent, 
      shutdown => 4000,
      modules  => [xssl_server_session_cache_sup],
      type     => supervisor
     }.

xssl_upgrade_server_session_child_spec() ->
    #{id       => xssl_upgrade_server_session_cache_sup,
      start    => {xssl_upgrade_server_session_cache_sup, start_link, []},
      restart  => permanent, 
      shutdown => 4000,
      modules  => [xssl_upgrade_server_session_cache_sup],
      type     => supervisor
     }.
